load(
    "@rules_dotnet//dotnet:defs.bzl",
    "csharp_library",
)

csharp_library(
    name = "d",
    srcs = ["d.cs"],
    target_frameworks = [
        "net6.0",
        "netstandard2.1",
    ],
    visibility = ["//visibility:public"],
    deps = ["@rules_dotnet_test_deps//microsoft.netcore.app.ref"],
)
