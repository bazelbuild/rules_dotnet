load("@io_bazel_stardoc//stardoc:stardoc.bzl", "stardoc")

stardoc(
    name = "my-docs",
    out = "api.md",
    func_template = "func.vm",
    input = "//dotnet:defs.bzl",
    rule_template = "rule.vm",
    deps = [
        "//dotnet/toolchain:bzl_library",
    ],
)
