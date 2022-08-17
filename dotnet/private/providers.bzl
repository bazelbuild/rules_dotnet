"Providers"

DotnetAssemblyInfo = provider(
    doc = "A DLL or exe.",
    fields = {
        "lib": "depset[File]: Runtime DLLs",
        "ref": "depset[File]: Reference-only assemblies containing only public symbols. See docs/ReferenceAssemblies.md for more info.",
        "iref": "depset[File]: Reference-only assemblies containing public and internal symbols. See docs/ReferenceAssemblies.md for more info.",
        "analyzers": "depset[File]: Analyzer dlls",
        "internals_visible_to": "list[string]: A list of assemblies that can use the assemblies listed in iref for compilation. See docs/ReferenceAssemblies.md for more info.",
        "data": "depset[File]: Runtime data files",
        "transitive_ref": "depset[File]: Transitive reference-only assemblies containing only public symbols.",
        "transitive_runfiles": "depset[File]: Runfiles from the transitive dependencies.",
        "transitive_analyzers": "depset[File]: Transitive analyzer dlls",
    },
)

NuGetInfo = provider(
    doc = "Information about a NuGet package.",
    fields = {
        "package_name": "string: The name of the NuGet package",
        "version": "string: The version of the NuGet package",
        "targeting_pack_overrides": "map[string, string]: Targeting packs like e.g. Microsoft.NETCore.App.Ref have a PackageOverride.txt that includes a list of NuGet packages that should be omitted in a compiliation because they are included in the targeting pack",
    },
)

DotnetBinaryInfo = provider(
    doc = "Information about a .Net binary",
    fields = {
        "app_host": "File: The apphost executable",
        "dll": "File: The main binary dll",
        "runfiles": "depset[File]: The runfiles required by the binary",
        "runtimeconfig": "File: An optional runtimeconfig.json",
        "depsjson": "File: An optional deps.json",
    },
)

DotnetPublishBinaryInfo = provider(
    doc = "Information about a published .Net binary",
    fields = {
        "binary_info": "DotnetBinaryInfo: Information about the binary",
        "publishing_pack": "depset[File]: The files that belong to the publishing pack",
        "target_framework": "string: The target framework of the published binary",
        "self_contained": "bool: True if the binary is self-contained",
    },
)
