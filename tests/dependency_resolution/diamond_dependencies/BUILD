load(
    "@rules_dotnet//dotnet:defs.bzl",
    "csharp_library",
    "csharp_nunit_test",
)

csharp_nunit_test(
    name = "a",
    srcs = ["a.cs"],
    target_frameworks = ["net6.0"],
    deps = [
        ":a_b",
        ":a_c",
        "@rules_dotnet_test_deps//microsoft.netcore.app.ref",
    ],
)

csharp_library(
    name = "a_b",
    srcs = ["a_b.cs"],
    target_frameworks = ["net6.0"],
    deps = [
        ":d",
        "@rules_dotnet_test_deps//microsoft.netcore.app.ref",
    ],
)

csharp_library(
    name = "a_c",
    srcs = ["a_c.cs"],
    target_frameworks = ["netstandard2.1"],
    deps = [
        ":d",
        "@rules_dotnet_test_deps//microsoft.netcore.app.ref",
    ],
)

csharp_library(
    name = "d",
    srcs = ["d.cs"],
    target_frameworks = [
        "net6.0",
        "netstandard2.1",
    ],
    deps = ["@rules_dotnet_test_deps//microsoft.netcore.app.ref"],
)
