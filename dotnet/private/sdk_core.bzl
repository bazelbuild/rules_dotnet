def _core_download_sdk_impl(ctx):
    if ctx.os.name == "linux":
        host = "core_linux_amd64"
    elif ctx.os.name == "mac os x":
        host = "core_darwin_amd64"
    elif ctx.os.name.startswith("windows"):
        host = "core_windows_amd64"
    else:
        fail("Unsupported operating system: " + ctx.os.name)
    sdks = ctx.attr.sdks
    if host not in sdks:
        fail("Unsupported host {}".format(host))
    filename, sha256 = ctx.attr.sdks[host]
    _sdk_build_file(ctx)
    _remote_sdk(ctx, [filename], ctx.attr.strip_prefix, sha256)
    ctx.symlink("core/sdk/" + ctx.attr.version + "/Roslyn/bincore", "mcs_bin")
    ctx.symlink("core/.", "mono_bin")
    ctx.symlink("core/sdk/" + ctx.attr.version, "lib")
    ctx.symlink("core/host/", "host")

core_download_sdk = repository_rule(
    _core_download_sdk_impl,
    attrs = {
        "sdks": attr.string_list_dict(),
        "urls": attr.string_list(),
        "version": attr.string(),
        "strip_prefix": attr.string(default = ""),
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
        Label("@io_bazel_rules_dotnet//dotnet/private:BUILD.core.bazel"),
        executable = False,
    )
