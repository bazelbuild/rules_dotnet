load("@io_bazel_rules_dotnet//dotnet:defs.bzl", "core_library")

core_library(
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
        "@core_sdk_windows_amd64_3.0.100//:libraryset",
    ],
)

# core_library(
#     name = "TransitiveClass-core-netstandard.dll",
#     srcs = [
#         "TransitiveClass.cs",
#     ],
#     target_framework = "netstandard2.0",
#     visibility = ["//visibility:public"],
#     deps = [
#         "@io_bazel_rules_dotnet//dotnet/stdlib.core:NETStandard.Library",
#     ],
# )

# core_library(
#     name = "TransitiveClass-core-v2.1.200-netstandard.dll",
#     srcs = [
#         "TransitiveClass.cs",
#     ],
#     target_framework = "netstandard2.0",
#     visibility = ["//visibility:public"],
#     deps = [
#         "@io_bazel_rules_dotnet//dotnet/stdlib.core/v2.1.200:netstandard.dll",
#     ],
# )
