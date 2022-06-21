# load("@io_bazel_stardoc//stardoc:stardoc.bzl", "stardoc")
# load("@bazel_skylib//:bzl_library.bzl", "bzl_library")

# bzl_library(
#     name = "bazel_dependencies",
#     srcs = [
#         "@bazel_skylib//lib:dicts",
#         "@bazel_skylib//lib:paths",
#         "@bazel_tools//tools:bzl_srcs",
#     ],
# )

# bzl_library(
#     name = "rules_dotnet",
#     srcs = [
#         "//dotnet/private:bzl_srcs",
#     ],
# )

# stardoc(
#     name = "core",
#     out = "APIReference.md",
#     input = "//dotnet:defs.bzl",
#     symbol_names = [
#         "csharp_binary",
#         "csharp_library",
#         "csharp_nunit_test",
#         "dotnet_register_toolchains",
#         "dotnet_repositories",
#         "import_multiframework_library",
#         "import_library",
#         "import_nuget_package",
#         "nuget_package",
#     ],
#     tags = ["fix-windows"],
#     deps = [
#         ":bazel_dependencies",
#         ":rules_dotnet",
#     ],
# )
