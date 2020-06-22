load(
    "@io_bazel_rules_dotnet//dotnet:defs.bzl",
    "DOTNET_NET_FRAMEWORKS",
    "net_binary",
)

[net_binary(
    name = "tlbimp_wrapper_{}.exe".format(framework),
    srcs = [
        "Program.cs",
    ],
    dotnet_context_data = "@io_bazel_rules_dotnet//:net_context_data_{}".format(framework),
    visibility = ["//visibility:public"],
    deps = [
        "@io_bazel_rules_dotnet//dotnet/stdlib.net/{}:system.dll".format(framework),
    ],
) for framework in DOTNET_NET_FRAMEWORKS]
