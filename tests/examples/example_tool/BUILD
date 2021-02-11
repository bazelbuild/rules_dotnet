load("@io_bazel_rules_dotnet//dotnet:defs.bzl", "csharp_binary")

csharp_binary(
    name = "hello_tool.exe",
    srcs = [
        "MyTool.cs",
    ],
    deps = [
        "//tests/examples/example_lib:MyClass.dll",
        "@core_sdk_stdlib//:libraryset",
    ],
)

genrule(
    name = "hello_single_output",
    outs = [
        "hello_world.txt",
    ],
    cmd = "$(location :hello_tool.exe) $@",
    local = 1,  #TODO: Should be fixed
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
    local = 1,  #TODO: Should be fixed
    tools = [
        ":hello_tool.exe",
    ],
)
