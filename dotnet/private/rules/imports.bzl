"""
Rules for importing assemblies for .NET frameworks.
"""

load(
    "//dotnet/private:common.bzl",
    "collect_transitive_info",
)
load("//dotnet/private:providers.bzl", "DotnetAssemblyInfo")
load("//dotnet/private:macros/register_tfms.bzl", "nuget_framework_transition")

def _import_library(ctx):
    (_irefs, prefs, analyzers, runfiles, _overrides) = collect_transitive_info(ctx.label.name, ctx.attr.deps)

    return DotnetAssemblyInfo(
        name = ctx.label.name,
        version = ctx.attr.version,
        libs = ctx.files.libs,
        analyzers = ctx.files.analyzers,
        data = ctx.files.data,
        prefs = ctx.files.refs,
        irefs = ctx.files.refs,
        internals_visible_to = [],
        deps = ctx.attr.deps,
        # todo is this one needed?
        # transitive = depset(direct = ctx.attr.deps, transitive = [a[DotnetAssemblyInfo].transitive for a in ctx.attr.deps]),
        transitive_prefs = prefs,
        transitive_analyzers = analyzers,
        transitive_runfiles = runfiles,
        targeting_pack_overrides = ctx.attr.targeting_pack_overrides,
    )

import_library = rule(
    _import_library,
    doc = "Creates a target for a static C# DLL for a specific target framework",
    attrs = {
        "version": attr.string(
            doc = "The version of the library",
        ),
        "libs": attr.label_list(
            doc = "Static runtime DLLs",
            allow_files = True,  # [".dll"] currently does not work with empty file groups
            allow_empty = True,
            cfg = nuget_framework_transition,
        ),
        "analyzers": attr.label_list(
            doc = "Static analyzer DLLs",
            allow_files = True,  # [".dll"] currently does not work with empty file groups
            allow_empty = True,
            cfg = nuget_framework_transition,
        ),
        # todo maybe add pdb's as data.
        "refs": attr.label_list(
            doc = "Compile time DLLs",
            allow_files = True,  # [".dll"] currently does not work with empty file groups
            allow_empty = True,
            cfg = nuget_framework_transition,
        ),
        "deps": attr.label_list(
            doc = "Other DLLs that this DLL depends on.",
            providers = [DotnetAssemblyInfo],
            cfg = nuget_framework_transition,
        ),
        "data": attr.label_list(
            doc = "Other files that this DLL depends on at runtime",
            allow_files = True,
        ),
        "targeting_pack_overrides": attr.string_dict(
            doc = "Targeting packs like e.g. Microsoft.NETCore.App.Ref have a PackageOverride.txt that includes a list of NuGet packages that should be omitted in a compiliation because they are included in the targeting pack",
            default = {},
        ),
        "_allowlist_function_transition": attr.label(
            default = "@bazel_tools//tools/allowlists/function_transition_allowlist",
        ),
    },
    executable = False,
)
