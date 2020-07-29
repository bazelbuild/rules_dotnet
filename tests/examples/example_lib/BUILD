load("@io_bazel_rules_dotnet//dotnet:defs.bzl", "DOTNET_CORE_FRAMEWORKS", "DOTNET_NET_FRAMEWORKS", "core_library", "dotnet_library", "net_library")

dotnet_library(
    name = "MyClass.dll",
    srcs = [
        "MyClass.cs",
        "Properties/AssemblyInfo.cs",
    ],
    #resources = [ "hello.txt" ],
    visibility = ["//visibility:public"],
    deps = [
        "//tests/examples/example_transitive_lib:TransitiveClass.dll",
    ],
)

[core_library(
    name = "{}_MyClass-core.dll".format(framework),
    srcs = [
        "MyClass.cs",
    ],
    dotnet_context_data = "@io_bazel_rules_dotnet//:core_context_data_{}".format(framework),
    visibility = ["//visibility:public"],
    deps = [
        "//tests/examples/example_transitive_lib:{}_TransitiveClass-core.dll".format(framework),
        "@io_bazel_rules_dotnet//dotnet/stdlib.core/{}:libraryset".format(framework),
    ],
) for framework in DOTNET_CORE_FRAMEWORKS]

[net_library(
    name = "MyClass-net_{}.dll".format(framework),
    srcs = [
        "MyClass.cs",
    ],
    dotnet_context_data = "@io_bazel_rules_dotnet//:net_context_data_{}".format(framework),
    visibility = ["//visibility:public"],
    deps = [
        "//tests/examples/example_transitive_lib:TransitiveClass-net_{}.dll".format(framework),
    ],
) for framework in DOTNET_NET_FRAMEWORKS]

core_library(
    name = "MyClass-core-netstandard.dll",
    srcs = [
        "MyClass.cs",
    ],
    target_framework = "netstandard2.0",
    visibility = ["//visibility:public"],
    deps = [
        "//tests/examples/example_transitive_lib:TransitiveClass-core-netstandard.dll",
        "@io_bazel_rules_dotnet//dotnet/stdlib.core:NETStandard.Library",
    ],
)

core_library(
    name = "MyClass-core-v2.1.200-netstandard.dll",
    srcs = [
        "MyClass.cs",
    ],
    target_framework = "netstandard2.0",
    visibility = ["//visibility:public"],
    deps = [
        "//tests/examples/example_transitive_lib:TransitiveClass-core-v2.1.200-netstandard.dll",
        "@io_bazel_rules_dotnet//dotnet/stdlib.core/v2.1.200:netstandard.dll",
    ],
)
