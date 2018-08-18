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
    "sets"
)


def _dotnet_imort_library_impl(ctx):
  """dotnet_import_library_impl emits actions for importing an external dll (for example provided by nuget)."""
  dotnet = dotnet_context(ctx)
  name = ctx.label.name
 
  deps = ctx.attr.deps
  src = ctx.attr.src

  deps_libraries = [d[DotnetLibrary] for d in deps]
  transitive = sets.union(deps_libraries, *[a[DotnetLibrary].transitive for a in deps])

  library = dotnet.new_library(
    dotnet = dotnet, 
    name = name, 
    deps = deps, 
    transitive = transitive,
    result = src.files.to_list()[0])

  transitive_files = [d.result for d in library.transitive.to_list()]

  return [
      library,
      DefaultInfo(
          files = depset([library.result]),
          runfiles = ctx.runfiles(files = [dotnet.stdlib, library.result], transitive_files=depset(direct=transitive_files)),
      ),
  ]
  
dotnet_import_library = rule(
    _dotnet_imort_library_impl,
    attrs = {
        "deps": attr.label_list(providers=[DotnetLibrary]),
        "src": attr.label(allow_files = FileType([".dll"]), mandatory=True),        
        "_dotnet_context_data": attr.label(default = Label("@io_bazel_rules_dotnet//:dotnet_context_data"))
    },
    toolchains = ["@io_bazel_rules_dotnet//dotnet:toolchain"],
    executable = False,
)