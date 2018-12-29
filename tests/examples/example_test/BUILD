load("@io_bazel_rules_dotnet//dotnet:defs.bzl", "dotnet_nunit_test", "net_nunit3_test", "net_nunit_test", "DOTNET_NET_FRAMEWORKS")

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

[net_nunit_test(
    name = "net.example_test_{}".format(framework),
    size = "small",
    srcs = [
        "MyTest.cs",
    ],
    deps = [
        "//tests/examples/example_lib:MyClass-net_{}".format(framework),
        "@nunit2//:net.nunit.framework",
    ],
    dotnet_context_data = "@io_bazel_rules_dotnet//:net_context_data_{}".format(framework),
    native_deps = "@net_sdk_{}//:native_deps".format(framework),
)  for framework in DOTNET_NET_FRAMEWORKS]

[net_nunit3_test(
    name = "net.example_test3_{}".format(framework),
    size = "small",
    srcs = [
        "MyTest.cs",
    ],
    deps = [
        "//tests/examples/example_lib:MyClass-net_{}".format(framework),
        "@nunit3//:lib",
    ],
    dotnet_context_data = "@io_bazel_rules_dotnet//:net_context_data_{}".format(framework),
    native_deps = "@net_sdk_{}//:native_deps".format(framework),
)  for framework in ["net45", "net451", "net452", "net46", "net461", "net462", "net47", "net471", "net472"]]
