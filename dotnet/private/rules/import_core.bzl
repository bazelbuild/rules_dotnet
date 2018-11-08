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


def _core_import_library_impl(ctx):
  """core_import_library_impl emits actions for importing an external dll (for example provided by nuget)."""
  dotnet = dotnet_context(ctx)
  name = ctx.label.name
 
  # Handle case of empty toolchain on linux and darwin
  if dotnet.assembly == None:
    library = dotnet.new_library(dotnet = dotnet)
    return [library]

  deps = ctx.attr.deps
  src = ctx.attr.src
  result = src.files.to_list()[0]
  data = ctx.attr.data

  transitive = depset(direct = deps, transitive = [d[DotnetLibrary].transitive for d in deps])
  extra = depset(direct = [result], transitive = [t.files for t in data])
  direct = extra.to_list()    
  runfiles = depset(direct = direct, transitive = [a[DotnetLibrary].runfiles for a in deps])

  library = dotnet.new_library(
    dotnet = dotnet, 
    name = name, 
    deps = deps, 
    transitive = transitive,
    result = result,
    runfiles = runfiles)

  return [
      library,
      DefaultInfo(
          files = depset([library.result]),
          runfiles = ctx.runfiles(files = [], transitive_files = runfiles),
      ),
  ]
  
core_import_library = rule(
    _core_import_library_impl,
    attrs = {
        "deps": attr.label_list(providers=[DotnetLibrary]),
        "src": attr.label(allow_files = FileType([".dll", ".exe"]), mandatory=True),        
        "data": attr.label_list(allow_files = True),        
        "_dotnet_context_data": attr.label(default = Label("@io_bazel_rules_dotnet//:core_context_data"))
    },
    toolchains = ["@io_bazel_rules_dotnet//dotnet:toolchain_core"],
    executable = False,
)
