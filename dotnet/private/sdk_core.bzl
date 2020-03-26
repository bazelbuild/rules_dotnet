load("@io_bazel_rules_dotnet//dotnet/private:common.bzl", "bat_extension", "executable_extension")

def _get_shared_dir(
    ctx,
    app_name="Microsoft.NETCore.App",
    file_to_look_for="System.dll",
):
    p = ctx.path("core/shared/" + app_name)
    
    content = p.readdir()
    for c in content:
        result = c.get_child(file_to_look_for)
        if result.exists:
            return c

    fail(file_to_look_for + " doesn't exist in " + p)

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
    _sdk_build_file(ctx, ctx.attr.additional_shared)
    _remote_sdk(ctx, [filename], ctx.attr.strip_prefix, sha256)
    ctx.symlink("core/sdk/" + ctx.attr.version + "/Roslyn/bincore", "mcs_bin")
    ctx.symlink("core/.", "mono_bin")
    ctx.symlink("core/sdk/" + ctx.attr.version, "lib")
    ctx.symlink(_get_shared_dir(ctx), "shared")
    for k in ctx.attr.additional_shared:
        ctx.symlink(_get_shared_dir(ctx, app_name=k, file_to_look_for=k + ".deps.json"), "shared-" + k)
    ctx.symlink("core/host/", "host")

core_download_sdk = repository_rule(
    _core_download_sdk_impl,
    attrs = {
        "sdks": attr.string_list_dict(),
        "urls": attr.string_list(),
        "version": attr.string(),
        "targetFrameworkString": attr.string(),
        "strip_prefix": attr.string(default = ""),
        "additional_shared": attr.string_list()
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

def _sdk_build_file(ctx, extra_shares = []):
    ctx.file("ROOT")

    extra_shares_template = ["glob([\"shared-" + k + "/**/*\"])" for k in extra_shares]
    if extra_shares_template != []:
        extra_shares_globs = " + " + " + ".join(extra_shares_template)
    else:
        extra_shares_globs = ""
    ctx.template(
        "BUILD.bazel",
        Label("@io_bazel_rules_dotnet//dotnet/private:BUILD.sdk.bazel"),
        executable = False,
        substitutions = {
            "EXTRA_SHARES": extra_shares_globs
        }
    )

    file_content = ctx.read("BUILD.bazel")
    for extra_share in extra_shares:
        file_content = file_content + """filegroup(
    name = "shared-""" + extra_share + """",
    srcs = glob([
        "shared-""" + extra_share + """/**/*",
    ]),
)"""
    ctx.delete("BUILD.bazel")
    ctx.file("BUILD.bazel", file_content)