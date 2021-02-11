load("@io_bazel_rules_dotnet//dotnet:defs.bzl", "DOTNET_NETSTANDARD", "csharp_library", "csharp_xunit_test")

[csharp_library(
    name = "{}_lib.dll".format(framework),
    srcs = ["Lib.cs"],
    target_compatible_with = select({
        "@io_bazel_rules_dotnet//dotnet/toolchain:3.0.100": [],
        "@io_bazel_rules_dotnet//dotnet/toolchain:3.1.100": [],
        "//conditions:default": ["@platforms//:incompatible"],
    }),
    target_framework = framework,
    deps = [
        "@core_sdk_stdlib//:NETStandard.Library",
    ],
) for framework in DOTNET_NETSTANDARD.keys()]

[csharp_xunit_test(
    name = "{}_core_core.dll".format(framework),
    srcs = [
        "XUnitTest.cs",
    ],
    target_compatible_with = select({
        "@io_bazel_rules_dotnet//dotnet/toolchain:3.0.100": [],
        "@io_bazel_rules_dotnet//dotnet/toolchain:3.1.100": [],
        "//conditions:default": ["@platforms//:incompatible"],
    }),
    deps = [
        "{}_lib.dll".format(framework),
        "@xunit.assert//:lib",
        "@xunit.extensibility.core//:lib",
        "@xunit.extensibility.execution//:lib",
    ],
) for framework in DOTNET_NETSTANDARD.keys()]
