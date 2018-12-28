load("@io_bazel_rules_dotnet//dotnet:defs.bzl", "DOTNET_CORE_FRAMEWORKS")

load("@io_bazel_rules_dotnet//dotnet/private:rules/stdlib.bzl", "core_stdlib")

def multi_core_stdlib(name, deps=[], data=[]):
    [core_stdlib(
        name="{}_{}".format(framework, name),
        dll = name,
        deps = [d.replace(":", ":{}_".format(framework)) for d in deps],
        data = data,
        dotnet_context_data = "@io_bazel_rules_dotnet//:core_context_data_{}".format(framework),
    ) for framework in DOTNET_CORE_FRAMEWORKS
    ] 
