load("@rules_dotnet//dotnet:defs.bzl", "csharp_binary")

csharp_binary(
  name = "Afas.BazelDotnet",
  srcs = glob(["**/*.cs"], exclude = ["**/obj/**", "**/bin/**"]),
  deps = [
    #Adding built-in .Net libs
    "@nuget//microsoft.netcore.app.ref",
    "@nuget//mcmaster.extensions.commandlineutils",
    "@rules_dotnet//tools/nuget/src/Afas.BazelDotnet.Nuget",
    "@rules_dotnet//tools/nuget/src/Afas.BazelDotnet.Project"
  ],
  visibility = ["//visibility:public"]
)
