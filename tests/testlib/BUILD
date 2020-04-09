load("@io_bazel_rules_dotnet//dotnet:defs.bzl", "core_library")

core_library(
    name = "testlib.dll",
    srcs = [
        "BazelTestBase.cs",
        "ProcessAsyncHelper.cs",
    ],
    dotnet_context_data = "@io_bazel_rules_dotnet//:core_context_data",
    visibility = ["//visibility:public"],
    deps = [
        "@io_bazel_rules_dotnet//dotnet/stdlib.core:libraryset",
        "@xunit.assert//:netcoreapp2.0_core",
        "@xunit.extensibility.core//:netcoreapp2.0_core",
        "@xunit.extensibility.execution//:netcoreapp2.0_core",
    ],
)
