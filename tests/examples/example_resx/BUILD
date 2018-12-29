load(
    "@io_bazel_rules_dotnet//dotnet:defs.bzl",
    "DOTNET_CORE_FRAMEWORKS",
    "DOTNET_NET_FRAMEWORKS",
    "core_resx",
    "core_xunit_test",
    "dotnet_resx",
    "dotnet_xunit_test",
    "net_resx",
    "net_xunit_test",
)

[core_resx(
    name = "{}_core.resx".format(framework),
    src = "Resources.resx",
    dotnet_context_data = "@io_bazel_rules_dotnet//:core_context_data_{}".format(framework),
    identifier = "example_resx.Resources.resources",
    simpleresgen = "@io_bazel_rules_dotnet//tools/simpleresgen:{}_simpleresgen".format(framework),
) for framework in DOTNET_CORE_FRAMEWORKS]

[core_xunit_test(
    name = "{}_example_resx".format(framework),
    size = "small",
    srcs = glob(["*.cs"]),
    dotnet_context_data = "@io_bazel_rules_dotnet//:core_context_data_{}".format(framework),
    native_deps = "@core_sdk_{}//:native_deps".format(framework),
    resources = [":{}_core.resx".format(framework)],
    testlauncher = "@{}_xunit//:xunit.console".format(framework),
    deps = [
        "@{}_xunit_assert//:assert.xunit".format(framework),
        "@{}_xunit//:xunit.core".format(framework),
    ],
) for framework in DOTNET_CORE_FRAMEWORKS]

[net_resx(
    name = "{}_net.resx".format(framework),
    src = "Resources.resx",
    dotnet_context_data = "@io_bazel_rules_dotnet//:net_context_data_{}".format(framework),
    identifier = "example_resx.Resources.resources",
) for framework in [
    "net45",
    "net451",
    "net452",
    "net46",
    "net461",
    "net462",
    "net47",
    "net471",
    "net472",
    "netstandard1.1",
    "netstandard1.2",
    "netstandard1.3",
    "netstandard1.4",
    "netstandard1.5",
    "netstandard1.6",
    "netstandard2.0",
]]

[net_xunit_test(
    name = "net.example_resx_{}".format(framework),
    size = "small",
    srcs = glob(["*.cs"]),
    dotnet_context_data = "@io_bazel_rules_dotnet//:net_context_data_{}".format(framework),
    native_deps = "@net_sdk_{}//:native_deps".format(framework),
    resources = [":{}_net.resx".format(framework)],
    deps = [
        "@io_bazel_rules_dotnet//dotnet/stdlib.net/{}:system.dll".format(framework),
        "@io_bazel_rules_dotnet//dotnet/stdlib.net/{}:system.runtime.dll".format(framework),
        "@xunit.assert//:{}_net".format(framework),
        "@xunit.extensibility.core//:{}_net".format(framework),
        "@xunit.extensibility.execution//:{}_net".format(framework),
    ],
) for framework in [
    "net45",
    "net451",
    "net452",
    "net46",
    "net461",
    "net462",
    "net47",
    "net471",
    "net472",
    "netstandard1.1",
    "netstandard1.2",
    "netstandard1.3",
    "netstandard1.4",
    "netstandard1.5",
    "netstandard1.6",
    "netstandard2.0",
]]

dotnet_resx(
    name = "mono.resx",
    src = "Resources.resx",
    identifier = "example_resx.Resources.resources",
)

dotnet_xunit_test(
    name = "mono.example_resx",
    size = "small",
    srcs = glob(["*.cs"]),
    resources = [":mono.resx"],
    deps = [
        "@io_bazel_rules_dotnet//dotnet/stdlib:System.dll",
        "@io_bazel_rules_dotnet//dotnet/stdlib:system.runtime.dll",
        "@xunit.assert//:mono",
        "@xunit.extensibility.core//:mono",
        "@xunit.extensibility.execution//:mono",
    ],
)
