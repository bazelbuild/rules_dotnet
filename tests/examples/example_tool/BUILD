load("@io_bazel_rules_dotnet//dotnet:defs.bzl", "DOTNET_CORE_FRAMEWORKS", "core_binary")

[core_binary(
    name = "{}_hello_tool_core.exe".format(framework),
    srcs = [
        "MyTool.cs",
    ],
    dotnet_context_data = "@io_bazel_rules_dotnet//:core_context_data_{}".format(framework),
    deps = [
        "//tests/examples/example_lib:{}_MyClass-core.dll".format(framework),
        "@io_bazel_rules_dotnet//dotnet/stdlib.core/{}:libraryset".format(framework),
    ],
) for framework in DOTNET_CORE_FRAMEWORKS]

[genrule(
    name = "{}_hello_single_output".format(framework),
    outs = [
        "{}_hello_world.txt".format(framework),
    ],
    cmd = "$(location :{}_hello_tool_core.exe) $@".format(framework),
    tools = [
        ":{}_hello_tool_core.exe".format(framework),
    ],
) for framework in DOTNET_CORE_FRAMEWORKS]

[genrule(
    name = "{}_hello_multiple_outputs".format(framework),
    outs = [
        "{}_hello_world_1.txt".format(framework),
        "{}_hello_world_2.txt".format(framework),
    ],
    cmd = "$(location :{}_hello_tool_core.exe) $(OUTS)".format(framework),
    tools = [
        ":{}_hello_tool_core.exe".format(framework),
    ],
) for framework in DOTNET_CORE_FRAMEWORKS]
