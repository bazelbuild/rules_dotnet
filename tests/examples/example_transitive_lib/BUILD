load("@io_bazel_rules_dotnet//dotnet:defs.bzl", "DOTNET_CORE_FRAMEWORKS", "DOTNET_NET_FRAMEWORKS", "core_library", "dotnet_library", "net_library")

dotnet_library(
    name = "TransitiveClass.dll",
    srcs = [
        "Properties/AssemblyInfo.cs",
        "TransitiveClass.cs",
    ],
    nowarn = ["CS0618"],
    visibility = ["//visibility:public"],
    deps = [
        "@io_bazel_rules_dotnet//dotnet/stdlib:system.dll",
    ],
)

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

[net_library(
    name = "TransitiveClass-net_{}.dll".format(framework),
    srcs = [
        "TransitiveClass.cs",
    ],
    dotnet_context_data = "@io_bazel_rules_dotnet//:net_context_data_{}".format(framework),
    nowarn = ["CS0618"],
    visibility = ["//visibility:public"],
    deps = [
        "@io_bazel_rules_dotnet//dotnet/stdlib.net:system.dll",
    ],
) for framework in DOTNET_NET_FRAMEWORKS]
