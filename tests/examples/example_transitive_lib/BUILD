load("@io_bazel_rules_dotnet//dotnet:defs.bzl", "core_library", "dotnet_library", "net_library", "DOTNET_NET_FRAMEWORKS", "DOTNET_CORE_FRAMEWORKS")

dotnet_library(
    name = "TransitiveClass",
    srcs = [
        "Properties/AssemblyInfo.cs",
        "TransitiveClass.cs",
    ],
    visibility = ["//visibility:public"],
)

[core_library(
    name = "{}_TransitiveClass-core".format(framework),
    srcs = [
        "TransitiveClass.cs",
    ],
    visibility = ["//visibility:public"],
    deps = [
        "@io_bazel_rules_dotnet//dotnet/stdlib.core:{}_system.private.corelib.dll".format(framework),
        "@io_bazel_rules_dotnet//dotnet/stdlib.core:{}_system.runtime.dll".format(framework),
    ],
    dotnet_context_data = "@io_bazel_rules_dotnet//:core_context_data_{}".format(framework),
) for framework in DOTNET_CORE_FRAMEWORKS]

[net_library(
    name = "TransitiveClass-net_{}".format(framework),
    srcs = [
        "TransitiveClass.cs",
    ],
    visibility = ["//visibility:public"],
    deps = [
    ],
    dotnet_context_data = "@io_bazel_rules_dotnet//:net_context_data_{}".format(framework),
) for framework in DOTNET_NET_FRAMEWORKS]
