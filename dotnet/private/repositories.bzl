load("@io_bazel_rules_dotnet//dotnet/private:deps/nunit.bzl", "dotnet_repositories_nunit")
load("@io_bazel_rules_dotnet//dotnet/private:deps/nuget.bzl", "dotnet_repositories_nuget")

def dotnet_repositories():
    dotnet_repositories_nunit()
    dotnet_repositories_nuget()
