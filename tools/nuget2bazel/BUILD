load("@io_bazel_rules_dotnet//dotnet:defs.bzl", "core_binary")

core_binary(
    name = "nuget2bazel.exe",
    srcs = glob([
        "*.cs",
        "rules/*.cs",
    ]),
    visibility = ["//visibility:public"],
    deps = [
        "@commandlineparser//:netcoreapp2.1_core",
        "@io_bazel_rules_dotnet//dotnet/stdlib.core:libraryset",
        "@newtonsoft.json//:netcoreapp2.1_core",
        "@nuget.common//:netcoreapp2.1_core",
        "@nuget.configuration//:netcoreapp2.1_core",
        "@nuget.frameworks//:netcoreapp2.1_core",
        "@nuget.packagemanagement.netstandard//:netcoreapp2.1_core",
        "@nuget.packaging.core//:netcoreapp2.1_core",
        "@nuget.packaging//:netcoreapp2.1_core",
        "@nuget.projectmodel//:netcoreapp2.1_core",
        "@nuget.protocol//:netcoreapp2.1_core",
        "@nuget.resolver//:netcoreapp2.1_core",
        "@nuget.versioning//:netcoreapp2.1_core",
        "@system.reflection.metadataloadcontext//:netcoreapp2.1_core",
    ],
)
