load("@io_bazel_rules_dotnet//dotnet:defs.bzl", "dotnet_nunit_test", "net_nunit_test", "net_nunit3_test")

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

net_nunit_test(
    name = "net.example_test",
    srcs = [
        "MyTest.cs",
    ],
    deps = [
        "//tests/examples/example_lib:MyClass-net",
        "@nunit2//:net.nunit.framework",
    ],
    size = "small",
)
net_nunit3_test(
    name = "net.example_test3",
    srcs = [
        "MyTest.cs",
    ],
    deps = [
        "//tests/examples/example_lib:MyClass-net",
        "@nunit3//:lib",
    ],
    size = "small",
)
