load("@io_bazel_rules_dotnet//dotnet:defs.bzl", "core_binary")

core_binary(
    name = "aspnetcore.exe",
    srcs = glob([
        "*.cs",
        "Controllers/*.cs",
    ]),
    deps = [
        "@core_sdk_stdlib//:Microsoft.AspNetCore.App",
        "@core_sdk_stdlib//:libraryset",
    ],
)
