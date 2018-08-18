load("@io_bazel_rules_dotnet//dotnet:defs.bzl", "dotnet_nunit_test")

dotnet_nunit_test(
    name = "example_test",
    srcs = [
        "MyTest.cs",
    ],
    deps = [
        "//tests/examples/example_lib:MyClass",
        "@nunit2//:nunit.framework",
    ],
    size = "small",
)
