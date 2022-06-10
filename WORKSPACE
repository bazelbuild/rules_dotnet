workspace(name = "rules_dotnet")

# skylib begin
load("@bazel_tools//tools/build_defs/repo:http.bzl", "http_archive")
load(":internal_deps.bzl", "rules_dotnet_internal_deps")

# Fetch deps needed only locally for development
rules_dotnet_internal_deps()

http_archive(
    name = "bazel_skylib",
    sha256 = "c6966ec828da198c5d9adbaa94c05e3a1c7f21bd012a0b29ba8ddbccb2c93b0d",
    urls = [
        "https://mirror.bazel.build/github.com/bazelbuild/bazel-skylib/releases/download/1.1.1/bazel-skylib-1.1.1.tar.gz",
        "https://github.com/bazelbuild/bazel-skylib/releases/download/1.1.1/bazel-skylib-1.1.1.tar.gz",
    ],
)

load("@bazel_skylib//:workspace.bzl", "bazel_skylib_workspace")

bazel_skylib_workspace()

# skylib end

load(
    "//dotnet:repositories.bzl",
    "dotnet_register_toolchains",
    "rules_dotnet_dependencies",
)

rules_dotnet_dependencies()

dotnet_register_toolchains("dotnet", "6.0.300")

load("@rules_dotnet//dotnet/private:rules/nuget_repo.bzl", "nuget_repo")
nuget_repo(
    name = "nuget",
    packages = [
        ("Microsoft.NETCore.App.Ref", "6.0.0", "sha512-YlT7r1FYRY8MysjHx7783xRMpUbstl0WWub4xiyAd16qjL2oN5al7MEJE+u8NI7YWSXKZtNGg8agbLu1cr9pHg==", []),
        ("McMaster.Extensions.CommandLineUtils", "2.5.0", "sha512-00uJOWYKPCPqDB6RxyOLXNnoPGeRmzKTZhu5OdZJaWn5+JV/n6mzB3/M+Z1yMpkabag3Lym9S11G/ITLrptOiw==", []),
        ("Microsoft.NET.HostModel", "3.1.6", None, []),
        ("Nuget.Commands", "5.10.0", "sha512-Q7ANXnmLUPC4pWgCZjBy2R7vRDABiaJz5NsBtoErE0dLylx/zQWRMyoa+m4Y478SKvUpt7S1V7LhAOlMRCTPpg==", []),
        ("Nuget.Common", "5.10.0", None, []),
        ("Nuget.Configuration", "5.10.0", None, []),
        ("Nuget.DependencyResolver.Core", "5.10.0", None, []),
        ("Nuget.Frameworks", "5.10.0", None, []),
        ("Nuget.PackageManagement", "5.10.0", None, []),
        ("Nuget.Packaging.Core", "5.10.0", None, []),
        ("Nuget.Packaging", "5.10.0", None, []),
        ("Nuget.ProjectModel", "5.10.0", None, []),
        ("Nuget.Protocol", "5.10.0", None, []),
        ("Nuget.Resolver", "5.10.0", None, []),
        ("Nuget.Versioning", "5.10.0", None, ["Nuget.Credentials", "Nuget.LibraryModel"]),
        ("Nuget.Credentials", "5.10.0", None, []),
        ("Nuget.LibraryModel", "5.10.0", None, []),
    ]
)
