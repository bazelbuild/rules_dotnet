load(
    "@io_bazel_rules_dotnet//dotnet/private:providers.bzl",
    "DotnetLibrary",
)

def _compareVersions(v1, v2):
    if v1 == None:
        return True

    if v2 == None:
        return False
    return v1 < v2

# Expects List of tuples (File|DotnetLibrary, version).
# Recalculates transitive dependencies.
def _ResolveVersions(targets):
    matched = {}
    matched_versions = {}

    for d, v in targets:
        if type(d) == "Target":
            key = d[DotnetLibrary].result.basename
        else:
            key = d.basename
        found = matched_versions.get(key)
        if not found:
            matched[key] = d
            matched_versions[key] = v
        elif _compareVersions(found, v):
            matched[key] = d
            matched_versions[key] = v

    return matched.values()

# Tries to decipher arguments to the list of File or DotnetLibrary
# We need to do tricky calls because Starlark doesn't support recursion
def ResolveVersions(*argv):
    toprocess_transitive = []
    toprocess_runfiles = []
    for arg in argv:
        toprocess_runfiles += _ResolveRunfilesLevel1(arg)
        toprocess_transitive += _ResolveTransitiveLevel1(arg)

    transitive = _ResolveVersions(toprocess_transitive)
    transitive_runfiles = _ResolveVersions(toprocess_runfiles)

    transitive = depset(direct = transitive)
    transitive_runfiles = depset(transitive_runfiles)
    return transitive, transitive_runfiles

def _ResolveRunfilesLevel1(arg):
    result = []
    if (type(arg)) == "list":
        for inner in arg:
            result += _ResolveRunfilesLevel2(inner, None)
        return result

    if (type(arg) == "Target"):
        result += _ResolveRunfilesLevel2(arg[DotnetLibrary].runfiles.to_list(), arg[DotnetLibrary].version)
        return result

    if (type(arg) == "struct"):
        result += _ResolveRunfilesLevel2(arg.runfiles.to_list(), arg.version)
        return result

    if (type(arg) == "File"):
        result += [(arg, None)]
        return result

    fail("Unknown argument %s" % arg)

def _ResolveRunfilesLevel2(arg, version):
    result = []
    if (type(arg)) == "list":
        for inner in arg:
            result += _ResolveRunfilesLevel3(inner, version)
        return result

    if (type(arg) == "Target"):
        result += _ResolveRunfilesLevel3(arg[DotnetLibrary].runfiles.to_list(), arg[DotnetLibrary].version)
        return result

    if (type(arg) == "struct"):
        result += _ResolveRunfilesLevel3(arg.runfiles.to_list(), arg.version)
        return result

    if (type(arg) == "File"):
        result += [(arg, version)]
        return result

    fail("Unknown argument %s" % arg)

def _ResolveRunfilesLevel3(arg, version):
    result = []
    if (type(arg)) == "list":
        for inner in arg:
            result += _ResolveRunfilesLevel4(inner, version)
        return result

    if (type(arg) == "Target"):
        result += _ResolveRunfilesLevel4(arg[DotnetLibrary].runfiles.to_list(), arg[DotnetLibrary].version)
        return result

    if (type(arg) == "struct"):
        result += _ResolveRunfilesLevel4(arg.runfiles.to_list(), arg.version)
        return result

    if (type(arg) == "File"):
        result += [(arg, version)]
        return result

    fail("Unknown argument %s" % arg)

def _ResolveRunfilesLevel4(arg, version):
    result = []
    if (type(arg)) == "list" or type(arg) == "Target" or type(arg) == "struct":
        fail("Recursion to deep on %s" % arg)

    if (type(arg) == "File"):
        result += [(arg, version)]
        return result

    fail("Unknown argument %s" % arg)

def _ResolveTransitiveLevel1(arg):
    result = []
    if (type(arg)) == "list":
        for inner in arg:
            result += _ResolveTransitiveLevel2(inner, None)
        return result

    if (type(arg) == "Target"):
        result += [(arg, arg[DotnetLibrary].version)]
        result += _ResolveTransitiveLevel2(arg[DotnetLibrary].transitive.to_list(), arg[DotnetLibrary].version)
        return result

    if (type(arg) == "struct"):
        result += _ResolveTransitiveLevel2(arg.transitive.to_list(), arg.version)
        return result

    fail("Unknown argument %s" % arg)

def _ResolveTransitiveLevel2(arg, version):
    result = []
    if (type(arg)) == "list":
        for inner in arg:
            result += _ResolveTransitiveLevel3(inner, version)
        return result

    if (type(arg) == "Target"):
        result += [(arg, arg[DotnetLibrary].version)]
        result += _ResolveTransitiveLevel3(arg[DotnetLibrary].transitive.to_list(), arg[DotnetLibrary].version)
        return result

    fail("Unknown argument %s" % arg)

def _ResolveTransitiveLevel3(arg, version):
    result = []
    if (type(arg)) == "list":
        for inner in arg:
            result += _ResolveTransitiveLevel4(inner, version)
        return result

    if (type(arg) == "Target"):
        result += [(arg, arg[DotnetLibrary].version)]
        return result

    fail("Unknown argument %s" % arg)

def _ResolveTransitiveLevel4(arg, version):
    result = []
    if (type(arg)) == "list":
        for inner in arg:
            result += _ResolveTransitiveLevel5(inner, version)
        return result

    if (type(arg) == "Target"):
        result += [(arg, arg[DotnetLibrary].version)]
        return result

    fail("Unknown argument %s" % arg)

def _ResolveTransitiveLevel5(arg, version):
    result = []
    if (type(arg)) == "list":
        for inner in arg:
            result += _ResolveTransitiveLevel6(inner, version)
        return result

    if (type(arg) == "Target"):
        result += [(arg, arg[DotnetLibrary].version)]
        return result

    fail("Unknown argument %s" % arg)

def _ResolveTransitiveLevel6(arg, version):
    result = []
    if (type(arg)) == "list":
        for inner in arg:
            result += _ResolveTransitiveLevel7(inner, version)
        return result

    if (type(arg) == "Target"):
        result += [(arg, arg[DotnetLibrary].version)]
        return result

    fail("Unknown argument %s" % arg)

def _ResolveTransitiveLevel7(arg, version):
    result = []
    if (type(arg)) == "list":
        for inner in arg:
            result += _ResolveTransitiveLevel8(inner, version)
        return result

    if (type(arg) == "Target"):
        result += [(arg, arg[DotnetLibrary].version)]
        return result

    fail("Unknown argument %s" % arg)

def _ResolveTransitiveLevel8(arg, version):
    result = []
    if (type(arg)) == "list":
        for inner in arg:
            result += _ResolveTransitiveLevel9(inner, version)
        return result

    if (type(arg) == "Target"):
        result += [(arg, arg[DotnetLibrary].version)]
        return result

    fail("Unknown argument %s" % arg)

def _ResolveTransitiveLevel9(arg, version):
    result = []
    if (type(arg)) == "list":
        for inner in arg:
            result += _ResolveTransitiveLevel10(inner, version)
        return result

    if (type(arg) == "Target"):
        result += [(arg, arg[DotnetLibrary].version)]
        return result

    fail("Unknown argument %s" % arg)

def _ResolveTransitiveLevel10(arg, version):
    result = []
    if (type(arg)) == "list":
        if (len(arg) == 0):
            return result
        fail("Recursion to deep on %s" % arg)

    if (type(arg) == "Target"):
        if (len(arg[DotnetLibrary].transitive.to_list()) > 0):
            fail("Recursion to deep on %s" % arg[DotnetLibrary])
        result += [(arg, arg[DotnetLibrary].version)]

        return result

    fail("Unknown argument %s" % arg)
