"Providers"

DotnetAssemblyInfo = provider(
    doc = "A DLL or exe.",
    fields = {
        "name": "string: The name of the assembly",
        "version": "string: The version of the assembly",
        "libs": "list[File]: Runtime DLLs",
        "pdbs": "list[File]: The PDBs of the assembly",
        "native": "list[File]: Native runtime files",
        "refs": "list[File]: Reference-only assemblies containing only public symbols. See docs/ReferenceAssemblies.md for more info.",
        "irefs": "list[File]: Reference-only assemblies containing public and internal symbols. See docs/ReferenceAssemblies.md for more info.",
        "analyzers": "list[File]: Analyzer dlls",
        "internals_visible_to": "list[string]: A list of assemblies that can use the assemblies listed in iref for compilation. See docs/ReferenceAssemblies.md for more info.",
        "data": "list[File]: Runtime data files",
        "exports": "list[File]",
        "runtime_deps": "list[DotnetDepVariantInfo]: The direct dependencies of the assembly",
        "transitive_runtime_deps": "depset[DotnetDepVariantInfo]: The transitive runtime dependencies of the assembly",
        "transitive_libs": "depset[File]: Transitive runtime DLLs",
        "transitive_native": "depset[File]: Transitive native runtime files",
        "transitive_data": "depset[File]: Transitive runtime data files",
        "transitive_refs": "depset[File]: Transitive reference-only assemblies containing only public symbols.",
        "transitive_analyzers": "depset[File]: Transitive analyzer dlls",
    },
)

DotnetDepVariantInfo = provider(
    doc = "A wrapper provider for a dependency. The dependency can be a project " +
          "dependency, in which case the `assembly_info` will be populated" +
          "or a NuGet dependency, in which case `assembly_info` and `nuget_info` will be populated.",
    fields = {
        "label": "Label: The label of the dependency",
        "assembly_info": "AssemblyInfo: The AssemblyInfo of a dependency",
        "nuget_info": "NuGetInfo: The NuGet info of a dependency",
    },
)

NuGetInfo = provider(
    doc = "Information about a NuGet package.",
    fields = {
        "targeting_pack_overrides": "map[string, string]: Targeting packs like e.g. Microsoft.NETCore.App.Ref have a PackageOverride.txt that includes a list of NuGet packages that should be omitted in a compiliation because they are included in the targeting pack",
        "sha512": "string: the SHA512 SRI string for the package",
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
        "runtime_packs": "list[AssemblyInfo]: Optional information about the used runtime packs. Used by self-contained publishing",
        "target_framework": "string: The target framework of the published binary",
        "self_contained": "bool: True if the binary is self-contained",
    },
)
