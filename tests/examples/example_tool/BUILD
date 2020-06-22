load("@io_bazel_rules_dotnet//dotnet:defs.bzl", "DOTNET_CORE_FRAMEWORKS", "DOTNET_NET_FRAMEWORKS", "core_binary", "dotnet_binary", "net_binary")

dotnet_binary(
    name = "hello_tool.exe",
    srcs = [
        "MyTool.cs",
    ],
    deps = [
        "//tests/examples/example_lib:MyClass.dll",
        "@io_bazel_rules_dotnet//dotnet/stdlib:system.dll",
    ],
)

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

[net_binary(
    name = "hello_tool_net_{}.exe".format(framework),
    srcs = [
        "MyTool.cs",
    ],
    dotnet_context_data = "@io_bazel_rules_dotnet//:net_context_data_{}".format(framework),
    deps = [
        "//tests/examples/example_lib:MyClass-net_{}.dll".format(framework),
    ],
) for framework in DOTNET_NET_FRAMEWORKS]

genrule(
    name = "hello_single_output",
    outs = [
        "hello_world.txt",
    ],
    cmd = "$(location :hello_tool.exe) $@",
    tools = [
        ":hello_tool.exe",
    ],
)

genrule(
    name = "hello_multiple_outputs",
    outs = [
        "hello_world_1.txt",
        "hello_world_2.txt",
    ],
    cmd = "$(location :hello_tool.exe) $(OUTS)",
    tools = [
        ":hello_tool.exe",
    ],
)
