load("@io_bazel_rules_dotnet//dotnet:defs.bzl", "DOTNET_CORE_FRAMEWORKS", "core_binary")

[core_binary(
    name = "{}_simpleresgen.exe".format(framework),
    srcs = glob(["**/*.cs"]),
    dotnet_context_data = "@io_bazel_rules_dotnet//:core_context_data_{}".format(framework),
    native_deps = "@core_sdk_{}//:native_deps".format(framework),
    unsafe = True,
    visibility = ["//visibility:public"],
    deps = [
        "@io_bazel_rules_dotnet//dotnet/stdlib.core/{}:system.dll".format(framework),
        "@io_bazel_rules_dotnet//dotnet/stdlib.core/{}:system.xml.dll".format(framework),
        "@io_bazel_rules_dotnet//dotnet/stdlib.core/{}:system.runtime.serialization.formatters.dll".format(framework),
        "@io_bazel_rules_dotnet//dotnet/stdlib.core/{}:system.drawing.primitives.dll".format(framework),
        "@io_bazel_rules_dotnet//dotnet/stdlib.core/{}:system.console.dll".format(framework),
        "@io_bazel_rules_dotnet//dotnet/stdlib.core/{}:system.io.filesystem.dll".format(framework),
    ],
) for framework in DOTNET_CORE_FRAMEWORKS]

core_binary(
    name = "simpleresgen.exe",
    srcs = glob(["**/*.cs"]),
    dotnet_context_data = "@io_bazel_rules_dotnet//:core_context_data",
    native_deps = "@core_sdk//:native_deps",
    unsafe = True,
    visibility = ["//visibility:public"],
    deps = [
        "@io_bazel_rules_dotnet//dotnet/stdlib.core:system.console.dll",
        "@io_bazel_rules_dotnet//dotnet/stdlib.core:system.dll",
        "@io_bazel_rules_dotnet//dotnet/stdlib.core:system.drawing.primitives.dll",
        "@io_bazel_rules_dotnet//dotnet/stdlib.core:system.io.filesystem.dll",
        "@io_bazel_rules_dotnet//dotnet/stdlib.core:system.runtime.serialization.formatters.dll",
        "@io_bazel_rules_dotnet//dotnet/stdlib.core:system.xml.dll",
    ],
)
