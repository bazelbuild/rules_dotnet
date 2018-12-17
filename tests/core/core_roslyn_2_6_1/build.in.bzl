load("@io_bazel_rules_dotnet//dotnet:defs.bzl", "net_nunit3_test")

net_nunit3_test(
    name = "sanity",
    size = "small",
    srcs = [
        "MyTest.cs",
    ],
    deps = [
        "@nunit3//:lib",
    ],
)
