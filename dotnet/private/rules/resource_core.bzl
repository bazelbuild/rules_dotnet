load(
    "@io_bazel_rules_dotnet//dotnet/private:context.bzl",
    "dotnet_context",
)

def _core_resource_impl(ctx):
    """core_resource_impl emits actions for embeding file as resource."""
    dotnet = dotnet_context(ctx)
    name = ctx.label.name

    resource = dotnet.new_resource(
        dotnet = dotnet,
        name = name,
        result = ctx.attr.src.files.to_list()[0],
        identifier = ctx.attr.identifier,
    )

    return [
        resource,
        DefaultInfo(
            files = depset([resource.result]),
        ),
    ]

core_resource = rule(
    _core_resource_impl,
    attrs = {
        # source files for this target.
        "src": attr.label(allow_files = True, mandatory = True),
        "identifier": attr.string(),
        "_dotnet_context_data": attr.label(default = Label("@io_bazel_rules_dotnet//:core_context_data")),
    },
    toolchains = ["@io_bazel_rules_dotnet//dotnet:toolchain_core"],
    executable = False,
)
