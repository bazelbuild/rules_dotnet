load("@io_bazel_rules_dotnet//dotnet:defs.bzl", "DEFAULT_DOTNET_CORE_FRAMEWORK", "core_xunit_test")

framework = DEFAULT_DOTNET_CORE_FRAMEWORK

core_xunit_test(
    name = "nuget2bazel-test.dll",
    size = "medium",
    srcs = [
        "RemotionLinqT.cs",
    ],
    dotnet_context_data = "@io_bazel_rules_dotnet//:core_context_data_{}".format(framework),
    native_deps = "@core_sdk_{}//:native_deps".format(framework),
    testlauncher = "@{}_xunit//:xunit.console.exe".format(framework),
    deps = [
        "@io_bazel_rules_dotnet//tools/nuget2bazel:nuget2bazel.exe",
        "@{}_xunit//:xunit.core.dll".format(framework),
        "@{}_xunit_assert//:assert.xunit.dll".format(framework),
    ],
)
