"Assembly generation rules"

load(
    "@io_bazel_rules_dotnet//dotnet/private:common.bzl",
    "as_iterable",
)
load(
    "@io_bazel_rules_dotnet//dotnet/private:providers.bzl",
    "DotnetLibraryInfo",
    "DotnetResourceListInfo",
)
load("@io_bazel_rules_dotnet//dotnet/private:rules/common.bzl", "collect_transitive_info")
load("@io_bazel_rules_dotnet//dotnet/private:rules/versions.bzl", "version2string")

def _map_resource(d):
    return d.result.path + "," + d.identifier

def emit_assembly_core_csharp(
        dotnet,
        name,
        srcs,
        deps = None,
        out = None,
        resources = None,
        executable = True,
        defines = None,
        unsafe = False,
        data = None,
        keyfile = None,
        subdir = "./",
        target_framework = "",
        nowarn = None,
        langversion = "latest",
        version = (0, 0, 0, 0, "")):
    """Emits actions for assembly build.

    The function is used to build C# assemblies..

    Args:
      dotnet: DotnetContextInfo provider
      name: name of the assembly
      srcs: source files (as passed from rules: list of lables/targets)
      deps: list of DotnetLibraryInfo. Dependencies as passed from rules)
      out: output file name if provided. Otherwise name is used
      resources: list of DotnetResourceListInfo provider
      executable: bool. True for executable assembly, False otherwise
      defines: list of string. Defines to pass to a compiler
      unsafe: /unsafe flag (False - default - /unsafe-, otherwise /unsafe+)
      data: list of targets (as passed from rules). Additional depdendencies of the target
      keyfile: File to be used for signing if provided
      subdir: specific subdirectory to be used for target location. Default ./
      target_framework: target framework to define via System.Runtime.Versioning.TargetFramework
      nowarn: list of warnings to ignore
      langversion: version of the language to use (see https://docs.microsoft.com/en-us/dotnet/csharp/language-reference/configure-language-version)
      version: version of the file to be compiled

    Returns:
      [DotnetLibraryInfo](api.md#DotnetLibraryInfo) for the compiled assembly
    """

    if name == "" and out == None:
        fail("either name or out must be set")

    if not out:
        result = dotnet.actions.declare_file(subdir + name)
    else:
        result = dotnet.actions.declare_file(subdir + out)

    if dotnet.debug:
        pdb = dotnet.actions.declare_file(result.basename + ".pdb", sibling = result)
    else:
        pdb = None

    direct_inputs = []

    # The goal is to match msbuild as much as reasonable. Inspired by rules_csharp (https://github.com/Brightspace/rules_csharp)
    # https://docs.microsoft.com/en-us/dotnet/csharp/language-reference/compiler-options/listed-alphabetically
    args = dotnet.actions.args()

    # General command lines parameters
    args.add(result.path, format = "/out:%s")
    if executable:
        target = "exe"
    else:
        target = "library"
    args.add(target, format = "/target:%s")

    args.add("/checked-")
    args.add("/nostdlib+")
    args.add("/utf8output")
    args.add("/deterministic+")
    args.add("/filealign:512")
    args.add("/nologo")
    args.add("/highentropyva+")
    args.add("/langversion:{}".format(langversion))

    # Debug parameters
    if pdb:
        args.add("-debug:full")
        args.add("-pdb:" + pdb.path)
        args.add("/optimize-")
        args.add("/define:TRACE;DEBUG")
    else:
        args.add("/debug-")
        args.add("/optimize+")
        args.add("/define:TRACE;RELEASE")

    if unsafe:
        args.add("/unsafe")

    # Keyfile
    if keyfile:
        args.add("-keyfile:" + keyfile.files.to_list()[0].path)
        direct_inputs.append(keyfile.files.to_list()[0])

    # Defines
    if defines and len(defines) > 0:
        args.add_all(defines, format_each = "/d:%s")

    # Warnings
    if nowarn and len(nowarn) > 0:
        w = ",".join(nowarn)
        args.add("-nowarn:" + w)

    # Resources
    for r in resources:
        if r[DotnetResourceListInfo].result and len(r[DotnetResourceListInfo].result) > 0:
            args.add_all(r[DotnetResourceListInfo].result, format_each = "/resource:%s", map_each = _map_resource)
            res_l = [t.result for t in r[DotnetResourceListInfo].result]
            direct_inputs += res_l

    # Source files
    attr_srcs = [f for t in srcs for f in as_iterable(t.files)]
    args.add_all(attr_srcs)
    direct_inputs += attr_srcs

    # Generate the source file for target framework
    if target_framework != "":
        f = dotnet.actions.declare_file(result.basename + "._tf_.cs", sibling = result)
        content = """
        [assembly:System.Runtime.Versioning.TargetFramework("{}")]
        """.format(target_framework)
        dotnet.actions.write(f, content)
        args.add(f)
        direct_inputs.append(f)

    # Generate the source file for assembly version
    if version != (0, 0, 0, 0, ""):
        f = dotnet.actions.declare_file(result.basename + "._tv_.cs", sibling = result)
        content = """
        [assembly:System.Reflection.AssemblyVersion("{}")]
        """.format(version2string(version))
        dotnet._ctx.actions.write(f, content)
        args.add(f)
        direct_inputs.append(f)

    # References - also needs to include transitive dependencies
    transitive = collect_transitive_info(deps)

    refs = []
    for d in transitive:
        if d.ref != None:
            refs.append(d.ref)

    args.add_all(refs, format_each = "/r:%s")

    args.set_param_file_format("multiline")

    # Prepare and execute action
    paramfilepath = name + ".param"
    paramfile = dotnet.actions.declare_file(paramfilepath)
    dotnet.actions.write(output = paramfile, content = args)

    direct_inputs.append(paramfile)

    # select runner and action_args
    runner_target = dotnet.toolchain.sdk_exec_runner
    csc_target = dotnet.toolchain.sdk_exec_csc
    runner = runner_target.files_to_run
    runner_tools = depset(transitive = [runner_target.default_runfiles.files, csc_target.default_runfiles.files])
    action_args = [csc_target.files_to_run.executable.path, "/noconfig", "@" + paramfile.path]

    inputs = depset(direct = direct_inputs, transitive = [depset(direct = refs)])
    dotnet.actions.run(
        inputs = inputs,
        outputs = [result] + ([pdb] if pdb else []),
        executable = runner,
        arguments = action_args,
        mnemonic = "Compile",
        tools = runner_tools,
        progress_message = (
            "Compiling " + dotnet.label.package + ":" + dotnet.label.name
        ),
    )

    # Collect runfiles
    direct_runfiles = []
    direct_runfiles.append(result)
    if pdb:
        direct_runfiles.append(pdb)
    data_l = [f for t in data for f in as_iterable(t.files)]
    direct_runfiles += data_l

    runfiles = depset(direct = direct_runfiles)

    # Final result
    new_library = DotnetLibraryInfo(
        name = name,
        deps = deps,
        transitive = transitive,
        runfiles = runfiles,
        result = result,
        pdb = pdb,
        version = version,
        ref = result,  # Generating reference assemblies is not supported yet
    )

    return new_library

def emit_assembly_core_fsharp(
        dotnet,
        name,
        srcs,
        deps = None,
        out = None,
        resources = None,
        executable = True,
        defines = None,
        data = None,
        keyfile = None,
        subdir = "./",
        target_framework = "",
        nowarn = None,
        langversion = "latest",
        version = (0, 0, 0, 0, "")):
    """Emits actions for assembly build.

    The function is used got build F# assemblies.

    Args:
      dotnet: DotnetContextInfo provider
      name: name of the assembly
      srcs: source files (as passed from rules: list of lables/targets)
      deps: list of DotnetLibraryInfo. Dependencies as passed from rules)
      out: output file name if provided. Otherwise name is used
      resources: list of DotnetResourceListInfo provider
      executable: bool. True for executable assembly, False otherwise
      defines: list of string. Defines to pass to a compiler
      data: list of targets (as passed from rules). Additional depdendencies of the target
      keyfile: File to be used for signing if provided
      subdir: specific subdirectory to be used for target location. Default ./
      target_framework: target framework to define via System.Runtime.Versioning.TargetFramework
      nowarn: list of warnings to ignore
      langversion: version of the language to use (see https://docs.microsoft.com/en-us/dotnet/csharp/language-reference/configure-language-version)
      version: version of the file to be compiled

    Returns:
      [DotnetLibraryInfo](api.md#DotnetLibraryInfo) for the compiled assembly
    """

    if name == "" and out == None:
        fail("either name or out must be set")

    if not out:
        result = dotnet.actions.declare_file(subdir + name)
    else:
        result = dotnet.actions.declare_file(subdir + out)

    if dotnet.debug:
        pdb = dotnet.actions.declare_file(result.basename + ".pdb", sibling = result)
    else:
        pdb = None

    direct_inputs = []

    # The goal is to match msbuild as much as reasonable. Inspired by rules_csharp (https://github.com/Brightspace/rules_csharp)
    # https://docs.microsoft.com/en-us/dotnet/csharp/language-reference/compiler-options/listed-alphabetically
    args = dotnet.actions.args()

    # General command lines parameters
    args.add(result.path, format = "/out:%s")
    if executable:
        target = "exe"
    else:
        target = "library"
    args.add(target, format = "/target:%s")

    args.add("/checked-")
    args.add("/utf8output")
    args.add("/deterministic+")
    args.add("/nologo")
    args.add("/highentropyva+")
    args.add("/noframework")
    args.add("/nowin32manifest")
    args.add("/targetprofile:netcore")
    args.add("/simpleresolution")
    args.add("/nocopyfsharpcore")

    # Debug parameters
    if pdb:
        args.add("-debug:portable")
        args.add("-pdb:" + pdb.path)
        args.add("/optimize-")
        args.add("/define:TRACE;DEBUG")
    else:
        args.add("/debug-")
        args.add("/optimize+")
        args.add("/define:TRACE;RELEASE")

    # Keyfile
    if keyfile:
        args.add("-keyfile:" + keyfile.files.to_list()[0].path)
        direct_inputs.append(keyfile.files.to_list()[0])

    # Defines
    if defines and len(defines) > 0:
        args.add_all(defines, format_each = "/d:%s")

    # Warnings
    if nowarn and len(nowarn) > 0:
        w = ",".join(nowarn)
        args.add("-nowarn:" + w)

    # Resources
    for r in resources:
        if r[DotnetResourceListInfo].result and len(r[DotnetResourceListInfo].result) > 0:
            args.add_all(r[DotnetResourceListInfo].result, format_each = "/resource:%s", map_each = _map_resource)
            res_l = [t.result for t in r[DotnetResourceListInfo].result]
            direct_inputs += res_l

    # Source files
    attr_srcs = [f for t in srcs for f in as_iterable(t.files)]
    args.add_all(attr_srcs)
    direct_inputs += attr_srcs

    # Generate the source file for target framework
    if target_framework != "":
        f = dotnet.actions.declare_file(result.basename + "._tf_.fs", sibling = result)
        content = """
        namespace Microsoft.BuildSettings
                        [<System.Runtime.Versioning.TargetFrameworkAttribute(".NETCoreApp,Version={}", FrameworkDisplayName="")>]
                        do ()
        """.format(target_framework)
        dotnet.actions.write(f, content)
        args.add(f)
        direct_inputs.append(f)

    # Generate the source file for assembly version
    if version != (0, 0, 0, 0, ""):
        f = dotnet.actions.declare_file(result.basename + "._tv_.fs", sibling = result)
        content = """
        namespace FSharp

        open System
        open System.Reflection

        [<assembly: System.Reflection.AssemblyVersionAttribute("{}")>]
        do()
        """.format(version2string(version))
        dotnet._ctx.actions.write(f, content)
        args.add(f)
        direct_inputs.append(f)

    # References - also needs to include transitive dependencies
    transitive = collect_transitive_info(deps)

    refs = []
    for d in transitive:
        if d.ref != None:
            refs.append(d.ref)

    args.add_all(refs, format_each = "/r:%s")

    args.set_param_file_format("multiline")

    # Prepare and execute action
    paramfilepath = name + ".param"
    paramfile = dotnet.actions.declare_file(paramfilepath)
    dotnet.actions.write(output = paramfile, content = args)

    direct_inputs.append(paramfile)

    # select runner and action_args
    runner_target = dotnet.toolchain.sdk_exec_runner
    fsc_target = dotnet.toolchain.sdk_exec_fsc
    runner = runner_target.files_to_run
    runner_tools = depset(transitive = [runner_target.default_runfiles.files, fsc_target.default_runfiles.files])
    action_args = [fsc_target.files_to_run.executable.path, "@" + paramfile.path]

    inputs = depset(direct = direct_inputs, transitive = [depset(direct = refs)])
    dotnet.actions.run(
        inputs = inputs,
        outputs = [result] + ([pdb] if pdb else []),
        executable = runner,
        arguments = action_args,
        mnemonic = "Compile",
        tools = runner_tools,
        progress_message = (
            "Compiling " + dotnet.label.package + ":" + dotnet.label.name
        ),
    )

    # Collect runfiles
    direct_runfiles = []
    direct_runfiles.append(result)
    if pdb:
        direct_runfiles.append(pdb)
    data_l = [f for t in data for f in as_iterable(t.files)]
    direct_runfiles += data_l

    runfiles = depset(direct = direct_runfiles, transitive = [dotnet.toolchain.sdk_fsharp_runtime_deps.files])

    # Final result
    new_library = DotnetLibraryInfo(
        name = name,
        deps = deps,
        transitive = transitive,
        runfiles = runfiles,
        result = result,
        pdb = pdb,
        version = version,
        ref = result,  # Generating reference assemblies is not supported yet
    )

    return new_library
