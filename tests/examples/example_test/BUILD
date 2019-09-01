load("@io_bazel_rules_dotnet//dotnet:defs.bzl", "DOTNET_NET_FRAMEWORKS", "dotnet_nunit_test", "net_nunit3_test", "net_nunit_test")

dotnet_nunit_test(
    name = "example_test.dll",
    size = "small",
    srcs = [
        "MyTest.cs",
    ],
    deps = [
        "//tests/examples/example_lib:MyClass.dll",
        "@nunitv2//:netstandard1.0_net",
    ],
)

[net_nunit_test(
    name = "net.example_test_{}.dll".format(framework),
    size = "small",
    srcs = [
        "MyTest.cs",
    ],
    dotnet_context_data = "@io_bazel_rules_dotnet//:net_context_data_{}".format(framework),
    native_deps = "@net_sdk_{}//:native_deps".format(framework),
    deps = [
        "//tests/examples/example_lib:MyClass-net_{}.dll".format(framework),
        "@nunitv2//:net472_net",
    ],
) for framework in DOTNET_NET_FRAMEWORKS]

[net_nunit3_test(
    name = "net.example_test3_{}.dll".format(framework),
    size = "small",
    srcs = [
        "MyTest.cs",
    ],
    dotnet_context_data = "@io_bazel_rules_dotnet//:net_context_data_{}".format(framework),
    native_deps = "@net_sdk_{}//:native_deps".format(framework),
    deps = [
        "@io_bazel_rules_dotnet//dotnet/stdlib.net/{}:system.runtime.dll".format(framework),
        "//tests/examples/example_lib:MyClass-net_{}.dll".format(framework),
        "@nunit//:net472_net",
    ],
) for framework in [
    "net45",
    "net451",
    "net452",
    "net46",
    "net461",
    "net462",
    "net47",
    "net471",
    "net472",
]]
