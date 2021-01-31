load("@io_bazel_stardoc//stardoc:stardoc.bzl", "stardoc")
load("@bazel_skylib//:bzl_library.bzl", "bzl_library")

bzl_library(
    name = "bzl_library",
    srcs = ["//dotnet/private:all_rules"],
)

stardoc(
    name = "my-docs",
    out = "api.md",
    func_template = "func.vm",
    input = "docs.bzl",
    rule_template = "rule.vm",
    tags = ["manual"],
)
