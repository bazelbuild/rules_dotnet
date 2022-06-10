load("@rules_dotnet//dotnet:defs.bzl", "csharp_library")

csharp_library(
  name = "Afas.BazelDotnet.Nuget",
  srcs = glob(["**/*.cs"], exclude = ["**/obj/**", "**/bin/**"]),
  deps = [
    #Adding built-in .Net libs
    "@nuget//microsoft.netcore.app.ref",
    "@nuget//nuget.commands",
    "@nuget//nuget.common",
    "@nuget//nuget.configuration",
    "@nuget//nuget.dependencyresolver.core",
    "@nuget//nuget.frameworks",
    "@nuget//nuget.packagemanagement",
    "@nuget//nuget.packaging.core",
    "@nuget//nuget.packaging",
    "@nuget//nuget.projectmodel",
    "@nuget//nuget.protocol",
    "@nuget//nuget.resolver",
    "@nuget//nuget.versioning"
  ],
  visibility = ["//visibility:public"]
)