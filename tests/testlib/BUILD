load("@io_bazel_rules_dotnet//dotnet:defs.bzl", "core_library")

core_library(
    name = "testlib.dll",
    srcs = [
        "BazelTestBase.cs",
    ],
    dotnet_context_data = "@io_bazel_rules_dotnet//:core_context_data",
    visibility = ["//visibility:public"],
    deps = [
        "@io_bazel_rules_dotnet//dotnet/stdlib.core:system.console.dll",
        "@io_bazel_rules_dotnet//dotnet/stdlib.core:system.diagnostics.process.dll",
        "@xunit//:xunit.core.dll",
        "@xunit_assert//:assert.xunit.dll",
    ],
)
