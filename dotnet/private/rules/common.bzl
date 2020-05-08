load(
    "@io_bazel_rules_dotnet//dotnet/private:providers.bzl",
    "DotnetLibrary",
)

def collect_transitive_info(deps, data = None):
    """Collects transitive information.

    Args:
      deps: Dependencies that the DotnetLibrary depends on.
      data: Data dependencies

    Returns:
      A depsets of the references, runfiles and deps. References and deps also include direct dependencies provided by deps.
      However, runtfiles do not include direct runfiles.
    """

    direct_refs = []
    direct_deps = []
    transitive_refs = []
    transitive_runfiles = []
    direct_runfiles = []
    transitive_deps = []

    for dep in deps:
        assembly = dep[DotnetLibrary]

        if assembly.ref:
            direct_refs += assembly.ref.files.to_list()
        elif assembly.result:
            direct_refs.append(assembly.result)

        if assembly.transitive_refs:
            transitive_refs.append(assembly.transitive_refs)

        transitive_runfiles.append(assembly.runfiles)

        direct_deps.append(assembly)
        if assembly.transitive:
            transitive_deps.append(assembly.transitive)

    if data:
        for i in data:
            transitive_runfiles.append(i.files)

    return (
        depset(direct = direct_refs, transitive = transitive_refs),
        depset(direct = direct_runfiles, transitive = transitive_runfiles),
        depset(direct = direct_deps, transitive = transitive_deps),
    )
