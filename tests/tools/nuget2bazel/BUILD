load("@io_bazel_rules_dotnet//dotnet:defs.bzl", "csharp_xunit_test")

csharp_xunit_test(
    name = "nuget2bazel-test.dll",
    size = "medium",
    srcs = glob(["*.cs"]),
    nowarn = ["CS1701"],
    deps = [
        "@io_bazel_rules_dotnet//tools/nuget2bazel:nuget2bazel.exe",
        "@xunit.assert//:lib",
        "@xunit.extensibility.core//:lib",
        "@xunit.extensibility.execution//:lib",
    ],
)
