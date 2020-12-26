load(
    "@io_bazel_rules_dotnet//dotnet:defs.bzl",
    "DOTNET_CORE_FRAMEWORKS",
    "core_resx",
    "core_xunit_test",
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

