"""
Rules for compiling NUnit tests.
"""

load("//dotnet/private:actions/csharp_assembly.bzl", "AssemblyAction")
load(
    "//dotnet/private:common.bzl",
    "is_debug",
    "is_strict_deps_enabled",
)
load("//dotnet/private:rules/common/binary.bzl", "build_binary")
load("//dotnet/private:rules/common/attrs.bzl", "CSHARP_BINARY_COMMON_ATTRS")
load("//dotnet/private:transitions/tfm_transition.bzl", "tfm_transition")

def _compile_action(ctx, tfm):
    toolchain = ctx.toolchains["@rules_dotnet//dotnet:toolchain_type"]
    return AssemblyAction(
        ctx.actions,
        additionalfiles = ctx.files.additionalfiles,
        debug = is_debug(ctx),
        defines = ctx.attr.defines,
        deps = ctx.attr.deps,
        private_deps = ctx.attr.private_deps,
        internals_visible_to = ctx.attr.internals_visible_to,
        keyfile = ctx.file.keyfile,
        langversion = ctx.attr.langversion,
        resources = ctx.files.resources,
        srcs = ctx.files.srcs,
        data = ctx.files.data,
        out = ctx.attr.out,
        target = "exe",
        target_name = ctx.attr.name,
        target_framework = tfm,
        toolchain = toolchain,
        strict_deps = is_strict_deps_enabled(toolchain, ctx.attr.strict_deps),
        include_host_model_dll = False,
    )

def _csharp_test_impl(ctx):
    return build_binary(ctx, _compile_action)

csharp_test = rule(
    _csharp_test_impl,
    doc = """Compiles a C# executable and runs it as a test""",
    attrs = CSHARP_BINARY_COMMON_ATTRS,
    test = True,
    toolchains = [
        "@rules_dotnet//dotnet:toolchain_type",
    ],
    cfg = tfm_transition,
)
