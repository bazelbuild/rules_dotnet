load(
    "@io_bazel_rules_dotnet//dotnet/private:context.bzl",
    "dotnet_context",
)

load(
    "@io_bazel_rules_dotnet//dotnet/private:providers.bzl",
    "DotnetLibrary",
    "DotnetResource",
)

_TEMPLATE = """
set -euo pipefail
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

PREPARELINKPRG="{prepare}"
LAUNCHERPATH="{launch}"
EXEBASENAME="{exebasename}"

PATH=/usr/bin:/bin:$PATH
PREPARE=`awk '{{if ($1 ~ "{prepare}") {{print $2;exit}} }}' $RUNFILES_MANIFEST_FILE`

$PREPARE $RUNFILES_MANIFEST_FILE

$DIR/dotnet $DIR/{testlauncher} $DIR/$EXEBASENAME "$@"
"""

def _core_xunit_test(ctx):
  dotnet = dotnet_context(ctx)
  name = ctx.label.name
 
  library = dotnet.assembly(dotnet,
      name = name,
      srcs = ctx.attr.srcs,
      deps = ctx.attr.deps,
      resources = ctx.attr.resources,
      out = ctx.attr.out,
      defines = ctx.attr.defines,
      unsafe = ctx.attr.unsafe,
      executable = False,
  )

  testlauncher = ctx.attr.testlauncher.files.to_list()[0].basename

  launcher = ctx.actions.declare_file("{}.bash".format(name))
  content = _TEMPLATE.format(
      prepare=ctx.attr._manifest_prep.files.to_list()[0].basename, 
      launch=launcher.path, 
      exebasename=library.result.basename,
      testlauncher = testlauncher
  )
  ctx.actions.write(output = launcher, content = content, is_executable=True)

  runfiles = ctx.runfiles(files = [launcher]  + ctx.attr._manifest_prep.files.to_list(), transitive_files=library.runfiles)
  test_launcher_runfiles = ctx.runfiles(files=[ctx.attr.testlauncher[DotnetLibrary].result], transitive_files = ctx.attr.testlauncher[DotnetLibrary].runfiles)
  runfiles = runfiles.merge(test_launcher_runfiles)

  return [
      library,
      DefaultInfo(
          files = depset([library.result, launcher]),
          runfiles = runfiles,
          executable = launcher,
      ),
  ]
  
core_xunit_test = rule(
    _core_xunit_test,
    attrs = {
        "deps": attr.label_list(providers=[DotnetLibrary]),
        "resources": attr.label_list(providers=[DotnetResource]),
        "srcs": attr.label_list(allow_files = FileType([".cs"])),        
        "out": attr.string(),
        "defines": attr.string_list(),
        "unsafe": attr.bool(default = False),
        "_dotnet_context_data": attr.label(default = Label("@io_bazel_rules_dotnet//:core_context_data")),
        "_manifest_prep": attr.label(default = Label("//dotnet/tools/manifest_prep")),
        "testlauncher": attr.label(default = "@nunit3_consolerunner//:nunit3.console.exe", providers=[DotnetLibrary])
    },
    toolchains = ["@io_bazel_rules_dotnet//dotnet:toolchain_core"],
    executable = True,
    test = True,
)

 