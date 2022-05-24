"""Define the dotnet providers for each .NET framework

This module defines one provider per target framework and creates some handy
lookup tables for dealing with frameworks.

See docs/MultiTargetingDesign.md for more info.
"""

def _make_dotnet_provider(tfm):
    return provider(
        doc = "A DLL or exe, targetting %s." % tfm,
        fields = {
            "out": "DLLs (for libraries and tests) or an exe (for binaries).",
            "prefout": "Reference-only assemblies containing only public symbols. See docs/ReferenceAssemblies.md for more info.",
            "irefout": "Reference-only assemblies containing public and internal symbols. See docs/ReferenceAssemblies.md for more info.",
            "internals_visible_to": "A list of assemblies that can must use irefout for compilation. See docs/ReferenceAssemblies.md for more info.",
            "pdb": "debug symbols",
            "native_dlls": "A list of native DLLs required to build and run this assembly",
            "deps": "the non-transitive dependencies for this assembly (used by import_multiframework_library).",
            "transitive_refs": "A list of other assemblies to reference when referencing this assembly in a compilation.",
            "transitive_runfiles": "Runfiles from the transitive dependencies.",
            "actual_tfm": "The target framework of the actual dlls",
            "runtimeconfig": "An optional runtimeconfig.json for executable assemblies",
            "depsjson": "An optional deps.json for executable assemblies",
        },
    )

# Bazel requires that providers be "top level" objects, so this stuff is a bit
# more boilerplate than it could otherwise be.
DotnetAssemblyNetStandardInfo = _make_dotnet_provider("netstandard")
DotnetAssemblyNetStandard10Info = _make_dotnet_provider("netstandard1.0")
DotnetAssemblyNetStandard11Info = _make_dotnet_provider("netstandard1.1")
DotnetAssemblyNetStandard12Info = _make_dotnet_provider("netstandard1.2")
DotnetAssemblyNetStandard13Info = _make_dotnet_provider("netstandard1.3")
DotnetAssemblyNetStandard14Info = _make_dotnet_provider("netstandard1.4")
DotnetAssemblyNetStandard15Info = _make_dotnet_provider("netstandard1.5")
DotnetAssemblyNetStandard16Info = _make_dotnet_provider("netstandard1.6")
DotnetAssemblyNetStandard20Info = _make_dotnet_provider("netstandard2.0")
DotnetAssemblyNetStandard21Info = _make_dotnet_provider("netstandard2.1")
DotnetAssemblyNet11Info = _make_dotnet_provider("net11")
DotnetAssemblyNet20Info = _make_dotnet_provider("net20")
DotnetAssemblyNet30Info = _make_dotnet_provider("net30")
DotnetAssemblyNet35Info = _make_dotnet_provider("net35")
DotnetAssemblyNet40Info = _make_dotnet_provider("net40")
DotnetAssemblyNet403Info = _make_dotnet_provider("net403")
DotnetAssemblyNet45Info = _make_dotnet_provider("net45")
DotnetAssemblyNet451Info = _make_dotnet_provider("net451")
DotnetAssemblyNet452Info = _make_dotnet_provider("net452")
DotnetAssemblyNet46Info = _make_dotnet_provider("net46")
DotnetAssemblyNet461Info = _make_dotnet_provider("net461")
DotnetAssemblyNet462Info = _make_dotnet_provider("net462")
DotnetAssemblyNet47Info = _make_dotnet_provider("net47")
DotnetAssemblyNet471Info = _make_dotnet_provider("net471")
DotnetAssemblyNet472Info = _make_dotnet_provider("net472")
DotnetAssemblyNet48Info = _make_dotnet_provider("net48")
DotnetAssemblyNetCoreApp10Info = _make_dotnet_provider("netcoreapp1.0")
DotnetAssemblyNetCoreApp11Info = _make_dotnet_provider("netcoreapp1.1")
DotnetAssemblyNetCoreApp20Info = _make_dotnet_provider("netcoreapp2.0")
DotnetAssemblyNetCoreApp21Info = _make_dotnet_provider("netcoreapp2.1")
DotnetAssemblyNetCoreApp22Info = _make_dotnet_provider("netcoreapp2.2")
DotnetAssemblyNetCoreApp30Info = _make_dotnet_provider("netcoreapp3.0")
DotnetAssemblyNetCoreApp31Info = _make_dotnet_provider("netcoreapp3.1")
DotnetAssemblyNet50Info = _make_dotnet_provider("net5.0")
DotnetAssemblyNet60Info = _make_dotnet_provider("net6.0")

# A dict from TFM to provider. The order of keys is not used.
DotnetAssemblyInfo = {
    "netstandard": DotnetAssemblyNetStandardInfo,
    "netstandard1.0": DotnetAssemblyNetStandard10Info,
    "netstandard1.1": DotnetAssemblyNetStandard11Info,
    "netstandard1.2": DotnetAssemblyNetStandard12Info,
    "netstandard1.3": DotnetAssemblyNetStandard13Info,
    "netstandard1.4": DotnetAssemblyNetStandard14Info,
    "netstandard1.5": DotnetAssemblyNetStandard15Info,
    "netstandard1.6": DotnetAssemblyNetStandard16Info,
    "netstandard2.0": DotnetAssemblyNetStandard20Info,
    "netstandard2.1": DotnetAssemblyNetStandard21Info,
    "net11": DotnetAssemblyNet11Info,
    "net20": DotnetAssemblyNet20Info,
    "net30": DotnetAssemblyNet30Info,
    "net35": DotnetAssemblyNet35Info,
    "net40": DotnetAssemblyNet40Info,
    "net403": DotnetAssemblyNet403Info,
    "net45": DotnetAssemblyNet45Info,
    "net451": DotnetAssemblyNet451Info,
    "net452": DotnetAssemblyNet452Info,
    "net46": DotnetAssemblyNet46Info,
    "net461": DotnetAssemblyNet461Info,
    "net462": DotnetAssemblyNet462Info,
    "net47": DotnetAssemblyNet47Info,
    "net471": DotnetAssemblyNet471Info,
    "net472": DotnetAssemblyNet472Info,
    "net48": DotnetAssemblyNet48Info,
    "netcoreapp1.0": DotnetAssemblyNetCoreApp10Info,
    "netcoreapp1.1": DotnetAssemblyNetCoreApp11Info,
    "netcoreapp2.0": DotnetAssemblyNetCoreApp20Info,
    "netcoreapp2.1": DotnetAssemblyNetCoreApp21Info,
    "netcoreapp2.2": DotnetAssemblyNetCoreApp22Info,
    "netcoreapp3.0": DotnetAssemblyNetCoreApp30Info,
    "netcoreapp3.1": DotnetAssemblyNetCoreApp31Info,
    "net5.0": DotnetAssemblyNet50Info,
    "net6.0": DotnetAssemblyNet60Info,
}

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

def GetDotnetAssemblyInfoFromLabel(label):
    """Create a *.deps.json file.

    This file is necessary when running a .NET Core binary.

    Args:
      label: The label from which the DotnetAssemblyInfo provider should be extracted from
    Returns:
        The DotnetAssemblyInfo provider for the target framework of the label
    """
    for info in reversed(DotnetAssemblyInfo.values()):
        provider = label[info]
        if provider:
            return provider
        else:
            continue
    fail("No DotnetAassemlyInfo provider found in label {}".format(label))

def GetFrameworkVersionInfo(tfm):
    return (
        _subsystem_version[tfm],
        _default_lang_version_csharp[tfm],
    )

# A convenience used in attributes that need to specify that they accept any
# kind of C# assembly. This is an array of single-element arrays.
AnyTargetFrameworkInfo = [[a] for a in DotnetAssemblyInfo.values()]
