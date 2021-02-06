load(
    "//dotnet/private:providers.bzl",
    "DotnetLibraryInfo",
)
load("@io_bazel_rules_dotnet//dotnet/private:rules/common.bzl", "collect_transitive_info")
load("@io_bazel_rules_dotnet//dotnet/private:common.bzl", "as_iterable")

def _libraryset_impl(ctx):
    """_libraryset_impl implements the set of libraries."""
    name = ctx.label.name

    transitive = collect_transitive_info(ctx.attr.deps)

    direct_runfiles = []

    if ctx.attr.data:
        data_l = [f for t in ctx.attr.data for f in as_iterable(t.files)]
        direct_runfiles += data_l

    runfiles = depset(direct = direct_runfiles)

    library = DotnetLibraryInfo(
        name = name,
        label = ctx.label,
        deps = ctx.attr.deps,
        transitive = transitive,
        runfiles = runfiles,
        result = None,
        pdb = None,
        version = None,
        ref = None,
    )

    return [
        library,
        DefaultInfo(
            runfiles = ctx.runfiles(files = library.runfiles.to_list(), transitive_files = depset(transitive = [t.runfiles for t in library.transitive])),
        ),
    ]

core_libraryset = rule(
    _libraryset_impl,
    attrs = {
        "deps": attr.label_list(providers = [DotnetLibraryInfo], doc = "The list of dependencies."),
        "data": attr.label_list(allow_files = True, doc = "The list of additional files to include in the list of runfiles for compiled assembly."),
    },
    executable = False,
    doc = "Groups libraries into sets which may be used as dependency.",
)
