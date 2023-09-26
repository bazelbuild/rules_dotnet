"""
Rule for compiling and running test binaries.

This rule can be used to compile and run any F# binary and run it as
a Bazel test.
"""

load("@bazel_skylib//rules:common_settings.bzl", "BuildSettingInfo")
load(
    "//dotnet/private:common.bzl",
    "is_debug",
)
load("//dotnet/private/rules/common:attrs.bzl", "FSHARP_BINARY_COMMON_ATTRS")
load("//dotnet/private/rules/common:binary.bzl", "build_binary")
load("//dotnet/private/rules/fsharp/actions:fsharp_assembly.bzl", "AssemblyAction")
load("//dotnet/private/transitions:tfm_transition.bzl", "tfm_transition")

def _compile_action(ctx, tfm):
    toolchain = ctx.toolchains["//dotnet:toolchain_type"]
    return AssemblyAction(
        ctx.actions,
        ctx.executable._compiler_wrapper_bat if ctx.target_platform_has_constraint(ctx.attr._windows_constraint[platform_common.ConstraintValueInfo]) else ctx.executable._compiler_wrapper_sh,
        debug = is_debug(ctx),
        defines = ctx.attr.defines,
        deps = ctx.attr.deps,
        exports = [],
        targeting_packs = ctx.attr.targeting_packs,
        internals_visible_to = ctx.attr.internals_visible_to,
        keyfile = ctx.file.keyfile,
        langversion = ctx.attr.langversion,
        resources = ctx.files.resources,
        srcs = ctx.files.srcs,
        data = ctx.files.data,
        compile_data = ctx.files.compile_data,
        out = ctx.attr.out,
        target = "exe",
        target_name = ctx.attr.name,
        target_framework = tfm,
        toolchain = toolchain,
        strict_deps = ctx.attr.strict_deps if ctx.attr.override_strict_deps else toolchain.strict_deps[BuildSettingInfo].value,
        generate_documentation_file = ctx.attr.generate_documentation_file,
        treat_warnings_as_errors = ctx.attr.treat_warnings_as_errors if ctx.attr.override_treat_warnings_as_errors else toolchain.dotnetinfo.fsharp_treat_warnings_as_errors[BuildSettingInfo].value,
        warnings_as_errors = ctx.attr.warnings_as_errors if ctx.attr.override_warnings_as_errors else toolchain.dotnetinfo.fsharp_warnings_as_errors[BuildSettingInfo].value,
        warnings_not_as_errors = ctx.attr.warnings_not_as_errors if ctx.attr.override_warnings_not_as_errors else toolchain.dotnetinfo.fsharp_warnings_not_as_errors[BuildSettingInfo].value,
        warning_level = ctx.attr.warning_level if ctx.attr.override_warning_level else toolchain.dotnetinfo.fsharp_warning_level[BuildSettingInfo].value,
        project_sdk = ctx.attr.project_sdk,
    )

def _fsharp_test_impl(ctx):
    return build_binary(ctx, _compile_action)

fsharp_test = rule(
    _fsharp_test_impl,
    doc = """Compile a F# executable and runs it as a test""",
    attrs = FSHARP_BINARY_COMMON_ATTRS,
    test = True,
    toolchains = [
        "//dotnet:toolchain_type",
    ],
    cfg = tfm_transition,
)
