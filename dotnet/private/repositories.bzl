load("@io_bazel_rules_dotnet//dotnet/private:deps/nunit.bzl", "dotnet_repositories_nunit")
load("@io_bazel_rules_dotnet//dotnet/private:deps/nuget.bzl", "dotnet_repositories_nuget")
load("@io_bazel_rules_dotnet//dotnet/private:deps/xunit.bzl", "dotnet_repositories_xunit")

def dotnet_repositories():
    dotnet_repositories_nunit()
    dotnet_repositories_nuget()
    dotnet_repositories_xunit()
