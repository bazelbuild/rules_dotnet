load("@io_bazel_rules_dotnet//dotnet:defs.bzl", "csharp_xunit_test")

csharp_xunit_test(
    name = "example_xunit.dll",
    size = "medium",
    srcs = [
        "MyTest.cs",
    ],
    langversion = "7.3",
    deps = [
        "@core_sdk_stdlib//:libraryset",
        "@xunit.assert//:lib",
        "@xunit.extensibility.core//:lib",
        "@xunit.extensibility.execution//:lib",
    ],
)
