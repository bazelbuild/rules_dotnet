load("@io_bazel_rules_dotnet//dotnet:defs.bzl", "DOTNET_CORE_FRAMEWORKS", "core_library")

[core_library(
    name = "{}_TransitiveClass-core.dll".format(framework),
    srcs = [
        "TransitiveClass.cs",
    ],
    dotnet_context_data = "@io_bazel_rules_dotnet//:core_context_data_{}".format(framework),
    nowarn = [
        "CS0618",
        "CS0612",
    ],
    visibility = ["//visibility:public"],
    deps = [
        "@io_bazel_rules_dotnet//dotnet/stdlib.core/{}:libraryset".format(framework),
    ],
) for framework in DOTNET_CORE_FRAMEWORKS]

core_library(
    name = "TransitiveClass-core-netstandard.dll",
    srcs = [
        "TransitiveClass.cs",
    ],
    target_framework = "netstandard2.0",
    visibility = ["//visibility:public"],
    deps = [
        "@io_bazel_rules_dotnet//dotnet/stdlib.core:NETStandard.Library",
    ],
)

core_library(
    name = "TransitiveClass-core-v2.1.200-netstandard.dll",
    srcs = [
        "TransitiveClass.cs",
    ],
    target_framework = "netstandard2.0",
    visibility = ["//visibility:public"],
    deps = [
        "@io_bazel_rules_dotnet//dotnet/stdlib.core/v2.1.200:netstandard.dll",
    ],
)
