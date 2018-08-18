load("@io_bazel_rules_dotnet//dotnet:defs.bzl", "dotnet_library")

dotnet_library(
    name = "MyClass",
    srcs = [
        "MyClass.cs",
        "Properties/AssemblyInfo.cs",
    ],
    #resources = [ "hello.txt" ],
    visibility = ["//visibility:public"],
    deps = [
        "//tests/examples/example_transitive_lib:TransitiveClass",
    ],
)
