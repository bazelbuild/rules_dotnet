load(
    "@rules_dotnet//dotnet:defs.bzl",
    "csharp_nunit_test",
)

csharp_nunit_test(
    name = "netcore",
    srcs = ["netcore.cs"],
    target_framework = "net6.0",
    deps = [
        "//tests/dependency_resolution/netcore_to_netstandard/netstandardlib",
        "@rules_dotnet_test_deps//microsoft.netcore.app.ref",
    ],
)
