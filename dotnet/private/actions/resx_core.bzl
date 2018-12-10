load(
    "@io_bazel_rules_dotnet//dotnet/private:common.bzl",
    "as_iterable",
)
load(
    "@io_bazel_rules_dotnet//dotnet/private:providers.bzl",
    "DotnetLibrary",
)

def _make_runner_arglist(dotnet, source, output, resgen):
    args = dotnet.actions.args()

    args.add(resgen)
    args.add_all(source.files)
    args.add(output)

    return args

def emit_resx_core(
        dotnet,
        name = "",
        src = None,
        identifier = None,
        out = None,
        customresgen = None):
    if name == "" and out == None:
        fail("either name or out must be set")

    if not out:
        result = dotnet.declare_file(dotnet, path = name + ".resources")
    else:
        result = dotnet.declare_file(dotnet, path = out)

    args = _make_runner_arglist(dotnet, src, result, customresgen.files_to_run.executable.path)

    # We use the command to extrace shell path and force runfiles creation
    resolve = dotnet._ctx.resolve_command(command = customresgen.files_to_run.executable.path, tools = [customresgen])

    dotnet.actions.run(
        inputs = src.files.to_list() + resolve[0],
        tools = customresgen.files,
        outputs = [result],
        executable = resolve[1][0],
        arguments = [args],
        env = {"RUNFILES_MANIFEST_FILE": customresgen.files_to_run.runfiles_manifest.path},
        mnemonic = "CoreResxCompile",
        input_manifests = resolve[2],
        progress_message = (
            "Compiling resoources" + dotnet.label.package + ":" + dotnet.label.name
        ),
    )

    return dotnet.new_resource(
        dotnet = dotnet,
        name = name,
        result = result,
        identifier = identifier,
    )
