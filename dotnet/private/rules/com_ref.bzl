load(
    "@io_bazel_rules_dotnet//dotnet/platform:list.bzl",
    "DOTNET_NET_FRAMEWORKS",
)
load(
    "@io_bazel_rules_dotnet//dotnet/private:context.bzl",
    "dotnet_context",
)
load(
    "@io_bazel_rules_dotnet//dotnet/private:providers.bzl",
    "DotnetLibrary",
)

def _net_com_library_impl(ctx):
    """_net_com_library_impl emits actions for creating com wrapper library."""
    dotnet = dotnet_context(ctx)
    name = ctx.label.name

    # Handle case of empty toolchain on linux and darwin
    if dotnet.assembly == None:
        library = dotnet.new_library(dotnet = dotnet)
        return [library]

    for wrapper in ctx.attr._tlbimp_wrapper:
        if ctx.attr._tlbimp_wrapper[wrapper] == dotnet.framework:
            tlbimp_wrapper = wrapper

    result = dotnet.declare_file(dotnet, path = name)

    args = dotnet.actions.args()
    args.add(dotnet.tlbimp)
    args.add(ctx.attr.guid)
    args.add(ctx.attr.major_version)
    args.add(ctx.attr.minor_version)
    args.add(ctx.attr.lcid)
    args.add(ctx.attr.platform)
    args.add(ctx.attr.namespace)
    args.add(result, format = "%s")

    dotnet.actions.run(
        outputs = [result],
        inputs = [],
        executable = tlbimp_wrapper.files_to_run,
        arguments = [args],
        mnemonic = "NetComRefGen",
        progress_message = (
            "Generating com wrapper" + dotnet.label.package + ":" + dotnet.label.name
        ),
    )

    library = dotnet.new_library(
        dotnet = dotnet,
        name = name,
        deps = [],
        transitive = [],
        result = result,
    )

    return [
        library,
        DefaultInfo(
            files = depset([library.result]),
            runfiles = ctx.runfiles(files = [dotnet.stdlib, library.result], transitive_files = depset()),
        ),
    ]

net_com_library = rule(
    _net_com_library_impl,
    attrs = {
        "guid": attr.string(),
        "major_version": attr.int(),
        "minor_version": attr.int(),
        "lcid": attr.int(),
        "platform": attr.string(),
        "namespace": attr.string(),
        "out": attr.string(),
        "dotnet_context_data": attr.label(default = Label("@io_bazel_rules_dotnet//:net_context_data")),
        "_tlbimp_wrapper": attr.label_keyed_string_dict(
            default = {Label("@io_bazel_rules_dotnet//dotnet/tools/tlbimp_wrapper:tlbimp_wrapper_{}.exe".format(framework)): framework for framework in DOTNET_NET_FRAMEWORKS},
        ),
    },
    toolchains = ["@io_bazel_rules_dotnet//dotnet:toolchain_type_net"],
    executable = False,
)
