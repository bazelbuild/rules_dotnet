load("@io_bazel_rules_dotnet//dotnet/private:context.bzl", "core_context_data", "dotnet_context_data", "net_context_data")
load("@io_bazel_rules_dotnet//dotnet:defs.bzl", "DEFAULT_DOTNET_CORE_FRAMEWORK", "DOTNET_CORE_FRAMEWORKS", "DOTNET_NET_FRAMEWORKS")

package(default_visibility = ["//visibility:public"])

dotnet_context_data(
    name = "dotnet_context_data",
    framework = "",
)

core_context_data(
    name = "core_context_data",
    framework = DEFAULT_DOTNET_CORE_FRAMEWORK,
)

net_context_data(
    name = "net_context_data",
    framework = "net48",
    libVersion = "4.8",
)

exports_files(["AUTHORS"])

[
    net_context_data(
        name = "net_context_data_" + framework,
        csc = "@net_sdk_{}//:csc".format(framework),
        framework = framework,
        host = "@net_sdk_{}//:mcs_bin".format(framework),
        lib = "@net_sdk_{}//:lib".format(framework),
        libVersion = DOTNET_NET_FRAMEWORKS[framework][3],
        mcs_bin = "@net_sdk_{}//:mcs_bin".format(framework),
        mono_bin = "@net_sdk_{}//:mono_bin".format(framework),
        shared = "@net_sdk_{}//:lib".format(framework),
        tools = "@net_sdk_{}//:tools".format(framework),
        visibility = ["//visibility:public"],
    )
    for framework in DOTNET_NET_FRAMEWORKS
]

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
