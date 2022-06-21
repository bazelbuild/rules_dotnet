load("@rules_dotnet//dotnet:defs.bzl", "csharp_library")

csharp_library(
    name = "Afas.BazelDotnet.Nuget",
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
        "@rules_dotnet_deps//nuget.commands",
        "@rules_dotnet_deps//nuget.common",
        "@rules_dotnet_deps//nuget.configuration",
        "@rules_dotnet_deps//nuget.dependencyresolver.core",
        "@rules_dotnet_deps//nuget.frameworks",
        "@rules_dotnet_deps//nuget.packagemanagement",
        "@rules_dotnet_deps//nuget.packaging.core",
        "@rules_dotnet_deps//nuget.packaging",
        "@rules_dotnet_deps//nuget.projectmodel",
        "@rules_dotnet_deps//nuget.protocol",
        "@rules_dotnet_deps//nuget.resolver",
        "@rules_dotnet_deps//nuget.versioning",
    ],
)
