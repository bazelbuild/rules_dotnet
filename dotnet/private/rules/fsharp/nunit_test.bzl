"""
Rules for compiling and running NUnit tests.

This rule is a macro that has the same attributes as `fsharp_test`
"""

load("//dotnet/private/rules/fsharp:test.bzl", "fsharp_test")

def fsharp_nunit_test(**kwargs):
    # TODO: This should be user configurable
    deps = kwargs.pop("deps", []) + [
        "@rules_dotnet_nuget_packages//nunitlite",
        "@rules_dotnet_nuget_packages//nunit",
    ]

    srcs = kwargs.pop("srcs", []) + [
        "@rules_dotnet//dotnet/private/rules/common/nunit:shim.fs",
    ]

    fsharp_test(
        srcs = srcs,
        deps = deps,
        **kwargs
    )
