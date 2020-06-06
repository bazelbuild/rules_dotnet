load(
    "@io_bazel_rules_dotnet//dotnet/private:common.bzl",
    "as_iterable",
)
load(
    "@io_bazel_rules_dotnet//dotnet/private:context.bzl",
    "new_library",
)
load(
    "@io_bazel_rules_dotnet//dotnet/private:providers.bzl",
    "DotnetLibrary",
)
load("@io_bazel_rules_dotnet//dotnet/private:rules/common.bzl", "collect_transitive_info")
load("@io_bazel_rules_dotnet//dotnet/private:rules/versions.bzl", "parse_version")

def _import_library_impl(ctx):
    """net_import_library_impl emits actions for importing an external dll (for example provided by nuget)."""
    name = ctx.label.name

    deps = ctx.attr.deps
    src = ctx.attr.src
    result = src.files.to_list()[0]

    transitive = collect_transitive_info(deps)

    direct_runfiles = []
    direct_runfiles.append(result)

    if ctx.attr.data:
        data_l = [f for t in ctx.attr.data for f in as_iterable(t.files)]
        direct_runfiles += data_l

    runfiles = depset(direct = direct_runfiles)

    library = new_library(
        dotnet = ctx,
        name = name,
        deps = deps,
        transitive = transitive,
        runfiles = runfiles,
        result = result,
        version = parse_version(ctx.attr.version),
        ref = ctx.attr.ref.files.to_list()[0] if ctx.attr.ref != None else result,
    )

    return [
        library,
        DefaultInfo(
            files = depset([library.result]),
            runfiles = ctx.runfiles(files = library.runfiles.to_list(), transitive_files = depset(transitive = [t.runfiles for t in library.transitive])),
        ),
    ]

dotnet_import_library = rule(
    _import_library_impl,
    attrs = {
        "deps": attr.label_list(providers = [DotnetLibrary]),
        "src": attr.label(allow_files = [".dll", ".exe"], mandatory = True),
        "data": attr.label_list(allow_files = True),
        "version": attr.string(mandatory = True),
        "ref": attr.label(allow_files = True, mandatory = False),
    },
    executable = False,
)

dotnet_import_binary = rule(
    _import_library_impl,
    attrs = {
        "deps": attr.label_list(providers = [DotnetLibrary]),
        "src": attr.label(allow_files = [".dll", ".exe"], mandatory = True),
        "data": attr.label_list(allow_files = True),
        "version": attr.string(mandatory = True),
        "ref": attr.label(allow_files = True, mandatory = False),
    },
    executable = False,
)

core_import_library = rule(
    _import_library_impl,
    attrs = {
        "deps": attr.label_list(providers = [DotnetLibrary]),
        "src": attr.label(allow_files = [".dll", ".exe"], mandatory = True),
        "data": attr.label_list(allow_files = True),
        "version": attr.string(mandatory = True),
        "ref": attr.label(allow_files = True, mandatory = False),
    },
    executable = False,
)

core_import_binary = rule(
    _import_library_impl,
    attrs = {
        "deps": attr.label_list(providers = [DotnetLibrary]),
        "src": attr.label(allow_files = [".dll", ".exe"], mandatory = True),
        "data": attr.label_list(allow_files = True),
        "version": attr.string(mandatory = True),
        "ref": attr.label(allow_files = True, mandatory = False),
    },
    executable = False,
)

net_import_library = rule(
    _import_library_impl,
    attrs = {
        "deps": attr.label_list(providers = [DotnetLibrary]),
        "src": attr.label(allow_files = [".dll", ".exe"], mandatory = True),
        "data": attr.label_list(allow_files = True),
        "version": attr.string(mandatory = True),
        "ref": attr.label(allow_files = True, mandatory = False),
    },
    executable = False,
)

net_import_binary = rule(
    _import_library_impl,
    attrs = {
        "deps": attr.label_list(providers = [DotnetLibrary]),
        "src": attr.label(allow_files = [".dll", ".exe"], mandatory = True),
        "data": attr.label_list(allow_files = True),
        "version": attr.string(mandatory = True),
        "ref": attr.label(allow_files = True, mandatory = False),
    },
    executable = False,
)
