load("@io_bazel_stardoc//stardoc:stardoc.bzl", "stardoc")
load("@bazel_skylib//:bzl_library.bzl", "bzl_library")

bzl_library(
    name = "private",
    srcs = ["//dotnet/private:all_rules"],
)

bzl_library(
    name = "toolchain",
    srcs = ["//dotnet/toolchain:all_rules"],
)

bzl_library(
    name = "platform",
    srcs = ["//dotnet/platform:all_rules"],
)

bzl_library(
    name = "our_skylib",
    srcs = ["@rules_dotnet_skylib//:distribution"],
)

bzl_library(
    name = "bazeltools",
    srcs = ["@bazel_tools//tools:bzl_srcs"],
)

stardoc(
    name = "my-docs",
    out = "api.md",
    func_template = "func.vm",
    input = "docs.bzl",
    rule_template = "rule.vm",
    tags = ["manual"],
    deps = [
        ":bazeltools",
        ":our_skylib",
        ":platform",
        ":private",
        ":toolchain",
    ],
)
