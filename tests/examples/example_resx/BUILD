load("@io_bazel_rules_dotnet//dotnet:defs.bzl", "core_resx", "core_xunit_test", "dotnet_resx", "dotnet_xunit_test", "net_resx", "net_xunit_test", "DOTNET_NET_FRAMEWORKS")

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

[net_xunit_test(
    name = "net.example_resx_{}".format(framework),
    size = "small",
    srcs = glob(["*.cs"]),
    resources = [":net.resx"],
    deps = [
        "@io_bazel_rules_dotnet//dotnet/stdlib.net:{}_system.dll".format(framework),
        "@io_bazel_rules_dotnet//dotnet/stdlib.net:{}_system.runtime.dll".format(framework),
        "@xunit.assert//:{}_net".format(framework),
        "@xunit.extensibility.core//:{}_net".format(framework),
        "@xunit.extensibility.execution//:{}_net".format(framework),
    ],
) for framework in ["net45", "net451", "net452","net46","net461","net462","net47","net471","net472","netstandard1.1",
    "netstandard1.2","netstandard1.3","netstandard1.4","netstandard1.5","netstandard1.6","netstandard2.0"]]

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
