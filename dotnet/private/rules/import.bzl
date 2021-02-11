load("@io_bazel_rules_dotnet//dotnet/private:context.bzl", "dotnet_context")
load("@io_bazel_rules_dotnet//dotnet/private:common.bzl", "as_iterable")
load("@io_bazel_rules_dotnet//dotnet/private:providers.bzl", "DotnetLibraryInfo")
load("@io_bazel_rules_dotnet//dotnet/private:rules/common.bzl", "collect_transitive_info", "wrap_binary")
load("@io_bazel_rules_dotnet//dotnet/private:rules/versions.bzl", "parse_version")

def _import_library_impl(ctx):
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

    library = DotnetLibraryInfo(
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

def _import_binary_internal_impl(ctx):
    dotnet = dotnet_context(ctx, "csharp")

    name = dotnet._ctx.label.name
    subdir = name + "/"

    srcname = ctx.attr.src.files.to_list()[0].basename

    deps = ctx.attr.deps
    src = ctx.attr.src

    # Binary import needs to be copied to be usable
    result = ctx.actions.declare_file(subdir + srcname)
    ctx.actions.run(
        outputs = [result],
        inputs = src.files.to_list(),
        executable = ctx.attr._copy.files.to_list()[0],
        arguments = [result.path, src.files.to_list()[0].path],
        mnemonic = "CopySrc",
    )

    transitive = collect_transitive_info(deps)

    direct_runfiles = []
    direct_runfiles.append(result)

    if ctx.attr.data:
        data_l = [f for t in ctx.attr.data for f in as_iterable(t.files)]
        direct_runfiles += data_l

    runfiles = depset(direct = direct_runfiles)

    executable = DotnetLibraryInfo(
        name = srcname,
        deps = deps,
        transitive = transitive,
        runfiles = runfiles,
        result = result,
        version = parse_version(ctx.attr.version),
        ref = ctx.attr.ref.files.to_list()[0] if ctx.attr.ref != None else result,
    )

    return wrap_binary(executable, dotnet)

core_import_library = rule(
    _import_library_impl,
    attrs = {
        "deps": attr.label_list(providers = [DotnetLibraryInfo], doc = "The direct dependencies of this dll. These may be compatible with the [DotnetLibraryInfo](api.md#dotnetlibraryinfo) provider."),
        "src": attr.label(allow_files = [".dll", ".exe"], mandatory = True, doc = "The file to be transformed into [DotnetLibraryInfo](api.md#dotnetlibraryinfo) provider."),
        "data": attr.label_list(allow_files = True, doc = "Additional files to copy with the target assembly. "),
        "version": attr.string(mandatory = True, doc = "Version of the imported assembly."),
        "ref": attr.label(allow_files = True, mandatory = False, doc = "[Reference assembly](https://docs.microsoft.com/en-us/dotnet/standard/assembly/reference-assemblies) for given library."),
    },
    provides = [DotnetLibraryInfo],
    executable = False,
    doc = "This imports an external dll and transforms it into [DotnetLibraryInfo](api.md#dotnetlibraryinfo) so it can be referenced as dependency by other rules.",
)

core_import_binary = rule(
    _import_binary_internal_impl,
    attrs = {
        "deps": attr.label_list(providers = [DotnetLibraryInfo], doc = "The direct dependencies of this dll. These may be rules or compatible rules with the [DotnetLibraryInfo](api.md#dotnetlibraryinfo) provider."),
        "src": attr.label(allow_files = [".dll", ".exe"], mandatory = True, doc = "The file to be transformed into [DotnetLibraryInfo](api.md#dotnetlibraryinfo) provider."),
        "data": attr.label_list(allow_files = True, doc = "Additional files to copy with the target assembly."),
        "version": attr.string(mandatory = True, doc = "Version of the imported assembly."),
        "ref": attr.label(allow_files = True, mandatory = False, doc = "[Reference assembly](https://docs.microsoft.com/en-us/dotnet/standard/assembly/reference-assemblies) for given library."),
        "_launcher": attr.label(default = Label("@io_bazel_rules_dotnet//dotnet/tools/launcher_core:launcher_core.exe")),
        "_copy": attr.label(default = Label("@io_bazel_rules_dotnet//dotnet/tools/copy")),
        "_symlink": attr.label(default = Label("@io_bazel_rules_dotnet//dotnet/tools/symlink")),
        "data_with_dirs": attr.label_keyed_string_dict(allow_files = True, doc = "Dictionary of {label:folder}. Files specified by <label> will be put in subdirectory <folder>."),
    },
    toolchains = ["@io_bazel_rules_dotnet//dotnet:toolchain_type_csharp_core"],
    executable = True,
    doc = "This imports an external assembly and transforms it into .NET Core binary. ",
)
