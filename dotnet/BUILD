exports_files(
    ["defs.bzl"],
    visibility = ["//visibility:public"],
)

filegroup(
    name = "all_rules",
    srcs = glob([
        "**/*.bzl",
    ]),
    visibility = ["//visibility:public"],
)

toolchain_type(
    name = "toolchain_type_mono",
    visibility = ["//visibility:public"],
)

toolchain_type(
    name = "toolchain_type_core",
    visibility = ["//visibility:public"],
)

toolchain_type(
    name = "toolchain_type_net",
    visibility = ["//visibility:public"],
)
