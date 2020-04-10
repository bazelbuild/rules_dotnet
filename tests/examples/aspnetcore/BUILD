load("@io_bazel_rules_dotnet//dotnet:defs.bzl", "core_binary")

core_binary(
    name = "aspnetcore.exe",
    srcs = glob([
        "*.cs",
        "Controllers/*.cs",
    ]),
    deps = [
        "@io_bazel_rules_dotnet//dotnet/stdlib.core:Microsoft.AspNetCore.App",
        "@io_bazel_rules_dotnet//dotnet/stdlib.core:libraryset",
    ],
)
