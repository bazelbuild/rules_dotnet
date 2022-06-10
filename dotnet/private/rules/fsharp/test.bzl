"""
Rules for compiling NUnit tests.
"""

load("//dotnet/private:providers.bzl", "DotnetAssemblyInfo")
load("//dotnet/private:actions/fsharp_assembly.bzl", "AssemblyAction")
load(
    "//dotnet/private:common.bzl",
    "is_debug",
)
load("//dotnet/private:rules/common/binary.bzl", "build_binary")
load("//dotnet/private:rules/common/attrs.bzl", "FSHARP_BINARY_COMMON_ATTRS")
load("@bazel_skylib//lib:dicts.bzl", "dicts")

def _compile_action(ctx, tfm, runtimeconfig, depsjson):
    return AssemblyAction(
        ctx.actions,
        debug = is_debug(ctx),
        defines = ctx.attr.defines,
        deps = ctx.attr.deps,
        internals_visible_to = ctx.attr.internals_visible_to,
        keyfile = ctx.file.keyfile,
        langversion = ctx.attr.langversion,
        resources = ctx.files.resources,
        srcs = ctx.files.srcs,
        out = ctx.attr.out,
        target = "exe",
        target_name = ctx.attr.name,
        target_framework = tfm,
        toolchain = ctx.toolchains["@rules_dotnet//dotnet:toolchain_type"],
        runtimeconfig = runtimeconfig,
        depsjson = depsjson,
    )

def _fsharp_test_impl(ctx):
    return build_binary(ctx, _compile_action)

fsharp_test = rule(
    _fsharp_test_impl,
    doc = """Compile a F# executable and runs it as a test""",
    attrs = dicts.add(
        FSHARP_BINARY_COMMON_ATTRS,
        {
            "_apphost_shimmer": attr.label(
                default = "@rules_dotnet//dotnet/private/tools/apphost_shimmer:apphost_shimmer",
                providers = [DotnetAssemblyInfo],
                executable = True,
                cfg = "exec",
            ),
            "use_apphost_shim": attr.bool(
                doc = "Whether to create a executable shim for the binary.",
                default = True,
            ),
        },
    ),
    test = True,
    toolchains = [
        "@rules_dotnet//dotnet:toolchain_type",
    ],
)
