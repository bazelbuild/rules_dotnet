load(
    "@rules_mono//dotnet/private:context.bzl",
    "dotnet_context",
)
load(
    "@rules_mono//dotnet/private:providers.bzl",
    "DotnetResourceList",
)
load("@rules_dotnet_skylib//lib:paths.bzl", "paths")

def _resx_impl(ctx):
    """dotnet_resx_impl emits actions for compiling resx to resource."""
    dotnet = dotnet_context(ctx)
    name = ctx.label.name

    # Handle case of empty toolchain on linux and darwin
    if dotnet.resx == None:
        result = dotnet.declare_file(dotnet, path = "empty.resources")
        dotnet.actions.write(output = result, content = ".net not supported on this platform")
        empty = dotnet.new_resource(dotnet = dotnet, name = name, result = result)
        return [empty, DotnetResourceList(result = [empty])]

    resource = dotnet.resx(
        dotnet,
        name = name,
        src = ctx.attr.src,
        identifier = ctx.attr.identifier,
        out = ctx.attr.out,
        customresgen = ctx.attr.simpleresgen,
    )
    return [
        resource,
        DotnetResourceList(result = [resource]),
        DefaultInfo(
            files = depset([resource.result]),
        ),
    ]

def _resx_multi_impl(ctx):
    dotnet = dotnet_context(ctx)
    name = ctx.label.name

    if ctx.attr.identifierBase != "" and ctx.attr.fixedIdentifierBase != "":
        fail("Both identifierBase and fixedIdentifierBase cannot be specified")

    result = []
    for d in ctx.attr.srcs:
        for k in d.files.to_list():
            base = paths.dirname(ctx.build_file_path)
            if ctx.attr.identifierBase != "":
                identifier = k.path.replace(base, ctx.attr.identifierBase, 1)
                identifier = identifier.replace("/", ".")
                identifier = paths.replace_extension(identifier, ".resources")
            else:
                identifier = ctx.attr.fixedIdentifierBase + "." + paths.basename(k.path)
                identifier = paths.replace_extension(identifier, ".resources")

            resource = dotnet.resx(
                dotnet = dotnet,
                name = identifier,
                src = k,
                identifier = identifier,
                out = identifier,
                customresgen = ctx.attr.simpleresgen,
            )
            result.append(resource)

    return [
        DotnetResourceList(result = result),
        DefaultInfo(
            files = depset([d.result for d in result]),
        ),
    ]

net_resx = rule(
    _resx_impl,
    attrs = {
        # source files for this target.
        "src": attr.label(allow_files = [".resx"], mandatory = True),
        "identifier": attr.string(),
        "out": attr.string(),
        "dotnet_context_data": attr.label(default = Label("@rules_mono//:net_context_data")),
        "simpleresgen": attr.label(),
    },
    toolchains = ["@rules_mono//dotnet:toolchain_type_net"],
    executable = False,
)
dotnet_resx = rule(
    _resx_impl,
    attrs = {
        # source files for this target.
        "src": attr.label(allow_files = [".resx"], mandatory = True),
        "identifier": attr.string(),
        "out": attr.string(),
        "dotnet_context_data": attr.label(default = Label("@rules_mono//:dotnet_context_data")),
        "simpleresgen": attr.label(),
    },
    toolchains = ["@rules_mono//dotnet:toolchain_type_mono"],
    executable = False,
)

core_resx = rule(
    _resx_impl,
    attrs = {
        # source files for this target.
        "src": attr.label(allow_files = [".resx"], mandatory = True),
        "identifier": attr.string(),
        "out": attr.string(),
        "dotnet_context_data": attr.label(default = Label("@rules_mono//:core_context_data")),
        "simpleresgen": attr.label(default = Label("@rules_mono//tools/simpleresgen:simpleresgen.exe")),
    },
    toolchains = ["@rules_mono//dotnet:toolchain_type_core"],
    executable = False,
)

net_resx_multi = rule(
    _resx_multi_impl,
    attrs = {
        # source files for this target.
        "srcs": attr.label_list(allow_files = True, mandatory = True),
        "identifierBase": attr.string(),
        "fixedIdentifierBase": attr.string(),
        "dotnet_context_data": attr.label(default = Label("@rules_mono//:net_context_data")),
        "simpleresgen": attr.label(),
    },
    toolchains = ["@rules_mono//dotnet:toolchain_type_net"],
    executable = False,
)
