load("@io_bazel_rules_dotnet//dotnet/private:providers.bzl", "DotnetLibrary")
load("@io_bazel_rules_dotnet//dotnet/private:rules/versions.bzl", "compare_versions")

def collect_transitive_info(deps):
    """Collects transitive information.

    Args:
      deps: Dependencies that the DotnetLibrary depends on.

    Returns:
      list of DotnetDepInfo.
    """

    result = []

    # key: basename of result, value: DotnetLibrary
    lookup = {}

    basename = ""
    found = None

    for dep in deps:
        assembly = dep[DotnetLibrary]

        # Empty result is set for librarysets
        if assembly.result != None:
            basename = assembly.result.basename
            found = lookup.get(basename)
        else:
            found = None

        if found == None or compare_versions(assembly.version, found.version) > 0:
            if assembly.result != None:
                result.append(assembly)
                lookup[basename] = assembly
            for t in assembly.transitive:
                if t.result != None:
                    tbasename = t.result.basename
                    tfound = lookup.get(tbasename)
                    if tfound == None or compare_versions(t.version, tfound.version) > 0:
                        result.append(t)
                        lookup[tbasename] = t

    return result
