load("@io_bazel_rules_dotnet//dotnet/private:common.bzl", "env_execute")
load("@io_bazel_rules_dotnet//dotnet:defs.bzl", "dotnet_context")

# _bazelrc is the bazel.rc file that sets the default options for tests
_bazelrc = """
build --verbose_failures
build --sandbox_debug
build --test_output=errors
build --spawn_strategy=standalone
build --genrule_strategy=standalone

test --test_strategy=standalone
test --nocache_test_results

build:isolate --
build:fetch --fetch=True
"""

# _env_build_template is the template for the bazel test environment repository build file
_env_build_template = """
load("@io_bazel_rules_dotnet//tests:bazel_tests.bzl", "bazel_test_settings")
bazel_test_settings(
  name = "settings",
  bazel = "{bazel}",
  exec_root = "{exec_root}",
  scratch_dir = "{scratch_dir}",
  visibility = ["//visibility:public"],
)
filegroup(
  name = "bazelrc",
  srcs = ["test.bazelrc"],
  visibility = ["//visibility:public"],
)
"""

# _bazel_test_script_template is the template for the bazel invocation script
_bazel_test_script_template = """
echo "Executing $0"

export PATH=/usr/bin:/bin:$PATH

if [[ -f "$0.runfiles/MANIFEST" ]]; then
export RUNFILES_MANIFEST_FILE="$0.runfiles/MANIFEST"
elif [[ -f "$0.runfiles_manifest" ]]; then
export RUNFILES_MANIFEST_FILE="$0.runfiles_manifest"
elif [[ -n "$RUNFILES_DIR" ]]; then
export RUNFILES_MANIFEST_FILE="$RUNFILES_DIR/MANIFEST"
fi

echo "Using for MANIFEST $RUNFILES_MANIFEST_FILE"
DIR=$(dirname $RUNFILES_MANIFEST_FILE)

echo pwd is `pwd`
echo command is {command}
echo running in {work_dir}
unset TEST_TMPDIR
RULES_DOTNET_OUTPUT={output}

mkdir -p {work_dir}
mkdir -p {cache_dir}
# Link files according to manifest

PREPARE=`awk '{{if ($1 ~ "{test_prep}") {{print $2;exit}} }}' $RUNFILES_MANIFEST_FILE`
$PREPARE $RUNFILES_MANIFEST_FILE

cp -f $DIR/{workspace} {work_dir}/WORKSPACE
cp -f $DIR/{build} {work_dir}/BUILD.bazel
{copy_srcs}
cd {work_dir}

{bazel} --bazelrc {bazelrc} {command} --config {config} {args} {target} >& bazel-output.txt
result=$?

echo "Result $result"

function at_exit {{
  echo "bazel exited with status $result"
  echo "----- bazel-output.txt begin -----"
  cat bazel-output.txt
  echo "----- bazel-output.txt end -----"
  for log in {logs}; do
    if [ ! -e "$log" ]; then
      echo "----- $log not found -----"
    else
      echo "----- $log begin -----"
      cat "$log"
      echo "----- $log end -----"
    fi
  done
}}
trap at_exit EXIT

{check}

exit $result
"""

def _test_environment_impl(ctx):
    # Find bazel
    bazel = ""
    if "BAZEL" in ctx.os.environ:
        bazel = ctx.os.environ["BAZEL"]
    elif "BAZEL_VERSION" in ctx.os.environ:
        home = ctx.os.environ["HOME"]
        bazel = home + "/.bazel/{0}/bin/bazel".format(ctx.os.environ["BAZEL_VERSION"])
    if bazel == "" or not ctx.path(bazel).exists:
        bazel = ctx.which("bazel")

    # Get a temporary directory to use as our scratch workspace
    if ctx.os.name.startswith("windows"):
        scratch_dir = ctx.os.environ["TMP"].replace("\\", "/") + "/bazel_dotnet_test"
    else:
        result = env_execute(ctx, ["mktemp", "-d"])
        if result.return_code:
            fail("failed to create temporary directory for bazel tests: {}".format(result.stderr))
        scratch_dir = result.stdout.strip()

    # Work out where we are running so we can find externals
    exec_root, _, _ = str(ctx.path(".")).rpartition("/external/")

    # build the basic environment
    ctx.file("WORKSPACE", 'workspace(name = "{}")'.format(ctx.name))
    ctx.file("BUILD.bazel", _env_build_template.format(
        bazel = bazel,
        exec_root = exec_root,
        scratch_dir = scratch_dir,
    ))
    ctx.file("test.bazelrc", content = _bazelrc)

_test_environment = repository_rule(
    implementation = _test_environment_impl,
    attrs = {},
    environ = [
        "BAZEL",
        "BAZEL_VERSION",
        "HOME",
    ],
)

def test_environment():
    _test_environment(name = "bazel_test")

CURRENT_VERSION = "current"

def _bazel_test_script_impl(ctx):
    dotnet = dotnet_context(ctx, "csharp")
    script_file = dotnet.declare_file(dotnet, ext = ".bash")

    if not ctx.attr.targets:
        # Skip test when there are no targets. Targets may be platform-specific,
        # and we may not have any targets on some platforms.
        ctx.actions.write(script_file, "", is_executable = True)
        return [DefaultInfo(files = depset([script_file]))]

    workspace_content = 'workspace(name = "bazel_test")\n\n'
    for ext in ctx.attr.externals:
        root = ext.label.workspace_root
        _, _, name = ext.label.workspace_root.rpartition("/")
        workspace_content += 'local_repository(name="{name}", path="{exec_root}/{root}")\n'.format(
            name = name,
            root = root,
            exec_root = ctx.attr._settings.exec_root,
        )
    if ctx.attr.workspace:
        workspace_content += ctx.attr.workspace

    workspace_file = dotnet.declare_file(dotnet, path = "WORKSPACE.in")
    ctx.actions.write(workspace_file, workspace_content)
    if ctx.attr.workspace_in:
        extra_workspace_file = dotnet.declare_file(dotnet, path = "WORKSPACE.in.extra")
        ctx.actions.run_shell(
            inputs = ctx.attr.workspace_in.files.to_list() + [workspace_file],
            mnemonic = "WorkspaceGenerate",
            outputs = [extra_workspace_file],
            command = "cat {} >> {}; cat {} >> {}".format(workspace_file.path, extra_workspace_file.path, ctx.attr.workspace_in.files.to_list()[0].path, extra_workspace_file.path),
        )
        workspace_file = extra_workspace_file

    build_file = dotnet.declare_file(dotnet, path = "BUILD.in")
    ctx.actions.write(build_file, ctx.attr.build)
    if ctx.attr.build_in:
        extra_build_file = dotnet.declare_file(dotnet, path = "BUILD.in.extra")
        ctx.actions.run_shell(
            inputs = ctx.attr.build_in.files.to_list() + [build_file],
            mnemonic = "BuildGenerate",
            outputs = [extra_build_file],
            command = "cat {} >> {}; cat {} >> {}".format(build_file.path, extra_build_file.path, ctx.attr.build_in.files.to_list()[0].path, extra_build_file.path),
        )
        build_file = extra_build_file

    output = "external/" + ctx.workspace_name + "/" + ctx.label.package
    targets = ["@" + ctx.workspace_name + "//" + ctx.label.package + t if t.startswith(":") else t for t in ctx.attr.targets]
    logs = []
    if ctx.attr.command in ("test", "coverage"):
        # TODO(jayconrod): read logs for other packages
        logs = [
            "bazel-testlogs/{}/{}/test.log".format(output, t[1:])
            for t in ctx.attr.targets
            if t.startswith(":")
        ]

    copy_srcs = ""
    for s in ctx.attr.srcs:
        p = s.files.to_list()[0]
        copy_srcs += "cp -f $DIR/{} {}/{};".format(p.basename, ctx.attr._settings.scratch_dir + "/" + ctx.attr.config, p.basename)

    script_content = _bazel_test_script_template.format(
        test_prep = ctx.attr._manifest_prep.files.to_list()[0].basename,
        bazelrc = ctx.attr._settings.exec_root + "/" + ctx.file._bazelrc.path,
        config = ctx.attr.config,
        command = ctx.attr.command,
        args = " ".join(ctx.attr.args),
        target = " ".join(targets),
        logs = " ".join(logs),
        check = ctx.attr.check,
        workspace = workspace_file.basename,
        build = build_file.basename,
        output = output,
        bazel = ctx.attr._settings.bazel,
        work_dir = ctx.attr._settings.scratch_dir + "/" + ctx.attr.config,
        cache_dir = ctx.attr._settings.scratch_dir + "/cache",
        copy_srcs = copy_srcs,
    )
    ctx.actions.write(output = script_file, is_executable = True, content = script_content)

    runfiles = depset(direct = [workspace_file, build_file] + ctx.attr._manifest_prep.files.to_list(), transitive = [f.files for f in ctx.attr.srcs])
    return struct(
        files = depset([script_file]),
        runfiles = ctx.runfiles(runfiles.to_list(), collect_data = True),
    )

_bazel_test_script = rule(
    _bazel_test_script_impl,
    attrs = {
        "command": attr.string(
            mandatory = True,
            values = [
                "build",
                "test",
                "coverage",
                "run",
            ],
        ),
        "args": attr.string_list(default = []),
        "targets": attr.string_list(mandatory = True),
        "externals": attr.label_list(allow_files = True),
        "dotnet_version": attr.string(default = CURRENT_VERSION),
        "workspace": attr.string(),
        "build": attr.string(),
        "workspace_in": attr.label(allow_files = True),
        "build_in": attr.label(allow_files = True),
        "srcs": attr.label_list(allow_files = True),
        "check": attr.string(),
        "config": attr.string(default = "isolate"),
        "data": attr.label_list(
            allow_files = True,
        ),
        "_bazelrc": attr.label(
            allow_single_file = True,
            default = "@bazel_test//:bazelrc",
        ),
        "_manifest_prep": attr.label(default = Label("@io_bazel_rules_dotnet//dotnet/tools/manifest_prep")),
        "_settings": attr.label(default = Label("@bazel_test//:settings")),
        "dotnet_context_data": attr.label(default = Label("@io_bazel_rules_dotnet//:dotnet_context_data")),
    },
    toolchains = ["@io_bazel_rules_dotnet//dotnet:toolchain_type_mono"],
)

def bazel_test(name, command = None, args = None, targets = None, dotnet_version = None, tags = [], externals = [], workspace = "", build = "", check = "", config = None, workspace_in = None, build_in = None, srcs = None):
    script_name = name + "_script"
    externals = externals + [
        "@io_bazel_rules_dotnet//:AUTHORS",
    ]
    #if dotnet_version == None or dotnet_version == CURRENT_VERSION:
    #    externals.append("@go_sdk//:packages.txt")

    _bazel_test_script(
        name = script_name,
        command = command,
        args = args,
        targets = targets,
        externals = externals,
        dotnet_version = dotnet_version,
        workspace = workspace,
        build = build,
        check = check,
        config = config,
        workspace_in = workspace_in,
        build_in = build_in,
        srcs = srcs,
    )

    native.sh_test(
        name = name,
        size = "large",
        timeout = "moderate",
        srcs = [":" + script_name],
        tags = ["local", "bazel", "exclusive"] + tags,
        data = [
            "@bazel_test//:bazelrc",
            "@io_bazel_rules_dotnet//tests:rules_dotnet_deps",
        ] + ([workspace_in] if workspace_in else []) + ([build_in] if build_in else []),
    )

def _bazel_test_settings_impl(ctx):
    return struct(
        bazel = ctx.attr.bazel,
        exec_root = ctx.attr.exec_root,
        scratch_dir = ctx.attr.scratch_dir,
    )

bazel_test_settings = rule(
    _bazel_test_settings_impl,
    attrs = {
        "bazel": attr.string(mandatory = True),
        "exec_root": attr.string(mandatory = True),
        "scratch_dir": attr.string(mandatory = True),
    },
)

def _md5_sum_impl(ctx):
    out = ctx.actions.declare_file(ctx.label.name + ".md5")
    arguments = ctx.actions.args()
    arguments.add_all([out])
    arguments.add_all(ctx.files.srcs)

    paramfile = ctx.actions.declare_file(ctx.label.name + ".params")
    ctx.actions.write(output = paramfile, content = arguments)

    ctx.actions.run(
        inputs = ctx.files.srcs + [paramfile],
        outputs = [out],
        mnemonic = "DotnetMd5sum",
        executable = ctx.executable._md5sum,
        arguments = [paramfile.path],
    )
    return struct(files = depset([out]))

md5_sum = rule(
    _md5_sum_impl,
    attrs = {
        "srcs": attr.label_list(allow_files = True),
        "_md5sum": attr.label(
            executable = True,
            default = "@io_bazel_rules_dotnet//dotnet/tools/md5sum",
            cfg = "host",
        ),
    },
)
