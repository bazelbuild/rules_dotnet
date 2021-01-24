load("@bazel_skylib//:bzl_library.bzl", "bzl_library")

exports_files(
    ["defs.bzl"],
    visibility = ["//visibility:public"],
)

bzl_library(
    name = "bzl_library",
    srcs = glob(["*.bzl"]),
    visibility = ["//visibility:public"],
    deps = [
    ],
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
