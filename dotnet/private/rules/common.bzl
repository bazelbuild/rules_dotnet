load("@io_bazel_rules_dotnet//dotnet/private:providers.bzl", "DotnetLibraryInfo")
load("@io_bazel_rules_dotnet//dotnet/private:rules/versions.bzl", "compare_versions")

def collect_transitive_info(deps):
    """Collects transitive information.

    Args:
      deps: Dependencies that the DotnetLibraryInfo depends on.

    Returns:
      list of DotnetLibraryInfo.
    """

    # key: basename of result, value: DotnetLibraryInfo
    lookup = {}

    basename = ""
    found = None

    for dep in deps:
        assembly = dep[DotnetLibraryInfo]

        # Empty result is set for librarysets
        if assembly.result != None:
            basename = assembly.result.basename.lower()
            found = lookup.get(basename)
        else:
            basename = assembly.name.lower() + "__libraryset__"
            found = None

        if found == None or compare_versions(assembly.version, found.version) > 0:
            lookup[basename] = assembly
            if assembly.transitive != None:
                for t in assembly.transitive:
                    if t.result != None:
                        tbasename = t.result.basename.lower()
                        tfound = lookup.get(tbasename)
                    else:
                        tbasename = t.name.lower() + "__libraryset__"
                        tfound = None

                    if tfound == None or compare_versions(t.version, tfound.version) > 0:
                        lookup[tbasename] = t

    return lookup.values()
