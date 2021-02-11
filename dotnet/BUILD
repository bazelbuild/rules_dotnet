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
    name = "toolchain_type_csharp_core",
    visibility = ["//visibility:public"],
)

toolchain_type(
    name = "toolchain_type_fsharp_core",
    visibility = ["//visibility:public"],
)
