load(
    "@io_bazel_rules_dotnet//dotnet/private:context.bzl",
    "dotnet_context",
)

load(
    "@io_bazel_rules_dotnet//dotnet/private:providers.bzl",
    "DotnetLibrary",
)

load(
    "@io_bazel_rules_dotnet//dotnet/private:rules/launcher_gen.bzl",
    "dotnet_launcher_gen",
)

def _core_import_binary_impl(ctx):
  """core_import_library_impl emits actions for importing an external executable (for example provided by nuget)."""
  dotnet = dotnet_context(ctx)
  name = ctx.label.name
 
  deps = ctx.attr.deps
  src = ctx.attr.src

  deps_libraries = [d[DotnetLibrary] for d in deps]  
  transitive = depset(direct = deps, transitive = [d[DotnetLibrary].transitive for d in deps])
  runfiles = depset(direct = [src.files.to_list()[0]] + ctx.attr._native_deps.files.to_list(), transitive = [a[DotnetLibrary].runfiles for a in transitive])


  library = dotnet.new_library(
    dotnet = dotnet, 
    name = name, 
    deps = deps, 
    transitive = transitive,
    result = src.files.to_list()[0],
    runfiles = runfiles)

  return [
      library,
      DefaultInfo(
          files = depset([library.result]),
          runfiles = ctx.runfiles(files = ctx.attr._native_deps.files.to_list() + [dotnet.runner], transitive_files = library.runfiles),
      ),
  ]
  
_core_import_binary = rule(
    _core_import_binary_impl,
    attrs = {
        "deps": attr.label_list(providers=[DotnetLibrary]),
        "src": attr.label(allow_files = FileType([".dll"]), mandatory=True),        
        "_dotnet_context_data": attr.label(default = Label("@io_bazel_rules_dotnet//:core_context_data")),
        "_native_deps": attr.label(default = Label("@core_sdk//:native_deps"))
    },
    toolchains = ["@io_bazel_rules_dotnet//dotnet:toolchain_core"],
)

def core_import_binary(name, src, deps = []):
    _core_import_binary(name = "%s_exe" % name, deps = deps, src = src)
    exe = ":%s_exe" % name
    dotnet_launcher_gen(name = "%s_launcher" % name, exe = exe)

    native.cc_binary(
        name=name, 
        srcs = [":%s_launcher" % name],
        deps = ["@io_bazel_rules_dotnet//dotnet/tools/runner_core", "@io_bazel_rules_dotnet//dotnet/tools/common"],
        data = [exe],
    )