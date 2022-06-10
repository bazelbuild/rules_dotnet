"""
Rules for compiling F# libraries.
"""

load("//dotnet/private:actions/fsharp_assembly.bzl", "AssemblyAction")
load("//dotnet/private:rules/common/library.bzl", "build_library")
load("//dotnet/private:rules/common/attrs.bzl", "FSHARP_COMMON_ATTRS")
load(
    "//dotnet/private:common.bzl",
    "is_debug",
)

def _compile_action(ctx, tfm):
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
        target = "library",
        target_name = ctx.attr.name,
        target_framework = tfm,
        toolchain = ctx.toolchains["@rules_dotnet//dotnet:toolchain_type"],
    )

def _library_impl(ctx):
    return build_library(ctx, _compile_action)

fsharp_library = rule(
    _library_impl,
    doc = "Compile a F# DLL",
    attrs = FSHARP_COMMON_ATTRS,
    executable = False,
    toolchains = ["@rules_dotnet//dotnet:toolchain_type"],
)
