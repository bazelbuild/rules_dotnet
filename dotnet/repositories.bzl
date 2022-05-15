"""
Rules to load all the .NET SDK & framework dependencies of rules_dotnet.
"""

load("//dotnet/private:sdk.bzl", "DOTNET_SDK")
load("//dotnet/private:rules/create_net_workspace.bzl", "create_net_workspace")
load("//dotnet/private:macros/nuget.bzl", "nuget_package")
load("@bazel_tools//tools/build_defs/repo:http.bzl", "http_archive")
load("@bazel_tools//tools/build_defs/repo:utils.bzl", "maybe")
load("//tools/paket2bazel/deps:paket.bzl", "paket")

# This macro does a bunch of random targets and doesn't have a unique name.
# This is an idiomatic pattern for rule initialization.
# buildifier: disable=unnamed-macro
def dotnet_repositories():
    """Download dependencies of dotnet rules."""
    _net_workspace()

    create_net_workspace()

    # Used for various utilities
    maybe(
        http_archive,
        name = "bazel_skylib",
        urls = [
            "https://mirror.bazel.build/github.com/bazelbuild/bazel-skylib/releases/download/1.1.1/bazel-skylib-1.1.1.tar.gz",
            "https://github.com/bazelbuild/bazel-skylib/releases/download/1.1.1/bazel-skylib-1.1.1.tar.gz",
        ],
        sha256 = "c6966ec828da198c5d9adbaa94c05e3a1c7f21bd012a0b29ba8ddbccb2c93b0d",
    )

    # NUnit
    nuget_package(
        name = "NUnitLite",
        package = "NUnitLite",
        version = "3.12.0",
        sha256 = "0b05b83f05b4eee07152e88b7b60b093fa408bfea56489a977ae655b640992f2",
    )

    nuget_package(
        name = "NUnit",
        package = "NUnit",
        version = "3.12.0",
        sha256 = "62b67516a08951a20b12b02e5d20b5045edbb687c3aabe9170286ec5bb9000a1",
    )

    # TODO: This should probably be fetched from the SDK
    nuget_package(
        name = "FSharp.Core",
        package = "FSharp.Core",
        version = "6.0.4",
        sha256 = "cd259093eb9dedc7d161c655837433b0e9e951c5e96c5ed48e7fd3d59378cd62",
    )

    # Required for building the Apphost shimming program
    nuget_package(
        name = "Microsoft.NET.HostModel",
        package = "Microsoft.NET.HostModel",
        version = "3.1.6",
        sha256 = "a142f0a518e5a0dfa3f5e00dc131f386dc9de9a6f817a5984ac2f251c0e895c3",
    )

    # We need the .NET Core runtime, sdk and compiler for our current OS,
    # so that we can run the .NET core build of the compiler.

    _download_dotnet(
        os = "windows",
        url = DOTNET_SDK["windows"]["url"],
        hash = DOTNET_SDK["windows"]["hash"],
    )

    _download_dotnet(
        os = "linux",
        url = DOTNET_SDK["linux"]["url"],
        hash = DOTNET_SDK["linux"]["hash"],
    )

    _download_dotnet(
        os = "osx",
        url = DOTNET_SDK["osx"]["url"],
        hash = DOTNET_SDK["osx"]["hash"],
    )

# buildifier: disable=unnamed-macro
def dotnet_register_toolchains():
    native.register_toolchains(
        "@rules_dotnet//dotnet/private:dotnet_windows_toolchain",
        "@rules_dotnet//dotnet/private:dotnet_linux_toolchain",
        "@rules_dotnet//dotnet/private:dotnet_osx_toolchain",
    )

def _download_dotnet(os, url, hash):
    http_archive(
        name = "netcore-sdk-%s" % os,
        urls = [url],
        sha256 = hash,
        build_file = "@rules_dotnet//dotnet/private:runtime.BUILD",
    )

def _net_framework_pkg(tfm, sha256):
    nuget_package(
        name = tfm,
        package = "Microsoft.NETFramework.ReferenceAssemblies.%s" % tfm,
        version = "1.0.0",
        sha256 = sha256,
        build_file = "@rules_dotnet//dotnet/private:frameworks/%s.BUILD" % tfm,
    )

def _net_workspace():
    _net_framework_pkg("net20", "82450fb8a67696bdde41174918d385d50691f18945a246907cd96dfa3f670c82")
    _net_framework_pkg("net40", "4e97e946e032ab5538ff97d1a215c6814336b3ffda6806495e3f3150f3ca06ee")
    _net_framework_pkg("net45", "9b9e76d6497bfc6d0328528eb50f5fcc886a3eba4f47cdabd3df66f94174eac6")
    _net_framework_pkg("net451", "706278539689d45219715ff3fa19ff459127fc90104102eefcc236c1550f71e7")
    _net_framework_pkg("net452", "e8a90f1699d9b542e1bd6fdbc9f60f36acf420b95cace59e23d6be376dc61bb8")
    _net_framework_pkg("net46", "514e991aaacd84759f01b2933e6f4aa44a7d4caa39599f7d6c0a454b630286fa")
    _net_framework_pkg("net461", "a12eec50ccca0642e686082a6c8e9e06a6f538f022a47d130d36836818b17303")
    _net_framework_pkg("net462", "c4115c862f5ca778dc3fb649f455d38c095dfd10a1dc116b687944111462734d")
    _net_framework_pkg("net47", "261e3476e6be010a525064ce0901b8f77b09cdb7ea1fec88832a00ebe0356503")
    _net_framework_pkg("net471", "554c9305a9f064086861ae7db57b407147ec0850de2dfc5d86adabfa35b33180")
    _net_framework_pkg("net472", "2c8fd79ea19bd03cece40ed92b7bafde024f87c73abcebe3eff8da6e05b611af")
    _net_framework_pkg("net48", "fd0ba0a0c5ccce36e104abd055d2f4bf596ff3afc0dbc1f201d6cf9a50b783ce")

    # .NET Core
    nuget_package(
        name = "netcoreapp2.1",
        package = "Microsoft.NETCore.App",
        version = "2.1.14",
        sha256 = "5f2b5c98addeab2de380302ac26caa3e38cb2c050b38f8f25b451415a2e79c0b",
        build_file = "@rules_dotnet//dotnet/private:frameworks/netcoreapp21.BUILD",
    )

    nuget_package(
        name = "netcoreapp2.2",
        package = "Microsoft.NETCore.App",
        version = "2.2.8",
        sha256 = "987b05eabc15cb625f1f9c6ee7bfad8408afca5b4761397f66c93a999c4011a1",
        build_file = "@rules_dotnet//dotnet/private:frameworks/netcoreapp22.BUILD",
    )

    nuget_package(
        name = "netcoreapp3.0",
        package = "Microsoft.NETCore.App.Ref",
        version = "3.0.0",
        sha256 = "3c7a2fbddfa63cdf47a02174ac51274b4d79a7b623efaf9ef5c7d253824023e2",
        build_file = "@rules_dotnet//dotnet/private:frameworks/netcoreapp30.BUILD",
    )

    nuget_package(
        name = "netcoreapp3.1",
        package = "Microsoft.NETCore.App.Ref",
        version = "3.1.0",
        sha256 = "9ee02f1f0989dacdce6f5a8d0c7d7eb95ddac0e65a5a5695dc57a74e63d45b23",
        build_file = "@rules_dotnet//dotnet/private:frameworks/netcoreapp31.BUILD",
    )

    nuget_package(
        name = "net5.0",
        package = "Microsoft.NETCore.App.Ref",
        version = "5.0.0",
        sha256 = "910f30a51e1cad6a2acbf8ebb246addf863736bde76f1a12a443cc9f1c9cc2dc",
        build_file = "@rules_dotnet//dotnet/private:frameworks/net50.BUILD",
    )

    nuget_package(
        name = "net6.0",
        package = "Microsoft.NETCore.App.Ref",
        version = "6.0.0",
        sha256 = "2a8287267ab57c8b24128f0232ff3bc31da37cd5abe6fd76d6e24d4c559e6fea",
        build_file = "@rules_dotnet//dotnet/private:frameworks/net60.BUILD",
    )

    # .NET Standard (& .NET Core)
    nuget_package(
        name = "NetStandard.Library",
        package = "NetStandard.Library",
        version = "2.0.3",
        sha256 = "3eb87644f79bcffb3c0331dbdac3c7837265f2cdf58a7bfd93e431776f77c9ba",
        build_file = "@rules_dotnet//dotnet/private:frameworks/netstandard20.BUILD",
    )

    nuget_package(
        name = "NetStandard.Library.Ref",
        package = "NetStandard.Library.Ref",
        version = "2.1.0",
        sha256 = "46ea2fcbd10a817685b85af7ce0c397d12944bdc81209e272de1e05efd33c78a",
        build_file = "@rules_dotnet//dotnet/private:frameworks/netstandard21.BUILD",
    )

# buildifier: disable=unnamed-macro
def paket2bazel_repositories():
    paket()
