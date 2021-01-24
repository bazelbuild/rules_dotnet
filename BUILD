load("//dotnet/private:context.bzl", "core_context_data")
load("//dotnet:defs.bzl", "DEFAULT_DOTNET_CORE_FRAMEWORK", "DOTNET_CORE_FRAMEWORKS")

package(default_visibility = ["//visibility:public"])

core_context_data(
    name = "core_context_data",
    framework = DEFAULT_DOTNET_CORE_FRAMEWORK,
)

exports_files(["AUTHORS"])

[
    core_context_data(
        name = "core_context_data_" + framework,
        csc = "@io_bazel_rules_dotnet//dotnet/stdlib.core/{}:csc.dll".format(framework),
        framework = framework,
        libVersion = DOTNET_CORE_FRAMEWORKS[framework][1],
        runner = "@core_sdk_{}//:runner".format(framework),
        runtime = "@io_bazel_rules_dotnet//dotnet/stdlib.core/{}:runtime".format(framework),
        visibility = ["//visibility:public"],
    )
    for framework in DOTNET_CORE_FRAMEWORKS
]
