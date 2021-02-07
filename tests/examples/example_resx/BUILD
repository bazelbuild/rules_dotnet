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
        "@xunit.assert//:lib",
        "@xunit.extensibility.core//:lib",
        "@xunit.extensibility.execution//:lib",
    ],
)
