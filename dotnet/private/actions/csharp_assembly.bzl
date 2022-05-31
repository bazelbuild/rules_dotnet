"""
Actions for compiling targets with C#.
"""

load(
    "//dotnet/private:common.bzl",
    "collect_transitive_info",
    "get_analyzer_dll",
    "use_highentropyva",
)
load(
    "//dotnet/private:providers.bzl",
    "DotnetAssemblyInfo",
    "GetFrameworkVersionInfo",
)
load("//dotnet/private:actions/misc.bzl", "framework_preprocessor_symbols", "write_internals_visible_to_csharp")

def _format_ref_arg(assembly):
    return "/r:" + assembly.path

def _format_analyzer_arg(analyzer):
    return "/analyzer:" + analyzer

def _format_additionalfile_arg(additionalfile):
    return "/additionalfile:" + additionalfile.path

def _format_resource_arg(resource):
    return "/resource:" + resource.path

def _format_define(symbol):
    return "/d:" + symbol

def AssemblyAction(
        actions,
        additionalfiles,
        analyzers,
        debug,
        defines,
        deps,
        internals_visible_to,
        keyfile,
        langversion,
        resources,
        srcs,
        out,
        target,
        target_name,
        target_framework,
        toolchain,
        runtimeconfig = None,
        depsjson = None):
    """Creates an action that runs the CSharp compiler with the specified inputs.

    This macro aims to match the [C# compiler](https://docs.microsoft.com/en-us/dotnet/csharp/language-reference/compiler-options/listed-alphabetically), with the inputs mapping to compiler options.

    Args:
        actions: Bazel module providing functions to create actions.
        additionalfiles: Names additional files that don't directly affect code generation but may be used by analyzers for producing errors or warnings.
        analyzers: The list of analyzers to run from this assembly.
        debug: Emits debugging information.
        defines: The list of conditional compilation symbols.
        deps: The list of other libraries to be linked in to the assembly.
        internals_visible_to: An optional list of assemblies that can see this assemblies internal symbols.
        keyfile: Specifies a strong name key file of the assembly.
        langversion: Specify language version: Default, ISO-1, ISO-2, 3, 4, 5, 6, 7, 7.1, 7.2, 7.3, or Latest
        resources: The list of resouces to be embedded in the assembly.
        srcs: The list of source (.cs) files that are processed to create the assembly.
        target_name: A unique name for this target.
        out: Specifies the output file name.
        target: Specifies the format of the output file by using one of four options.
        target_framework: The target framework moniker for the assembly.
        toolchain: The toolchain that supply the C# compiler.
        runtimeconfig: The runtime configuration of the assembly.
        depsjson: The deps.json for the assembly.

    Returns:
        The compiled csharp artifacts.
    """

    assembly_name = target_name if out == "" else out
    (subsystem_version, default_lang_version) = GetFrameworkVersionInfo(target_framework)
    (refs, runfiles, native_dlls) = collect_transitive_info(target_name, deps, target_framework)
    analyzer_assemblies = [get_analyzer_dll(a) for a in analyzers]
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
            analyzer_assemblies,
            debug,
            default_lang_version,
            defines,
            keyfile,
            langversion,
            native_dlls,
            refs,
            resources,
            srcs,
            subsystem_version,
            target,
            target_name,
            target_framework,
            toolchain,
            out_dll = out_dll,
            out_ref = out_ref,
            out_pdb = out_pdb,
        )
    else:
        # If the user is using internals_visible_to generate an additional
        # reference-only DLL that contains the internals. We want the
        # InternalsVisibleTo in the main DLL too to be less suprising to users.
        out_iref = actions.declare_file("%s/iref/%s.%s" % (out_dir, assembly_name, out_ext))

        internals_visible_to_cs = write_internals_visible_to_csharp(
            actions,
            name = target_name,
            others = internals_visible_to,
        )

        _compile(
            actions,
            additionalfiles,
            analyzer_assemblies,
            debug,
            default_lang_version,
            defines,
            keyfile,
            langversion,
            native_dlls,
            refs,
            resources,
            srcs + [internals_visible_to_cs],
            subsystem_version,
            target,
            target_name,
            target_framework,
            toolchain,
            out_ref = out_iref,
            out_dll = out_dll,
            out_pdb = out_pdb,
        )

        # Generate a ref-only DLL without internals
        _compile(
            actions,
            additionalfiles,
            analyzer_assemblies,
            debug,
            default_lang_version,
            defines,
            keyfile,
            langversion,
            native_dlls,
            refs,
            resources,
            srcs,
            subsystem_version,
            target,
            target_name,
            target_framework,
            toolchain,
            out_dll = None,
            out_ref = out_ref,
            out_pdb = None,
        )

    return DotnetAssemblyInfo(
        out = out_dll,
        irefout = out_iref or out_ref,
        prefout = out_ref,
        internals_visible_to = internals_visible_to or [],
        pdb = out_pdb,
        native_dlls = native_dlls,
        deps = deps,
        transitive_refs = refs,
        transitive_runfiles = runfiles,
        actual_tfm = target_framework,
        runtimeconfig = runtimeconfig,
        depsjson = depsjson,
    )

def _compile(
        actions,
        additionalfiles,
        analyzer_assemblies,
        debug,
        default_lang_version,
        defines,
        keyfile,
        langversion,
        native_dlls,
        refs,
        resources,
        srcs,
        subsystem_version,
        target,
        target_name,
        target_framework,
        toolchain,
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

    args.add("/warn:0")  # TODO: this stuff ought to be configurable

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
    args.add_all(refs, map_each = _format_ref_arg)

    # analyzers
    args.add_all(analyzer_assemblies, map_each = _format_analyzer_arg)
    args.add_all(additionalfiles, map_each = _format_additionalfile_arg)

    # .cs files
    args.add_all([cs for cs in srcs])

    # resources
    args.add_all(resources, map_each = _format_resource_arg)

    # defines
    args.add_all(defines, map_each = _format_define)

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

    # Our wrapper uses _spawnv to launch dotnet, and that has a command line limit
    # of 1024 bytes, so always use a param file.
    args.use_param_file("@%s", use_always = True)

    direct_inputs = srcs + resources + analyzer_assemblies + additionalfiles + [toolchain.csharp_compiler]
    direct_inputs += [keyfile] if keyfile else []

    # dotnet.exe csc.dll /noconfig <other csc args>
    # https://docs.microsoft.com/en-us/dotnet/csharp/language-reference/compiler-options/command-line-building-with-csc-exe
    actions.run(
        mnemonic = "CSharpCompile",
        progress_message = "Compiling " + target_name + (" (internals ref-only dll)" if out_dll == None else ""),
        inputs = depset(
            direct = direct_inputs,
            transitive = [refs] + [native_dlls],
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
    )
