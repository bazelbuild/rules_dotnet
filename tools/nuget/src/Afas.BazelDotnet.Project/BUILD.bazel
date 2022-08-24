load("@rules_dotnet//dotnet:defs.bzl", "csharp_library")

csharp_library(
    name = "Afas.BazelDotnet.Project",
    srcs = glob(
        ["**/*.cs"],
        exclude = [
            "**/obj/**",
            "**/bin/**",
        ],
    ),
    private_deps = [
        "@rules_dotnet_deps//microsoft.netcore.app.ref",
    ],
    target_frameworks = ["net6.0"],
    visibility = ["//visibility:public"],
    deps = [
    ],
)
