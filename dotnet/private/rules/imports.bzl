"""
Rules for importing assemblies for .NET frameworks.
"""

load(
    "//dotnet/private:common.bzl",
    "collect_transitive_info",
)
load("//dotnet/private:providers.bzl", "AnyTargetFrameworkInfo", "DotnetAssemblyInfo")

def _import_library(ctx):
    return DotnetAssemblyInfo(
        name = ctx.label.name,
        version = ctx.attr.version,
        libs = ctx.files.libs,
        prefs = ctx.files.refs,
        irefs = None,
        internals_visible_to = [],
        deps = ctx.attr.deps,
        # todo is this one needed?
        transitive = depset(direct = ctx.attr.deps, transitive = [a[DotnetAssemblyInfo].transitive for a in ctx.attr.deps]),
        transitive_prefs = depset(direct = ctx.files.refs, transitive = [a[DotnetAssemblyInfo].transitive_prefs for a in ctx.attr.deps]),
        transitive_analyzers = depset(direct = ctx.files.analyzers, transitive = [a[DotnetAssemblyInfo].transitive_analyzers for a in ctx.attr.deps]),
        transitive_runfiles = depset(
            direct = ctx.files.data + ctx.files.libs,
            transitive = [a[DotnetAssemblyInfo].transitive_runfiles for a in ctx.attr.deps]
        ),
    )

import_library = rule(
    _import_library,
    doc = "Creates a target for a static C# DLL for a specific target framework",
    attrs = {
        # todo where is this required?
        "version": attr.string(),
        "libs": attr.label_list(
            doc = "static DLLs",
            allow_files = True, # [".dll"] currently does not work with empty file groups
            allow_empty = True,
        ),
        "analyzers": attr.label_list(
            doc = "static DLLs",
            allow_files = True, # [".dll"] currently does not work with empty file groups
            allow_empty = True,
        ),
        # todo maybe add pdb's as data.
        "refs": attr.label_list(
            doc = "metadata-only DLLs, suitable for compiling against but not running",
            allow_files = True, # [".dll"] currently does not work with empty file groups
            allow_empty = True,
        ),
        # arent these just deps?
        # "native_dlls": attr.label_list(
        #     doc = "A list of native dlls, which while unreferenced, are required for running and compiling",
        #     allow_files = [".dll"],
        # ),
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
