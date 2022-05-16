"""
Rules to load all the .NET SDK & framework dependencies of rules_dotnet.
"""

load("@bazel_tools//tools/build_defs/repo:http.bzl", "http_archive")
load("@bazel_tools//tools/build_defs/repo:utils.bzl", "maybe")
load("//dotnet/private:rules/create_net_workspace.bzl", "create_net_workspace")
load("//dotnet/private:macros/nuget.bzl", "nuget_package")
load("//dotnet/private:toolchains_repo.bzl", "PLATFORMS", "toolchains_repo")
load("//dotnet/private:versions.bzl", "TOOL_VERSIONS")
load("//tools/paket2bazel/deps:paket.bzl", "paket")

# WARNING: any changes in this function may be BREAKING CHANGES for users
# because we'll fetch a dependency which may be different from one that
# they were previously fetching later in their WORKSPACE setup, and now
# ours took precedence. Such breakages are challenging for users, so any
# changes in this function should be marked as BREAKING in the commit message
# and released only in semver majors.
# buildifier: disable=function-docstring
def rules_dotnet_dependencies():
    # The minimal version of bazel_skylib we require
    maybe(
        http_archive,
        name = "bazel_skylib",
        urls = [
            "https://mirror.bazel.build/github.com/bazelbuild/bazel-skylib/releases/download/1.2.1/bazel-skylib-1.2.1.tar.gz",
            "https://github.com/bazelbuild/bazel-skylib/releases/download/1.2.1/bazel-skylib-1.2.1.tar.gz",
        ],
        sha256 = "f7be3474d42aae265405a592bb7da8e171919d74c16f082a5457840f06054728",
    )

    # Download dependencies of dotnet rules
    _net_workspace()

    create_net_workspace()

    # NUnit
    # TODO: Create testing toolchain for NUnit
    nuget_package(
        name = "NUnitLite",
        package = "NUnitLite",
        version = "3.12.0",
        sha256 = "0b05b83f05b4eee07152e88b7b60b093fa408bfea56489a977ae655b640992f2",
    )

    # TODO: Create testing toolchain for NUnit
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

    # paket2bazel dependencies
    paket()

########
# Remaining content of the file is only used to support toolchains.
########
_DOC = "Fetch external tools needed for dotnet toolchain"
_ATTRS = {
    "dotnet_version": attr.string(mandatory = True, values = TOOL_VERSIONS.keys()),
    "platform": attr.string(mandatory = True, values = PLATFORMS.keys()),
}

def _dotnet_repo_impl(repository_ctx):
    url = TOOL_VERSIONS[repository_ctx.attr.dotnet_version][repository_ctx.attr.platform]["url"]
    repository_ctx.download_and_extract(
        url = url,
        integrity = TOOL_VERSIONS[repository_ctx.attr.dotnet_version][repository_ctx.attr.platform]["hash"],
    )
    build_content = """#Generated by dotnet/repositories.bzl
load("@rules_dotnet//dotnet:toolchain.bzl", "dotnet_toolchain")
load("@rules_cc//cc:defs.bzl", "cc_binary")
load("@rules_dotnet//dotnet:defs.bzl", "dotnet_wrapper")

exports_files(
    # csharp compiler: csc
    glob([
        "sdk/**/Roslyn/bincore/**/*",
    ]),
    visibility = ["//visibility:public"],
)

filegroup(
    name = "runtime",
    srcs = glob(
        [
            "dotnet",
            "dotnet.exe",  # windows
        ],
        allow_empty = True,
    ),
    data = glob([
        "host/**/*",
        "shared/**/*",
    ]),
    visibility = ["//visibility:public"],
)

filegroup(
    name = "apphost",
    srcs = glob([
        "sdk/**/AppHostTemplate/apphost.exe", # windows
        "sdk/**/AppHostTemplate/apphost",
    ]),
    visibility = ["//visibility:public"],
)

filegroup(
    name = "fsc_binary",
    # We glob both fsc.dll and fsc.exe for backwards compatibility
    # Pre .Net 5.0 the file was called fsc.exe but has been changed to fsc.dll
    srcs = glob([
        "sdk/**/FSharp/fsc.dll*",
        "sdk/**/FSharp/fsc.exe*",
    ]),
    visibility = ["//visibility:public"],
)

cc_binary(
    name = "dotnetw",
    srcs = [":main-cc"],
    data = glob(
        [
            "dotnet",
            "dotnet.exe",
        ],
        allow_empty = True,
    ),
    visibility = ["//visibility:public"],
    deps = ["@bazel_tools//tools/cpp/runfiles"],
)

dotnet_wrapper(
    name = "main-cc",
    dotnet = glob(
        [
            "dotnet",
            "dotnet.exe",
        ],
        allow_empty = True,
    ),
)

dotnet_toolchain(
    name = "dotnet_toolchain", 
    runtime = ":runtime",
    csharp_compiler = ":sdk/{0}/Roslyn/bincore/csc.dll",
    fsharp_compiler = ":fsc_binary",
    apphost = ":apphost",
    sdk_version = "{1}",
    runtime_version = "{2}",
    runtime_tfm = "{3}",
    csharp_default_version = "{4}",
    fsharp_default_version = "{5}",
)
""".format(
        repository_ctx.attr.dotnet_version,
        repository_ctx.attr.dotnet_version,
        TOOL_VERSIONS[repository_ctx.attr.dotnet_version]["runtimeVersion"],
        TOOL_VERSIONS[repository_ctx.attr.dotnet_version]["runtimeTfm"],
        TOOL_VERSIONS[repository_ctx.attr.dotnet_version]["csharpDefaultVersion"],
        TOOL_VERSIONS[repository_ctx.attr.dotnet_version]["fsharpDefaultVersion"],
    )

    # Base BUILD file for this repository
    repository_ctx.file("BUILD.bazel", build_content)

dotnet_repositories = repository_rule(
    _dotnet_repo_impl,
    doc = _DOC,
    attrs = _ATTRS,
)

# Wrapper macro around everything above, this is the primary API
def dotnet_register_toolchains(name, dotnet_version, **kwargs):
    """Convenience macro for users which does typical setup.

    - create a repository for each built-in platform like "dotnet_linux_amd64" -
      this repository is lazily fetched when node is needed for that platform.
    - create a repository exposing toolchains for each platform like "dotnet_platforms"
    - register a toolchain pointing at each platform
    Users can avoid this macro and do these steps themselves, if they want more control.
    Args:
        name: base name for all created repos, like "dotnet"
        dotnet_version: The .Net SDK version to use e.g. 6.0.300
        **kwargs: passed to each dotnet_repositories call
    """
    for platform in PLATFORMS.keys():
        dotnet_repositories(
            name = name + "_" + platform,
            platform = platform,
            dotnet_version = dotnet_version,
            **kwargs
        )
        native.register_toolchains("@%s_toolchains//:%s_toolchain" % (name, platform))

    toolchains_repo(
        name = name + "_toolchains",
        user_repository_name = name,
    )
