load(
    "@io_bazel_rules_dotnet//dotnet/private:context.bzl",
    "dotnet_context",
)

load(
    "@io_bazel_rules_dotnet//dotnet/private:providers.bzl",
    "DotnetLibrary",
    "DotnetResource",
)

load(
    "@io_bazel_rules_dotnet//dotnet/private:rules/launcher_gen.bzl",
    "dotnet_launcher_gen",
)

_TEMPLATE = """
DIR=$0.runfiles
$DIR/dotnet $DIR/{} "$@"
"""


def _core_binary_impl(ctx):
  """dotnet_binary_impl emits actions for compiling dotnet executable assembly."""
  dotnet = dotnet_context(ctx)
  name = ctx.label.name
 
  executable = dotnet.binary(dotnet,
      name = name,
      srcs = ctx.attr.srcs,
      deps = ctx.attr.deps,
      resources = ctx.attr.resources,
      out = ctx.attr.out,
      defines = ctx.attr.defines,
      unsafe = ctx.attr.unsafe,
      data = ctx.attr.data,
  )

  launcher = ctx.actions.declare_file("{}.bash".format(name))
  content = _TEMPLATE.format(executable.result.basename)
  ctx.actions.write(output = launcher, content = content, is_executable=False)

  out = ctx.actions.declare_file("{}.out".format(name))
  ctx.actions.run(outputs=[out], inputs=[launcher, executable.result], executable=ctx.attr._manifest_prep.files.to_list()[0], arguments=[launcher.path, out.path])

  return [
      DefaultInfo(
          files = depset([executable.result, launcher, out]),
          runfiles = ctx.runfiles(files = ctx.attr._native_deps.files.to_list() + [dotnet.runner] + ctx.attr._manifest_prep.files.to_list(), transitive_files = executable.runfiles),
          executable = launcher,
      ),
  ]
  
core_binary = rule(
    _core_binary_impl,
    attrs = {
        "deps": attr.label_list(providers=[DotnetLibrary]),
        "resources": attr.label_list(providers=[DotnetResource]),
        "srcs": attr.label_list(allow_files = FileType([".cs"])),        
        "out": attr.string(),
        "defines": attr.string_list(),
        "unsafe": attr.bool(default = False),
        "data": attr.label_list(allow_files = True),        
        "_dotnet_context_data": attr.label(default = Label("@io_bazel_rules_dotnet//:core_context_data")),
        "_native_deps": attr.label(default = Label("@core_sdk//:native_deps")),
        "_manifest_prep": attr.label(default = Label("//dotnet/tools/manifest_prep"))
    },
    toolchains = ["@io_bazel_rules_dotnet//dotnet:toolchain_core"],
    executable = True,
)
