def _detect_net_framework(ctx, version):
    defpath = ctx.path("C:/Program Files (x86)/Reference Assemblies/Microsoft/Framework/.NETFramework/v" + version)
    if defpath.exists:
        return defpath
    fail("Failed to find .net " + version + " in default location " + str(defpath))

def _detect_net_tools(ctx, version):
    ms_sdk_versions = ["v8.0A", "v8.1", "v8.1A", "v10.0A"]
    for ms_sdk_version in ms_sdk_versions:
        defpath = ctx.path("C:/Program Files (x86)/Microsoft SDKs/Windows/" + ms_sdk_version + "/bin/NETFX " + version + " Tools")
        if defpath.exists:
            return defpath
    fail("Failed to find .net tools " + version + " in default location " + str(defpath))

def _net_download_sdk_impl(ctx):
    if not ctx.os.name.startswith("windows"):
        _net_empty_download_sdk_impl(ctx)
        return

    host = "net_windows_amd64"

    sdks = ctx.attr.sdks
    if host not in sdks:
        fail("Unsupported host {}".format(host))
    filename, sha256 = ctx.attr.sdks[host]
    _sdk_build_file(ctx)
    _remote_sdk(ctx, [filename], ctx.attr.strip_prefix, sha256)

    ctx.symlink("net/tools", "mcs_bin")
    ctx.symlink("net/tools", "mono_bin")

    lib = _detect_net_framework(ctx, ctx.attr.version)
    ctx.symlink(lib, "lib")

    if ctx.attr.toolsVersion == "":
        tools = _detect_net_tools(ctx, ctx.attr.version)
    else:
        tools = _detect_net_tools(ctx, ctx.attr.toolsVersion)

    ctx.symlink(tools, "tools")

def _net_empty_download_sdk_impl(ctx):
    sdks = ctx.attr.sdks
    _sdk_build_file(ctx)
    ctx.symlink("net/tools", "mcs_bin")
    ctx.symlink("net/tools", "mono_bin")
    ctx.symlink("net/tools", "lib")
    ctx.symlink("net/tools", "tools")

net_download_sdk = repository_rule(
    _net_download_sdk_impl,
    attrs = {
        "sdks": attr.string_list_dict(),
        "urls": attr.string_list(),
        "version": attr.string(),
        "toolsVersion": attr.string(),
        "strip_prefix": attr.string(default = ""),
    },
)

"""See /dotnet/toolchains.rst#dotnet-sdk for full documentation."""

def _remote_sdk(ctx, urls, strip_prefix, sha256):
    ctx.download_and_extract(
        url = urls,
        stripPrefix = strip_prefix,
        sha256 = sha256,
        output = "net",
        type = "zip",
    )

def _sdk_build_file(ctx):
    ctx.file("ROOT")
    ctx.template(
        "BUILD.bazel",
        Label("@io_bazel_rules_dotnet//dotnet/private:BUILD.net.bazel"),
        executable = False,
    )
