load("@io_bazel_rules_dotnet//dotnet:defs.bzl", "csharp_binary")

csharp_binary(
    name = "hello.exe",
    srcs = [
        "Program.cs",
    ],
    deps = [
        "//tests/examples/example_lib:MyClass.dll",
    ],
)
