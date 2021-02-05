load("@rules_dotnet_skylib//lib:paths.bzl", "paths")

def _make_runner_arglist(dotnet, source, output):
    args = dotnet.actions.args()

    args.add(dotnet.resgen.path)
    if type(source) == "Target":
        args.add_all(source.files)
    else:
        args.add(source)

    args.add(output)

    return args

def emit_resx(
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

    # Unfortunately, resgen always produces the output in the same directory as the input file
    # Therefore we have to copy the source file to the target directory
    copied_source = dotnet.declare_file(dotnet, path = paths.replace_extension(result.basename, ".resx"))

    inputs = src.files if type(src) == "Target" else [src]

    dotnet.actions.run_shell(
        inputs = inputs,
        outputs = [copied_source],
        mnemonic = "MonoResxCopySource",
        command = "cp {} {}".format(src.files.to_list()[0].path, copied_source.path),
    )

    args = _make_runner_arglist(dotnet, src, result)

    dotnet.actions.run(
        inputs = [copied_source],
        outputs = [result],
        executable = dotnet.runner.files_to_run,
        arguments = [dotnet.resgen.path, copied_source.path],
        mnemonic = "MonoResxCompile",
        tools = [dotnet.runner.files_to_run],
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
