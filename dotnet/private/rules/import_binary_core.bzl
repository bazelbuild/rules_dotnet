load(
    "@io_bazel_rules_dotnet//dotnet/private:context.bzl",
    "dotnet_context",
)

load(
    "@io_bazel_rules_dotnet//dotnet/private:providers.bzl",
    "DotnetLibrary",
)

def _core_import_binary_impl(ctx):
  """core_import_library_impl emits actions for importing an external executable (for example provided by nuget)."""
  dotnet = dotnet_context(ctx)
  name = ctx.label.name
 
  deps = ctx.attr.deps
  src = ctx.attr.src
  result = src.files.to_list()[0]

  runfiles = depset(direct=[result] + [dotnet.stdlib], transitive=[d[DotnetLibrary].runfiles for d in deps])
  transitive = depset(direct=deps, transitive=[a[DotnetLibrary].transitive for a in deps])


  library = dotnet.new_library(
    dotnet = dotnet, 
    name = name, 
    deps = deps, 
    transitive = transitive,
    runfiles = runfiles,
    result = result)

  return [
      library,
      DefaultInfo(
          files = depset([library.result]),
          runfiles = ctx.runfiles(files = ctx.attr._native_deps.files.to_list(), transitive_files = library.runfiles),
      ),
  ]
  
core_import_binary = rule(
    _core_import_binary_impl,
    attrs = {
        "deps": attr.label_list(providers=[DotnetLibrary]),
        "src": attr.label(allow_files = FileType([".dll"]), mandatory=True),        
        "_dotnet_context_data": attr.label(default = Label("@io_bazel_rules_dotnet//:core_context_data")),
        "_native_deps": attr.label(default = Label("@core_sdk//:native_deps"))
    },
    toolchains = ["@io_bazel_rules_dotnet//dotnet:toolchain_core"],
    executable = False,
)
