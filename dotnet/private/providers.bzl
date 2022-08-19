"Providers"

DotnetAssemblyInfo = provider(
    doc = "A DLL or exe.",
    fields = {
        "lib": "list[File]: Runtime DLLs",
        "native": "list[File]: Native runtime files",
        "ref": "list[File]: Reference-only assemblies containing only public symbols. See docs/ReferenceAssemblies.md for more info.",
        "iref": "list[File]: Reference-only assemblies containing public and internal symbols. See docs/ReferenceAssemblies.md for more info.",
        "analyzers": "list[File]: Analyzer dlls",
        "internals_visible_to": "list[string]: A list of assemblies that can use the assemblies listed in iref for compilation. See docs/ReferenceAssemblies.md for more info.",
        "data": "list[File]: Runtime data files",
        "transitive_lib": "depset[File]: Transitive runtime DLLs",
        "transitive_native": "depset[File]: Transitive native runtime files",
        "transitive_data": "depset[File]: Transitive runtime data files",
        "transitive_ref": "depset[File]: Transitive reference-only assemblies containing only public symbols.",
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
    },
)

DotnetPublishBinaryInfo = provider(
    doc = "Information about a published .Net binary",
    fields = {
        "publishing_pack": "depset[File]: The files that belong to the publishing pack",
        "target_framework": "string: The target framework of the published binary",
        "self_contained": "bool: True if the binary is self-contained",
    },
)
