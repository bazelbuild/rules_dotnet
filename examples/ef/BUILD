load("@io_bazel_rules_dotnet//dotnet:defs.bzl", "csharp_xunit_test")

package(default_visibility = ["//visibility:public"])

csharp_xunit_test(
    name = "dotnet_ef.dll",
    srcs = glob(["**/*.cs"]),
    nowarn = ["CS1701"],
    deps = [
        "@core_sdk_stdlib//:Microsoft.AspNetCore.App",
        "@core_sdk_stdlib//:libraryset",
        "@microsoft.entityframeworkcore//:lib",
        "@xunit.assert//:lib",
        "@xunit.extensibility.core//:lib",
        "@xunit.extensibility.execution//:lib",
    ],
)
