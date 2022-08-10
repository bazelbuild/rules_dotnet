"""
Rules for compatability resolution of dependencies for .NET frameworks.
"""

load("@bazel_skylib//lib:sets.bzl", "sets")
load(
    "//dotnet/private:providers.bzl",
    "DotnetAssemblyInfo",
    "NuGetInfo",
)

def _collect_transitive():
    t = {}
    for (framework, compat) in FRAMEWORK_COMPATIBILITY.items():
        # the transitive closure of compatible frameworks
        t[framework] = sets.union(sets.make([framework]), *[t[c] for c in compat])
    return t

# A dict of target frameworks to the set of other framworks it can compile
# against. This relationship is transitive. The order of this dictionary also
# matters. netstandard should appear first, and keys within a family should
# proceed from oldest to newest
FRAMEWORK_COMPATIBILITY = {
    # .NET Standard
    "netstandard": [],
    "netstandard1.0": ["netstandard"],
    "netstandard1.1": ["netstandard1.0"],
    "netstandard1.2": ["netstandard1.1"],
    "netstandard1.3": ["netstandard1.2"],
    "netstandard1.4": ["netstandard1.3"],
    "netstandard1.5": ["netstandard1.4"],
    "netstandard1.6": ["netstandard1.5"],
    "netstandard2.0": ["netstandard1.6"],
    "netstandard2.1": ["netstandard2.0"],

    # .NET Framework
    "net11": [],
    "net20": ["net11"],
    "net30": ["net20"],
    "net35": ["net30"],
    "net40": ["net35"],
    "net403": ["net40"],
    "net45": ["net403", "netstandard1.1"],
    "net451": ["net45", "netstandard1.2"],
    "net452": ["net451"],
    "net46": ["net452", "netstandard1.3"],
    "net461": ["net46", "netstandard2.0"],
    "net462": ["net461"],
    "net47": ["net462"],
    "net471": ["net47"],
    "net472": ["net471"],
    "net48": ["net472"],

    # .NET Core
    "netcoreapp1.0": ["netstandard1.6"],
    "netcoreapp1.1": ["netcoreapp1.0"],
    "netcoreapp2.0": ["netcoreapp1.1", "netstandard2.0"],
    "netcoreapp2.1": ["netcoreapp2.0"],
    "netcoreapp2.2": ["netcoreapp2.1"],
    "netcoreapp3.0": ["netcoreapp2.2", "netstandard2.1"],
    "netcoreapp3.1": ["netcoreapp3.0"],
    "net5.0": ["netcoreapp3.1"],
    "net6.0": ["net5.0"],
}

_subsystem_version = {
    "netstandard": None,
    "netstandard1.0": None,
    "netstandard1.1": None,
    "netstandard1.2": None,
    "netstandard1.3": None,
    "netstandard1.4": None,
    "netstandard1.5": None,
    "netstandard1.6": None,
    "netstandard2.0": None,
    "netstandard2.1": None,
    "net11": None,
    "net20": None,
    "net30": None,
    "net35": None,
    "net40": None,
    "net403": None,
    "net45": "6.00",
    "net451": "6.00",
    "net452": "6.00",
    "net46": "6.00",
    "net461": "6.00",
    "net462": "6.00",
    "net47": "6.00",
    "net471": "6.00",
    "net472": "6.00",
    "net48": "6.00",
    "netcoreapp1.0": None,
    "netcoreapp1.1": None,
    "netcoreapp2.0": None,
    "netcoreapp2.1": None,
    "netcoreapp2.2": None,
    "netcoreapp3.0": None,
    "netcoreapp3.1": None,
    "net5.0": None,
    "net6.0": None,
}

_default_lang_version_csharp = {
    "netstandard": "7.3",
    "netstandard1.0": "7.3",
    "netstandard1.1": "7.3",
    "netstandard1.2": "7.3",
    "netstandard1.3": "7.3",
    "netstandard1.4": "7.3",
    "netstandard1.5": "7.3",
    "netstandard1.6": "7.3",
    "netstandard2.0": "7.3",
    "netstandard2.1": "7.3",
    "net11": "7.3",
    "net20": "7.3",
    "net30": "7.3",
    "net35": "7.3",
    "net40": "7.3",
    "net403": "7.3",
    "net45": "7.3",
    "net451": "7.3",
    "net452": "7.3",
    "net46": "7.3",
    "net461": "7.3",
    "net462": "7.3",
    "net47": "7.3",
    "net471": "7.3",
    "net472": "7.3",
    "net48": "7.3",
    "netcoreapp1.0": "7.3",
    "netcoreapp1.1": "7.3",
    "netcoreapp2.0": "7.3",
    "netcoreapp2.1": "7.3",
    "netcoreapp2.2": "7.3",
    "netcoreapp3.0": "8.0",
    "netcoreapp3.1": "8.0",
    "net5.0": "9.0",
    "net6.0": "10.0",
}

_net = FRAMEWORK_COMPATIBILITY.keys().index("net11")
_cor = FRAMEWORK_COMPATIBILITY.keys().index("netcoreapp1.0")
STD_FRAMEWORKS = FRAMEWORK_COMPATIBILITY.keys()[:_net]
NET_FRAMEWORKS = FRAMEWORK_COMPATIBILITY.keys()[_net:_cor]
COR_FRAMEWORKS = FRAMEWORK_COMPATIBILITY.keys()[_cor:]
TRANSITIVE_FRAMEWORK_COMPATIBILITY = _collect_transitive()

def is_debug(ctx):
    return ctx.var["COMPILATION_MODE"] == "dbg"

def use_highentropyva(tfm):
    return tfm not in ["net20", "net40"]

def is_standard_framework(tfm):
    return tfm.startswith("netstandard")

def is_core_framework(tfm):
    # TODO: Make this work with future versions
    return tfm.startswith("netcoreapp") or tfm.startswith("net5.0") or tfm.startswith("net6.0") or tfm.startswith("net7.0") or tfm.startswith("net8.0") or tfm.startswith("net9.0")

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

    args.add_all(refs, allow_closure = True, map_each = _format_ref_with_overrides)

    return args

def collect_transitive_info(name, deps, private_deps, strict_deps):
    """Determine the transitive dependencies by the target framework.

    Args:
        name: The name of the assembly that is asking.
        deps: Dependencies that the compilation target depends on.
        private_deps: Private dependencies that the compilation target depends on.
        strict_deps: Whether or not to use strict dependencies.

    Returns:
        A collection of the overrides, references, analyzers and runfiles.
    """
    direct_irefs = []
    direct_prefs = []
    transitive_prefs = []
    direct_runfiles = []
    transitive_runfiles = []
    direct_analyzers = []
    transitive_analyzers = []

    direct_private_refs = []
    transitive_private_refs = []
    direct_private_analyzers = []
    transitive_private_analyzers = []
    direct_labels = [d.label for d in deps]

    overrides = {}
    for dep in deps + private_deps:
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
        direct_analyzers.extend(assembly.analyzers)
        direct_runfiles.extend(assembly.libs)

        # Runfiles are always collected transitively
        # We need to make sure that we do not include multiple versions of the same first party dll
        # in the runfiles. We can do that by taking the direct first party deps and see if any of them are already
        # in the runfiles and if they are we remove them from the transitive runfiles.
        if NuGetInfo in dep:
            transitive_runfiles.append(assembly.transitive_runfiles)
        else:
            runfiles = []
            for transitive_runfile in assembly.transitive_runfiles.to_list():
                if transitive_runfile.owner in direct_labels:
                    continue
                runfiles.append(transitive_runfile)

            transitive_runfiles.append(depset(runfiles))

        direct_runfiles.extend(assembly.data)

        if not strict_deps:
            transitive_prefs.append(assembly.transitive_prefs)
            transitive_analyzers.append(assembly.transitive_analyzers)

    for dep in private_deps:
        assembly = dep[DotnetAssemblyInfo]

        direct_private_refs.extend(assembly.irefs if name in assembly.internals_visible_to else assembly.prefs)
        direct_private_analyzers.extend(assembly.analyzers)

        if not strict_deps:
            transitive_private_refs.append(assembly.transitive_prefs)
            transitive_private_analyzers.append(assembly.transitive_analyzers)

    return (
        depset(direct = direct_irefs, transitive = transitive_prefs),
        depset(direct = direct_prefs, transitive = transitive_prefs),
        depset(direct = direct_analyzers, transitive = transitive_analyzers),
        depset(direct = direct_runfiles, transitive = transitive_runfiles),
        depset(direct = direct_private_refs, transitive = transitive_private_refs),
        depset(direct = direct_private_analyzers, transitive = transitive_private_analyzers),
        overrides,
    )

def get_framework_version_info(tfm):
    return (
        _subsystem_version[tfm],
        _default_lang_version_csharp[tfm],
    )

def get_highest_compatible_target_framework(incoming_tfm, tfms):
    """Returns the highest compatible framework version for the incoming_tfm.

    Args:
      incoming_tfm: The target framework of the incoming binary
      tfms: A list of target frameworks
    Returns:
        The highest compatible framework version
    """
    if incoming_tfm in tfms:
        return incoming_tfm

    if FRAMEWORK_COMPATIBILITY[incoming_tfm] == None:
        fail("Target framework moniker is not supported/valid: {}", incoming_tfm)

    incoming_tfm_index = FRAMEWORK_COMPATIBILITY.keys().index(incoming_tfm)
    for tfm in reversed(FRAMEWORK_COMPATIBILITY.keys()[:incoming_tfm_index]):
        if tfm in tfms:
            return tfm

    return None

def is_strict_deps_enabled(toolchain, strict_deps_attr):
    """Determines if strict dependencies are enabled.

    Args:
        toolchain: The toolchain that is being used.
        strict_deps_attr: Target level override for strict dependencies.

    Returns:
        True if strict dependencies are enabled, False otherwise.
    """
    default = toolchain.strict_deps

    if strict_deps_attr != default:
        return strict_deps_attr

    return default
