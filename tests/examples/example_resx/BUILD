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
    simpleresgen = "@io_bazel_rules_dotnet//tools/simpleresgen:{}_simpleresgen.exe".format(framework),
) for framework in DOTNET_CORE_FRAMEWORKS]

[core_xunit_test(
    name = "{}_example_resx.dll".format(framework),
    size = "medium",
    srcs = glob(["*.cs"]),
    dotnet_context_data = "@io_bazel_rules_dotnet//:core_context_data_{}".format(framework),
    resources = [":{}_core.resx".format(framework)],
    testlauncher = "@xunit.runner.console//:netcoreapp2.0_core_tool",
    deps = [
        "@io_bazel_rules_dotnet//dotnet/stdlib.core/{}:libraryset".format(framework),
        "@xunit.assert//:netcoreapp2.0_core",
        "@xunit.extensibility.core//:netcoreapp2.0_core",
        "@xunit.extensibility.execution//:netcoreapp2.0_core",
    ],
) for framework in DOTNET_CORE_FRAMEWORKS]

[net_resx(
    name = "{}_net.resx".format(framework),
    src = "Resources.resx",
    dotnet_context_data = "@io_bazel_rules_dotnet//:net_context_data_{}".format(framework),
    identifier = "example_resx.Resources.resources",
) for framework in DOTNET_NET_FRAMEWORKS]

[net_xunit_test(
    name = "net.example_resx_{}.dll".format(framework),
    size = "medium",
    srcs = glob(["*.cs"]),
    dotnet_context_data = "@io_bazel_rules_dotnet//:net_context_data_{}".format(framework),
    resources = [":{}_net.resx".format(framework)],
    testlauncher = "@xunit.runner.console//:{}_net_tool".format(framework),
    deps = [
        "@io_bazel_rules_dotnet//dotnet/stdlib.net/{}:system.dll".format(framework),
        "@io_bazel_rules_dotnet//dotnet/stdlib.net/{}:system.runtime.dll".format(framework),
        "@xunit.assert//:{}_net".format(framework),
        "@xunit.extensibility.core//:{}_net".format(framework),
        "@xunit.extensibility.execution//:{}_net".format(framework),
    ],
) for framework in [
    # "net45",
    # "net451",
    "net452",
    "net46",
    "net461",
    "net462",
    "net47",
    #"net471",
    #"net472",
]]

dotnet_resx(
    name = "mono.resx",
    src = "Resources.resx",
    identifier = "example_resx.Resources.resources",
)

dotnet_xunit_test(
    name = "mono.example_resx.dll",
    size = "small",
    srcs = glob(["*.cs"]),
    resources = [":mono.resx"],
    deps = [
        "@io_bazel_rules_dotnet//dotnet/stdlib:system.runtime.dll",
        "@xunit.assert//:mono",
        "@xunit.extensibility.core//:mono",
        "@xunit.extensibility.execution//:mono",
    ],
)
