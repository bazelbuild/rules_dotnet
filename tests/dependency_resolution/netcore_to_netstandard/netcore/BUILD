load(
    "@rules_dotnet//dotnet:defs.bzl",
    "csharp_nunit_test",
)

csharp_nunit_test(
    name = "netcore",
    srcs = ["netcore.cs"],
    private_deps = [
        "@rules_dotnet_test_deps//microsoft.netcore.app.ref",
    ],
    target_frameworks = ["net6.0"],
    deps = [
        "//tests/dependency_resolution/netcore_to_netstandard/netstandardlib",
    ],
)
