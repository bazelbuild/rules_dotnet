DotnetLibrary = provider(
    doc = "A represenatation of the dotnet assembly (regardless of framework used). See dotnet/providers.rst#DotnetLibrary for full documentation",
    fields = {
        "label": "Label of the rule used to create this DotnetLibrary",
        "name": "Name of the assembly (label.name if not provided)",
        "version": "Version number of the library. Tuple with 5 elements",
        "ref": "Reference assembly for this DotnetLibrary. Must be set to ctx.attr.ref or result if not provided",
        "deps": "The direct dependencies of this library",
        "result": "The assembly file",
        "pdb": "The pdb file (with compilation mode dbg)",
        "runfiles": "The depset of direct runfiles (File)",
        "transitive": "The full set of transitive dependencies. This does not include this assembly. List of DotnetLibrary",
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
