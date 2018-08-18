load("@io_bazel_rules_dotnet//dotnet:defs.bzl", "dotnet_binary")


dotnet_binary(
    name = "hello",
    srcs = [
        "Program.cs",
        "Properties/AssemblyInfo.cs",
    ],
    deps = [
        "//tests/examples/example_lib:MyClass",
        "@npgsql//:npgsqllib",
    ],
)
