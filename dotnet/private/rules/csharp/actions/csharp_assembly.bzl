"""
Actions for compiling targets with C#.
"""

load(
    "//dotnet/private:common.bzl",
    "collect_transitive_info",
    "format_ref_arg",
    "framework_preprocessor_symbols",
    "generate_warning_args",
    "get_framework_version_info",
    "transform_deps",
    "use_highentropyva",
)
load(
    "//dotnet/private:providers.bzl",
    "DotnetAssemblyInfo",
)

def _write_internals_visible_to_csharp(actions, name, others):
    """Write a .cs file containing InternalsVisibleTo attributes.

    Letting Bazel see which assemblies we are going to have InternalsVisibleTo
    allows for more robust caching of compiles.

    Args:
      actions: An actions module, usually from ctx.actions.
      name: The assembly name.
      others: The names of other assemblies.

    Returns:
      A File object for a generated .cs file
    """

    if len(others) == 0:
        return None

    attrs = actions.args()
    attrs.set_param_file_format(format = "multiline")

    attrs.add_all(
        others,
        format_each = "[assembly: System.Runtime.CompilerServices.InternalsVisibleTo(\"%s\")]",
    )

    output = actions.declare_file("bazelout/%s/internalsvisibleto.cs" % name)

    actions.write(output, attrs)

    return output

# buildifier: disable=unnamed-macro
def AssemblyAction(
        actions,
        additionalfiles,
        debug,
        defines,
        deps,
        exports,
        private_deps,
        internals_visible_to,
        keyfile,
        langversion,
        resources,
        srcs,
        data,
        out,
        target,
        target_name,
        target_framework,
        toolchain,
        strict_deps,
        include_host_model_dll,
        treat_warnings_as_errors,
        warnings_as_errors,
        warnings_not_as_errors,
        warning_level):
    """Creates an action that runs the CSharp compiler with the specified inputs.

    This macro aims to match the [C# compiler](https://docs.microsoft.com/en-us/dotnet/csharp/language-reference/compiler-options/listed-alphabetically), with the inputs mapping to compiler options.

    Args:
        actions: Bazel module providing functions to create actions.
        additionalfiles: Names additional files that don't directly affect code generation but may be used by analyzers for producing errors or warnings.
        debug: Emits debugging information.
        defines: The list of conditional compilation symbols.
        deps: The list of other libraries to be linked in to the assembly.
        exports: List of exported targets.
        private_deps: The list of libraries that are private to the target. These deps are not passed transitively.
        internals_visible_to: An optional list of assemblies that can see this assemblies internal symbols.
        keyfile: Specifies a strong name key file of the assembly.
        langversion: Specify language version: Default, ISO-1, ISO-2, 3, 4, 5, 6, 7, 7.1, 7.2, 7.3, or Latest
        resources: The list of resouces to be embedded in the assembly.
        srcs: The list of source (.cs) files that are processed to create the assembly.
        data: List of files that are a direct runtime dependency
        target_name: A unique name for this target.
        out: Specifies the output file name.
        target: Specifies the format of the output file by using one of four options.
        target_framework: The target framework moniker for the assembly.
        toolchain: The toolchain that supply the C# compiler.
        strict_deps: Whether or not to use strict dependencies.
        include_host_model_dll: Whether or not to include he Microsoft.NET.HostModel dll. ONLY USED FOR COMPILING THE APPHOST SHIMMER.
        treat_warnings_as_errors: Whether or not to treat warnings as errors.
        warnings_as_errors: List of warnings to treat as errors.
        warnings_not_as_errors: List of warnings to not treat errors.
        warning_level: The warning level to use.
    Returns:
        The compiled csharp artifacts.
    """

    assembly_name = target_name if out == "" else out
    (subsystem_version, default_lang_version) = get_framework_version_info(target_framework)
    (
        irefs,
        prefs,
        analyzers,
        transitive_libs,
        transitive_native,
        transitive_data,
        private_refs,
        private_analyzers,
        transitive_runtime_deps,
        exports_files,
        overrides,
    ) = collect_transitive_info(
        target_name,
        deps,
        private_deps,
        exports,
        strict_deps,
    )

    # This is only required to compile the apphost shimmer
    # The reason for it not being a normal dependency in the
    # apphost shimmer target is that the DLL is part of the downloaded runtime
    # TODO: Maybe it's possible to make this a normal dependency?
    if include_host_model_dll:
        irefs = depset(direct = [toolchain.host_model], transitive = [irefs])
        transitive_libs = depset(direct = [toolchain.host_model], transitive = [transitive_libs])

    defines = framework_preprocessor_symbols(target_framework) + defines

    out_dir = "bazelout/" + target_framework
    out_ext = "dll"

    out_dll = actions.declare_file("%s/%s.%s" % (out_dir, assembly_name, out_ext))
    out_iref = None
    out_ref = actions.declare_file("%s/ref/%s.%s" % (out_dir, assembly_name, out_ext))
    out_pdb = actions.declare_file("%s/%s.pdb" % (out_dir, assembly_name))

    if len(internals_visible_to) == 0:
        _compile(
            actions,
            additionalfiles,
            analyzers,
            private_analyzers,
            debug,
            default_lang_version,
            defines,
            keyfile,
            langversion,
            irefs,
            private_refs,
            overrides,
            resources,
            srcs,
            subsystem_version,
            target,
            target_name,
            target_framework,
            toolchain,
            treat_warnings_as_errors,
            warnings_as_errors,
            warnings_not_as_errors,
            warning_level,
            out_dll = out_dll,
            out_ref = out_ref,
            out_pdb = out_pdb,
        )
    else:
        # If the user is using internals_visible_to generate an additional
        # reference-only DLL that contains the internals. We want the
        # InternalsVisibleTo in the main DLL too to be less suprising to users.
        out_iref = actions.declare_file("%s/iref/%s.%s" % (out_dir, assembly_name, out_ext))

        internals_visible_to_cs = _write_internals_visible_to_csharp(
            actions,
            name = target_name,
            others = internals_visible_to,
        )

        _compile(
            actions,
            additionalfiles,
            analyzers,
            private_analyzers,
            debug,
            default_lang_version,
            defines,
            keyfile,
            langversion,
            irefs,
            private_refs,
            overrides,
            resources,
            srcs + [internals_visible_to_cs],
            subsystem_version,
            target,
            target_name,
            target_framework,
            toolchain,
            treat_warnings_as_errors,
            warnings_as_errors,
            warnings_not_as_errors,
            warning_level,
            out_ref = out_iref,
            out_dll = out_dll,
            out_pdb = out_pdb,
        )

        # Generate a ref-only DLL without internals
        _compile(
            actions,
            additionalfiles,
            analyzers,
            private_analyzers,
            debug,
            default_lang_version,
            defines,
            keyfile,
            langversion,
            irefs,
            private_refs,
            overrides,
            resources,
            srcs,
            subsystem_version,
            target,
            target_name,
            target_framework,
            toolchain,
            treat_warnings_as_errors,
            warnings_as_errors,
            warnings_not_as_errors,
            warning_level,
            out_dll = None,
            out_ref = out_ref,
            out_pdb = None,
        )
    direct_data = []
    direct_data.extend(data)

    return DotnetAssemblyInfo(
        name = target_name,
        version = "1.0.0",  #TODO: Maybe make this configurable?
        libs = [out_dll],
        pdbs = [out_pdb] if out_pdb else [],
        refs = [out_ref],
        irefs = [out_iref] if out_iref else [out_ref],
        analyzers = [],
        internals_visible_to = internals_visible_to or [],
        data = data,
        native = [],
        exports = exports_files,
        transitive_refs = prefs,
        transitive_analyzers = analyzers,
        transitive_libs = transitive_libs,
        transitive_native = transitive_native,
        transitive_data = transitive_data,
        runtime_deps = transform_deps(deps),
        transitive_runtime_deps = transitive_runtime_deps,
    )

def _compile(
        actions,
        additionalfiles,
        analyzer_assemblies,
        private_analyzer_assemblies,
        debug,
        default_lang_version,
        defines,
        keyfile,
        langversion,
        refs,
        private_refs,
        overrides,
        resources,
        srcs,
        subsystem_version,
        target,
        target_name,
        target_framework,
        toolchain,
        treat_warnings_as_errors,
        warnings_as_errors,
        warnings_not_as_errors,
        warning_level,
        out_dll = None,
        out_ref = None,
        out_pdb = None):
    # Our goal is to match msbuild as much as reasonable
    # https://docs.microsoft.com/en-us/dotnet/csharp/language-reference/compiler-options/listed-alphabetically
    args = actions.args()
    args.add("/unsafe-")
    args.add("/checked-")
    args.add("/nostdlib+")  # mscorlib will get added due to our transitive deps
    args.add("/utf8output")
    args.add("/deterministic+")
    args.add("/filealign:512")

    args.add("/nologo")

    if use_highentropyva(target_framework):
        args.add("/highentropyva+")
    else:
        args.add("/highentropyva-")

    if subsystem_version != None:
        args.add("/subsystemversion:" + subsystem_version)

    generate_warning_args(
        args,
        treat_warnings_as_errors,
        warnings_as_errors,
        warnings_not_as_errors,
        warning_level,
    )

    args.add("/target:" + target)
    args.add("/langversion:" + (langversion or default_lang_version))

    if debug:
        args.add("/debug+")
        args.add("/optimize-")
        args.add("/define:TRACE;DEBUG")
    else:
        args.add("/debug-")
        args.add("/optimize+")
        args.add("/define:TRACE;RELEASE")

    args.add("/debug:portable")

    # outputs
    if out_dll != None:
        args.add("/out:" + out_dll.path)
        args.add("/refout:" + out_ref.path)
        args.add("/pdb:" + out_pdb.path)
        outputs = [out_dll, out_ref, out_pdb]
    else:
        args.add("/refonly")
        args.add("/out:" + out_ref.path)
        outputs = [out_ref]

    # assembly references
    format_ref_arg(args, depset(transitive = [private_refs, refs]), overrides)

    # analyzers
    args.add_all(analyzer_assemblies, format_each = "/analyzer:%s")
    args.add_all(private_analyzer_assemblies, format_each = "/analyzer:%s")
    args.add_all(additionalfiles, format_each = "/additionalfile:%s")

    # .cs files
    args.add_all(srcs)

    # resources
    args.add_all(resources, format_each = "/resource:%s")

    # defines
    args.add_all(defines, format_each = "/d:%s")

    # keyfile
    if keyfile != None:
        args.add("/keyfile:" + keyfile.path)

    # TODO:
    # - appconfig(?)
    # - define
    #   * Need to audit D2L defines
    #   * msbuild adds some by default depending on your TF; we should too
    # - doc (d2l can probably skip this?)
    # - main (probably not a high priority for d2l)
    # - pathmap (needed for deterministic pdbs across hosts): this will
    #   probably need to be done in a wrapper because of the difference between
    #   the analysis phase (when this code runs) and execution phase.
    # - various code signing args (not needed for d2l)
    # - COM-related args like /link
    # - allow warnings to be configured
    # - unsafe (not needed for d2l)
    # - win32 args like /win32icon

    # spill to a "response file" when the argument list gets too big (Bazel
    # makes that call based on limitations of the OS).
    args.set_param_file_format("multiline")

    args.use_param_file("@%s", use_always = True)

    direct_inputs = srcs + resources + additionalfiles + [toolchain.csharp_compiler]
    direct_inputs += [keyfile] if keyfile else []

    # dotnet.exe csc.dll /noconfig <other csc args>
    # https://docs.microsoft.com/en-us/dotnet/csharp/language-reference/compiler-options/command-line-building-with-csc-exe
    actions.run(
        mnemonic = "CSharpCompile",
        progress_message = "Compiling " + target_name + (" (internals ref-only dll)" if out_dll == None else ""),
        inputs = depset(
            direct = direct_inputs,
            transitive = [private_refs, refs, analyzer_assemblies, private_analyzer_assemblies],
        ),
        outputs = outputs,
        executable = toolchain.runtime.files_to_run,
        arguments = [
            toolchain.csharp_compiler.path,

            # This can't go in the response file (if it does it won't be seen
            # until it's too late).
            "/noconfig",
            args,
        ],
        env = {
            "DOTNET_CLI_HOME": toolchain.runtime.files_to_run.executable.dirname,
            # Set so that compilations work on remote execution workers that don't have ICU installed
            # ICU should not be required during compliation but only at runtime
            "DOTNET_SYSTEM_GLOBALIZATION_INVARIANT": "1",
        },
    )
