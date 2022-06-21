"""
Rules for compiling NUnit tests.
"""

load("//dotnet/private:rules/csharp/test.bzl", "csharp_test")

def csharp_nunit_test(**kwargs):
    # TODO: This should be user configurable
    deps = kwargs.pop("deps", []) + [
        "@rules_dotnet_deps//nunitlite",
        "@rules_dotnet_deps//nunit",
    ]

    srcs = kwargs.pop("srcs", []) + [
        "@rules_dotnet//dotnet/private:nunit/shim.cs",
    ]

    csharp_test(
        srcs = srcs,
        deps = deps,
        **kwargs
    )
