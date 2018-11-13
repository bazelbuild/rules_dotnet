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

PREPARE=`awk '{{if ($1 ~ "{prepare}") {{print $2;exit}} }}' $RUNFILES_MANIFEST_FILE`
$PREPARE $RUNFILES_MANIFEST_FILE

if [[ "$OSTYPE" == "darwin"* ]]; then
    READLINK=greadlink
else
    READLINK=readlink
fi

MONOPRG=`$READLINK -f $DIR/mono`
echo "Using $MONOPRG"
"$MONOPRG" $DIR/{testlauncher} $DIR/$EXEBASENAME "$@"
"""

def _dotnet_nunit_test(ctx):
  """net_binary_impl emits actions for compiling dotnet executable assembly."""
  dotnet = dotnet_context(ctx)
  name = ctx.label.name
 
  # Handle case of empty toolchain on linux and darwin
  if dotnet.assembly == None:
    empty = dotnet.declare_file(dotnet, path="empty.sh")
    dotnet.actions.write(output = empty, content = "echo '.net not supported on this platform'")
    library = dotnet.new_library(dotnet = dotnet)
    return [library, DefaultInfo(executable = empty)]

  library = dotnet.assembly(dotnet,
      name = name,
      srcs = ctx.attr.srcs,
      deps = ctx.attr.deps,
      resources = ctx.attr.resources,
      out = ctx.attr.out,
      defines = ctx.attr.defines,
      unsafe = ctx.attr.unsafe,
      data = ctx.attr.data,
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

  runfiles = ctx.runfiles(files = [launcher]  + ctx.attr._manifest_prep.files.to_list() + [dotnet.runner] + ctx.attr._native_deps.files.to_list(), transitive_files=library.runfiles)
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
  
dotnet_nunit_test = rule(
    _dotnet_nunit_test,
    attrs = {
        "deps": attr.label_list(providers=[DotnetLibrary]),
        "resources": attr.label_list(providers=[DotnetResource]),
        "srcs": attr.label_list(allow_files = FileType([".cs"])),        
        "out": attr.string(),
        "defines": attr.string_list(),
        "unsafe": attr.bool(default = False),
        "data": attr.label_list(),
        "_dotnet_context_data": attr.label(default = Label("@io_bazel_rules_dotnet//:dotnet_context_data")),
        "_manifest_prep": attr.label(default = Label("//dotnet/tools/manifest_prep")),
        "_native_deps": attr.label(default = Label("@dotnet_sdk//:native_deps")),
        "testlauncher": attr.label(default = "@nunit2//:nunit-console-runner-exe", providers=[DotnetLibrary])
    },
    toolchains = ["@io_bazel_rules_dotnet//dotnet:toolchain"],
    executable = True,
    test = True,
)

