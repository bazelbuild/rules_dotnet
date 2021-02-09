load("@io_bazel_stardoc//stardoc:stardoc.bzl", "stardoc")
load("@bazel_skylib//:bzl_library.bzl", "bzl_library")

bzl_library(
    name = "bzl_library",
    srcs = ["//dotnet/private:all_rules"],
)

bzl_library(
    name = "our_skylib",
    srcs = ["@rules_dotnet_skylib//:distribution"],
)

stardoc(
    name = "my-docs",
    out = "api.md",
    func_template = "func.vm",
    input = "docs.bzl",
    rule_template = "rule.vm",
    tags = ["manual"],
    deps = [
        ":bzl_library",
        ":our_skylib",
    ],
)
