load("@io_bazel_rules_dotnet//dotnet:defs.bzl", "DOTNET_CORE_FRAMEWORKS", "core_xunit_test", "dotnet_xunit_test", "net_xunit_test")

[core_xunit_test(
    name = "{}_example_xunit.dll".format(framework),
    size = "medium",
    srcs = [
        "MyTest.cs",
    ],
    dotnet_context_data = "@io_bazel_rules_dotnet//:core_context_data_{}".format(framework),
    langversion = "7.3",
    testlauncher = "@xunit.runner.console//:netcoreapp2.0_core_tool",
    deps = [
        "@io_bazel_rules_dotnet//dotnet/stdlib.core/{}:libraryset".format(framework),
        "@xunit.assert//:netcoreapp2.0_core",
        "@xunit.extensibility.core//:netcoreapp2.0_core",
        "@xunit.extensibility.execution//:netcoreapp2.0_core",
    ],
) for framework in DOTNET_CORE_FRAMEWORKS]

[net_xunit_test(
    name = "net.example_xunit_{}.dll".format(framework),
    size = "medium",
    srcs = [
        "MyTest.cs",
    ],
    dotnet_context_data = "@io_bazel_rules_dotnet//:net_context_data_{}".format(framework),
    testlauncher = "@xunit.runner.console//:{}_net_tool".format(framework),
    deps = [
        "@io_bazel_rules_dotnet//dotnet/stdlib.net/{}:system.runtime.dll".format(framework),
        "@xunit.assert//:netstandard1.1_net",
        "@xunit.extensibility.core//:netstandard1.1_net",
        "@xunit.extensibility.execution//:netstandard1.1_net",
    ],
) for framework in [
    #"net45",
    #"net451",
    "net452",
    "net46",
    "net461",
    "net462",
    "net47",
    "net471",
    "net472",
    # "netstandard1.1",
    # "netstandard1.2",
    # "netstandard1.3",
    # "netstandard1.4",
    # "netstandard1.5",
    # "netstandard1.6",
    # "netstandard2.0",
]]

dotnet_xunit_test(
    name = "mono.example_xunit.dll",
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
