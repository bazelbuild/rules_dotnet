"Providers"

# TODO: Split up into multiple providers e.g. DotnetAssemblyInfo, DotnetRuntimeInfo, NuGetInfo
DotnetAssemblyInfo = provider(
    doc = "A DLL or exe.",
    fields = {
        "name": "The name of the assembly",
        "version": "The version of the assembly",
        "libs": "a dll (for libraries and tests) or an exe (for binaries).",
        "analyzers": "Analyzer dlls",
        "prefs": "Reference-only assemblies containing only public symbols. See docs/ReferenceAssemblies.md for more info.",
        "irefs": "Reference-only assemblies containing public and internal symbols. See docs/ReferenceAssemblies.md for more info.",
        "internals_visible_to": "A list of assemblies that can must use irefout for compilation. See docs/ReferenceAssemblies.md for more info.",
        "data": "Runtime data files",
        "deps": "the non-transitive dependencies for this assembly (used by import_multiframework_library).",
        "transitive_prefs": "A list of public assemblies to reference when referencing this assembly in a compilation.",
        "transitive_runfiles": "Runfiles from the transitive dependencies.",
        "transitive_analyzers": "Transitive analyzer dlls",
        "runtimeconfig": "An optional runtimeconfig.json for executable assemblies",
        "depsjson": "An optional deps.json for executable assemblies",
        "targeting_pack_overrides": "Targeting packs like e.g. Microsoft.NETCore.App.Ref have a PackageOverride.txt that includes a list of NuGet packages that should be omitted in a compiliation because they are included in the targeting pack",
    },
)

NuGetInfo = provider(
    doc = "Information about a NuGet package.",
    fields = {
    },
)
