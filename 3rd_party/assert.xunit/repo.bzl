load("@io_bazel_rules_dotnet//dotnet:defs.bzl", "core_library", "core_binary", "core_resource","DOTNET_CORE_FRAMEWORKS")

[core_library(
    name = "{}_assert.xunit".format(framework),
    srcs = glob(["**/*.cs"]),
    visibility = ["//visibility:public"],
    deps = [
        "@io_bazel_rules_dotnet//dotnet/stdlib.core:{}_system.runtime.dll".format(framework),
        "@io_bazel_rules_dotnet//dotnet/stdlib.core:{}_system.private.corelib.dll".format(framework),
        "@io_bazel_rules_dotnet//dotnet/stdlib.core:{}_system.linq.dll".format(framework),
        "@io_bazel_rules_dotnet//dotnet/stdlib.core:{}_system.text.regularexpressions.dll".format(framework),
        "@io_bazel_rules_dotnet//dotnet/stdlib.core:{}_system.objectmodel.dll".format(framework),
    ],
    dotnet_context_data = "@io_bazel_rules_dotnet//:core_context_data_{}".format(framework),
) for framework in DOTNET_CORE_FRAMEWORKS]

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
