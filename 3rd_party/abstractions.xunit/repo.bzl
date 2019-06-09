load("@io_bazel_rules_dotnet//dotnet:defs.bzl", "core_binary", "core_library", "core_resource")

def buildall(framework):
    core_library(
        name = "abstractions.xunit.dll",
        srcs = native.glob(["**/*.cs"]),
        visibility = ["//visibility:public"],
        deps = [
            "@io_bazel_rules_dotnet//dotnet/stdlib.core/{}:system.runtime.dll".format(framework),
            "@io_bazel_rules_dotnet//dotnet/stdlib.core/{}:system.private.corelib.dll".format(framework),
        ],
        dotnet_context_data = "@io_bazel_rules_dotnet//:core_context_data_{}".format(framework),
    )
