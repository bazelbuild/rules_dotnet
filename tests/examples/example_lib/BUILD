load("@io_bazel_rules_dotnet//dotnet:defs.bzl", "core_library")

core_library(
    name = "MyClass.dll",
    srcs = [
        "MyClass.cs",
    ],
    visibility = ["//visibility:public"],
    deps = [
        "//tests/examples/example_transitive_lib:TransitiveClass.dll",
    ],
)

core_library(
    name = "MyClass-netstandard.dll",
    srcs = [
        "MyClass.cs",
    ],
    tags = ["manual"],
    target_compatible_with = [
        "@io_bazel_rules_dotnet//dotnet/toolchain:3.0.100",
    ],
    target_framework = "netstandard2.0",
    visibility = ["//visibility:public"],
    deps = [
        "//tests/examples/example_transitive_lib:TransitiveClass-netstandard.dll",
    ],
)
