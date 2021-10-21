load("@io_bazel_rules_dotnet//dotnet:defs.bzl", "csharp_library")

csharp_library(
    name = "MyClass.dll",
    srcs = [
        "MyClass.cs",
    ],
    visibility = ["//visibility:public"],
    deps = [
        "//tests/examples/example_transitive_lib:TransitiveClass.dll",
    ],
)

csharp_library(
    name = "MyClass-netstandard.dll",
    srcs = [
        "MyClass.cs",
    ],
    tags = ["manual"],
    target_compatible_with = select({
        "@io_bazel_rules_dotnet//dotnet/toolchain:3.1.100": [],
        "@io_bazel_rules_dotnet//dotnet/toolchain:3.1.407": [],
        "//conditions:default": ["@platforms//:incompatible"],
    }),
    target_framework = "netstandard2.0",
    visibility = ["//visibility:public"],
    deps = [
        "//tests/examples/example_transitive_lib:TransitiveClass-netstandard.dll",
    ],
)
