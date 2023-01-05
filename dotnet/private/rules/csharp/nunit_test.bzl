"""
Rules for compiling and running NUnit tests.

This rule is a macro that has the same attributes as `csharp_test`
"""

load("//dotnet/private/rules/csharp:test.bzl", "csharp_test")

def csharp_nunit_test(**kwargs):
    # TODO: This should be user configurable
    deps = kwargs.pop("deps", []) + [
        "@rules_dotnet_nuget_packages//nunitlite",
        "@rules_dotnet_nuget_packages//nunit",
    ]

    srcs = kwargs.pop("srcs", []) + [
        "@rules_dotnet//dotnet/private/rules/common/nunit:shim.cs",
    ]

    csharp_test(
        srcs = srcs,
        deps = deps,
        **kwargs
    )
