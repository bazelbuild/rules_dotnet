load("@rules_cc//cc:defs.bzl", "cc_binary")

package(default_visibility = ["//visibility:public"])

cc_binary(
    name = "launcher_core_nunit3.exe",
    srcs = glob([
        "*.c",
    ]),
    deps = ["@io_bazel_rules_dotnet//dotnet/tools/common"],
)
