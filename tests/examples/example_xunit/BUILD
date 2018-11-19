load("@io_bazel_rules_dotnet//dotnet:defs.bzl", "core_xunit_test", "net_xunit_test")

core_xunit_test(
    name = "example_xunit",
    srcs = [
        "MyTest.cs",
    ],
    deps = [
        "@xunit.extensibility.core//:core",
        "@xunit.assert//:core",
        "@xunit.extensibility.execution//:core",
    ],
    size = "small",
)

net_xunit_test(
    name = "net.example_xunit",
    srcs = [
        "MyTest.cs",
    ],
    deps = [
        "@io_bazel_rules_dotnet//dotnet/stdlib.net:system.runtime.dll",
        "@xunit.extensibility.core//:net",
        "@xunit.assert//:net",
        "@xunit.extensibility.execution//:net",
    ],
    size = "small",
)
