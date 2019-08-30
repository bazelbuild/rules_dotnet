load(
    "@io_bazel_rules_dotnet//dotnet/private:providers.bzl",
    "DotnetLibrary",
)

# Expects List of depset(Target). Each Target needs to provide DotnetLibrary provider.
# Recalculates transitive dependencies. The result does not include input targets.
def ResolveVersionsRaw(targets):
    matched = {}
    for d in targets:
        for f in d.to_list():
            ts = f[DotnetLibrary].transitive.to_list()
            for t in ts:
                dl = t[DotnetLibrary]
                key = dl.result.basename
                found = matched.get(key)
                if not found:
                    matched[key] = t

    values = matched.values()
    values_depset = None if len(values) == 0 else [depset(direct = values)]
    transitive = depset(direct = [], transitive = values_depset)
    transitive_runfiles = depset(direct = [], transitive = [a[DotnetLibrary].runfiles for a in values])
    return transitive, transitive_runfiles

# Expects List of Traget. Each Target needs to provide DotnetLibrary provider.
# Includes in the result both deps and its unique transitive dependencies
def ResolveVersions(deps):
    targets = [t[DotnetLibrary].transitive for t in deps]

    transitive, transitive_runfiles = ResolveVersionsRaw(targets)
    transitive = depset(direct = deps, transitive = [transitive])
    return transitive, transitive_runfiles
