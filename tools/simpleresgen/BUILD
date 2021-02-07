load("@io_bazel_rules_dotnet//dotnet:defs.bzl", "core_binary")

core_binary(
    name = "simpleresgen.exe",
    srcs = glob(["**/*.cs"]),
    unsafe = True,
    visibility = ["//visibility:public"],
    deps = [
        "@core_sdk_stdlib//:libraryset",
    ],
)
