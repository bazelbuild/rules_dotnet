load("@io_bazel_rules_dotnet//dotnet:defs.bzl", "core_xunit_test", "dotnet_xunit_test", "net_xunit_test")

core_xunit_test(
    name = "example_xunit",
    size = "small",
    srcs = [
        "MyTest.cs",
    ],
    deps = [
        "@xunit.assert//:core",
        "@xunit.extensibility.core//:core",
        "@xunit.extensibility.execution//:core",
    ],
)

net_xunit_test(
    name = "net.example_xunit",
    size = "small",
    srcs = [
        "MyTest.cs",
    ],
    deps = [
        "@io_bazel_rules_dotnet//dotnet/stdlib.net:system.runtime.dll",
        "@xunit.assert//:net",
        "@xunit.extensibility.core//:net",
        "@xunit.extensibility.execution//:net",
    ],
)

dotnet_xunit_test(
    name = "mono.example_xunit",
    size = "small",
    srcs = [
        "MyTest.cs",
    ],
    deps = [
        "@io_bazel_rules_dotnet//dotnet/stdlib:system.runtime.dll",
        "@xunit.assert//:mono",
        "@xunit.extensibility.core//:mono",
        "@xunit.extensibility.execution//:mono",
    ],
)
