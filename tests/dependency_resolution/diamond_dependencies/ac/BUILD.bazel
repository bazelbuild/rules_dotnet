load(
    "@rules_dotnet//dotnet:defs.bzl",
    "csharp_library",
)

csharp_library(
    name = "ac",
    srcs = ["ac.cs"],
    private_deps = [
        "@rules_dotnet_test_deps//netstandard.library.ref",
    ],
    target_frameworks = ["netstandard2.1"],
    visibility = ["//visibility:public"],
    deps = [
        "//tests/dependency_resolution/diamond_dependencies/d",
    ],
)
