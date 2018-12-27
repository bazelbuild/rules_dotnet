load("@io_bazel_rules_dotnet//dotnet:defs.bzl", "core_library", "core_binary", "core_resource")

core_library(
    name = "assert.xunit",
    srcs = glob(["**/*.cs"]),
    visibility = ["//visibility:public"],
    deps = [
        "@io_bazel_rules_dotnet//dotnet/stdlib.core:system.runtime.dll",
        "@io_bazel_rules_dotnet//dotnet/stdlib.core:system.private.corelib.dll",
        "@io_bazel_rules_dotnet//dotnet/stdlib.core:system.linq.dll",
        "@io_bazel_rules_dotnet//dotnet/stdlib.core:system.text.regularexpressions.dll",
        "@io_bazel_rules_dotnet//dotnet/stdlib.core:system.objectmodel.dll",
    ]
)

filegroup(
    name = "common_files",
    srcs = [
        ":Sdk/ArgumentFormatter.cs",
        ":Sdk/AssertEqualityComparer.cs",
        ":Sdk/AssertEqualityComparerAdapter.cs",
    ],
    visibility = ["//visibility:public"],
)


filegroup(
    name = "test_files",
    srcs = [
        ":Sdk/ArgumentFormatter.cs",
    ],
    visibility = ["//visibility:public"],
)
