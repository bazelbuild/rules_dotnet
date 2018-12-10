load("@io_bazel_rules_dotnet//dotnet:defs.bzl", "dotnet_nunit_test")

dotnet_nunit_test(
    name = "empty_test",
    srcs = [
        "main_test.cs",
    ],
    deps = [
        "@nunit2//:nunit.framework",
        "@npgsql//:lib",
        "@commandlineparser//:lib",
        "@nuget.frameworks//:mono",
        "@nuget.common//:mono",
    ],
    size = "small",
)
