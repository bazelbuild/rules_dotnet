load("@io_bazel_rules_dotnet//dotnet:defs.bzl", "csharp_library")

csharp_library(
    name = "TransitiveClass.dll",
    srcs = [
        "TransitiveClass.cs",
    ],
    nowarn = [
        "CS0618",
        "CS0612",
    ],
    visibility = ["//visibility:public"],
    deps = [
        "@core_sdk_stdlib//:libraryset",
    ],
)

csharp_library(
    name = "TransitiveClass-netstandard.dll",
    srcs = [
        "TransitiveClass.cs",
    ],
    tags = ["manual"],
    target_compatible_with = [
        "@io_bazel_rules_dotnet//dotnet/toolchain:3.0.100",
    ],
    target_framework = "netstandard2.0",
    visibility = ["//visibility:public"],
    deps = [
        "@core_sdk_stdlib//:NETStandard.Library",
    ],
)
