load("@io_bazel_rules_dotnet//dotnet:defs.bzl", "csharp_xunit_test")

csharp_xunit_test(
    name = "nuget2bazel-test.dll",
    size = "medium",
    srcs = glob(["*.cs"]),
    nowarn = ["CS1701"],
    target_compatible_with = select({
        "//dotnet/toolchain:3.1.100": [],
        "//dotnet/toolchain:3.1.407": [],
        # There is an issue with nuget2Bazel on .Net > 3.1
        # The plan is to replace nuget2bazel with a more robust tool so the test is disabled for now
        # "//dotnet/toolchain:5.0.201": [],
        # "//dotnet/toolchain:5.0.404": [],
        # "//dotnet/toolchain:6.0.101": [],
        "//conditions:default": ["@platforms//:incompatible"],
    }),
    deps = [
        "//tools/nuget2bazel:nuget2bazel.exe",
        "@xunit.assert//:lib",
        "@xunit.extensibility.core//:lib",
        "@xunit.extensibility.execution//:lib",
    ],
)
