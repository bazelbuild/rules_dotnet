"""
Rules for compatability resolution of dependencies for .NET frameworks.
"""

load(
    "//dotnet/private:providers.bzl",
    "DotnetAssemblyInfo",
    "FRAMEWORK_COMPATIBILITY",
)

def is_debug(ctx):
    return ctx.var["COMPILATION_MODE"] == "dbg"

def use_highentropyva(tfm):
    return tfm not in ["net20", "net40"]

def is_standard_framework(tfm):
    return tfm.startswith("netstandard")

def is_core_framework(tfm):
    return tfm.startswith("netcoreapp") or tfm.startswith("net5.0") or tfm.startswith("net6.0")

def format_ref_arg(args, tfm, refs, project_sdk_refs):
    """Takes all deps and the project SDK and deduplicates all DLLs that are part of the project SDK.

    Args:
        args: The args object that will be sent into the compilation action
        tfm: The TFM that is being targeted
        refs: List of all references that are being sent into the compilation action excluding the project SDK
        project_sdk_refs: The references that are in the project SDK

    Returns:
        The updated args object
    """
    project_sdk_dll_map = { dll.basename: dll.path for dll in project_sdk_refs.to_list()}
    def _format_ref_arg(assembly):
        return "/r:" + assembly.path

    def _format_ref_arg_remove_duplicates(assembly):
        if assembly.basename in project_sdk_dll_map:
            return None

        return "/r:" + assembly.path
    
    args.add_all(project_sdk_refs, allow_closure= True, map_each = _format_ref_arg)
    args.add_all(refs, allow_closure= True, map_each = _format_ref_arg_remove_duplicates)

    return args

def format_analyzer_arg(analyzer):
    return "/analyzer:" + analyzer

def format_additionalfile_arg(additionalfile):
    return "/additionalfile:" + additionalfile.path

def format_resource_arg(resource):
    return "/resource:" + resource.path

def format_define(symbol):
    return "/d:" + symbol

def collect_transitive_info(name, deps, tfm):
    """Determine the transitive dependencies by the target framework.

    Args:
        name: The name of the assembly that is asking.
        deps: Dependencies that the compilation target depends on.
        tfm: The target framework moniker.

    Returns:
        A collection of the references, runfiles and native dlls.
    """
    direct_refs = []
    transitive_refs = []
    direct_runfiles = []
    transitive_runfiles = []
    native_dlls = []

    provider = DotnetAssemblyInfo[tfm]

    for dep in deps:
        if provider not in dep:
            fail("The dependency %s is not compatible with %s!" % (str(dep.label), tfm))

        assembly = dep[provider]

        # See docs/ReferenceAssemblies.md for more info on why we use (and prefer) refout
        # and the mechanics of irefout vs. prefout.
        if name not in assembly.internals_visible_to and assembly.prefout:
            # Best compile caching (prefout changes less frequently than irefout or out)
            direct_refs.extend(assembly.prefout)
        elif assembly.irefout:
            # Ok compile caching (irefout changes less frequently than out)
            direct_refs.extend(assembly.irefout)
        elif assembly.out:
            # No compile caching when the dependencies change
            direct_refs.extend(assembly.out)

        transitive_refs.append(assembly.transitive_refs)

        if assembly.out:
            direct_runfiles.extend(assembly.out)
        if assembly.pdb:
            direct_runfiles.extend(assembly.pdb)

        transitive_runfiles.append(assembly.transitive_runfiles)
        native_dlls.append(assembly.native_dlls)

    return (
        depset(direct = direct_refs, transitive = transitive_refs),
        depset(direct = direct_runfiles, transitive = transitive_runfiles),
        depset(transitive = native_dlls),
    )      

def _get_provided_by_netstandard(providerInfo):
    actual_tfm = providerInfo[0].actual_tfm
    tfm = providerInfo[1]

    return is_standard_framework(actual_tfm) and not is_standard_framework(tfm)

def fill_in_missing_frameworks(name, providers):
    """Creates extra providers for frameworks that are compatible with us.

    Since we may not have built this DLL for all possible frameworks that we're
    compatible with (e.g. we might have a net20 and net45 build, but no net40
    one) we "fill in the gaps" for our dependees.
    See docs/MultiTargetingDesign.md for more info.

    Args:
      name: The name of the assembly.
      providers: a dict from TFM to a provider.
    """

    # iterate through the compatability table since it's in preference order
    for tfm in FRAMEWORK_COMPATIBILITY.keys():
        if tfm in providers:
            continue

        # There are at most 2 elements in FRAMEWORK_COMPATIBILITY[tfm], so this
        # nested loop isn't bad.
        # Order by providers that didn't "cross the netstandard boundary" so
        # newer netstandard will be preferred, if applicable
        for (base, _compatible_tfm) in sorted([(providers[compatible_tfm], compatible_tfm) for compatible_tfm in FRAMEWORK_COMPATIBILITY[tfm] if compatible_tfm in providers], key = _get_provided_by_netstandard):
            # Copy the output from the compatible tfm, re-resolving the deps
            (refs, runfiles, native_dlls) = collect_transitive_info(name, base.deps, tfm)
            providers[tfm] = DotnetAssemblyInfo[tfm](
                out = base.out,
                prefout = base.prefout,
                irefout = base.irefout,
                internals_visible_to = base.internals_visible_to,
                pdb = base.pdb,
                native_dlls = native_dlls,
                deps = base.deps,
                transitive_refs = refs,
                transitive_runfiles = runfiles,
                actual_tfm = base.actual_tfm,
            )
            break

def get_analyzer_dll(analyzer_target):
    return analyzer_target[DotnetAssemblyInfo["netstandard"]]
