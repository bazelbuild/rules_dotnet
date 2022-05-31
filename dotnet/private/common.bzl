"""
Rules for compatability resolution of dependencies for .NET frameworks.
"""

load(
    "//dotnet/private:providers.bzl",
    "DotnetAssemblyInfo",
    "FRAMEWORK_COMPATIBILITY",
)

def is_debug(ctx):
    return ctx.var["COMPILATION_MODE"] == "dbg"

def use_highentropyva(tfm):
    return tfm not in ["net20", "net40"]

def is_standard_framework(tfm):
    return tfm.startswith("netstandard")

def is_core_framework(tfm):
    return tfm.startswith("netcoreapp") or tfm.startswith("net5.0") or tfm.startswith("net6.0")

def collect_transitive_info(name, deps, tfm):
    return (depset(), depset(), depset())
    # """Determine the transitive dependencies by the target framework.

    # Args:
    #     name: The name of the assembly that is asking.
    #     deps: Dependencies that the compilation target depends on.
    #     tfm: The target framework moniker.

    # Returns:
    #     A collection of the references, runfiles and native dlls.
    # """
    # direct_refs = []
    # transitive_refs = []
    # direct_runfiles = []
    # transitive_runfiles = []
    # native_dlls = []

    # provider = DotnetAssemblyInfo

    # for dep in deps:
    #     if provider not in dep:
    #         fail("The dependency %s is not compatible with %s!" % (str(dep.label), tfm))

    #     assembly = dep[provider]

    #     # See docs/ReferenceAssemblies.md for more info on why we use (and prefer) refout
    #     # and the mechanics of irefout vs. prefout.
    #     if name not in assembly.internals_visible_to and assembly.prefs:
    #         # Best compile caching (prefout changes less frequently than irefout or out)
    #         direct_refs.extend(assembly.prefs)
    #     elif assembly.irefout:
    #         # Ok compile caching (irefout changes less frequently than out)
    #         direct_refs.append(assembly.irefout)
    #     elif assembly.out:
    #         # No compile caching when the dependencies change
    #         direct_refs.append(assembly.out)

    #     transitive_refs.append(assembly.transitive_refs)

    #     if assembly.out:
    #         direct_runfiles.append(assembly.out)
    #     if assembly.pdb:
    #         direct_runfiles.append(assembly.pdb)

    #     transitive_runfiles.append(assembly.transitive_runfiles)
    #     native_dlls.append(assembly.native_dlls)

    # return (
    #     depset(direct = direct_refs, transitive = transitive_refs),
    #     depset(direct = direct_runfiles, transitive = transitive_runfiles),
    #     depset(transitive = native_dlls),
    # )

def get_analyzer_dll(analyzer_target):
    return analyzer_target[DotnetAssemblyInfo["netstandard"]]
