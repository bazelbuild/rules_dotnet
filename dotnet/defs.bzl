load(
    "@io_bazel_rules_dotnet//dotnet/private:context.bzl",
    dotnet_context = "dotnet_context",
)
load(
    "@io_bazel_rules_dotnet//dotnet/toolchain:toolchains.bzl",
    "dotnet_register_toolchains",
)
load(
    "@io_bazel_rules_dotnet//dotnet/private:sdk.bzl",
    dotnet_download_sdk = "dotnet_download_sdk",
    dotnet_host_sdk = "dotnet_host_sdk",
    dotnet_local_sdk = "dotnet_local_sdk",
)
load(
    "@io_bazel_rules_dotnet//dotnet/private:dotnet_toolchain.bzl",
    dotnet_toolchain = "dotnet_toolchain",
)
load(
    "@io_bazel_rules_dotnet//dotnet/private:repositories.bzl",
    dotnet_repositories = "dotnet_repositories",
)

load(
    "@io_bazel_rules_dotnet//dotnet/private:rules/binary.bzl", 
    dotnet_binary = "dotnet_binary"
)

load(
    "@io_bazel_rules_dotnet//dotnet/private:rules/library.bzl", 
    dotnet_library = "dotnet_library"
)

load(
    "@io_bazel_rules_dotnet//dotnet/private:rules/resx.bzl", 
    dotnet_resx = "dotnet_resx"
)

load(
    "@io_bazel_rules_dotnet//dotnet/private:rules/test.bzl", 
    dotnet_nunit_test = "dotnet_nunit_test"
)

load(
    "@io_bazel_rules_dotnet//dotnet/private:rules/nuget.bzl", 
    dotnet_nuget = "dotnet_nuget",
    dotnet_nuget_new = "dotnet_nuget_new"
)

load(
    "@io_bazel_rules_dotnet//dotnet/private:rules/import.bzl", 
    dotnet_import_library = "dotnet_import_library"
)
