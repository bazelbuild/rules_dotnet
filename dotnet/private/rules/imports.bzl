"""
Rules for importing assemblies for .NET frameworks.
"""

load(
    "//dotnet/private:common.bzl",
    "collect_transitive_info",
)
load("//dotnet/private:providers.bzl", "DotnetAssemblyInfo", "NuGetInfo")
load("//dotnet/private:transitions/nuget_transition.bzl", "nuget_transition")

def _import_library(ctx):
    (_irefs, prefs, analyzers, runfiles, _private_refs, _private_analyzers, _overrides) = collect_transitive_info(ctx.label.name, ctx.attr.deps, [], ctx.toolchains["@rules_dotnet//dotnet:toolchain_type"].strict_deps)

    return [DotnetAssemblyInfo(
        name = ctx.attr.library_name,
        version = ctx.attr.version,
        libs = ctx.files.libs,
        analyzers = ctx.files.analyzers,
        data = ctx.files.data,
        prefs = ctx.files.refs,
        irefs = ctx.files.refs,
        internals_visible_to = [],
        deps = ctx.attr.deps,
        transitive_prefs = prefs,
        transitive_analyzers = analyzers,
        transitive_runfiles = runfiles,
        targeting_pack_overrides = ctx.attr.targeting_pack_overrides,
    ), NuGetInfo()]

import_library = rule(
    _import_library,
    doc = "Creates a target for a static C# DLL for a specific target framework",
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
            cfg = nuget_transition,
        ),
        "analyzers": attr.label_list(
            doc = "Static analyzer DLLs",
            allow_files = True,  # [".dll"] currently does not work with empty file groups
            allow_empty = True,
            cfg = nuget_transition,
        ),
        # todo maybe add pdb's as data.
        "refs": attr.label_list(
            doc = "Compile time DLLs",
            allow_files = True,  # [".dll"] currently does not work with empty file groups
            allow_empty = True,
            cfg = nuget_transition,
        ),
        "deps": attr.label_list(
            doc = "Other DLLs that this DLL depends on.",
            providers = [DotnetAssemblyInfo],
            cfg = nuget_transition,
        ),
        "data": attr.label_list(
            doc = "Other files that this DLL depends on at runtime",
            allow_files = True,
            cfg = nuget_transition,
        ),
        "targeting_pack_overrides": attr.string_dict(
            doc = "Targeting packs like e.g. Microsoft.NETCore.App.Ref have a PackageOverride.txt that includes a list of NuGet packages that should be omitted in a compiliation because they are included in the targeting pack",
            default = {},
        ),
        "_allowlist_function_transition": attr.label(
            default = "@bazel_tools//tools/allowlists/function_transition_allowlist",
        ),
    },
    toolchains = [
        "@rules_dotnet//dotnet:toolchain_type",
    ],
    executable = False,
)
