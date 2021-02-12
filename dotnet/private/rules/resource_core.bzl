".resource rules"

load(
    "@io_bazel_rules_dotnet//dotnet/private:context.bzl",
    "dotnet_context",
)
load(
    "@io_bazel_rules_dotnet//dotnet/private:providers.bzl",
    "DotnetResourceInfo",
    "DotnetResourceListInfo",
)
load("@rules_dotnet_skylib//lib:paths.bzl", "paths")

def _resource_impl(ctx):
    """core_resource_impl emits actions for embeding file as resource."""
    dotnet = dotnet_context(ctx, "csharp")
    name = ctx.label.name

    resource = DotnetResourceInfo(
        name = name,
        result = ctx.attr.src.files.to_list()[0],
        identifier = ctx.attr.identifier,
    )

    return [
        resource,
        DotnetResourceListInfo(result = [resource]),
        DefaultInfo(
            files = depset([resource.result]),
        ),
    ]

def _resource_multi_impl(ctx):
    dotnet = dotnet_context(ctx, "csharp")
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

            resource = DotnetResourceInfo(
                name = identifier,
                result = k,
                identifier = identifier,
            )
            result.append(resource)

    return [
        DotnetResourceListInfo(result = result),
        DefaultInfo(
            files = depset([d.result for d in result]),
        ),
    ]

core_resource = rule(
    _resource_impl,
    attrs = {
        # source files for this target.
        "src": attr.label(allow_single_file = True, mandatory = True, doc = "The source to be embeded."),
        "identifier": attr.string(doc = "The logical name for the resource; the name is used to load the resource. The default is the basename of the file name (no subfolder)."),
    },
    toolchains = ["@io_bazel_rules_dotnet//dotnet:toolchain_type_csharp_core"],
    executable = False,
    doc = "This wraps a resource so it can be embeded into an assembly.",
)

core_resource_multi = rule(
    _resource_multi_impl,
    attrs = {
        # source files for this target.
        "srcs": attr.label_list(allow_files = True, mandatory = True, doc = "The source files to be embeded. "),
        "identifierBase": attr.string(doc = "The logical name for given resource is constructred from identiferBase + \".\" + directory.repalce('/','.') + \".\" + filename. The resulting name is used to load the resource. Either identifierBase of fixedIdentifierBase must be specified."),
        "fixedIdentifierBase": attr.string(doc = "The logical name for given resource is constructred from fixedIdentiferBase + \".\" + filename. The resulting name that is used to load the resource. Either identifierBase of fixedIdentifierBase must be specified. "),
    },
    toolchains = ["@io_bazel_rules_dotnet//dotnet:toolchain_type_csharp_core"],
    executable = False,
    doc = "This wraps multiple resource files so they can be embeded into an assembly.",
)
