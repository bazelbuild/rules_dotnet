"""
Rules for compatability resolution of dependencies for .NET frameworks.
"""

load(
    "//dotnet/private:providers.bzl",
    "DotnetAssemblyInfo",
)

def is_debug(ctx):
    return ctx.var["COMPILATION_MODE"] == "dbg"

def use_highentropyva(tfm):
    return tfm not in ["net20", "net40"]

def is_standard_framework(tfm):
    return tfm.startswith("netstandard")

def is_core_framework(tfm):
    return tfm.startswith("netcoreapp") or tfm.startswith("net5.0") or tfm.startswith("net6.0")

def format_ref_arg(args, refs, targeting_pack_overrides):
    """Takes 

    Args:
        args: The args object that will be sent into the compilation action
        refs: List of all references that are being sent into the compilation action
        targeting_pack_overrides: Dict of overrides that are declared by targeting packs 
    Returns:
        The updated args object
    """

    def _format_ref_with_overrides(assembly):
        # TODO: Make it a bit more robust
        # We rely on the naming convention of nuget_archive/nuget_repo which isn't too nice
        # We also need to handle the versions here and make sure that if the version of the dep is > version in targeting pack then do not skip
        package_name = None
        if assembly.path.startswith("external/nuget."):
            package_name = assembly.path.lstrip("external/nuget.").split("/")[0].split(".v")[0]
        if package_name and package_name in targeting_pack_overrides:
            return None

        return "/r:" + assembly.path
    
    args.add_all(refs, allow_closure= True, map_each = _format_ref_with_overrides)

    return args

def collect_transitive_info(name, deps):
    """Determine the transitive dependencies by the target framework.

    Args:
        name: The name of the assembly that is asking.
        deps: Dependencies that the compilation target depends on.

    Returns:
        A collection of the references, runfiles and native dlls.
    """
    direct_irefs = []
    direct_prefs = []
    transitive_prefs = []
    direct_runfiles = []
    transitive_runfiles = []
    direct_analyzers = []
    transitive_analyzers = []

    overrides = {}
    for dep in deps:
        assembly = dep[DotnetAssemblyInfo]

        for override_name, override_version in assembly.targeting_pack_overrides.items():
            # TODO: In case there are multiple overrides of the same package
            # we should take the one with the highest version
            # Need to get a semver comparison function to do that
            overrides[override_name] = override_version

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

        direct_analyzers.extend(assembly.analyzers)
        transitive_analyzers.append(assembly.transitive_analyzers)


    return (
        depset(direct = direct_irefs, transitive = transitive_prefs),
        depset(direct = direct_prefs, transitive = transitive_prefs),
        depset(direct = direct_analyzers, transitive = transitive_analyzers),
        depset(direct = direct_runfiles, transitive = transitive_runfiles),
        overrides
    )    
