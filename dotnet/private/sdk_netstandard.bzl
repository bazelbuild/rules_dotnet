load("@io_bazel_rules_dotnet//dotnet/private:common.bzl", "bat_extension", "executable_extension")

def _get_shared_dir(ctx):
    p = ctx.path("netstandard/build/netstandard2.0")
    content = p.readdir()
    for c in content:
        result = c.get_child("netstandard.dll")
        if result.exists:
            return c

    fail("netstandard.dll doesn't exist in " + p)

def _netstandard_download_sdk_impl(ctx):
    if ctx.os.name == "linux":
        sdk_host = "core_linux_amd64"
        stdlib_host = "netstandard_linux_amd64"
    elif ctx.os.name == "mac os x":
        sdk_host = "core_darwin_amd64"
        stdlib_host = "netstandard_darwin_amd64"
    elif ctx.os.name.startswith("windows"):
        sdk_host = "core_windows_amd64"
        stdlib_host = "netstandard_windows_amd64"
    else:
        fail("Unsupported operating system: " + ctx.os.name)
    sdks = ctx.attr.sdks
    if sdk_host not in sdks:
        fail("Unsupported SDK host {}".format(sdk_host))
    netstandard = ctx.attr.netstandard
    if stdlib_host not in netstandard:
        fail("Unsupported .NET Standard stdlib host {}".format(stdlib_host))
    filename, sha256 = ctx.attr.sdks[sdk_host]
    stdlib, stdlib_hash = ctx.attr.netstandard[stdlib_host]
    _sdk_build_file(ctx)
    _remote_sdk(ctx, [filename], ctx.attr.strip_prefix, sha256)
    _remote_stdlib(ctx, [stdlib], ctx.attr.strip_prefix, stdlib_hash)
    ctx.symlink("core/sdk/" + ctx.attr.version + "/Roslyn/bincore", "mcs_bin")
    ctx.symlink("core/.", "mono_bin")
    ctx.symlink("core/sdk/" + ctx.attr.version, "lib")
    ctx.symlink(_get_shared_dir(ctx), "shared")
    ctx.symlink("core/host/", "host")

netstandard_download_sdk = repository_rule(
    _netstandard_download_sdk_impl,
    attrs = {
        "sdks": attr.string_list_dict(),
        "urls": attr.string_list(),
        "version": attr.string(),
        "targetFrameworkString": attr.string(),
        "strip_prefix": attr.string(default = ""),
        "netstandard": attr.string_list_dict(),
    },
)

"""See /dotnet/toolchains.rst#dotnet-sdk for full documentation."""

def _remote_sdk(ctx, urls, strip_prefix, sha256):
    ctx.download_and_extract(
        url = urls,
        stripPrefix = strip_prefix,
        sha256 = sha256,
        output = "core",
    )

def _sdk_build_file(ctx):
    ctx.file("ROOT")
    ctx.template(
        "BUILD.bazel",
        Label("@io_bazel_rules_dotnet//dotnet/private:BUILD.sdk.bazel"),
        executable = False,
    )

def _remote_stdlib(ctx, urls, strip_prefix, sha256):
    ctx.download_and_extract(
        url = urls,
        stripPrefix = strip_prefix,
        output = "netstandard",
        sha256 = sha256,
        type = "zip",
    )
