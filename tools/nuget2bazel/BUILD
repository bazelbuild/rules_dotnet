load("@io_bazel_rules_dotnet//dotnet:defs.bzl", "csharp_binary")

csharp_binary(
    name = "nuget2bazel.exe",
    srcs = glob([
        "*.cs",
        "rules/*.cs",
    ]),
    target_compatible_with = select({
        "@io_bazel_rules_dotnet//dotnet/toolchain:3.1.100": [],
        "@io_bazel_rules_dotnet//dotnet/toolchain:3.1.407": [],
        "@io_bazel_rules_dotnet//dotnet/toolchain:5.0.201": [],
        "@io_bazel_rules_dotnet//dotnet/toolchain:5.0.404": [],
        "//conditions:default": ["@platforms//:incompatible"],
    }),
    visibility = ["//visibility:public"],
    deps = [
        "@commandlineparser//:lib",
        "@core_sdk_stdlib//:libraryset",
        "@newtonsoft.json//:lib",
        "@nuget.common//:lib",
        "@nuget.configuration//:lib",
        "@nuget.frameworks//:lib",
        "@nuget.packagemanagement//:lib",
        "@nuget.packaging.core//:lib",
        "@nuget.packaging//:lib",
        "@nuget.projectmodel//:lib",
        "@nuget.protocol//:lib",
        "@nuget.resolver//:lib",
        "@nuget.versioning//:lib",
        "@sharpziplib//:lib",
        "@system.reflection.metadataloadcontext//:lib",
        "@system.security.cryptography.pkcs//:lib",
    ],
)
