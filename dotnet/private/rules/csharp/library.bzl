"""
Rules for compiling C# libraries.
"""

load("//dotnet/private/rules/csharp/actions:csharp_assembly.bzl", "AssemblyAction")
load("@bazel_skylib//rules:common_settings.bzl", "BuildSettingInfo")
load("//dotnet/private/rules/common:library.bzl", "build_library")
load("//dotnet/private/rules/common:attrs.bzl", "CSHARP_LIBRARY_COMMON_ATTRS")
load("//dotnet/private/transitions:tfm_transition.bzl", "tfm_transition")
load(
    "//dotnet/private:common.bzl",
    "is_debug",
)

def _compile_action(ctx, tfm):
    toolchain = ctx.toolchains["@rules_dotnet//dotnet:toolchain_type"]
    return AssemblyAction(
        ctx.actions,
        additionalfiles = ctx.files.additionalfiles,
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
        compile_data = ctx.files.compile_data,
        out = ctx.attr.out,
        target = "library",
        target_name = ctx.attr.name,
        target_framework = tfm,
        toolchain = toolchain,
        strict_deps = ctx.attr.strict_deps if ctx.attr.override_strict_deps else toolchain.strict_deps[BuildSettingInfo].value,
        include_host_model_dll = False,
        treat_warnings_as_errors = ctx.attr.treat_warnings_as_errors if ctx.attr.override_treat_warnings_as_errors else toolchain.dotnetinfo.csharp_treat_warnings_as_errors[BuildSettingInfo].value,
        warnings_as_errors = ctx.attr.warnings_as_errors if ctx.attr.override_warnings_as_errors else toolchain.dotnetinfo.csharp_warnings_as_errors[BuildSettingInfo].value,
        warnings_not_as_errors = ctx.attr.warnings_not_as_errors if ctx.attr.override_warnings_not_as_errors else toolchain.dotnetinfo.csharp_warnings_not_as_errors[BuildSettingInfo].value,
        warning_level = ctx.attr.warning_level if ctx.attr.override_warning_level else toolchain.dotnetinfo.csharp_warning_level[BuildSettingInfo].value,
    )

def _library_impl(ctx):
    return build_library(ctx, _compile_action)

csharp_library = rule(
    _library_impl,
    doc = "Compile a C# DLL",
    attrs = CSHARP_LIBRARY_COMMON_ATTRS,
    executable = False,
    toolchains = ["@rules_dotnet//dotnet:toolchain_type"],
    cfg = tfm_transition,
)
