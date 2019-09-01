load("@io_bazel_rules_dotnet//dotnet:defs.bzl", "DEFAULT_DOTNET_CORE_FRAMEWORK", "core_xunit_test")

core_xunit_test(
    name = "nuget2bazel-test.dll",
    size = "medium",
    srcs = [
        "RemotionLinqT.cs",
    ],
    deps = [
        "@io_bazel_rules_dotnet//tools/nuget2bazel:nuget2bazel.exe",
        "@xunit.assert//:netcoreapp2.0_core",
        "@xunit.extensibility.core//:netcoreapp2.0_core",
        "@xunit.extensibility.execution//:netcoreapp2.0_core",
    ],
)
