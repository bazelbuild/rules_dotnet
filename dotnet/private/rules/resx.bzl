load(
    "@io_bazel_rules_dotnet//dotnet/private:context.bzl",
    "dotnet_context",
)


def _resx_impl(ctx):
  """dotnet_resx_impl emits actions for compiling resx to resource."""
  dotnet = dotnet_context(ctx)
  name = ctx.label.name
 
  # Handle case of empty toolchain on linux and darwin
  if dotnet.resx == None:
    result = dotnet.declare_file(dotnet, path="empty.resources")
    dotnet.actions.write(output = result, content = ".net not supported on this platform")
    empty = dotnet.new_resource(dotnet = dotnet, name = name, result=result)
    return [empty]

  resource = dotnet.resx(dotnet,
      name = name,
      src = ctx.attr.src,
      identifier = ctx.attr.identifier,
      out = ctx.attr.out,
      customresgen = ctx.attr._simpleresgen,
  )
  return [
      resource,
      DefaultInfo(
          files = depset([resource.result]),
      ),
  ]
  
net_resx = rule(
    _resx_impl,
    attrs = {
        # source files for this target.
        "src": attr.label(allow_files = FileType([".resx"]), mandatory=True),        
        "identifier": attr.string(),
        "out": attr.string(),
        "_dotnet_context_data": attr.label(default = Label("@io_bazel_rules_dotnet//:net_context_data")),
        "_simpleresgen": attr.label(),
    },
    toolchains = ["@io_bazel_rules_dotnet//dotnet:toolchain_net"],
    executable = False,
)  
dotnet_resx = rule(
    _resx_impl,
    attrs = {
        # source files for this target.
        "src": attr.label(allow_files = FileType([".resx"]), mandatory=True),        
        "identifier": attr.string(),
        "out": attr.string(),
        "_dotnet_context_data": attr.label(default = Label("@io_bazel_rules_dotnet//:dotnet_context_data")),
        "_simpleresgen": attr.label(),
    },
    toolchains = ["@io_bazel_rules_dotnet//dotnet:toolchain"],
    executable = False,
)

core_resx = rule(
    _resx_impl,
    attrs = {
        # source files for this target.
        "src": attr.label(allow_files = FileType([".resx"]), mandatory=True),        
        "identifier": attr.string(),
        "out": attr.string(),
        "_dotnet_context_data": attr.label(default = Label("@io_bazel_rules_dotnet//:core_context_data")),
        "_simpleresgen": attr.label(default = Label("@io_bazel_rules_dotnet//tools/simpleresgen:simpleresgen")),
    },
    toolchains = ["@io_bazel_rules_dotnet//dotnet:toolchain_core"],
    executable = False,
)  
