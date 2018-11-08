load(
    "@io_bazel_rules_dotnet//dotnet/private:context.bzl",
    "dotnet_context",
)

load(
    "@io_bazel_rules_dotnet//dotnet/private:providers.bzl",
    "DotnetLibrary",
)

load(
    "@io_bazel_rules_dotnet//dotnet/private:common.bzl",
    "paths",
    "sets"
)

def _get_net_stdlib_byname(shared, libVersion, name):
  lname = name.lower()
  for f in shared.files:
    basename = paths.basename(f.path)
    if basename.lower() != lname:
      continue
    return f
  fail("Could not find %s in net_sdk (shared)" % name)


# TODO(tomek) we don't need special treatment for mscorlib.dll
def _net_stdlib_impl(ctx):
  """_net_stdlib_impl emits the assembly from @net_sdk//:shared."""
  dotnet = dotnet_context(ctx)
  name = ctx.label.name

  # Handle case of empty toolchain on linux and darwin
  if dotnet.assembly == None:
    library = dotnet.new_library(dotnet = dotnet)
    return [library]

  result = _get_net_stdlib_byname(dotnet.shared, dotnet.libVersion, name)

  deps = ctx.attr.deps
  deps_libraries = [d[DotnetLibrary] for d in deps]
  transitive = sets.union(deps_libraries, *[a[DotnetLibrary].transitive for a in deps])

  library = dotnet.new_library(
    dotnet = dotnet, 
    name = name, 
    deps = deps, 
    transitive = transitive,
    result = result)
 
  return [
      library,
      DefaultInfo(
          files = depset([library.result]),
      ),
  ]
  
net_stdlib = rule(
    _net_stdlib_impl,
    attrs = {
        "deps": attr.label_list(providers=[DotnetLibrary]),        
        "_dotnet_context_data": attr.label(default = Label("@io_bazel_rules_dotnet//:net_context_data"))
    },
    toolchains = ["@io_bazel_rules_dotnet//dotnet:toolchain_net"],
    executable = False,
)