"""Define the dotnet providers for each .NET framework

This module defines one provider per target framework and creates some handy
lookup tables for dealing with frameworks.

See docs/MultiTargetingDesign.md for more info.
"""

load("@bazel_skylib//lib:sets.bzl", "sets")
load("@bazel_skylib//rules:common_settings.bzl", "bool_flag")

# todo rename. Maybe to DotnetLibrary like on master?
DotnetAssemblyInfo = provider(
    doc = "A DLL or exe.",
    # fields = {
    #     "out": "a dll (for libraries and tests) or an exe (for binaries).",
    #     "prefout": "A reference-only assembly containing only public symbols. See docs/ReferenceAssemblies.md for more info.",
    #     "irefout": "A reference-only assembly containing public and internal symbols. See docs/ReferenceAssemblies.md for more info.",
    #     "internals_visible_to": "A list of assemblies that can must use irefout for compilation. See docs/ReferenceAssemblies.md for more info.",
    #     "pdb": "debug symbols",
    #     "native_dlls": "A list of native DLLs required to build and run this assembly",
    #     "deps": "the non-transitive dependencies for this assembly (used by import_multiframework_library).",
    #     "transitive_refs": "A list of other assemblies to reference when referencing this assembly in a compilation.",
    #     "transitive_runfiles": "Runfiles from the transitive dependencies.",
    #     "actual_tfm": "The target framework of the actual dlls",
    #     "runtimeconfig": "An optional runtimeconfig.json for executable assemblies",
    #     "depsjson": "An optional deps.json for executable assemblies",
    # },
)

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

_net = FRAMEWORK_COMPATIBILITY.keys().index("net11")
_cor = FRAMEWORK_COMPATIBILITY.keys().index("netcoreapp1.0")
STD_FRAMEWORKS = FRAMEWORK_COMPATIBILITY.keys()[:_net]
NET_FRAMEWORKS = FRAMEWORK_COMPATIBILITY.keys()[_net:_cor]
COR_FRAMEWORKS = FRAMEWORK_COMPATIBILITY.keys()[_cor:]

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
AnyTargetFrameworkInfo = [DotnetAssemblyInfo]
