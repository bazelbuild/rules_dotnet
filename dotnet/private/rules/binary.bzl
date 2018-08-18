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

def _dotnet_binary_impl(ctx):
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
  )

  transitive_files = [d.result for d in executable.transitive.to_list()]

  return [
      DefaultInfo(
          files = depset([executable.result]),
          runfiles = ctx.runfiles(files = [dotnet.stdlib, dotnet.runner], transitive_files=depset(direct=transitive_files)),
          executable = executable.result,
      ),
  ]
  
_dotnet_binary = rule(
    _dotnet_binary_impl,
    attrs = {
        "deps": attr.label_list(providers=[DotnetLibrary]),
        "resources": attr.label_list(providers=[DotnetResource]),
        "srcs": attr.label_list(allow_files = FileType([".cs"])),        
        "out": attr.string(),
        "defines": attr.string_list(),
        "_dotnet_context_data": attr.label(default = Label("@io_bazel_rules_dotnet//:dotnet_context_data")),
    },
    toolchains = ["@io_bazel_rules_dotnet//dotnet:toolchain"],
    executable = True,
)

def dotnet_binary(name, srcs, deps = [], defines = None, out = None):
    _dotnet_binary(name = "%s_exe" % name, deps = deps, srcs = srcs, out = out, defines = defines)
    exe = ":%s_exe" % name
    dotnet_launcher_gen(name = "%s_launcher" % name, exe = exe)

    native.cc_binary(
        name=name, 
        srcs = [":%s_launcher" % name],
        deps = ["@io_bazel_rules_dotnet//dotnet/tools/runner", "@io_bazel_rules_dotnet//dotnet/tools/common"],
        data = [exe],
    )