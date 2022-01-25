load("@io_bazel_rules_dotnet//dotnet:defs.bzl", "csharp_binary")

csharp_binary(
    name = "nuget2bazel.exe",
    srcs = glob([
        "*.cs",
        "rules/*.cs",
    ]),
    target_compatible_with = select({
        "//dotnet/toolchain:3.1.100": [],
        "//dotnet/toolchain:3.1.407": [],
        "//dotnet/toolchain:5.0.201": [],
        "//dotnet/toolchain:5.0.404": [],
        "//dotnet/toolchain:6.0.101": [],
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
