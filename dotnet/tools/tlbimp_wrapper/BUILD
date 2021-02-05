load(
    "@rules_mono//dotnet:defs.bzl",
    "DOTNET_NET_FRAMEWORKS",
    "net_binary",
)

[net_binary(
    name = "tlbimp_wrapper_{}.exe".format(framework),
    srcs = [
        "Program.cs",
    ],
    dotnet_context_data = "@rules_mono//:net_context_data_{}".format(framework),
    visibility = ["//visibility:public"],
    deps = [
        "@rules_mono//dotnet/stdlib.net/{}:system.dll".format(framework),
    ],
) for framework in DOTNET_NET_FRAMEWORKS]
