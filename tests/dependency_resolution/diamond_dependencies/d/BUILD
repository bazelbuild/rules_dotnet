load(
    "@rules_dotnet//dotnet:defs.bzl",
    "csharp_library",
)

csharp_library(
    name = "d",
    srcs = ["d.cs"],
    private_deps = select({
        "@rules_dotnet//dotnet:tfm_net6.0": ["@rules_dotnet_test_deps//microsoft.netcore.app.ref"],
        "@rules_dotnet//dotnet:tfm_netstandard2.1": ["@rules_dotnet_test_deps//netstandard.library.ref"],
    }),
    target_frameworks = [
        "net6.0",
        "netstandard2.1",
    ],
    visibility = ["//visibility:public"],
    deps = [],
)
