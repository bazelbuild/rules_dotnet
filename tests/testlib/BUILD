load("@io_bazel_rules_dotnet//dotnet:defs.bzl", "core_library")

core_library(
    name = "testlib.dll",
    srcs = [
        "BazelTestBase.cs",
        "ProcessAsyncHelper.cs",
    ],
    visibility = ["//visibility:public"],
    deps = [
        "@core_sdk_stdlib//:libraryset",
        "@xunit.assert//:lib",
        "@xunit.extensibility.core//:lib",
        "@xunit.extensibility.execution//:lib",
    ],
)
