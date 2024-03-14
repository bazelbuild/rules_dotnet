load(
    "//dotnet:defs.bzl",
    "csharp_binary",
    "csharp_library",
    "fsharp_binary",
    "fsharp_library",
)
load("@bazel_skylib//rules:build_test.bzl", "build_test")
load("//dotnet/private:common.bzl", "DEFAULT_TFM", "FRAMEWORK_COMPATIBILITY", "is_standard_framework")

def tests():
    "Tests that build all supported frameworks that support automatically resolving targeting packs"

    for tfm in FRAMEWORK_COMPATIBILITY.keys():
        # Binaries can't target netstandard so we default to the latest version of the framework which
        # is compatible with all versions of netstandard
        binary_tfm = DEFAULT_TFM if is_standard_framework(tfm) else tfm
        csharp_library(
            name = "csharp_library_{}".format(tfm),
            srcs = ["csharp/Lib.cs"],
            target_frameworks = [tfm],
        )

        csharp_binary(
            name = "csharp_binary_{}".format(tfm),
            srcs = ["csharp/Main.cs"],
            target_frameworks = [binary_tfm],
            deps = [
                ":csharp_library_{}".format(tfm),
            ],
        )

        fsharp_library(
            name = "fsharp_library_{}".format(tfm),
            srcs = ["fsharp/Lib.fs"],
            target_frameworks = [tfm],
        )

        fsharp_binary(
            name = "fsharp_binary_{}".format(tfm),
            srcs = ["fsharp/Main.fs"],
            target_frameworks = [binary_tfm],
            deps = [
                ":fsharp_library_{}".format(tfm),
            ],
        )

        build_test(
            name = "test_{}".format(tfm),
            targets = [
                ":csharp_library_{}".format(tfm),
                ":csharp_binary_{}".format(tfm),
                ":fsharp_library_{}".format(tfm),
                ":fsharp_binary_{}".format(tfm),
            ],
        )
