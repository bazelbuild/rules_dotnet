load("@io_bazel_rules_dotnet//dotnet:defs.bzl", "core_resx", "core_xunit_test", "dotnet_resx", "dotnet_xunit_test", "net_resx", "net_xunit_test")

core_resx(
    name = "core.resx",
    src = "Resources.resx",
    identifier = "example_resx.Resources.resources",
)

core_xunit_test(
    name = "example_resx",
    size = "small",
    srcs = glob(["*.cs"]),
    resources = [":core.resx"],
    deps = [
        "@xunit.assert//:core",
        "@xunit.extensibility.core//:core",
        "@xunit.extensibility.execution//:core",
    ],
)

net_resx(
    name = "net.resx",
    src = "Resources.resx",
    identifier = "example_resx.Resources.resources",
)

net_xunit_test(
    name = "net.example_resx",
    size = "small",
    srcs = glob(["*.cs"]),
    resources = [":net.resx"],
    deps = [
        "@io_bazel_rules_dotnet//dotnet/stdlib.net:system.dll",
        "@io_bazel_rules_dotnet//dotnet/stdlib.net:system.runtime.dll",
        "@xunit.assert//:net",
        "@xunit.extensibility.core//:net",
        "@xunit.extensibility.execution//:net",
    ],
)

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
