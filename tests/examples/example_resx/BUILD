load("@io_bazel_rules_dotnet//dotnet:defs.bzl", "core_xunit_test", "net_xunit_test", "dotnet_xunit_test", "net_resx", "core_resx", "dotnet_resx")

core_resx(
    name = "core.resx",
    src = "Resources.resx",
    identifier="example_resx.Resources.resources",
)

core_xunit_test(
    name = "example_resx",
    srcs = glob(["*.cs"]),
    deps = [
        "@xunit.extensibility.core//:core",
        "@xunit.assert//:core",
        "@xunit.extensibility.execution//:core",
    ],
    size = "small",
    resources = [":core.resx"],
)

net_resx(
    name = "net.resx",
    src = "Resources.resx",
    identifier="example_resx.Resources.resources",
)

net_xunit_test(
    name = "net.example_resx",
    srcs = glob(["*.cs"]),
    deps = [
        "@io_bazel_rules_dotnet//dotnet/stdlib.net:system.runtime.dll",
        "@xunit.extensibility.core//:net",
        "@xunit.assert//:net",
        "@xunit.extensibility.execution//:net",
    ],
    size = "small",
    resources = [":net.resx"],
)

dotnet_resx(
    name = "mono.resx",
    src = "Resources.resx",
    identifier="example_resx.Resources.resources",
)

dotnet_xunit_test(
    name = "mono.example_resx",
    srcs = glob(["*.cs"]),
    deps = [
        "@io_bazel_rules_dotnet//dotnet/stdlib:system.runtime.dll",
        "@io_bazel_rules_dotnet//dotnet/stdlib:System.dll",
        "@xunit.extensibility.core//:mono",
        "@xunit.assert//:mono",
        "@xunit.extensibility.execution//:mono",
    ],
    size = "small",
    resources = [":mono.resx"],
)
