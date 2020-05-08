load(
    "@io_bazel_rules_dotnet//dotnet/private:context.bzl",
    "dotnet_context",
)
load(
    "@io_bazel_rules_dotnet//dotnet/private:providers.bzl",
    "DotnetLibrary",
)
load("@io_bazel_rules_dotnet//dotnet/private:rules/common.bzl", "collect_transitive_info")

def _libraryset_impl(ctx):
    """_libraryset_impl implements the set of libraries."""
    dotnet = dotnet_context(ctx)
    name = ctx.label.name

    # Handle case of empty toolchain on linux and darwin
    if dotnet.assembly == None:
        library = dotnet.new_library(dotnet = dotnet)
        return [library]

    (transitive_refs, transitive_runfiles, transitive_deps) = collect_transitive_info(ctx.attr.deps, ctx.attr.data)

    library = dotnet.new_library(
        dotnet = dotnet,
        name = name,
        deps = ctx.attr.deps,
        transitive = transitive_deps,
        runfiles = transitive_runfiles,
        transitive_refs = transitive_refs,
    )

    return [
        library,
        DefaultInfo(
            runfiles = ctx.runfiles(files = [], transitive_files = library.runfiles),
        ),
    ]

dotnet_libraryset = rule(
    _libraryset_impl,
    attrs = {
        "deps": attr.label_list(providers = [DotnetLibrary]),
        "data": attr.label_list(allow_files = True),
        "dotnet_context_data": attr.label(default = Label("@io_bazel_rules_dotnet//:dotnet_context_data")),
    },
    toolchains = ["@io_bazel_rules_dotnet//dotnet:toolchain"],
    executable = False,
)

core_libraryset = rule(
    _libraryset_impl,
    attrs = {
        "deps": attr.label_list(providers = [DotnetLibrary]),
        "data": attr.label_list(allow_files = True),
        "dotnet_context_data": attr.label(default = Label("@io_bazel_rules_dotnet//:core_context_data")),
    },
    toolchains = ["@io_bazel_rules_dotnet//dotnet:toolchain_core"],
    executable = False,
)

net_libraryset = rule(
    _libraryset_impl,
    attrs = {
        "deps": attr.label_list(providers = [DotnetLibrary]),
        "data": attr.label_list(allow_files = True),
        "dotnet_context_data": attr.label(default = Label("@io_bazel_rules_dotnet//:net_context_data")),
    },
    toolchains = ["@io_bazel_rules_dotnet//dotnet:toolchain_net"],
    executable = False,
)
