load("@rules_mono//dotnet:defs.bzl", "DOTNET_CORE_FRAMEWORKS", "DOTNET_NET_FRAMEWORKS", "core_binary", "dotnet_binary", "net_binary")

dotnet_binary(
    name = "hello_tool.exe",
    srcs = [
        "MyTool.cs",
    ],
    deps = [
        "//tests/examples/example_lib:MyClass.dll",
        "@rules_mono//dotnet/stdlib:system.dll",
    ],
)

[core_binary(
    name = "{}_hello_tool_core.exe".format(framework),
    srcs = [
        "MyTool.cs",
    ],
    dotnet_context_data = "@rules_mono//:core_context_data_{}".format(framework),
    deps = [
        "//tests/examples/example_lib:{}_MyClass-core.dll".format(framework),
        "@rules_mono//dotnet/stdlib.core/{}:libraryset".format(framework),
    ],
) for framework in DOTNET_CORE_FRAMEWORKS]

[net_binary(
    name = "hello_tool_net_{}.exe".format(framework),
    srcs = [
        "MyTool.cs",
    ],
    dotnet_context_data = "@rules_mono//:net_context_data_{}".format(framework),
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

core_binary(
    name = "hello_tool_core-v2.1.200.exe",
    srcs = [
        "MyTool.cs",
    ],
    dotnet_context_data = "@rules_mono//:core_context_data_v2.1.200",
    deps = [
        "//tests/examples/example_lib:MyClass-core-v2.1.200-netstandard.dll",
        "@rules_mono//dotnet/stdlib.core/v2.1.200:libraryset",
    ],
)
