"""
Rules for compiling NUnit tests.
"""

load("//dotnet/private:rules/fsharp/test.bzl", "fsharp_test")

def fsharp_nunit_test(**kwargs):
    # TODO: This should be user configurable
    deps = kwargs.pop("deps", []) + [
        "@NUnitLite//:nunitlite",
        "@NUnit//:nunit.framework",
    ]

    srcs = kwargs.pop("srcs", []) + [
        "@rules_dotnet//dotnet/private:nunit/shim.fs",
    ]

    fsharp_test(
        srcs = srcs,
        deps = deps,
        **kwargs
    )
