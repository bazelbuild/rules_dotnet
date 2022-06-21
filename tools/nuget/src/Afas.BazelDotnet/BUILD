load("@rules_dotnet//dotnet:defs.bzl", "csharp_binary")

csharp_binary(
    name = "Afas.BazelDotnet",
    srcs = glob(
        ["**/*.cs"],
        exclude = [
            "**/obj/**",
            "**/bin/**",
        ],
    ),
    visibility = ["//visibility:public"],
    deps = [
        #Adding built-in .Net libs
        "@rules_dotnet_deps//microsoft.netcore.app.ref",
        "@rules_dotnet_deps//mcmaster.extensions.commandlineutils",
        "@rules_dotnet//tools/nuget/src/Afas.BazelDotnet.Nuget",
        "@rules_dotnet//tools/nuget/src/Afas.BazelDotnet.Project",
    ],
)
