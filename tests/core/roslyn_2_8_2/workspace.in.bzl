load("@io_bazel_rules_dotnet//dotnet:defs.bzl", "dotnet_register_toolchains", "dotnet_repositories", "mono_register_sdk", "net_register_sdk")

dotnet_repositories()
dotnet_register_toolchains()
net_register_sdk("net472")

load("@io_bazel_rules_dotnet//dotnet:defs.bzl", "nuget_package")
