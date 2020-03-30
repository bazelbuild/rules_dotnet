DotnetLibrary = provider(
    doc = "A represenatation of the dotnet assembly (regardless of framework used). See dotnet/providers.rst#DotnetLibrary for full documentation",
    fields = {
        "label": "Label of the rule used to create this DotnetLibrary",
        "name": "Name of the assembly (label.name if not provided)",
        "version": "Version number of the library",
        "deps": "The direct dependencies of this library",
        "transitive": "The full set of transitive dependencies. This includes deps for this assembly",
        "result": "The assembly file",
        "pdb": "The pdb file (with compilation mode dbg)",
        "runfiles": "The depset of files required to run given assembly. It should include result and pdb",
        "ref": "Reference assembly for this DotnetLibrary. If provided it is used as the compilation reference",
        "transitive_refs": "Transitive paths to be used as references during compilation (either ref or result)",
    },
)

DotnetResource = provider()
"""
A represenatation of the dotnet compiled resource (.resources).
See dotnet/providers.rst#DotnetResource for full documentation.
"""

DotnetResourceList = provider()
"""
A represenatation of the lsit of compiled resource (.resources).
See dotnet/providers.rst#DotnetResourceList for full documentation.
"""
