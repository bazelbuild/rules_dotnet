"""
Rules for importing assemblies for .NET frameworks.
"""

load(
    "//dotnet/private:common.bzl",
    "collect_transitive_info",
    "transform_deps",
)
load("//dotnet/private:providers.bzl", "DotnetAssemblyInfo", "NuGetInfo")
load("@bazel_skylib//rules:common_settings.bzl", "BuildSettingInfo")

def _import_library(ctx):
    (_irefs, prefs, analyzers, libs, native, data, _private_refs, _private_analyzers, transitive_runtime_deps, _exports, _overrides) = collect_transitive_info(ctx.label.name, ctx.attr.deps, [], [], ctx.toolchains["@rules_dotnet//dotnet:toolchain_type"].strict_deps[BuildSettingInfo].value)

    return [DotnetAssemblyInfo(
        name = ctx.attr.library_name,
        version = ctx.attr.version,
        libs = ctx.files.libs,
        # TODO: PDBs from nuget packages should also be forwarded
        pdbs = [],
        refs = ctx.files.refs,
        irefs = ctx.files.refs,
        analyzers = ctx.files.analyzers,
        native = ctx.files.native,
        data = ctx.files.data,
        exports = [],
        transitive_libs = libs,
        transitive_native = native,
        transitive_data = data,
        transitive_refs = prefs,
        transitive_analyzers = analyzers,
        internals_visible_to = [],
        runtime_deps = transform_deps(ctx.attr.deps),
        transitive_runtime_deps = transitive_runtime_deps,
    ), NuGetInfo(
        targeting_pack_overrides = ctx.attr.targeting_pack_overrides,
        sha512 = ctx.attr.sha512,
    )]

import_library = rule(
    _import_library,
    doc = "Creates a target for a static DLL for a specific target framework",
    attrs = {
        "library_name": attr.string(
            doc = "The name of the library",
            mandatory = True,
        ),
        "version": attr.string(
            doc = "The version of the library",
        ),
        "libs": attr.label_list(
            doc = "Static runtime DLLs",
            allow_files = True,  # [".dll"] currently does not work with empty file groups
            allow_empty = True,
        ),
        "native": attr.label_list(
            doc = "Native runtime DLLs",
            allow_files = True,  # [".dll"] currently does not work with empty file groups
            allow_empty = True,
        ),
        "analyzers": attr.label_list(
            doc = "Static analyzer DLLs",
            allow_files = True,  # [".dll"] currently does not work with empty file groups
            allow_empty = True,
        ),
        # todo maybe add pdb's as data.
        "refs": attr.label_list(
            doc = "Compile time DLLs",
            allow_files = True,  # [".dll"] currently does not work with empty file groups
            allow_empty = True,
        ),
        "deps": attr.label_list(
            doc = "Other DLLs that this DLL depends on.",
            providers = [DotnetAssemblyInfo],
        ),
        "data": attr.label_list(
            doc = "Other files that this DLL depends on at runtime",
            allow_files = True,
        ),
        "targeting_pack_overrides": attr.string_dict(
            doc = "Targeting packs like e.g. Microsoft.NETCore.App.Ref have a PackageOverride.txt that includes a list of NuGet packages that should be omitted in a compiliation because they are included in the targeting pack",
            default = {},
        ),
        "sha512": attr.string(
            doc = "The SHA512 sum of the NuGet package",
        ),
    },
    toolchains = [
        "@rules_dotnet//dotnet:toolchain_type",
    ],
    executable = False,
)
