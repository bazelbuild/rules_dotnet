load(
    "@io_bazel_rules_dotnet//dotnet/private:context.bzl",
    "dotnet_context",
)

load(
    "@io_bazel_rules_dotnet//dotnet/private:providers.bzl",
    "DotnetLibrary",
)

def _import_library_impl(ctx):
  """net_import_library_impl emits actions for importing an external dll (for example provided by nuget)."""
  dotnet = dotnet_context(ctx)
  name = ctx.label.name
 
  # Handle case of empty toolchain on linux and darwin
  if dotnet.assembly == None:
    library = dotnet.new_library(dotnet = dotnet)
    return [library]

  deps = ctx.attr.deps
  src = ctx.attr.src
  result = src.files.to_list()[0]

  if ctx.attr.data != None:
    data = depset(direct=[], transitive = [t.files for t in ctx.attr.data])
  else:
    data = depset()

  runfiles = depset(direct=[result] + [dotnet.stdlib], transitive=[d[DotnetLibrary].runfiles for d in deps]+[data])
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
          runfiles = ctx.runfiles(files = ctx.attr._native_deps.files.to_list(), transitive_files=library.runfiles),
      ),
  ]
  
dotnet_import_library = rule(
    _import_library_impl,
    attrs = {
        "deps": attr.label_list(providers=[DotnetLibrary]),
        "src": attr.label(allow_files = FileType([".dll", ".exe"]), mandatory=True),        
        "data": attr.label_list(allow_files = True),        
        "_dotnet_context_data": attr.label(default = Label("@io_bazel_rules_dotnet//:dotnet_context_data")),
        "_native_deps": attr.label(default = Label("@dotnet_sdk//:native_deps"))
    },
    toolchains = ["@io_bazel_rules_dotnet//dotnet:toolchain"],
    executable = False,
)

dotnet_import_binary = rule(
    _import_library_impl,
    attrs = {
        "deps": attr.label_list(providers=[DotnetLibrary]),
        "src": attr.label(allow_files = FileType([".dll", ".exe"]), mandatory=True),        
        "data": attr.label_list(allow_files = True),        
        "_dotnet_context_data": attr.label(default = Label("@io_bazel_rules_dotnet//:dotnet_context_data")),
        "_native_deps": attr.label(default = Label("@dotnet_sdk//:native_deps"))
    },
    toolchains = ["@io_bazel_rules_dotnet//dotnet:toolchain"],
    executable = False,
)

core_import_library = rule(
    _import_library_impl,
    attrs = {
        "deps": attr.label_list(providers=[DotnetLibrary]),
        "src": attr.label(allow_files = FileType([".dll", ".exe"]), mandatory=True),        
        "data": attr.label_list(allow_files = True),        
        "_dotnet_context_data": attr.label(default = Label("@io_bazel_rules_dotnet//:core_context_data")),
        "_native_deps": attr.label(default = Label("@core_sdk//:native_deps"))
    },
    toolchains = ["@io_bazel_rules_dotnet//dotnet:toolchain_core"],
    executable = False,
)

core_import_binary = rule(
    _import_library_impl,
    attrs = {
        "deps": attr.label_list(providers=[DotnetLibrary]),
        "src": attr.label(allow_files = FileType([".dll", ".exe"]), mandatory=True),        
        "data": attr.label_list(allow_files = True),        
        "_dotnet_context_data": attr.label(default = Label("@io_bazel_rules_dotnet//:core_context_data")),
        "_native_deps": attr.label(default = Label("@core_sdk//:native_deps"))
    },
    toolchains = ["@io_bazel_rules_dotnet//dotnet:toolchain_core"],
    executable = False,
)

net_import_library = rule(
    _import_library_impl,
    attrs = {
        "deps": attr.label_list(providers=[DotnetLibrary]),
        "src": attr.label(allow_files = FileType([".dll", ".exe"]), mandatory=True),        
        "data": attr.label_list(allow_files = True),        
        "_dotnet_context_data": attr.label(default = Label("@io_bazel_rules_dotnet//:net_context_data")),
        "_native_deps": attr.label(default = Label("@net_sdk//:native_deps"))
    },
    toolchains = ["@io_bazel_rules_dotnet//dotnet:toolchain_net"],
    executable = False,
)

net_import_binary = rule(
    _import_library_impl,
    attrs = {
        "deps": attr.label_list(providers=[DotnetLibrary]),
        "src": attr.label(allow_files = FileType([".dll", ".exe"]), mandatory=True),        
        "data": attr.label_list(allow_files = True),        
        "_dotnet_context_data": attr.label(default = Label("@io_bazel_rules_dotnet//:net_context_data")),
        "_native_deps": attr.label(default = Label("@net_sdk//:native_deps"))
    },
    toolchains = ["@io_bazel_rules_dotnet//dotnet:toolchain_net"],
    executable = False,
)
