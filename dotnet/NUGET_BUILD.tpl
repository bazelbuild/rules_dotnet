load("@io_bazel_rules_dotnet//dotnet:csharp.bzl", "dll_import")

dll_import(
  name = "%{package}",
  srcs = glob(["**/*.dll"]),
  visibility = ["//visibility:public"],
)