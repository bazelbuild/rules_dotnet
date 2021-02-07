load(
    "@io_bazel_rules_dotnet//dotnet:defs.bzl",
    "core_resx",
    "core_xunit_test",
)

core_resx(
    name = "core.resx",
    src = "Resources.resx",
    identifier = "example_resx.Resources.resources",
)

core_xunit_test(
    name = "example_resx.dll",
    size = "medium",
    srcs = glob(["*.cs"]),
    resources = [":core.resx"],
    deps = [
        "@core_sdk_stdlib//:libraryset",
        "@xunit.assert//:netcoreapp2.0_core",
        "@xunit.extensibility.core//:netcoreapp2.0_core",
        "@xunit.extensibility.execution//:netcoreapp2.0_core",
    ],
)
