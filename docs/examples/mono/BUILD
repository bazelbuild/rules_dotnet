load("@io_bazel_rules_dotnet//dotnet:defs.bzl", "dotnet_nunit_test")

dotnet_nunit_test(
    name = "test_lib.dll",
    srcs = ["a.cs"],
    deps = [
        "@io_bazel_rules_dotnet//dotnet/stdlib:system.dll",
        "@moq//:mono",
        "@newtonsoft.json//:mono",
        "@nunitv2//:netstandard1.0_net",
    ],
)
