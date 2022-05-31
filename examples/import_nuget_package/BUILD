load("@rules_dotnet//dotnet:defs.bzl", "csharp_library")

csharp_library(
    name = "Demo",
    srcs = ["Class.cs"],
    target_frameworks = ["netcoreapp3.0"],
    deps = [
        "@nuget//microsoft.netcore.app.ref",
        # "@ExamplePackageFolder//:SomePackage",
    ],
)

csharp_library(
    name = "OldThing",
    srcs = ["Class.cs"],
    target_frameworks = ["net11"],
    deps = ["@nuget//microsoft.netcore.app.ref"],
)
