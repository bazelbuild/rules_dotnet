workspace(name = "io_bazel_rules_dotnet")

load("//dotnet:defs.bzl", "dotnet_register_toolchains", "dotnet_repositories", "dotnet_nuget_new")

dotnet_repositories()
dotnet_register_toolchains("host")

dotnet_nuget_new(
    name = "npgsql", 
    package="Npgsql", 
    version="3.2.7", 
    sha256="fa3e0cfbb2caa9946d2ce3d8174031a06320aad2c9e69a60f7739b9ddf19f172",
    build_file_content = """
package(default_visibility = [ "//visibility:public" ])
load("@io_bazel_rules_dotnet//dotnet:defs.bzl", "dotnet_import_library")

dotnet_import_library(
    name = "npgsqllib",
    src = "lib/net451/Npgsql.dll"
)    
    """
)


load("@io_bazel_rules_dotnet//tests:bazel_tests.bzl", "test_environment")

test_environment()
