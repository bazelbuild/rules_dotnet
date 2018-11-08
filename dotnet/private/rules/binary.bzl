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
PREPARELINKPRG="{prepare}"
LAUNCHERPATH="{launch}"
EXEBASENAME="{exebasename}"

DIR=$0.runfiles
MANIFEST=$DIR/MANIFEST

PREPARE=`/usr/bin/awk '{{if ($1 ~ "{prepare}") {{print $2;exit}} }}' $MANIFEST`

export MONO_PATH=$DIR
$PREPARE $LAUNCHERPATH
$DIR/mono $DIR/$EXEBASENAME "$@"
"""


def _dotnet_binary_impl(ctx):
  """dotnet_binary_impl emits actions for compiling dotnet executable assembly."""
  dotnet = dotnet_context(ctx)
  name = ctx.label.name
 
  executable = dotnet.assembly(dotnet,
      name = name,
      srcs = ctx.attr.srcs,
      deps = ctx.attr.deps,
      resources = ctx.attr.resources,
      out = ctx.attr.out,
      defines = ctx.attr.defines,
      unsafe = ctx.attr.unsafe,
      data = ctx.attr.data,
      executable = True,
  )


  launcher = ctx.actions.declare_file("{}.bash".format(name))
  content = _TEMPLATE.format(
      prepare=ctx.attr._manifest_prep.files.to_list()[0].basename, 
      launch=launcher.path, 
      exebasename=executable.result.basename
  )
  ctx.actions.write(output = launcher, content = content, is_executable=True)  
  runfiles = ctx.runfiles(files = [launcher]  + ctx.attr._manifest_prep.files.to_list() + [dotnet.runner], transitive_files=executable.runfiles)

  return [
      executable,
      DefaultInfo(
          files = depset([executable.result, launcher]),
          runfiles = runfiles,
          executable = launcher,
      ),
  ]
  
dotnet_binary = rule(
    _dotnet_binary_impl,
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
    },
    toolchains = ["@io_bazel_rules_dotnet//dotnet:toolchain"],
    executable = True,
)
