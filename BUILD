load("@io_bazel_rules_dotnet//dotnet/private:context.bzl", "core_context_data", "dotnet_context_data", "net_context_data")
load("//dotnet:defs.bzl", "DOTNET_NET_FRAMEWORKS","DOTNET_CORE_FRAMEWORKS" )

dotnet_context_data(
    name = "dotnet_context_data",
    visibility = ["//visibility:public"],
)

net_context_data(
    name = "net_context_data",
    visibility = ["//visibility:public"],
)

exports_files(["AUTHORS"])

[net_context_data(
    name = "net_context_data_" + framework,
    mcs_bin = "@net_sdk_{}//:mcs_bin".format(framework),
    mono_bin = "@net_sdk_{}//:mono_bin".format(framework),
    lib = "@net_sdk_{}//:lib".format(framework),
    tools = "@net_sdk_{}//:tools".format(framework),
    shared = "@net_sdk_{}//:lib".format(framework),
    host = "@net_sdk_{}//:mcs_bin".format(framework),
    libVersion = DOTNET_NET_FRAMEWORKS[framework][3], 
    extra_srcs = ["@net_sdk_{}//:tagetframework".format(framework)],
    visibility = ["//visibility:public"],
) for framework in DOTNET_NET_FRAMEWORKS
]

[core_context_data(
    name = "core_context_data_" + framework,
    mcs_bin = "@core_sdk_{}//:mcs_bin".format(framework),
    mono_bin = "@core_sdk_{}//:mono_bin".format(framework),
    lib = "@core_sdk_{}//:lib".format(framework),
    tools = "@core_sdk_{}//:lib".format(framework),
    shared = "@core_sdk_{}//:shared".format(framework),
    host = "@core_sdk_{}//:host".format(framework),
    extra_srcs = ["@core_sdk_{}//:tagetframework".format(framework)],
    visibility = ["//visibility:public"],
) for framework in DOTNET_CORE_FRAMEWORKS
]
