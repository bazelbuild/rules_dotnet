load("@bazel_skylib//:bzl_library.bzl", "bzl_library")

filegroup(
    name = "all_rules",
    srcs = glob(["**/*.bzl"]),
    visibility = ["//visibility:public"],
)

bzl_library(
    name = "skylib",
    srcs = ["@rules_dotnet_skylib//lib:paths"],
)

bzl_library(
    name = "bzl_library",
    srcs = glob(["**/*.bzl"]),
    visibility = ["//visibility:public"],
    deps = ["skylib"],
)
