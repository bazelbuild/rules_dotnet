load(
    "@rules_dotnet//dotnet:defs.bzl",
    "csharp_library",
)

csharp_library(
    name = "ac",
    srcs = ["ac.cs"],
    target_frameworks = ["netstandard2.1"],
    visibility = ["//visibility:public"],
    deps = [
        "//tests/dependency_resolution/diamond_dependencies/d",
        "@rules_dotnet_test_deps//microsoft.netcore.app.ref",
    ],
)
