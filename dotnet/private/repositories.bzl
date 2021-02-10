load("@bazel_tools//tools/build_defs/repo:http.bzl", "http_archive")
load("@io_bazel_rules_dotnet//dotnet/private:sdk_core.bzl", "core_download_sdk")
load(
    "@io_bazel_rules_dotnet//dotnet/platform:list.bzl",
    "DOTNET_CORE_FRAMEWORKS",
    "DOTNET_OS_ARCH",
)
load(
    "@io_bazel_rules_dotnet//dotnet/toolchain:toolchains.bzl",
    "CORE_SDK_REPOSITORIES",
)

def dotnet_repositories():
    """Fetches remote repositories required before loading other rules_dotnet files. 
    
    It fetches basic dependencies. For example: bazel_skylib is loaded.
    """
    _maybe(
        http_archive,
        name = "rules_dotnet_skylib",
        urls = [
            "https://mirror.bazel.build/github.com/bazelbuild/bazel-skylib/releases/download/1.0.2/bazel-skylib-1.0.2.tar.gz",
            "https://github.com/bazelbuild/bazel-skylib/releases/download/1.0.2/bazel-skylib-1.0.2.tar.gz",
        ],
        sha256 = "97e70364e9249702246c0e9444bccdc4b847bed1eb03c5a3ece4f83dfe6abc44",
    )

    _maybe(
        http_archive,
        name = "platforms",
        strip_prefix = "platforms-0.0.3",
        # 0.0.1, latest as of 2020-12-01
        urls = [
            "https://github.com/bazelbuild/platforms/archive/0.0.3.zip",
        ],
        sha256 = "be834dc9b61c0aa3f42517966b54c0b599356c30c6ea08028597b7f0986e7060",
    )

    _core_sdks()
    _core_stdlib(name = "core_sdk_stdlib")

def _core_sdks():
    for os, arch in DOTNET_OS_ARCH:
        for sdk in DOTNET_CORE_FRAMEWORKS:
            core_download_sdk(
                name = "core_sdk_{}_{}_{}".format(os, arch, sdk),
                os = os,
                arch = arch,
                runtimeVersion = DOTNET_CORE_FRAMEWORKS.get(sdk)[3],
                sdkVersion = sdk,
                sdks = CORE_SDK_REPOSITORIES[sdk],
            )

def _maybe(repo_rule, name, **kwargs):
    if name not in native.existing_rules():
        repo_rule(name = name, **kwargs)

def _core_stdlib_impl(ctx):
    ctx.file("ROOT")

    body = ""
    for target in ["libraryset", "NETStandard.Library", "Microsoft.AspNetCore.App", "Microsoft.NETCore.App", "Microsoft.WindowsDesktop.App"]:
        values = ""
        for os, arch in DOTNET_OS_ARCH:
            for sdk in DOTNET_CORE_FRAMEWORKS:
                name = "{}_{}_{}".format(os, arch, sdk)
                key = "@io_bazel_rules_dotnet//dotnet/toolchain:" + name + "_config"
                val = "@core_sdk_" + name + "//:" + target
                values = values + """"{}": "{}",""".format(key, val)

        body = body + """alias(name = "{}",actual = select({{""".format(target) + values + """}, no_match_error = "platform not known"), visibility=["//visibility:public"])\n"""

    ctx.file(
        "BUILD.bazel",
        body,
        executable = False,
    )

_core_stdlib = repository_rule(
    _core_stdlib_impl,
)
