load(
    "@io_bazel_rules_dotnet//dotnet/private:context.bzl",
    "dotnet_context",
)
load(
    "@io_bazel_rules_dotnet//dotnet/private:providers.bzl",
    "DotnetLibrary",
    "DotnetResource",
    "DotnetResourceList",
)
load(
    "@io_bazel_rules_dotnet//dotnet/private:skylib/lib/paths.bzl",
    "paths",
)

_TEMPLATE_MONO = """
set -eo pipefail
echo "Executing $0"

export PATH=/usr/bin:/bin:$PATH

if [[ -z "$RUNFILES_MANIFEST_FILE" ]]; then
    if [[ -f "$0.runfiles/MANIFEST" ]]; then
    export RUNFILES_MANIFEST_FILE="$0.runfiles/MANIFEST"
    elif [[ -f "$0.runfiles_manifest" ]]; then
    export RUNFILES_MANIFEST_FILE="$0.runfiles_manifest"
    elif [[ -n "$RUNFILES_DIR" ]]; then
    export RUNFILES_MANIFEST_FILE="$RUNFILES_DIR/MANIFEST"
    fi
fi

echo "Using for MANIFEST $RUNFILES_MANIFEST_FILE"
DIR=$(dirname $RUNFILES_MANIFEST_FILE)

PREPARELINKPRG="{prepare}"
LAUNCHERPATH="{launch}"
EXEBASENAME="{exebasename}"

PREPARE=`awk '{{if ($1 ~ "{prepare}") {{print $2;exit}} }}' $RUNFILES_MANIFEST_FILE`
$PREPARE $RUNFILES_MANIFEST_FILE

if [[ "$OSTYPE" == "darwin"* ]]; then
    READLINK=greadlink
else
    READLINK=readlink
fi

MONOPRG=`$READLINK -f $DIR/mono`
echo "Using $MONOPRG"
"$MONOPRG" $DIR/$EXEBASENAME "$@"
"""

_TEMPLATE_CORE = """
set -eo pipefail
echo "Executing $0 args $#"
exit

export PATH=/usr/bin:/bin:$PATH

if [[ -z "$RUNFILES_MANIFEST_FILE" ]]; then
    if [[ -f "$0.runfiles/MANIFEST" ]]; then
    export RUNFILES_MANIFEST_FILE="$0.runfiles/MANIFEST"
    elif [[ -f "$0.runfiles_manifest" ]]; then
    export RUNFILES_MANIFEST_FILE="$0.runfiles_manifest"
    elif [[ -n "$RUNFILES_DIR" ]]; then
    export RUNFILES_MANIFEST_FILE="$RUNFILES_DIR/MANIFEST"
    fi
fi

echo "Using for MANIFEST $RUNFILES_MANIFEST_FILE in $PWD"
DIR=$(dirname $RUNFILES_MANIFEST_FILE)

PREPARELINKPRG="{prepare}"
LAUNCHERPATH="{launch}"
EXEBASENAME="{exebasename}"

PREPARE=`awk '{{if ($1 ~ "{prepare}") {{print $2;exit}} }}' $RUNFILES_MANIFEST_FILE`
$PREPARE $RUNFILES_MANIFEST_FILE

$DIR/dotnet $DIR/$EXEBASENAME "$@"
"""

_TEMPLATE_NET = """
set -eo pipefail
echo "Executing $0"

export PATH=/usr/bin:/bin:$PATH

if [[ -z "$RUNFILES_MANIFEST_FILE" ]]; then
    if [[ -f "$0.runfiles/MANIFEST" ]]; then
    export RUNFILES_MANIFEST_FILE="$0.runfiles/MANIFEST"
    elif [[ -f "$0.runfiles_manifest" ]]; then
    export RUNFILES_MANIFEST_FILE="$0.runfiles_manifest"
    elif [[ -n "$RUNFILES_DIR" ]]; then
    export RUNFILES_MANIFEST_FILE="$RUNFILES_DIR/MANIFEST"
    fi
fi

echo "Using for MANIFEST $RUNFILES_MANIFEST_FILE"
DIR=$(dirname $RUNFILES_MANIFEST_FILE)

PREPARELINKPRG="{prepare}"
LAUNCHERPATH="{launch}"
EXEBASENAME="{exebasename}"

PREPARE=`awk '{{if ($1 ~ "{prepare}") {{print $2;exit}} }}' $RUNFILES_MANIFEST_FILE`
$PREPARE $RUNFILES_MANIFEST_FILE

$PREPARE $RUNFILES_MANIFEST_FILE
$DIR/$EXEBASENAME "$@"
"""

def _binary_impl(ctx):
    """dotnet_binary_impl emits actions for compiling dotnet executable assembly."""
    dotnet = dotnet_context(ctx)
    name = ctx.label.name

    if dotnet.assembly == None:
        empty = dotnet.declare_file(dotnet, path = "empty.sh")
        dotnet.actions.write(output = empty, content = "echo assembly generations is not supported on this platform'")
        library = dotnet.new_library(dotnet = dotnet)
        return [library, DefaultInfo(executable = empty)]

    executable = dotnet.assembly(
        dotnet,
        name = name,
        srcs = ctx.attr.srcs,
        deps = ctx.attr.deps,
        resources = ctx.attr.resources,
        out = ctx.attr.out,
        defines = ctx.attr.defines,
        unsafe = ctx.attr.unsafe,
        data = ctx.attr.data,
        executable = True,
        keyfile = ctx.attr.keyfile,
    )

    launcher = ctx.actions.declare_file("{}.bash".format(name))
    content = ctx.attr._template.format(
        prepare = ctx.attr._manifest_prep.files.to_list()[0].basename,
        launch = launcher.path,
        exebasename = executable.result.basename,
    )
    ctx.actions.write(output = launcher, content = content, is_executable = True)
    if dotnet.runner != None:
        runner = [dotnet.runner]
    else:
        runner = []
    runfiles = ctx.runfiles(files = [launcher] + ctx.attr._manifest_prep.files.to_list() + runner + ctx.attr.native_deps.files.to_list(), transitive_files = executable.runfiles)

    return [
        executable,
        DefaultInfo(
            files = depset([executable.result, launcher]),
            runfiles = runfiles,
            executable = launcher,
        ),
    ]

def _binary_impl2(ctx):
    """dotnet_binary_impl emits actions for compiling dotnet executable assembly."""
    dotnet = dotnet_context(ctx)
    name = ctx.label.name

    if dotnet.assembly == None:
        empty = dotnet.declare_file(dotnet, path = "empty.sh")
        dotnet.actions.write(output = empty, content = "echo assembly generations is not supported on this platform'")
        library = dotnet.new_library(dotnet = dotnet)
        return [library, DefaultInfo(executable = empty)]

    executable = dotnet.assembly(
        dotnet,
        name = paths.split_extension(name)[0] + "_0.dll",
        srcs = ctx.attr.srcs,
        deps = ctx.attr.deps,
        resources = ctx.attr.resources,
        out = None,
        defines = ctx.attr.defines,
        unsafe = ctx.attr.unsafe,
        data = ctx.attr.data,
        executable = True,
        keyfile = ctx.attr.keyfile,
    )

    launcher = dotnet.declare_file(dotnet, path = name)
    ctx.actions.run(
        outputs = [launcher],
        inputs = ctx.attr._launcher.files.to_list(),
        executable = ctx.attr._copy.files.to_list()[0],
        arguments = [launcher.path, ctx.attr._launcher.files.to_list()[0].path],
        mnemonic = "CopyLauncher",
    )

    if dotnet.runner != None:
        runner = [dotnet.runner]
    else:
        runner = []
    runfiles = ctx.runfiles(files = [launcher] + runner + ctx.attr.native_deps.files.to_list(), transitive_files = executable.runfiles)

    return [
        executable,
        DefaultInfo(
            files = depset([executable.result, launcher]),
            runfiles = runfiles,
            executable = launcher,
        ),
    ]

dotnet_binary = rule(
    _binary_impl2,
    attrs = {
        "deps": attr.label_list(providers = [DotnetLibrary]),
        "resources": attr.label_list(providers = [DotnetResourceList]),
        "srcs": attr.label_list(allow_files = [".cs"]),
        "out": attr.string(),
        "defines": attr.string_list(),
        "unsafe": attr.bool(default = False),
        "data": attr.label_list(allow_files = True),
        "keyfile": attr.label(allow_files = True),
        "dotnet_context_data": attr.label(default = Label("@io_bazel_rules_dotnet//:dotnet_context_data")),
        "native_deps": attr.label(default = Label("@dotnet_sdk//:native_deps")),
        "_launcher": attr.label(default = Label("//dotnet/tools/launcher_mono:launcher_mono.exe")),
        "_copy": attr.label(default = Label("//dotnet/tools/copy")),
    },
    toolchains = ["@io_bazel_rules_dotnet//dotnet:toolchain"],
    executable = True,
)

core_binary = rule(
    _binary_impl2,
    attrs = {
        "deps": attr.label_list(providers = [DotnetLibrary]),
        "resources": attr.label_list(providers = [DotnetResourceList]),
        "srcs": attr.label_list(allow_files = [".cs"]),
        "defines": attr.string_list(),
        "unsafe": attr.bool(default = False),
        "data": attr.label_list(allow_files = True),
        "keyfile": attr.label(allow_files = True),
        "dotnet_context_data": attr.label(default = Label("@io_bazel_rules_dotnet//:core_context_data")),
        "native_deps": attr.label(default = Label("@core_sdk//:native_deps")),
        "_launcher": attr.label(default = Label("//dotnet/tools/launcher_core:launcher_core.exe")),
        "_copy": attr.label(default = Label("//dotnet/tools/copy")),
    },
    toolchains = ["@io_bazel_rules_dotnet//dotnet:toolchain_core"],
    executable = True,
)

net_binary = rule(
    _binary_impl2,
    attrs = {
        "deps": attr.label_list(providers = [DotnetLibrary]),
        "resources": attr.label_list(providers = [DotnetResourceList]),
        "srcs": attr.label_list(allow_files = [".cs"]),
        "defines": attr.string_list(),
        "unsafe": attr.bool(default = False),
        "data": attr.label_list(allow_files = True),
        "keyfile": attr.label(allow_files = True),
        "dotnet_context_data": attr.label(default = Label("@io_bazel_rules_dotnet//:net_context_data")),
        "native_deps": attr.label(default = Label("@net_sdk//:native_deps")),
        "_launcher": attr.label(default = Label("//dotnet/tools/launcher_net:launcher_net.exe")),
        "_copy": attr.label(default = Label("//dotnet/tools/copy")),
    },
    toolchains = ["@io_bazel_rules_dotnet//dotnet:toolchain_net"],
    executable = True,
)
