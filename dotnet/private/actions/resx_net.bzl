load(
    "@io_bazel_rules_dotnet//dotnet/private:common.bzl",
    "as_iterable",
    "sets",
)
load(
    "@io_bazel_rules_dotnet//dotnet/private:providers.bzl",
    "DotnetLibrary",
)
load(
    "@io_bazel_rules_dotnet//dotnet/private:common.bzl",
    "paths",
)

def _make_runner_arglist(dotnet, source, output):
    args = dotnet.actions.args()

    args.add(source.files, format = "%s")
    args.add(output)

    return args

def emit_resx_net(
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

    args = _make_runner_arglist(dotnet, src, result)

    dotnet.actions.run(
        inputs = src.files,
        outputs = [result],
        executable = dotnet.resgen,
        arguments = [args],
        mnemonic = "NetResxCompile",
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
