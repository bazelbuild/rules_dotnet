load("@rules_cc//cc:defs.bzl", "cc_library")

package(default_visibility = ["//visibility:public"])

cc_library(
    name = "common",
    srcs = [
        "manifest.c",
        "misc.c",
    ] + select({
        "@bazel_tools//src/conditions:windows": [],
        "//conditions:default": ["copyfile.c"],
    }),
    hdrs = glob([
        "*.h",
    ]),
)

exports_files(["manifest.h"])
