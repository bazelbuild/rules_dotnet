"Actions for compiling resx files"

load(
    "@io_bazel_rules_dotnet//dotnet/private:providers.bzl",
    "DotnetResourceInfo",
)

def _make_runner_arglist(dotnet, source, output, resgen):
    args = dotnet.actions.args()

    if type(source) == "Target":
        args.add_all(source.files)
    else:
        args.add(source)
    args.add(output)

    return args

def emit_resx_core(
        dotnet,
        name = "",
        src = None,
        identifier = None,
        out = None,
        customresgen = None):
    """The function adds an action that compiles a single .resx file into .resources file.

    Returns [DotnetResourceInfo](api.md#dotnetresourceinfo).

    Args:
        dotnet: [DotnetContextInfo](api.md#dotnetcontextinfo).
        name: name of the file to generate.
        src: The .resx source file that is transformed into .resources file. Only `.resx` files are permitted.
        identifier: The logical name for the resource; the name that is used to load the resource. The default is the basename of the file name (no subfolder).
        out: An alternative name of the output file (if name should not be used).
        customresgen: custom resgen program to use.

    Returns:
        DotnetResourceInfo: [DotnetResourceInfo](api.md#dotnetresourceinfo).
    """
    if name == "" and out == None:
        fail("either name or out must be set")

    if not out:
        result = dotnet.actions.declare_file(name + ".resources")
    else:
        result = dotnet.actions.declare_file(out)

    args = _make_runner_arglist(dotnet, src, result, customresgen.files_to_run.executable.path)

    # We use the command to extrace shell path and force runfiles creation
    resolve = dotnet._ctx.resolve_tools(tools = [customresgen])

    inputs = src.files.to_list() if type(src) == "Target" else [src]

    dotnet.actions.run(
        inputs = inputs + resolve[0].to_list(),
        tools = customresgen.default_runfiles.files,
        outputs = [result],
        executable = customresgen.files_to_run,
        arguments = [args],
        env = {"RUNFILES_MANIFEST_FILE": customresgen.files_to_run.runfiles_manifest.path},
        mnemonic = "CoreResxCompile",
        input_manifests = resolve[1],
        progress_message = (
            "Compiling resoources" + dotnet.label.package + ":" + dotnet.label.name
        ),
    )

    return DotnetResourceInfo(
        name = name,
        result = result,
        identifier = identifier,
    )
