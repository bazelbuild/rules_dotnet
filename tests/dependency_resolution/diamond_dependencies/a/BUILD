load(
    "@rules_dotnet//dotnet:defs.bzl",
    "csharp_nunit_test",
)

csharp_nunit_test(
    name = "a",
    srcs = ["a.cs"],
    private_deps = [
        "@rules_dotnet_test_deps//microsoft.netcore.app.ref",
    ],
    target_frameworks = ["net6.0"],
    deps = [
        "//tests/dependency_resolution/diamond_dependencies/ab",
        "//tests/dependency_resolution/diamond_dependencies/ac",
        "//tests/dependency_resolution/diamond_dependencies/d",
    ],
)
