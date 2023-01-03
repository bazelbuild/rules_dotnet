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
    "is_core_framework",
    "is_standard_framework",
    "transform_deps",
    "use_highentropyva",
)
load(
    "//dotnet/private:providers.bzl",
    "DotnetAssemblyInfo",
)

def _format_targetprofile(tfm):
    if is_standard_framework(tfm):
        return "/targetprofile:netstandard"

    if is_core_framework(tfm):
        return "/targetprofile:netcore"

    return "/targetprofile:mscorlib"

def _write_internals_visible_to_fsharp(actions, name, others):
    """Write a .fs file containing InternalsVisibleTo attributes.

    Letting Bazel see which assemblies we are going to have InternalsVisibleTo
    allows for more robust caching of compiles.

    Args:
      actions: An actions module, usually from ctx.actions.
      name: The assembly name.
      others: The names of other assemblies.

    Returns:
      A File object for a generated .fs file
    """

    if len(others) == 0:
        return None

    content = """
module AssemblyInfo

"""
    for other in others:
        content += """
[<assembly: System.Runtime.CompilerServices.InternalsVisibleTo(\"%s\")>]
do()

""" % other

    output = actions.declare_file("bazelout/%s/internalsvisibleto.fs" % name)
    actions.write(output, content)

    return output

# buildifier: disable=unnamed-macro
def AssemblyAction(
        actions,
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
        compile_data,
        out,
        target,
        target_name,
        target_framework,
        toolchain,
        strict_deps,
        treat_warnings_as_errors,
        warnings_as_errors,
        warnings_not_as_errors,
        warning_level,
        project_sdk):
    """Creates an action that runs the F# compiler with the specified inputs.

    This macro aims to match the [F# compiler](https://docs.microsoft.com/en-us/dotnet/fsharp/language-reference/compiler-options), with the inputs mapping to compiler options.

    Args:
        actions: Bazel module providing functions to create actions.
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
        compile_data: List of files that are a direct compile time dependency
        target_name: A unique name for this target.
        out: Specifies the output file name.
        target: Specifies the format of the output file by using one of four options.
        target_framework: The target framework moniker for the assembly.
        toolchain: The toolchain that supply the F# compiler.
        strict_deps: Whether or not to use strict dependencies.
        treat_warnings_as_errors: Whether or not to treat warnings as errors.
        warnings_as_errors: List of warnings to treat as errors.
        warnings_not_as_errors: List of warnings to not treat errors.
        warning_level: The warning level to use.
        project_sdk: The project SDK being targeted

    Returns:
        The compiled fsharp artifacts.
    """

    assembly_name = target_name if out == "" else out
    (subsystem_version, _default_lang_version) = get_framework_version_info(target_framework)
    (
        irefs,
        prefs,
        analyzers,
        transitive_libs,
        transitive_native,
        transitive_data,
        transitive_compile_data,
        private_refs,
        _private_analyzers,
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
    defines = framework_preprocessor_symbols(target_framework) + defines

    out_dir = "bazelout/" + target_framework
    out_ext = "dll"

    out_dll = actions.declare_file("%s/%s.%s" % (out_dir, assembly_name, out_ext))

    # TODO: Reintroduce once the F# compiler supports reference assemblies
    # out_iref = None
    # out_ref = actions.declare_file("%s/ref/%s.%s" % (out_dir, assembly_name, out_ext))
    out_pdb = actions.declare_file("%s/%s.pdb" % (out_dir, assembly_name))
    if len(internals_visible_to) == 0:
        _compile(
            actions,
            debug,
            defines,
            keyfile,
            langversion,
            irefs,
            private_refs,
            overrides,
            resources,
            srcs,
            depset(compile_data, transitive = [transitive_compile_data]),
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
            out_pdb = out_pdb,
        )
    else:
        internals_visible_to_cs = _write_internals_visible_to_fsharp(
            actions,
            name = target_name,
            others = internals_visible_to,
        )

        _compile(
            actions,
            debug,
            defines,
            keyfile,
            langversion,
            irefs,
            private_refs,
            overrides,
            resources,
            srcs + [internals_visible_to_cs],
            depset(compile_data, transitive = [transitive_compile_data]),
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
            out_pdb = out_pdb,
        )

    return DotnetAssemblyInfo(
        name = target_name,
        version = "1.0.0",  #TODO: Maybe make this configurable?
        project_sdk = project_sdk,
        libs = [out_dll],
        pdbs = [out_pdb] if out_pdb else [],
        refs = [out_dll],
        irefs = [out_dll],
        analyzers = [],
        internals_visible_to = internals_visible_to or [],
        data = data,
        compile_data = compile_data,
        native = [],
        exports = exports_files,
        transitive_refs = prefs,
        transitive_analyzers = analyzers,
        transitive_libs = transitive_libs,
        transitive_native = transitive_native,
        transitive_data = transitive_data,
        transitive_compile_data = transitive_compile_data,
        runtime_deps = transform_deps(deps),
        transitive_runtime_deps = transitive_runtime_deps,
    )

def _compile(
        actions,
        debug,
        defines,
        keyfile,
        langversion,
        refs,
        private_refs,
        overrides,
        resources,
        srcs,
        compile_data,
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
        # TODO: Reintroduce once the F# compiler supports reference assemblies
        # out_ref = None,
        out_pdb = None):
    # Our goal is to match msbuild as much as reasonable
    # https://docs.microsoft.com/en-us/dotnet/fsharp/language-reference/compiler-options
    args = actions.args()
    args.add("/noframework")
    args.add("/utf8output")
    args.add("/deterministic+")
    args.add("/nowin32manifest")
    args.add("/nocopyfsharpcore")
    args.add("/simpleresolution")
    args.add(_format_targetprofile(target_framework))
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
    if langversion:
        args.add("/langversion:" + langversion)

    if debug:
        args.add("/debug+")
        args.add("/optimize-")
        args.add("/define:TRACE;DEBUG")
        args.add("/tailcalls-")
    else:
        args.add("/debug-")
        args.add("/optimize+")
        args.add("/define:TRACE;RELEASE")

    args.add("/debug:portable")

    # outputs
    if out_dll != None:
        args.add("/out:" + out_dll.path)

        # TODO: Reintroduce once the F# compiler supports reference assemblies
        # args.add("/refout:" + out_ref.path)
        args.add("/pdb:" + out_pdb.path)
        outputs = [out_dll, out_pdb]
        # outputs = [out_dll, out_ref, out_pdb]

    else:
        fail("F# compiler does not support reference assemblies")
        # TODO: Reintroduce once the F# compiler supports reference assemblies
        # args.add("/refonly")
        # args.add("/out:" + out_ref.path)
        # outputs = [out_ref]

    # assembly references
    format_ref_arg(args, depset(transitive = [private_refs, refs]), overrides)

    # .fs files
    args.add_all(srcs)

    # resources
    args.add_all(resources, format_each = "/resource:%s")

    # defines
    args.add_all(defines, format_each = "/d:%s")

    # keyfile
    if keyfile != None:
        args.add("/keyfile:" + keyfile.path)

    # spill to a "response file" when the argument list gets too big (Bazel
    # makes that call based on limitations of the OS).
    args.set_param_file_format("multiline")

    args.use_param_file("@%s", use_always = True)

    direct_inputs = srcs + resources + [toolchain.fsharp_compiler.files_to_run.executable]
    direct_inputs += [keyfile] if keyfile else []

    # dotnet.exe fsc.dll /noconfig <other fsc args>
    actions.run(
        mnemonic = "FSharpCompile",
        progress_message = "Compiling " + target_name + (" (internals ref-only dll)" if out_dll == None else ""),
        inputs = depset(
            direct = direct_inputs,
            transitive = [refs, private_refs, toolchain.runtime.default_runfiles.files, toolchain.fsharp_compiler.default_runfiles.files, compile_data],
        ),
        outputs = outputs,
        executable = toolchain.runtime.files_to_run.executable,
        arguments = [
            toolchain.fsharp_compiler.files_to_run.executable.path,
            args,
        ],
        env = {
            "DOTNET_CLI_HOME": toolchain.runtime.files_to_run.executable.dirname,
            # Set so that compilations work on remote execution workers that don't have ICU installed
            # ICU should not be required during compliation but only at runtime
            "DOTNET_SYSTEM_GLOBALIZATION_INVARIANT": "1",
        },
    )
