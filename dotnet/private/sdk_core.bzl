def _core_download_sdk_impl(ctx):
    host = ctx.attr.os + "_" + ctx.attr.arch
    sdks = ctx.attr.sdks
    if host not in sdks:
        fail("Unsupported host {}".format(host))
    filename, sha256 = ctx.attr.sdks[host]
    _sdk_build_file(ctx)
    _remote_sdk(ctx, [filename], ctx.attr.strip_prefix, sha256)

core_download_sdk = repository_rule(
    _core_download_sdk_impl,
    attrs = {
        "sdks": attr.string_list_dict(mandatory = True, doc = "Map of URLs. See CORE_SDK_REPOSITORIES in dotnet/private/toolchain/toolchains.bzl for the expected shape of the parameter."),
        "os": attr.string(mandatory = True, doc = "Operating system for the SDK."),
        "arch": attr.string(mandatory = True, doc = "Architecture for the SDK."),
        "sdkVersion": attr.string(mandatory = True, doc = "SDK version to use."),
        "runtimeVersion": attr.string(mandatory = True, doc = "Runtime version to use. It's bound to sdkVersion."),
        "strip_prefix": attr.string(default = "", doc = "If present then provided prefix is stripped when extracting SDK."),
    },
    doc = "This downloads .NET Core SDK for given version. It usually is not used directly. Use [dotnet_repositories](api.md#dotnet_repositories) instead.",
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
        substitutions = {"{sdkVersion}": ctx.attr.sdkVersion, "{runtimeVersion}": ctx.attr.runtimeVersion},
        executable = False,
    )
