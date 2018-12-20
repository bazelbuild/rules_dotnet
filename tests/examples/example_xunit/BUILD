load("@io_bazel_rules_dotnet//dotnet:defs.bzl", "core_xunit_test", "dotnet_xunit_test", "net_xunit_test", "DOTNET_NET_FRAMEWORKS")

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

[net_xunit_test(
    name = "net.example_xunit_{}".format(framework),
    size = "small",
    srcs = [
        "MyTest.cs",
    ],
    deps = [
        "@io_bazel_rules_dotnet//dotnet/stdlib.net:{}_system.runtime.dll".format(framework),
        "@xunit.assert//:net",
        "@xunit.extensibility.core//:net",
        "@xunit.extensibility.execution//:net",
    ],
) for framework in DOTNET_NET_FRAMEWORKS]

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
