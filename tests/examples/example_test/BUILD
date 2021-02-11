load("@io_bazel_rules_dotnet//dotnet:defs.bzl", "csharp_nunit3_test")

csharp_nunit3_test(
    name = "core.example_test6.dll",
    size = "small",
    srcs = [
        "MyTest.cs",
    ],
    deps = [
        "//tests/examples/example_lib:MyClass.dll",
        "@nunit//:lib",
    ],
)

csharp_nunit3_test(
    name = "core.example_netstandard.dll",
    size = "small",
    srcs = [
        "MyTest.cs",
    ],
    deps = [
        "//tests/examples/example_lib:MyClass-netstandard.dll",
        "@nunit//:lib",
    ],
)
