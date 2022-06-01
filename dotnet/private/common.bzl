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

def collect_transitive_info(name, deps):
    """Determine the transitive dependencies by the target framework.

    Args:
        name: The name of the assembly that is asking.
        deps: Dependencies that the compilation target depends on.
        tfm: The target framework moniker.

    Returns:
        A collection of the references, runfiles and native dlls.
    """
    direct_irefs = []
    direct_prefs = []
    transitive_prefs = []
    
    direct_runfiles = []
    transitive_runfiles = []

    for dep in deps:
        assembly = dep[DotnetAssemblyInfo]

        # See docs/ReferenceAssemblies.md for more info on why we use (and prefer) refout
        # and the mechanics of irefout vs. prefout.
        direct_irefs.extend(assembly.irefs if name in assembly.internals_visible_to else assembly.prefs)
        direct_prefs.extend(assembly.prefs)
        transitive_prefs.append(assembly.transitive_prefs)

        direct_runfiles.extend(assembly.libs)
        direct_runfiles.extend(assembly.data)
        transitive_runfiles.append(assembly.transitive_runfiles)

    return (
        depset(direct = direct_irefs, transitive = transitive_prefs),
        depset(direct = direct_prefs, transitive = transitive_prefs),
        depset(direct = direct_runfiles, transitive = transitive_runfiles),
    )

def get_analyzer_dll(analyzer_target):
    return analyzer_target[DotnetAssemblyInfo["netstandard"]]
