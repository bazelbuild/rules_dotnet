load(
    "//dotnet/private:common.bzl",
    "as_iterable",
)
load(
    "//dotnet/private:context.bzl",
    "dotnet_context",
)
load(
    "//dotnet/private:providers.bzl",
    "DotnetLibrary",
)
load("//dotnet/private:rules/common.bzl", "collect_transitive_info")
load("//dotnet/private:rules/versions.bzl", "parse_version")

def _stdlib_impl(ctx):
    dotnet = dotnet_context(ctx)
    if ctx.attr.dll == "":
        name = ctx.label.name
    else:
        name = ctx.attr.dll

    if dotnet.stdlib_byname == None:
        library = dotnet.new_library(dotnet = dotnet)
        return [library]

    if ctx.attr.stdlib_path:
        result = ctx.attr.stdlib_path.files.to_list()[0]
    else:
        result = dotnet.stdlib_byname(name = name, shared = dotnet.shared, lib = dotnet.lib, libVersion = dotnet.libVersion, attr_ref = ctx.attr.ref)

    transitive = collect_transitive_info(ctx.attr.deps)

    direct_runfiles = []
    direct_runfiles.append(result)

    if ctx.attr.data:
        data_l = [f for t in ctx.attr.data for f in as_iterable(t.files)]
        direct_runfiles += data_l

    runfiles = depset(direct = direct_runfiles)

    library = dotnet.new_library(
        dotnet = dotnet,
        name = name,
        version = parse_version(ctx.attr.version),
        deps = ctx.attr.deps,
        ref = ctx.attr.ref.files.to_list()[0] if ctx.attr.ref != None else result,
        transitive = transitive,
        runfiles = runfiles,
        result = result,
    )

    return [
        library,
        DefaultInfo(
            files = depset([library.result]),
            runfiles = ctx.runfiles(files = library.runfiles.to_list(), transitive_files = depset(transitive = [t.runfiles for t in library.transitive])),
        ),
    ]

def _stdlib_internal_impl(ctx):
    if ctx.attr.dll == "":
        name = ctx.label.name
    else:
        name = ctx.attr.dll

    result = ctx.attr.stdlib_path.files.to_list()[0]

    transitive = collect_transitive_info(ctx.attr.deps)

    direct_runfiles = []
    direct_runfiles.append(result)

    if ctx.attr.data:
        data_l = [f for t in ctx.attr.data for f in as_iterable(t.files)]
        direct_runfiles += data_l

    runfiles = depset(direct = direct_runfiles)

    library = DotnetLibrary(
        name = name,
        label = ctx.label,
        version = parse_version(ctx.attr.version),
        deps = ctx.attr.deps,
        ref = ctx.attr.ref.files.to_list()[0] if ctx.attr.ref != None else result,
        transitive = transitive,
        runfiles = runfiles,
        result = result,
        pdb = None,
    )

    return [
        library,
        DefaultInfo(
            files = depset([library.result]),
            runfiles = ctx.runfiles(files = library.runfiles.to_list(), transitive_files = depset(transitive = [t.runfiles for t in library.transitive])),
        ),
    ]

core_stdlib = rule(
    _stdlib_impl,
    attrs = {
        "dll": attr.string(),
        "version": attr.string(mandatory = True, doc = "Version of the assembly."),
        "ref": attr.label(allow_files = True, mandatory = False, doc = "[Reference assembly](https://docs.microsoft.com/en-us/dotnet/standard/assembly/reference-assemblies) for given library."),
        "deps": attr.label_list(providers = [DotnetLibrary], doc = "The direct dependencies of this dll. These may be [dotnet_library](api.md#dotnet_library) rules or compatible rules with the [DotnetLibrary](api.md#DotnetLibrary) provider."),
        "data": attr.label_list(allow_files = True, doc = "Additional files to copy with the target assembly."),
        "stdlib_path": attr.label(allow_files = True, doc = "The stdlib_path to be used instead of looking for one in sdk by name speeds up the rule execution because the proper file needs not to be searched for within sdk."),
        "dotnet_context_data": attr.label(default = Label("@io_bazel_rules_dotnet//:core_context_data")),
    },
    toolchains = ["@io_bazel_rules_dotnet//dotnet:toolchain_type_core"],
    executable = False,
    doc = "It imports a framework dll and transforms it into [DotnetLibrary](api.md#DotnetLibrary) so it can be referenced as dependency by other rules.",
)

core_stdlib_internal = rule(
    _stdlib_internal_impl,
    attrs = {
        "dll": attr.string(),
        "version": attr.string(mandatory = True),
        "ref": attr.label(allow_files = True),
        "deps": attr.label_list(providers = [DotnetLibrary]),
        "data": attr.label_list(allow_files = True),
        "stdlib_path": attr.label(allow_files = True, mandatory = True),
    },
    toolchains = ["@io_bazel_rules_dotnet//dotnet:toolchain_type_core"],
    executable = False,
    doc = "Internal. Do not use. It imports a framework dll and transforms it into [DotnetLibrary](api.md#DotnetLibrary) so it can be referenced as dependency by other rules. Used by //dotnet/stdlib... packages. It doesn't use dotnet_context_data. ",
)
