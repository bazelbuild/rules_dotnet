load(
    "@io_bazel_rules_dotnet//dotnet:defs.bzl",
    "DOTNET_CORE_FRAMEWORKS",
    "core_binary",
)


[core_binary(
    name = "{}_hello-core.exe".format(framework),
    srcs = [
        "Program.cs",
    ],
    dotnet_context_data = "@io_bazel_rules_dotnet//:core_context_data_{}".format(framework),
    deps = [
        "//tests/examples/example_lib:{}_MyClass-core.dll".format(framework),
        "@io_bazel_rules_dotnet//dotnet/stdlib.core/{}:libraryset".format(framework),
        "@newtonsoft.json//:netcoreapp2.1_core",
    ],
) for framework in DOTNET_CORE_FRAMEWORKS]

