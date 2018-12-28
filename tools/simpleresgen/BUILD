load("@io_bazel_rules_dotnet//dotnet:defs.bzl", "core_binary", "DOTNET_CORE_FRAMEWORKS")

[core_binary(
    name = "{}_simpleresgen".format(framework),
    srcs = glob(["**/*.cs"]),
    unsafe = True,
    visibility = ["//visibility:public"],
    deps = [
        "@io_bazel_rules_dotnet//dotnet/stdlib.core:{}_system.dll".format(framework),
        "@io_bazel_rules_dotnet//dotnet/stdlib.core:{}_system.xml.dll".format(framework),
    ],
    dotnet_context_data = "@io_bazel_rules_dotnet//:core_context_data_{}".format(framework),
    native_deps = "@core_sdk_{}//:native_deps".format(framework),
) for framework in DOTNET_CORE_FRAMEWORKS]
