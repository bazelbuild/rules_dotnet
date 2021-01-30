load("@io_bazel_rules_dotnet//dotnet:defs.bzl", "core_binary")

core_binary(
    name = "nuget2bazel.exe",
    srcs = glob([
        "*.cs",
        "rules/*.cs",
    ]),
    visibility = ["//visibility:public"],
    deps = [
        "@commandlineparser//:netcoreapp3.1_core",
        "@io_bazel_rules_dotnet//dotnet/stdlib.core:libraryset",
        "@newtonsoft.json//:netcoreapp3.1_core",
        "@nuget.common//:netcoreapp3.1_core",
        "@nuget.configuration//:netcoreapp3.1_core",
        "@nuget.frameworks//:netcoreapp3.1_core",
        "@nuget.packagemanagement.netstandard//:netcoreapp3.1_core",
        "@nuget.packaging.core//:netcoreapp3.1_core",
        "@nuget.packaging//:netcoreapp3.1_core",
        "@nuget.projectmodel//:netcoreapp3.1_core",
        "@nuget.protocol//:netcoreapp3.1_core",
        "@nuget.resolver//:netcoreapp3.1_core",
        "@nuget.versioning//:netcoreapp3.1_core",
        "@sharpziplib//:netcoreapp3.1_core",
        "@system.reflection.metadataloadcontext//:netcoreapp3.1_core",
    ],
)
