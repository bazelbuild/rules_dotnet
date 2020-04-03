load("@io_bazel_rules_dotnet//dotnet/private:deps/nunitv2.bzl", "dotnet_repositories_nunitv2")
load("@io_bazel_rules_dotnet//dotnet/private:deps/nuget.bzl", "dotnet_repositories_nuget")
load("@io_bazel_rules_dotnet//dotnet/private:deps/xunit.bzl", "dotnet_repositories_xunit")
load("@io_bazel_rules_dotnet//dotnet/private:deps/nunit.bzl", "dotnet_repositories_nunit")

def dotnet_repositories_nugets():
    dotnet_repositories_nunitv2()
    dotnet_repositories_nuget()
    dotnet_repositories_xunit()
    dotnet_repositories_nunit()
