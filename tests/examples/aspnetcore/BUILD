load("@rules_mono//dotnet:defs.bzl", "core_binary")

core_binary(
    name = "aspnetcore.exe",
    srcs = glob([
        "*.cs",
        "Controllers/*.cs",
    ]),
    deps = [
        "@rules_mono//dotnet/stdlib.core:Microsoft.AspNetCore.App",
        "@rules_mono//dotnet/stdlib.core:libraryset",
    ],
)
