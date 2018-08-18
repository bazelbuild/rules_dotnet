load(
    "@io_bazel_rules_dotnet//dotnet/private:context.bzl",
    "dotnet_context",
)

load(
    "@io_bazel_rules_dotnet//dotnet/private:common.bzl",
    "paths",
)

def _get_dotnet_stdlib_byname(lib, libVersion, name):
  lname = name.lower()
  for f in lib.files:
    basename = paths.basename(f.path)
    if basename.lower() != lname:
      continue
    dirname = paths.dirname(f.path)
    if dirname.find(libVersion)==-1:
      continue
    return f
  fail("Could not find %s in dotnet_sdk (lib)" % name)


# TODO(tomek) we don't need special treatment for mscorlib.dll
def _dotnet_stdlib_impl(ctx):
  """dotnet_stdlib_impl emits the assembly from @dotnet_sdk//:lib."""
  dotnet = dotnet_context(ctx)
  name = ctx.label.name
  result = _get_dotnet_stdlib_byname(dotnet.lib, dotnet.libVersion, name)

  library = dotnet.new_library(
    dotnet = dotnet, 
    name = name, 
    deps = None, 
    transitive = depset([]),
    result = result)
 
  return [
      library,
      DefaultInfo(
          files = depset([library.result]),
      ),
  ]
  
dotnet_stdlib = rule(
    _dotnet_stdlib_impl,
    attrs = {
        "_dotnet_context_data": attr.label(default = Label("@io_bazel_rules_dotnet//:dotnet_context_data"))
    },
    toolchains = ["@io_bazel_rules_dotnet//dotnet:toolchain"],
    executable = False,
)