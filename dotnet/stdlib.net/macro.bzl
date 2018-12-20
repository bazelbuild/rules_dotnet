load("//dotnet:defs.bzl", "DOTNET_NET_FRAMEWORKS")

load("@io_bazel_rules_dotnet//dotnet/private:rules/stdlib.bzl", "net_stdlib")

def multi_framework_stdlib(name):
    [net_stdlib(
        name="{}_{}".format(framework, name),
        dll = name,
        dotnet_context_data = "@io_bazel_rules_dotnet//:net_context_data_{}".format(framework),
    ) for framework in DOTNET_NET_FRAMEWORKS
    ] 
