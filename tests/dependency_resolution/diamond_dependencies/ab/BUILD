load(
    "@rules_dotnet//dotnet:defs.bzl",
    "csharp_library",
    "csharp_nunit_test",
)

csharp_library(
    name = "ab",
    srcs = ["ab.cs"],
    target_frameworks = ["net6.0"],
    visibility = ["//visibility:public"],
    deps = [
        "//tests/dependency_resolution/diamond_dependencies/d",
        "@rules_dotnet_test_deps//microsoft.netcore.app.ref",
    ],
)
