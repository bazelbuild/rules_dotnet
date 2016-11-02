load("//dotnet:csharp.bzl", "csharp_binary")

csharp_binary(
    name = "hello_tool",
    srcs = [
        "MyTool.cs",
    ],
    deps = [
        "//examples/example_lib:MyClass",
    ],
)

genrule(
    name = "hello_single_output",
    outs = [
        "hello_world.txt",
    ],
    tools = [
        ":hello_tool",
    ],
    cmd = "$(location :hello_tool) $@",
)

genrule(
    name = "hello_multiple_outputs",
    outs = [
        "hello_world_1.txt",
        "hello_world_2.txt",
    ],
    tools = [
        ":hello_tool",
    ],
    cmd = "$(location :hello_tool) $(OUTS)",
)
