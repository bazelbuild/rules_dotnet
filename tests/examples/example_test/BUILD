load("@io_bazel_rules_dotnet//dotnet:defs.bzl", "dotnet_nunit_test", "net_nunit3_test", "net_nunit_test")

dotnet_nunit_test(
    name = "example_test",
    size = "small",
    srcs = [
        "MyTest.cs",
    ],
    deps = [
        "//tests/examples/example_lib:MyClass",
        "@nunit2//:nunit.framework",
    ],
)

net_nunit_test(
    name = "net.example_test",
    size = "small",
    srcs = [
        "MyTest.cs",
    ],
    deps = [
        "//tests/examples/example_lib:MyClass-net",
        "@nunit2//:net.nunit.framework",
    ],
)

net_nunit3_test(
    name = "net.example_test3",
    size = "small",
    srcs = [
        "MyTest.cs",
    ],
    deps = [
        "//tests/examples/example_lib:MyClass-net",
        "@nunit3//:lib",
    ],
)
