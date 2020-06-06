load(
    "@io_bazel_rules_dotnet//dotnet/private:context.bzl",
    "dotnet_context",
)
load(
    "@io_bazel_rules_dotnet//dotnet/private:providers.bzl",
    "DotnetLibrary",
)
load("@io_bazel_rules_dotnet//dotnet/private:rules/common.bzl", "collect_transitive_info")
load("@io_bazel_rules_dotnet//dotnet/private:common.bzl", "as_iterable")

def _libraryset_impl(ctx):
    """_libraryset_impl implements the set of libraries."""
    dotnet = dotnet_context(ctx)
    name = ctx.label.name

    # Handle case of empty toolchain on linux and darwin
    if dotnet.assembly == None:
        library = dotnet.new_library(dotnet = dotnet, runfiles = depset())
        return [library]

    transitive = collect_transitive_info(ctx.attr.deps)

    direct_runfiles = []

    if ctx.attr.data:
        data_l = [f for t in ctx.attr.data for f in as_iterable(t.files)]
        direct_runfiles += data_l

    runfiles = depset(direct = direct_runfiles)

    library = dotnet.new_library(
        dotnet = dotnet,
        name = name,
        deps = ctx.attr.deps,
        transitive = transitive,
        runfiles = runfiles,
    )

    return [
        library,
        DefaultInfo(
            runfiles = ctx.runfiles(files = library.runfiles.to_list(), transitive_files = depset(transitive = [t.runfiles for t in library.transitive])),
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
