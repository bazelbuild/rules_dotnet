"""
Rules for aggregating C# libraries for ease of use. 
"""

load(
    "//dotnet/private:common.bzl",
    "collect_transitive_info",
)
load("//dotnet/private:providers.bzl", "AnyTargetFrameworkInfo", "DotnetAssemblyInfo")

def _library_set(ctx):
    tfm = ctx.attr.target_framework

    (refs, runfiles, native_dlls) = collect_transitive_info(ctx.attr.name, ctx.attr.deps, tfm)

    return [DotnetAssemblyInfo(
        out = None,
        prefout = None,
        irefout = None,
        internals_visible_to = [],
        pdb = None,
        native_dlls = native_dlls,
        deps = ctx.attr.deps,
        transitive_prefs = refs,
        transitive_runfiles = runfiles,
        actual_tfm = tfm,
    )]

library_set = rule(
    _library_set,
    doc = "Defines a set of C# libraries to be depended on together",
    attrs = {
        "target_framework": attr.string(
            doc = "The target framework for this set of libraries",
            mandatory = True,
        ),
        "deps": attr.label_list(
            doc = "The set of libraries",
            providers = AnyTargetFrameworkInfo,
        ),
    },
    executable = False,
)
