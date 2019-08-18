load("@io_bazel_rules_dotnet//dotnet:defs.bzl", "DEFAULT_DOTNET_CORE_FRAMEWORK", "core_xunit_test")

core_xunit_test(
    name = "nuget2bazel-test.dll",
    size = "medium",
    srcs = [
        "RemotionLinqT.cs",
    ],
    deps = [
        "@io_bazel_rules_dotnet//tools/nuget2bazel:nuget2bazel.exe",
        "@xunit//:xunit.core.dll",
        "@xunit_assert//:assert.xunit.dll",
    ],
)
