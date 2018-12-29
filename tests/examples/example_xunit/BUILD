load("@io_bazel_rules_dotnet//dotnet:defs.bzl", "core_xunit_test", "dotnet_xunit_test", "net_xunit_test", "DOTNET_NET_FRAMEWORKS", "DOTNET_CORE_FRAMEWORKS")

[core_xunit_test(
    name = "{}_example_xunit".format(framework),
    size = "small",
    srcs = [
        "MyTest.cs",
    ],
    deps = [
        "@{}_xunit//:xunit.core".format(framework),
        "@{}_xunit_assert//:assert.xunit".format(framework),
    ],
    dotnet_context_data = "@io_bazel_rules_dotnet//:core_context_data_{}".format(framework),
    native_deps = "@core_sdk_{}//:native_deps".format(framework),
    testlauncher = "@{}_xunit//:xunit.console".format(framework),
) for framework in DOTNET_CORE_FRAMEWORKS]

[net_xunit_test(
    name = "net.example_xunit_{}".format(framework),
    size = "small",
    srcs = [
        "MyTest.cs",
    ],
    deps = [
        "@io_bazel_rules_dotnet//dotnet/stdlib.net:{}_system.runtime.dll".format(framework),
        "@xunit.assert//:{}_net".format(framework),
        "@xunit.extensibility.core//:{}_net".format(framework),
        "@xunit.extensibility.execution//:{}_net".format(framework),
    ],
) for framework in ["net45", "net451", "net452","net46","net461","net462","net47","net471","net472","netstandard1.1",
    "netstandard1.2","netstandard1.3","netstandard1.4","netstandard1.5","netstandard1.6","netstandard2.0"]]

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
