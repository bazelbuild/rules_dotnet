load(
    "@rules_mono//dotnet/private:context.bzl",
    "dotnet_context",
)
load(
    "@rules_mono//dotnet/private:providers.bzl",
    "DotnetResourceList",
)
load("@rules_dotnet_skylib//lib:paths.bzl", "paths")

def _resource_impl(ctx):
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
        DotnetResourceList(result = [resource]),
        DefaultInfo(
            files = depset([resource.result]),
        ),
    ]

def _resource_multi_impl(ctx):
    dotnet = dotnet_context(ctx)
    name = ctx.label.name

    if ctx.attr.identifierBase != "" and ctx.attr.fixedIdentifierBase != "":
        fail("Both identifierBase and fixedIdentifierBase cannot be specified")

    result = []
    for d in ctx.attr.srcs:
        for k in d.files.to_list():
            if ctx.attr.identifierBase != "":
                base = paths.dirname(ctx.build_file_path)
                identifier = k.path.replace(base, ctx.attr.identifierBase, 1)
                identifier = identifier.replace("/", ".")
            else:
                identifier = ctx.attr.fixedIdentifierBase + "." + paths.basename(k.path)

            resource = dotnet.new_resource(
                dotnet = dotnet,
                name = identifier,
                result = k,
                identifier = identifier,
            )
            result.append(resource)

    return [
        DotnetResourceList(result = result),
        DefaultInfo(
            files = depset([d.result for d in result]),
        ),
    ]

core_resource = rule(
    _resource_impl,
    attrs = {
        # source files for this target.
        "src": attr.label(allow_single_file = True, mandatory = True),
        "identifier": attr.string(),
        "dotnet_context_data": attr.label(default = Label("@rules_mono//:core_context_data")),
    },
    toolchains = ["@rules_mono//dotnet:toolchain_type_core"],
    executable = False,
)

core_resource_multi = rule(
    _resource_multi_impl,
    attrs = {
        # source files for this target.
        "srcs": attr.label_list(allow_files = True, mandatory = True),
        "identifierBase": attr.string(),
        "fixedIdentifierBase": attr.string(),
        "dotnet_context_data": attr.label(default = Label("@rules_mono//:core_context_data")),
    },
    toolchains = ["@rules_mono//dotnet:toolchain_type_core"],
    executable = False,
)

net_resource = rule(
    _resource_impl,
    attrs = {
        # source files for this target.
        "src": attr.label(allow_single_file = True, mandatory = True),
        "identifier": attr.string(),
        "dotnet_context_data": attr.label(default = Label("@rules_mono//:net_context_data")),
    },
    toolchains = ["@rules_mono//dotnet:toolchain_type_net"],
    executable = False,
)

net_resource_multi = rule(
    _resource_multi_impl,
    attrs = {
        # source files for this target.
        "srcs": attr.label_list(allow_files = True, mandatory = True),
        "identifierBase": attr.string(),
        "fixedIdentifierBase": attr.string(),
        "dotnet_context_data": attr.label(default = Label("@rules_mono//:net_context_data")),
    },
    toolchains = ["@rules_mono//dotnet:toolchain_type_net"],
    executable = False,
)
