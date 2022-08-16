"""
Rules for compiling NUnit tests.
"""

load("//dotnet/private:actions/fsharp_assembly.bzl", "AssemblyAction")
load(
    "//dotnet/private:common.bzl",
    "is_debug",
    "is_strict_deps_enabled",
)
load("//dotnet/private:rules/common/binary.bzl", "build_binary")
load("//dotnet/private:rules/common/attrs.bzl", "FSHARP_BINARY_COMMON_ATTRS")
load("//dotnet/private:transitions/tfm_transition.bzl", "tfm_transition")

def _compile_action(ctx, tfm):
    toolchain = ctx.toolchains["@rules_dotnet//dotnet:toolchain_type"]
    return AssemblyAction(
        ctx.actions,
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
    )

def _fsharp_test_impl(ctx):
    return build_binary(ctx, _compile_action)

fsharp_test = rule(
    _fsharp_test_impl,
    doc = """Compile a F# executable and runs it as a test""",
    attrs = FSHARP_BINARY_COMMON_ATTRS,
    test = True,
    toolchains = [
        "@rules_dotnet//dotnet:toolchain_type",
    ],
    cfg = tfm_transition,
)
