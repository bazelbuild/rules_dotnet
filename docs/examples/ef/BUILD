load("@io_bazel_rules_dotnet//dotnet:defs.bzl", "core_xunit_test")

package(default_visibility = ["//visibility:public"])

core_xunit_test(
    name = "dotnet_ef.dll",
    srcs = glob(["**/*.cs"]),
    nowarn = ["CS1701"],
    deps = [
        "@io_bazel_rules_dotnet//dotnet/stdlib.core:Microsoft.AspNetCore.App",
        "@io_bazel_rules_dotnet//dotnet/stdlib.core:libraryset",
        "@microsoft.entityframeworkcore//:netcoreapp3.1_core",
        "@xunit.assert//:netcoreapp3.1_core",
        "@xunit.extensibility.core//:netcoreapp3.1_core",
        "@xunit.extensibility.execution//:netcoreapp3.1_core",
    ],
)
