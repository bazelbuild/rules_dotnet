"""
Rules for compiling F# libraries.
"""

load("//dotnet/private:actions/fsharp_assembly.bzl", "AssemblyAction")
load("//dotnet/private:rules/common/library.bzl", "build_library")
load("//dotnet/private:rules/common/attrs.bzl", "FSHARP_COMMON_ATTRS")
load("//dotnet/private:transitions/tfm_transition.bzl", "tfm_transition")
load(
    "//dotnet/private:common.bzl",
    "is_debug",
    "is_strict_deps_enabled",
)

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
        target = "library",
        target_name = ctx.attr.name,
        target_framework = tfm,
        toolchain = toolchain,
        strict_deps = is_strict_deps_enabled(toolchain, ctx.attr.strict_deps),
    )

def _library_impl(ctx):
    return build_library(ctx, _compile_action)

fsharp_library = rule(
    _library_impl,
    doc = "Compile a F# DLL",
    attrs = FSHARP_COMMON_ATTRS,
    executable = False,
    toolchains = ["@rules_dotnet//dotnet:toolchain_type"],
    cfg = tfm_transition,
)
