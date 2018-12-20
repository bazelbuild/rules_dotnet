load(
    "@io_bazel_rules_dotnet//dotnet/private:context.bzl",
    "dotnet_context",
)
load(
    "@io_bazel_rules_dotnet//dotnet/private:providers.bzl",
    "DotnetLibrary",
)

def _net_com_library_impl(ctx):
    """_net_com_reference_impl emits actions for creating com wrapper library."""
    dotnet = dotnet_context(ctx)
    name = ctx.label.name

    # Handle case of empty toolchain on linux and darwin
    if dotnet.assembly == None:
        library = dotnet.new_library(dotnet = dotnet)
        return [library]

    com_library = dotnet.com_ref(
        dotnet,
        name = name,
        guid = ctx.attr.guid,
        major_version = ctx.attr.major_version,
        minor_version = ctx.attr.minor_version,
        lcid = ctx.attr.lcid,
        platform = ctx.attr.platform,
        namespace = ctx.attr.namespace,
        out = ctx.attr.out,
    )

    deps = ctx.attr.deps

    deps_libraries = [d[DotnetLibrary] for d in deps]
    transitive = depset(direct = deps, transitive = [a[DotnetLibrary].transitive for a in deps])

    library = dotnet.new_library(
        dotnet = dotnet,
        name = name,
        deps = deps,
        transitive = transitive,
        result = com_library,
    )

    transitive_files = [d.result for d in library.transitive.to_list()]

    return [
        library,
        DefaultInfo(
            files = depset([library.result]),
            runfiles = ctx.runfiles(files = [dotnet.stdlib, library.result], transitive_files = depset(direct = transitive_files)),
        ),
    ]

net_com_library = rule(
    _net_com_library_impl,
    attrs = {
        "deps": attr.label_list(providers = [DotnetLibrary]),
        "guid": attr.string(),
        "major_version": attr.int(),
        "minor_version": attr.int(),
        "lcid": attr.int(),
        "platform": attr.string(),
        "namespace": attr.string(),
        "out": attr.string(),
        "dotnet_context_data": attr.label(default = Label("@io_bazel_rules_dotnet//:net_context_data")),
    },
    toolchains = ["@io_bazel_rules_dotnet//dotnet:toolchain_net"],
    executable = False,
)
