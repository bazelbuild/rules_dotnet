"""
Rules for compiling F# libraries.
"""

load("//dotnet/private/rules/fsharp/actions:fsharp_assembly.bzl", "AssemblyAction")
load("//dotnet/private/rules/common:library.bzl", "build_library")
load("//dotnet/private/rules/common:attrs.bzl", "FSHARP_LIBRARY_COMMON_ATTRS")
load("//dotnet/private/transitions:tfm_transition.bzl", "tfm_transition")
load(
    "//dotnet/private:common.bzl",
    "is_debug",
)
load("@bazel_skylib//rules:common_settings.bzl", "BuildSettingInfo")

def _compile_action(ctx, tfm):
    toolchain = ctx.toolchains["@rules_dotnet//dotnet:toolchain_type"]

    return AssemblyAction(
        ctx.actions,
        debug = is_debug(ctx),
        defines = ctx.attr.defines,
        deps = ctx.attr.deps,
        exports = ctx.attr.exports,
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
        strict_deps = ctx.attr.strict_deps if ctx.attr.override_strict_deps else toolchain.strict_deps,
        treat_warnings_as_errors = ctx.attr.treat_warnings_as_errors if ctx.attr.override_treat_warnings_as_errors else toolchain.dotnetinfo.fsharp_treat_warnings_as_errors[BuildSettingInfo].value,
        warnings_as_errors = ctx.attr.warnings_as_errors if ctx.attr.override_warnings_as_errors else toolchain.dotnetinfo.fsharp_warnings_as_errors[BuildSettingInfo].value,
        warnings_not_as_errors = ctx.attr.warnings_not_as_errors if ctx.attr.override_warnings_not_as_errors else toolchain.dotnetinfo.fsharp_warnings_not_as_errors[BuildSettingInfo].value,
        warning_level = ctx.attr.warning_level if ctx.attr.override_warning_level else toolchain.dotnetinfo.fsharp_warning_level[BuildSettingInfo].value,
    )

def _library_impl(ctx):
    return build_library(ctx, _compile_action)

fsharp_library = rule(
    _library_impl,
    doc = "Compile a F# DLL",
    attrs = FSHARP_LIBRARY_COMMON_ATTRS,
    executable = False,
    toolchains = ["@rules_dotnet//dotnet:toolchain_type"],
    cfg = tfm_transition,
)
