load("@io_bazel_rules_dotnet//dotnet:defs.bzl", "core_library", "dotnet_library", "net_library")

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

core_library(
    name = "MyClass-core",
    srcs = [
        "MyClass.cs",
    ],
    visibility = ["//visibility:public"],
    deps = [
        "//tests/examples/example_transitive_lib:TransitiveClass-core",
        "@io_bazel_rules_dotnet//dotnet/stdlib.core:system.private.corelib.dll",
        "@io_bazel_rules_dotnet//dotnet/stdlib.core:system.runtime.dll",
    ],
)

net_library(
    name = "MyClass-net",
    srcs = [
        "MyClass.cs",
    ],
    visibility = ["//visibility:public"],
    deps = [
        "//tests/examples/example_transitive_lib:TransitiveClass-net",
    ],
)
