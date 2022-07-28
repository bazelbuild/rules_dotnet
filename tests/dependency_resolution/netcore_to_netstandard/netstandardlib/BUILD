load(
    "@rules_dotnet//dotnet:defs.bzl",
    "csharp_library",
)

csharp_library(
    name = "netstandardlib",
    srcs = ["netstandardlib.cs"],
    target_frameworks = ["netstandard2.1"],
    visibility = ["//visibility:public"],
    deps = [
        "@rules_dotnet_test_deps//netstandard.library.ref",
    ],
)
