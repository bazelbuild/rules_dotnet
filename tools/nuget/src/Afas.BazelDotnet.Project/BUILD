load("@rules_dotnet//dotnet:defs.bzl", "csharp_library")

csharp_library(
  name = "Afas.BazelDotnet.Project",
  srcs = glob(["**/*.cs"], exclude = ["**/obj/**", "**/bin/**"]),
  deps = [
    #Adding built-in .Net libs
    "@rules_dotnet_deps//microsoft.netcore.app.ref",
  ],
  visibility = ["//visibility:public"]
)
