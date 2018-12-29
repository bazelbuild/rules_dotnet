load("@io_bazel_rules_dotnet//dotnet:defs.bzl", "core_binary", "dotnet_binary", "net_binary", "DOTNET_NET_FRAMEWORKS", "DOTNET_CORE_FRAMEWORKS")

dotnet_binary(
    name = "hello_tool",
    srcs = [
        "MyTool.cs",
    ],
    deps = [
        "//tests/examples/example_lib:MyClass",
    ],
)

[core_binary(
    name = "{}_hello_tool_core".format(framework),
    srcs = [
        "MyTool.cs",
    ],
    deps = [
        "//tests/examples/example_lib:{}_MyClass-core".format(framework),
        "@io_bazel_rules_dotnet//dotnet/stdlib.core/{}:system.console.dll".format(framework),
        "@io_bazel_rules_dotnet//dotnet/stdlib.core/{}:system.io.filesystem.dll".format(framework),
        "@io_bazel_rules_dotnet//dotnet/stdlib.core/{}:system.private.corelib.dll".format(framework),
        "@io_bazel_rules_dotnet//dotnet/stdlib.core/{}:system.runtime.dll".format(framework),
        "@io_bazel_rules_dotnet//dotnet/stdlib.core/{}:system.runtime.extensions.dll".format(framework),
    ],
    dotnet_context_data = "@io_bazel_rules_dotnet//:core_context_data_{}".format(framework),
    native_deps = "@core_sdk_{}//:native_deps".format(framework),
) for framework in DOTNET_CORE_FRAMEWORKS]

[net_binary(
    name = "hello_tool_net_{}".format(framework),
    srcs = [
        "MyTool.cs",
    ],
    deps = [
        "//tests/examples/example_lib:MyClass-net_{}".format(framework),
    ],
    dotnet_context_data = "@io_bazel_rules_dotnet//:net_context_data_{}".format(framework),
) for framework in DOTNET_NET_FRAMEWORKS]

genrule(
    name = "hello_single_output",
    outs = [
        "hello_world.txt",
    ],
    cmd = "$(location :hello_tool) $@",
    tools = [
        ":hello_tool",
    ],
)

genrule(
    name = "hello_multiple_outputs",
    outs = [
        "hello_world_1.txt",
        "hello_world_2.txt",
    ],
    cmd = "$(location :hello_tool) $(OUTS)",
    tools = [
        ":hello_tool",
    ],
)

# genrule(
#     name = "hello_single_output_core",
#     outs = [
#         "hello_world_core.txt",
#     ],
#     cmd = "$(location :hello_tool_core) $@",
#     tools = [
#         ":hello_tool_core",
#     ],
# )

# genrule(
#     name = "hello_multiple_outputs_core",
#     outs = [
#         "hello_world_1_core.txt",
#         "hello_world_2_core.txt",
#     ],
#     cmd = "$(location :hello_tool_core) $(OUTS)",
#     tools = [
#         ":hello_tool_core",
#     ],
# )

#genrule(
#    name = "hello_single_output_net",
#    outs = [
#        "hello_world_net.txt",
#    ],
#    tools = [
#        ":hello_tool_net",
#    ],
#    cmd = "$(location :hello_tool_net) $@",
#)

#genrule(
#    name = "hello_multiple_outputs_net",
#    outs = [
#        "hello_world_1_net.txt",
#        "hello_world_2_net.txt",
#    ],
#    tools = [
#        ":hello_tool_net",
#    ],
#    cmd = "$(location :hello_tool_net) $(OUTS)",
#)
