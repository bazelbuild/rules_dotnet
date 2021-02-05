load("@io_bazel_rules_dotnet//dotnet:defs.bzl", "DOTNET_NETSTANDARD", "core_library", "core_xunit_test", "net_library")

[core_library(
    name = "{}_lib.dll".format(framework),
    srcs = ["Lib.cs"],
    target_framework = framework,
    deps = [
        "@io_bazel_rules_dotnet//dotnet/stdlib.core:NETStandard.Library",
    ],
) for framework in DOTNET_NETSTANDARD.keys()]

[net_library(
    name = "{}_net_lib.dll".format(framework),
    srcs = ["Lib.cs"],
    target_framework = framework,
    deps = [
        "@io_bazel_rules_dotnet//dotnet/stdlib.net:netstandard.dll",
    ],
) for framework in DOTNET_NETSTANDARD.keys()]

[core_xunit_test(
    name = "{}_core_core.dll".format(framework),
    srcs = [
        "XUnitTest.cs",
    ],
    deps = [
        "{}_lib.dll".format(framework),
        "@io_bazel_rules_dotnet//dotnet/stdlib.core:NETStandard.Library",
        "@xunit.assert//:netcoreapp2.0_core",
        "@xunit.extensibility.core//:netcoreapp2.0_core",
        "@xunit.extensibility.execution//:netcoreapp2.0_core",
    ],
) for framework in DOTNET_NETSTANDARD.keys()]

# [core_xunit_test(
#     name = "{}_core_net.dll".format(framework),
#     srcs = [
#         "XUnitTest.cs",
#     ],
#     deps = [
#         "{}_net_lib.dll".format(framework),
#         "@io_bazel_rules_dotnet//dotnet/stdlib.core:NETStandard.Library",
#         "@xunit.assert//:netcoreapp2.0_core",
#         "@xunit.extensibility.core//:netcoreapp2.0_core",
#         "@xunit.extensibility.execution//:netcoreapp2.0_core",
#     ],
# ) for framework in DOTNET_NETSTANDARD.keys()]

# [net_xunit_test(
#     name = "{}_net_core.dll".format(framework),
#     srcs = [
#         "XUnitTest.cs",
#     ],
#     deps = [
#         "{}_lib.dll".format(framework),
#         "@xunit.assert//:netcoreapp2.0_core",
#         "@xunit.extensibility.core//:netcoreapp2.0_core",
#         "@xunit.extensibility.execution//:netcoreapp2.0_core",
#     ],
# ) for framework in DOTNET_NETSTANDARD.keys()]
