"""
Rules for importing assemblies for .NET frameworks.
"""

load(
    "//dotnet/private:common.bzl",
    "collect_transitive_info",
    "fill_in_missing_frameworks",
)
load("//dotnet/private:providers.bzl", "AnyTargetFrameworkInfo", "DotnetAssemblyInfo")

def _import_library(ctx):
    files = []

    if ctx.file.dll != None:
        files.append(ctx.file.dll)

    if ctx.file.pdb != None:
        files.append(ctx.file.pdb)

    if ctx.file.refdll != None:
        files.append(ctx.file.refdll)

    files += ctx.files.native_dlls
    files += ctx.files.data

    tfm = ctx.attr.target_framework

    (refs, runfiles, native_dlls) = collect_transitive_info(ctx.attr.name, ctx.attr.deps, tfm)

    providers = {
        tfm: DotnetAssemblyInfo[tfm](
            out = ctx.file.dll,
            prefout = ctx.file.refdll,
            irefout = None,
            internals_visible_to = [],
            pdb = ctx.file.pdb,
            native_dlls = depset(direct = ctx.files.native_dlls, transitive = [native_dlls]),
            deps = ctx.attr.deps,
            transitive_refs = refs,
            transitive_runfiles = runfiles,
            actual_tfm = tfm,
        ),
    }

    fill_in_missing_frameworks(ctx.attr.name, providers)

    return [DefaultInfo(files = depset(files))] + providers.values()

import_library = rule(
    _import_library,
    doc = "Creates a target for a static C# DLL for a specific target framework",
    attrs = {
        "target_framework": attr.string(
            doc = "The target framework for this DLL",
            mandatory = True,
        ),
        "dll": attr.label(
            doc = "A static DLL",
            allow_single_file = [".dll"],
        ),
        "pdb": attr.label(
            doc = "Debug symbols for the dll",
            allow_single_file = [".pdb"],
        ),
        "refdll": attr.label(
            doc = "A metadata-only DLL, suitable for compiling against but not running",
            allow_single_file = [".dll"],
        ),
        "native_dlls": attr.label_list(
            doc = "A list of native dlls, which while unreferenced, are required for running and compiling",
            allow_files = [".dll"],
        ),
        "deps": attr.label_list(
            doc = "other DLLs that this DLL depends on.",
            providers = AnyTargetFrameworkInfo,
        ),
        "data": attr.label_list(
            doc = "Other files that this DLL depends on at runtime",
            allow_files = True,
        ),
    },
    executable = False,
)

def _import_multiframework_library_impl(ctx):
    # Oh dear. I don't know of any way to do this better. ctx.attr is a struct
    # and it doesn't look like there's too much available to reflect on it.
    attrs = {
        "netstandard": ctx.attr.netstandard,
        "netstandard1.0": ctx.attr.netstandard1_0,
        "netstandard1.1": ctx.attr.netstandard1_1,
        "netstandard1.2": ctx.attr.netstandard1_2,
        "netstandard1.3": ctx.attr.netstandard1_3,
        "netstandard1.4": ctx.attr.netstandard1_4,
        "netstandard1.5": ctx.attr.netstandard1_5,
        "netstandard1.6": ctx.attr.netstandard1_6,
        "netstandard2.0": ctx.attr.netstandard2_0,
        "netstandard2.1": ctx.attr.netstandard2_1,
        "net11": ctx.attr.net11,
        "net20": ctx.attr.net20,
        "net30": ctx.attr.net30,
        "net35": ctx.attr.net35,
        "net40": ctx.attr.net40,
        "net403": ctx.attr.net403,
        "net45": ctx.attr.net45,
        "net451": ctx.attr.net451,
        "net452": ctx.attr.net452,
        "net46": ctx.attr.net46,
        "net461": ctx.attr.net461,
        "net462": ctx.attr.net462,
        "net47": ctx.attr.net47,
        "net471": ctx.attr.net471,
        "net472": ctx.attr.net472,
        "net48": ctx.attr.net48,
        "netcoreapp1.0": ctx.attr.netcoreapp1_0,
        "netcoreapp1.1": ctx.attr.netcoreapp1_1,
        "netcoreapp2.0": ctx.attr.netcoreapp2_0,
        "netcoreapp2.1": ctx.attr.netcoreapp2_1,
        "netcoreapp2.2": ctx.attr.netcoreapp2_2,
        "netcoreapp3.0": ctx.attr.netcoreapp3_0,
        "netcoreapp3.1": ctx.attr.netcoreapp3_1,
        "net5.0": ctx.attr.net5_0,
        "net6.0": ctx.attr.net6_0,
    }

    providers = {}

    for (tfm, attr) in attrs.items():
        if attr != None:
            providers[tfm] = attr[DotnetAssemblyInfo[tfm]]

    fill_in_missing_frameworks(ctx.attr.name, providers)

    # TODO: we don't return an explicit DefaultInfo for this rule... maybe we
    # should construct one from a specific (indicated by the user) framework?
    return providers.values()

def _generate_multiframework_attrs():
    attrs = {}
    for (tfm, tf_provider) in DotnetAssemblyInfo.items():
        attrs[tfm.replace(".", "_")] = attr.label(
            doc = "The %s version of this library" % tfm,
            providers = [tf_provider],
        )

    return attrs

import_multiframework_library = rule(
    _import_multiframework_library_impl,
    doc = "Aggregate import_library targets for specific target-frameworks into one target",
    attrs = _generate_multiframework_attrs(),
)
