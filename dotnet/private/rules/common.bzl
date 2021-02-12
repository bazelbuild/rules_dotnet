"Helper functions for handling transitive info"

load("@io_bazel_rules_dotnet//dotnet/private:providers.bzl", "DotnetLibraryInfo")
load("@io_bazel_rules_dotnet//dotnet/private:rules/versions.bzl", "compare_versions")
load("@io_bazel_rules_dotnet//dotnet/private:rules/runfiles.bzl", "CopyDataWithDirs", "CopyRunfiles")

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

def wrap_binary(executable, dotnet, extra = None):
    """Wraps provided executable with appropriate runfiles and providers.

    Args:
      executable: [DotnetLibraryInfo](api.md#DotnetLibraryInfo) to provide launcher for.
      dotnet: [DotnetContextInfo(api.md#DotnetContextInfo)] for current rule.
      extra: depset of additional runfiles to add

    Returns:
      list of providers to be returned by the binary rule.
    """

    name = dotnet._ctx.label.name
    subdir = name + "/"

    launcher = dotnet.actions.declare_file(subdir + executable.result.basename + "_0.exe")
    dotnet._ctx.actions.run(
        outputs = [launcher],
        inputs = dotnet._ctx.attr._launcher.files.to_list(),
        executable = dotnet._ctx.attr._copy.files.to_list()[0],
        arguments = [launcher.path, dotnet._ctx.attr._launcher.files.to_list()[0].path],
        mnemonic = "CopyLauncher",
    )

    # Calculate final runfiles including runtime-required files
    run_transitive = collect_transitive_info(dotnet._ctx.attr.deps + [dotnet.toolchain.sdk_runtime] + (extra.deps if extra != None else []))

    direct_runfiles = []
    direct_runfiles += dotnet.toolchain.sdk_target_runner.files.to_list()
    if extra != None:
        direct_runfiles += extra.runfiles.to_list()

    #runfiles = ctx.runfiles(files = runner + ctx.attr.native_dep.files.to_list(), transitive_files = depset(transitive = [t.runfiles for t in executable.transitive]))
    runfiles = dotnet._ctx.runfiles(files = direct_runfiles, transitive_files = depset(transitive = [t.runfiles for t in run_transitive] + [executable.runfiles]))
    runfiles = CopyRunfiles(dotnet._ctx, runfiles, dotnet._ctx.attr._copy, dotnet._ctx.attr._symlink, executable, subdir)

    if dotnet._ctx.attr.data_with_dirs:
        runfiles = runfiles.merge(CopyDataWithDirs(dotnet, dotnet._ctx.attr.data_with_dirs, dotnet._ctx.attr._copy, subdir))

    return [
        executable,
        DefaultInfo(
            files = depset([executable.result, launcher]),
            runfiles = runfiles,
            executable = launcher,
        ),
    ]
