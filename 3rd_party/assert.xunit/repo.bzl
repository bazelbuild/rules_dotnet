load("@io_bazel_rules_dotnet//dotnet:defs.bzl", "core_binary", "core_library", "core_resource")

def buildall(framework):
    core_library(
        name = "assert.xunit.dll",
        srcs = native.glob(["**/*.cs"]),
        visibility = ["//visibility:public"],
        deps = [
            "@io_bazel_rules_dotnet//dotnet/stdlib.core/{}:system.runtime.dll".format(framework),
            "@io_bazel_rules_dotnet//dotnet/stdlib.core/{}:system.private.corelib.dll".format(framework),
            "@io_bazel_rules_dotnet//dotnet/stdlib.core/{}:system.linq.dll".format(framework),
            "@io_bazel_rules_dotnet//dotnet/stdlib.core/{}:system.text.regularexpressions.dll".format(framework),
            "@io_bazel_rules_dotnet//dotnet/stdlib.core/{}:system.objectmodel.dll".format(framework),
        ],
        dotnet_context_data = "@io_bazel_rules_dotnet//:core_context_data_{}".format(framework),
    )
    native.filegroup(
        name = "common_files",
        srcs = [
            ":Sdk/ArgumentFormatter.cs",
            ":Sdk/AssertEqualityComparer.cs",
            ":Sdk/AssertEqualityComparerAdapter.cs",
        ],
        visibility = ["//visibility:public"],
    )
    native.filegroup(
        name = "test_files",
        srcs = [
            ":Sdk/ArgumentFormatter.cs",
        ],
        visibility = ["//visibility:public"],
    )
