"""
Rules for compatability resolution of dependencies for .NET frameworks.
"""

load("@bazel_skylib//lib:sets.bzl", "sets")
load(
    "//dotnet/private:providers.bzl",
    "DotnetAssemblyInfo",
    "DotnetDepVariantInfo",
    "NuGetInfo",
)
load("//dotnet/private:rids.bzl", "RUNTIME_GRAPH")
load("@aspect_bazel_lib//lib:paths.bzl", "to_manifest_path")

def _collect_transitive():
    t = {}
    for (framework, compat) in FRAMEWORK_COMPATIBILITY.items():
        # the transitive closure of compatible frameworks
        t[framework] = sets.union(sets.make([framework]), *[t[c] for c in compat])
    return t

# A dict of target frameworks to the set of other framworks it can compile
# against. This relationship is transitive. The order of this dictionary also
# matters. netstandard should appear first, and keys within a family should
# proceed from oldest to newest
FRAMEWORK_COMPATIBILITY = {
    # .NET Standard
    "netstandard": [],
    "netstandard1.0": ["netstandard"],
    "netstandard1.1": ["netstandard1.0"],
    "netstandard1.2": ["netstandard1.1"],
    "netstandard1.3": ["netstandard1.2"],
    "netstandard1.4": ["netstandard1.3"],
    "netstandard1.5": ["netstandard1.4"],
    "netstandard1.6": ["netstandard1.5"],
    "netstandard2.0": ["netstandard1.6"],
    "netstandard2.1": ["netstandard2.0"],

    # .NET Framework
    "net11": [],
    "net20": ["net11"],
    "net30": ["net20"],
    "net35": ["net30"],
    "net40": ["net35"],
    "net403": ["net40"],
    "net45": ["net403", "netstandard1.1"],
    "net451": ["net45", "netstandard1.2"],
    "net452": ["net451"],
    "net46": ["net452", "netstandard1.3"],
    "net461": ["net46", "netstandard2.0"],
    "net462": ["net461"],
    "net47": ["net462"],
    "net471": ["net47"],
    "net472": ["net471"],
    "net48": ["net472"],

    # .NET Core
    "netcoreapp1.0": ["netstandard1.6"],
    "netcoreapp1.1": ["netcoreapp1.0"],
    "netcoreapp2.0": ["netcoreapp1.1", "netstandard2.0"],
    "netcoreapp2.1": ["netcoreapp2.0"],
    "netcoreapp2.2": ["netcoreapp2.1"],
    "netcoreapp3.0": ["netcoreapp2.2", "netstandard2.1"],
    "netcoreapp3.1": ["netcoreapp3.0"],
    "net5.0": ["netcoreapp3.1"],
    "net6.0": ["net5.0"],
}

_subsystem_version = {
    "netstandard": None,
    "netstandard1.0": None,
    "netstandard1.1": None,
    "netstandard1.2": None,
    "netstandard1.3": None,
    "netstandard1.4": None,
    "netstandard1.5": None,
    "netstandard1.6": None,
    "netstandard2.0": None,
    "netstandard2.1": None,
    "net11": None,
    "net20": None,
    "net30": None,
    "net35": None,
    "net40": None,
    "net403": None,
    "net45": "6.00",
    "net451": "6.00",
    "net452": "6.00",
    "net46": "6.00",
    "net461": "6.00",
    "net462": "6.00",
    "net47": "6.00",
    "net471": "6.00",
    "net472": "6.00",
    "net48": "6.00",
    "netcoreapp1.0": None,
    "netcoreapp1.1": None,
    "netcoreapp2.0": None,
    "netcoreapp2.1": None,
    "netcoreapp2.2": None,
    "netcoreapp3.0": None,
    "netcoreapp3.1": None,
    "net5.0": None,
    "net6.0": None,
}

_default_lang_version_csharp = {
    "netstandard": "7.3",
    "netstandard1.0": "7.3",
    "netstandard1.1": "7.3",
    "netstandard1.2": "7.3",
    "netstandard1.3": "7.3",
    "netstandard1.4": "7.3",
    "netstandard1.5": "7.3",
    "netstandard1.6": "7.3",
    "netstandard2.0": "7.3",
    "netstandard2.1": "7.3",
    "net11": "7.3",
    "net20": "7.3",
    "net30": "7.3",
    "net35": "7.3",
    "net40": "7.3",
    "net403": "7.3",
    "net45": "7.3",
    "net451": "7.3",
    "net452": "7.3",
    "net46": "7.3",
    "net461": "7.3",
    "net462": "7.3",
    "net47": "7.3",
    "net471": "7.3",
    "net472": "7.3",
    "net48": "7.3",
    "netcoreapp1.0": "7.3",
    "netcoreapp1.1": "7.3",
    "netcoreapp2.0": "7.3",
    "netcoreapp2.1": "7.3",
    "netcoreapp2.2": "7.3",
    "netcoreapp3.0": "8.0",
    "netcoreapp3.1": "8.0",
    "net5.0": "9.0",
    "net6.0": "10.0",
}

_net = FRAMEWORK_COMPATIBILITY.keys().index("net11")
_cor = FRAMEWORK_COMPATIBILITY.keys().index("netcoreapp1.0")
STD_FRAMEWORKS = FRAMEWORK_COMPATIBILITY.keys()[:_net]
NET_FRAMEWORKS = FRAMEWORK_COMPATIBILITY.keys()[_net:_cor]
COR_FRAMEWORKS = FRAMEWORK_COMPATIBILITY.keys()[_cor:]
TRANSITIVE_FRAMEWORK_COMPATIBILITY = _collect_transitive()

def is_debug(ctx):
    return ctx.var["COMPILATION_MODE"] == "dbg"

def use_highentropyva(tfm):
    return tfm not in ["net20", "net40"]

def is_standard_framework(tfm):
    return tfm.startswith("netstandard")

def is_core_framework(tfm):
    # TODO: Make this work with future versions
    return tfm.startswith("netcoreapp") or tfm.startswith("net5.0") or tfm.startswith("net6.0") or tfm.startswith("net7.0") or tfm.startswith("net8.0") or tfm.startswith("net9.0")

def format_ref_arg(args, refs, targeting_pack_overrides):
    """Takes 

    Args:
        args: The args object that will be sent into the compilation action
        refs: List of all references that are being sent into the compilation action
        targeting_pack_overrides: Dict of overrides that are declared by targeting packs
    Returns:
        The updated args object
    """

    def _format_ref_with_overrides(assembly):
        # TODO: Make it a bit more robust
        # We rely on the naming convention of nuget_archive/nuget_repo which isn't too nice
        # We also need to handle the versions here and make sure that if the version of the dep is > version in targeting pack then do not skip
        package_name = None
        if assembly.path.startswith("external/nuget."):
            package_name = assembly.path.lstrip("external/nuget.").split("/")[0].split(".v")[0]
        if package_name and package_name in targeting_pack_overrides:
            return None

        return "/r:" + assembly.path

    args.add_all(refs, allow_closure = True, map_each = _format_ref_with_overrides)

    return args

def collect_transitive_info(name, deps, private_deps, exports, strict_deps):
    """Determine the transitive dependencies by the target framework.

    Args:
        name: The name of the assembly that is asking.
        deps: Dependencies that the compilation target depends on.
        private_deps: Private dependencies that the compilation target depends on.
        exports: Exported targets
        strict_deps: Whether or not to use strict dependencies.

    Returns:
        A collection of the overrides, references, analyzers and runfiles.
    """
    direct_iref = []
    direct_ref = []
    transitive_ref = []
    direct_lib = []
    transitive_lib = []
    direct_native = []
    transitive_native = []
    direct_data = []
    transitive_data = []
    direct_compile_data = []
    transitive_compile_data = []
    direct_analyzers = []
    transitive_analyzers = []
    direct_runtime_deps = transform_deps(deps)
    transitive_runtime_deps = []

    direct_private_ref = []
    transitive_private_ref = []
    direct_private_analyzers = []
    transitive_private_analyzers = []
    direct_labels = [d.label for d in deps]

    exports_files = []

    overrides = {}
    for dep in deps + private_deps:
        if NuGetInfo in dep:
            nuget_info = dep[NuGetInfo]

            for override_name, override_version in nuget_info.targeting_pack_overrides.items():
                # TODO: In case there are multiple overrides of the same package
                # we should take the one with the highest version
                # Need to get a semver comparison function to do that
                overrides[override_name] = override_version

    for dep in deps:
        assembly = dep[DotnetAssemblyInfo]

        # See docs/ReferenceAssemblies.md for more info on why we use (and prefer) refout
        # and the mechanics of irefout vs. prefout.
        direct_iref.extend(assembly.irefs if name in assembly.internals_visible_to else assembly.refs)
        direct_ref.extend(assembly.refs)
        direct_analyzers.extend(assembly.analyzers)
        direct_lib.extend(assembly.libs)
        direct_native.extend(assembly.native)
        direct_data.extend(assembly.data)
        direct_compile_data.extend(assembly.compile_data)

        # We take all the exports of each dependency and add them
        # to the direct refs.
        direct_iref.extend(assembly.exports)

        # Runfiles are always collected transitively
        # We need to make sure that we do not include multiple versions of the same first party dll
        # in the runfiles. We can do that by taking the direct first party deps and see if any of them are already
        # in the runfiles and if they are we remove them from the transitive runfiles.
        if NuGetInfo in dep:
            transitive_lib.append(assembly.transitive_libs)
            transitive_native.append(assembly.transitive_native)
            transitive_data.append(assembly.transitive_data)
            transitive_runtime_deps.append(assembly.transitive_runtime_deps)
        else:
            # TODO: This might be a performance issue. See if we can do this without
            # having to iterate over the transitive files.
            lib = []
            native = []
            data = []
            runtime_deps = []
            for tlib in assembly.transitive_libs.to_list():
                if tlib.owner in direct_labels:
                    continue
                lib.append(tlib)

            for tnative in assembly.transitive_native.to_list():
                if tnative.owner in direct_labels:
                    continue
                native.append(tnative)

            for tdata in assembly.transitive_data.to_list():
                if tdata.owner in direct_labels:
                    continue
                data.append(tdata)

            for truntime_dep in assembly.runtime_deps + assembly.transitive_runtime_deps.to_list():
                if truntime_dep.label in direct_labels:
                    continue
                runtime_deps.append(truntime_dep)

            transitive_runtime_deps.append(depset(runtime_deps))
            transitive_lib.append(depset(lib))
            transitive_native.append(depset(native))
            transitive_data.append(depset(data))

        if not strict_deps:
            transitive_ref.append(assembly.transitive_refs)
            transitive_analyzers.append(assembly.transitive_analyzers)
            transitive_compile_data.append(assembly.transitive_compile_data)

    for dep in private_deps:
        assembly = dep[DotnetAssemblyInfo]

        direct_private_ref.extend(assembly.irefs if name in assembly.internals_visible_to else assembly.refs)
        direct_private_analyzers.extend(assembly.analyzers)
        direct_compile_data.extend(assembly.compile_data)

        if not strict_deps:
            transitive_private_ref.append(assembly.transitive_refs)
            transitive_private_analyzers.append(assembly.transitive_analyzers)
            transitive_compile_data.append(assembly.transitive_compile_data)

    for export in exports:
        assembly = export[DotnetAssemblyInfo]
        exports_files.extend(assembly.refs)

    return (
        depset(direct = direct_iref, transitive = transitive_ref),
        depset(direct = direct_ref, transitive = transitive_ref),
        depset(direct = direct_analyzers, transitive = transitive_analyzers),
        depset(direct = direct_lib, transitive = transitive_lib),
        depset(direct = direct_native, transitive = transitive_native),
        depset(direct = direct_data, transitive = transitive_data),
        depset(direct = direct_compile_data, transitive = transitive_compile_data),
        depset(direct = direct_private_ref, transitive = transitive_private_ref),
        depset(direct = direct_private_analyzers, transitive = transitive_private_analyzers),
        depset(direct = direct_runtime_deps, transitive = transitive_runtime_deps),
        exports_files,
        overrides,
    )

def get_framework_version_info(tfm):
    return (
        _subsystem_version[tfm],
        _default_lang_version_csharp[tfm],
    )

def get_highest_compatible_target_framework(incoming_tfm, tfms):
    """Returns the highest compatible framework version for the incoming_tfm.

    Args:
      incoming_tfm: The target framework of the incoming binary
      tfms: A list of target frameworks
    Returns:
        The highest compatible framework version
    """
    if incoming_tfm in tfms:
        return incoming_tfm

    if FRAMEWORK_COMPATIBILITY[incoming_tfm] == None:
        fail("Target framework moniker is not supported/valid: {}", incoming_tfm)

    incoming_tfm_index = FRAMEWORK_COMPATIBILITY.keys().index(incoming_tfm)
    for tfm in reversed(FRAMEWORK_COMPATIBILITY.keys()[:incoming_tfm_index]):
        if tfm in tfms:
            return tfm

    return None

def get_nuget_relative_path(file):
    """Returns NuGet package relative path of a file that is part of a NuGet package

    Args:
        file: A file that is part of a nuget_archive/nuget_repo.

    Returns:
        The package relateive path of the file
    """

    # The path of the files is of the form external/<packagename>.v<version>/<path within nuget package>
    # So we remove the first two parts of the path to get the path within the nuget package.
    return "/".join(file.path.split("/")[2:])

def transform_deps(deps):
    """Transforms a [Target] into [DotnetDepVariantInfo].

    This helper function is used to transform ctx.attr.deps into
    [DotnetDepVariantInfo].
    Args:
        deps (list of Targets): Dependencies coming from ctx.attr.deps
    Returns:
        list of DotnetDepVariantInfos.
    """
    return [DotnetDepVariantInfo(
        label = dep.label,
        assembly_info = dep[DotnetAssemblyInfo] if DotnetAssemblyInfo in dep else None,
        nuget_info = dep[NuGetInfo] if NuGetInfo in dep else None,
    ) for dep in deps]

def generate_warning_args(
        args,
        treat_warnings_as_errors,
        warnings_as_errors,
        warnings_not_as_errors,
        warning_level):
    """Generates the compiler arguments for warnings and errors

    Args:
        args: The args object that will be passed to the compilation action
        treat_warnings_as_errors: If all warnigns should be treated as errors
        warnings_as_errors: List of warnings that should be treated as errors
        warnings_not_as_errors: List of warnings that should not be treated as errors
        warning_level: The warning level to use
    """
    if treat_warnings_as_errors:
        if len(warnings_as_errors) > 0:
            fail("Cannot use both treat_warnings_as_errors and warnings_as_errors")

        for warning in warnings_not_as_errors:
            args.add("/warnaserror-:{}".format(warning))

        args.add("/warnaserror+")
    else:
        if len(warnings_not_as_errors) > 0:
            fail("Cannot use warnings_not_as_errors if treat_warnings_as_errors is not set")
        for warning in warnings_as_errors:
            args.add("/warnaserror+:{}".format(warning))

    args.add("/warn:{}".format(warning_level))

def framework_preprocessor_symbols(tfm):
    """Gets the standard preprocessor symbols for the target framework.

    See https://docs.microsoft.com/en-us/dotnet/csharp/language-reference/preprocessor-directives/preprocessor-if#remarks
    for the official list.

    Args:
        tfm: The target framework moniker target being built.
    Returns:
        A list of preprocessor symbols.
    """
    # TODO: All built in preprocessor directives: https://docs.microsoft.com/en-us/dotnet/csharp/language-reference/preprocessor-directives

    specific = tfm.upper().replace(".", "_")

    if tfm.startswith("netstandard"):
        return ["NETSTANDARD", specific]
    elif tfm.startswith("netcoreapp"):
        return ["NETCOREAPP", specific]
    else:
        return ["NETFRAMEWORK", specific]

# For deps.json spec see: https://github.com/dotnet/sdk/blob/main/documentation/specs/runtime-configuration-file.md
def generate_depsjson(
        ctx,
        target_framework,
        is_self_contained,
        runtime_deps,
        transitive_runtime_deps,
        runtime_identifier,
        runtime_pack_infos = [],
        use_relative_paths = False):
    """Generates a deps.json file.

    Args:
        ctx: The ctx object
        target_framework: The target framework moniker for the target being built.
        is_self_contained: If the target is a self-contained publish.
        runtime_deps: The runtime dependencies of the target.
        transitive_runtime_deps: The transitive runtime dependencies of the target.
        runtime_identifier: The runtime identifier of the target.
        runtime_pack_infos: The DotnetAssemblyInfo of the runtime packs that are used for a self contained publish.
        use_relative_paths: If the paths to the dependencies should be relative to the workspace root.
    Returns:
        The deps.json file as a struct.
    """
    runtime_target = ".NETCoreApp,Version=v{}".format(
        "{}/{}".format(
            target_framework.replace("net", ""),
            runtime_identifier,
        ),
    )
    base = {
        "runtimeTarget": {
            "name": runtime_target,
            "signature": "",
        },
        "compilationOptions": {},
        "targets": {
        },
    }
    base["targets"][runtime_target] = {}
    base["libraries"] = {}

    for runtime_pack_info in runtime_pack_infos:
        runtime_pack_name = "runtimepack.{}/{}".format(runtime_pack_info.name, runtime_pack_info.version)
        base["libraries"][runtime_pack_name] = {
            "type": "runtimepack",
            "serviceable": False,
            "sha512": "",
        }
        base["targets"][runtime_target][runtime_pack_name] = {
            "runtime": {dll.basename: {} for dll in runtime_pack_info.libs + runtime_pack_info.transitive_libs.to_list()},
            "native": {native_file.basename: {} for native_file in runtime_pack_info.native + runtime_pack_info.transitive_native.to_list()},
        }

    if is_self_contained:
        base["runtimes"] = {rid: RUNTIME_GRAPH[rid] for rid, supported_rids in RUNTIME_GRAPH.items() if runtime_identifier in supported_rids or runtime_identifier == rid}

    for runtime_dep in runtime_deps + transitive_runtime_deps.to_list():
        library_name = "{}/{}".format(runtime_dep.assembly_info.name, runtime_dep.assembly_info.version)
        library_fragment = {
            "type": "project",
            "serviceable": False,
            "sha512": "",
        }
        if use_relative_paths:
            library_fragment["path"] = "./"

        if runtime_dep.nuget_info and not use_relative_paths:
            library_fragment["type"] = "package"
            library_fragment["serviceable"] = True
            library_fragment["sha512"] = runtime_dep.nuget_info.sha512
            library_fragment["path"] = library_name.lower()
            library_fragment["hashPath"] = "{}.{}.nupkg.sha512".format(runtime_dep.assembly_info.name.lower(), runtime_dep.assembly_info.version)

        target_fragment = {
            "runtime": {dll.basename if not use_relative_paths else to_manifest_path(ctx, dll): {} for dll in runtime_dep.assembly_info.libs},
            "native": {native_file.basename if not use_relative_paths else to_manifest_path(ctx, native_file): {} for native_file in runtime_dep.assembly_info.native},
            "dependencies": {dep.assembly_info.name: dep.assembly_info.version for dep in runtime_dep.assembly_info.runtime_deps},
        }

        base["libraries"][library_name] = library_fragment
        base["targets"][runtime_target][library_name] = target_fragment

    return base

# For runtimeconfig.json spec see https://github.com/dotnet/sdk/blob/main/documentation/specs/runtime-configuration-file.md
def generate_runtimeconfig(target_framework, is_self_contained, toolchain):
    """Generates a runtimeconfig.json file.

    Args:
        target_framework: The target framework moniker for the target being built.
        is_self_contained: If the target is a self-contained publish.
        toolchain: The currently configured dotnet toolchain.
    Returns:
        The runtimeconfig.json file as a struct.
    """
    runtime_version = toolchain.dotnetinfo.runtime_version
    base = {
        "runtimeOptions": {
            "tfm": target_framework,
        },
    }

    if is_self_contained:
        base["runtimeOptions"]["includedFrameworks"] = [{
            "name": "Microsoft.NETCore.App",
            "version": runtime_version,
        }]
    else:
        base["runtimeOptions"]["framework"] = {
            "name": "Microsoft.NETCore.App",
            "version": runtime_version,
        }

    return base
