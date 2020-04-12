load(
    "@io_bazel_rules_dotnet//dotnet/private:common.bzl",
    "as_iterable",
)
load(
    "@io_bazel_rules_dotnet//dotnet/private:providers.bzl",
    "DotnetResourceList",
)
load("@io_bazel_rules_dotnet//dotnet/private:rules/common.bzl", "collect_transitive_info")

def _map_resource(d):
    return d.result.path + "," + d.identifier

def emit_assembly_common(
        kind,
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
        nowarn = None):
    """See dotnet/toolchains.rst#binary for full documentation. Emits actions for assembly build.

    The function is used by all frameworks.

    Args:
      kind: String "core", "net" "mono"
      dotnet: DotnetContext provider
      name: name of the assembly
      srcs: source files (as passed from rules: list of lables/targets)
      deps: list of DotnetLibrary. Dependencies as passed from rules)
      out: output file name if provided. Otherwise name is used
      resources: list of DotnetResourceList provider
      executable: bool. True for executable assembly, False otherwise
      defines: list of string. Defines to pass to a compiler
      unsafe: /unsafe flag (False - default - /unsafe-, otherwise /unsafe+)
      data: list of targets (as passed from rules). Additional depdendencies of the target
      keyfile: File to be used for signing if provided
      subdir: specific subdirectory to be used for target location. Default ./
      target_framework: target framework to define via System.Runtime.Versioning.TargetFramework
      nowarn: list of warnings to ignore
    """

    if name == "" and out == None:
        fail("either name or out must be set")

    if not out:
        result = dotnet.declare_file(dotnet, path = subdir + name)
    else:
        result = dotnet.declare_file(dotnet, path = subdir + out)

    if dotnet.debug:
        pdbext = ".mdb" if kind == "mono" else ".pdb"
        pdb = dotnet.declare_file(dotnet, path = result.basename + pdbext, sibling = result)
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
    args.add("/langversion:latest")

    # Debug parameters
    if pdb:
        if kind != "mono":
            args.add("-debug:full")
            args.add("-pdb:" + pdb.path)
            args.add("/optimize-")
            args.add("/define:TRACE;DEBUG")
        else:
            args.add("-debug")
    elif kind != "mono":
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
        if r[DotnetResourceList].result and len(r[DotnetResourceList].result) > 0:
            args.add_all(r[DotnetResourceList].result, format_each = "/resource:%s", map_each = _map_resource)
            res_l = [t.result for t in r[DotnetResourceList].result]
            direct_inputs += res_l

    # Source files
    attr_srcs = [f for t in srcs for f in as_iterable(t.files)]
    args.add_all(attr_srcs)
    direct_inputs += attr_srcs

    # Generate the source file for target framework
    if target_framework != "":
        f = dotnet._ctx.actions.declare_file(result.basename + "._tf_.cs", sibling = result)
        content = """
        [assembly:System.Runtime.Versioning.TargetFramework("{}")]
        """.format(target_framework)
        dotnet._ctx.actions.write(f, content)
        args.add(f)
        direct_inputs.append(f)

    # References - also needs to include transitive dependencies
    (transitive_refs, transitive_runfiles, transitive_deps) = collect_transitive_info(deps)

    args.add_all(transitive_refs, format_each = "/r:%s")

    args.set_param_file_format("multiline")

    # Prepare and execute action
    paramfilepath = name + ".param"
    paramfile = dotnet.declare_file(dotnet, path = paramfilepath)
    dotnet.actions.write(output = paramfile, content = args)

    direct_inputs.append(paramfile)

    # select runner and action_args
    if kind != "net":
        runner = dotnet.runner
        action_args = [dotnet.mcs.path, "/noconfig", "@" + paramfile.path]
        direct_inputs.append(runner)
        direct_inputs.append(dotnet.mcs)
    else:
        runner = dotnet.mcs
        action_args = ["/noconfig", "@" + paramfile.path]
        direct_inputs.append(runner)

    inputs = depset(direct = direct_inputs, transitive = [transitive_refs])
    dotnet.actions.run(
        inputs = inputs,
        outputs = [result] + ([pdb] if pdb else []),
        executable = runner,
        arguments = action_args,
        mnemonic = "Compile" + kind,
        progress_message = (
            "Compiling " + kind + " " + dotnet.label.package + ":" + dotnet.label.name
        ),
    )

    # Collect runfiles
    direct_runfiles = []
    direct_runfiles.append(result)
    if pdb:
        direct_runfiles.append(pdb)

    data_l = [f for t in data for f in as_iterable(t.files)]
    direct_runfiles += data_l

    # Final result
    return dotnet.new_library(
        dotnet = dotnet,
        name = name,
        deps = deps,
        transitive = transitive_deps,
        runfiles = depset(direct = direct_runfiles, transitive = [transitive_runfiles]),
        result = result,
        pdb = pdb,
        transitive_refs = depset(direct = [result], transitive = [transitive_refs]),
    )
