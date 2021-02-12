"Key poviders"

DotnetLibraryInfo = provider(
    doc = "DotnetLibraryInfo is a provider that exposes a compiled assembly along with it's full transitive dependencies.",
    fields = {
        "label": "Label of the rule used to create this DotnetLibraryInfo.",
        "name": "Name of the assembly (label.name if not provided).",
        "version": "Version number of the library. Tuple with 5 elements.",
        "ref": "Reference assembly for this DotnetLibraryInfo. Must be set to ctx.attr.ref or result if not provided. See [reference assembly](https://docs.microsoft.com/en-us/dotnet/standard/assembly/reference-assemblies).",
        "deps": "The direct dependencies of this library.",
        "result": "The assembly file.",
        "pdb": "The pdb file (with compilation mode dbg).",
        "runfiles": "The depset of direct runfiles (File).",
        "transitive": "The full set of transitive dependencies. This does not include this assembly. List of DotnetLibraryInfo",
    },
)

DotnetResourceInfo = provider(
    doc = "Represents a resource file.",
    fields = {
        "label": "Label of the rule used to create this provider.",
        "name": "Name of the resource.",
        "result": "The file to be embeded into assembly. ",
        "identifier": "Identifier used when loading the resource. ",
    },
)

DotnetResourceListInfo = provider(
    doc = "Represents resource files. ",
    fields = {
        "result": "Array of [DotnetResourceInfo](api.md#dotnetresourceinfo).",
    },
)
