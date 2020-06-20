load("@io_bazel_rules_dotnet//dotnet:defs.bzl", "core_binary")

core_binary(
    name = "nuget2bazel.exe",
    srcs = glob([
        "*.cs",
        "rules/*.cs",
    ]),
    visibility = ["//visibility:public"],
    deps = [
        "@commandlineparser//:core",
        "@io_bazel_rules_dotnet//dotnet/stdlib.core:libraryset",
        "@newtonsoft.json//:core",
        "@nuget.common//:core",
        "@nuget.configuration//:core",
        "@nuget.frameworks//:core",
        "@nuget.packagemanagement.netstandard//:core",
        "@nuget.packaging.core//:core",
        "@nuget.packaging//:core",
        "@nuget.projectmodel//:core",
        "@nuget.protocol//:core",
        "@nuget.resolver//:core",
        "@nuget.versioning//:core",
        "@sharpziplib//:core",
        "@system.reflection.metadataloadcontext//:core",
    ],
)
