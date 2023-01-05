"""
Rule for compiling and running test binaries.

This rule can be used to compile and run any C# binary and run it as
a Bazel test.
"""

load("//dotnet/private/rules/csharp/actions:csharp_assembly.bzl", "AssemblyAction")
load("@bazel_skylib//rules:common_settings.bzl", "BuildSettingInfo")
load(
    "//dotnet/private:common.bzl",
    "is_debug",
)
load("//dotnet/private/rules/common:binary.bzl", "build_binary")
load("//dotnet/private/rules/common:attrs.bzl", "CSHARP_BINARY_COMMON_ATTRS")
load("//dotnet/private/transitions:tfm_transition.bzl", "tfm_transition")

def _compile_action(ctx, tfm):
    toolchain = ctx.toolchains["@rules_dotnet//dotnet:toolchain_type"]
    return AssemblyAction(
        ctx.actions,
        additionalfiles = ctx.files.additionalfiles,
        debug = is_debug(ctx),
        defines = ctx.attr.defines,
        deps = ctx.attr.deps,
        exports = [],
        private_deps = ctx.attr.private_deps,
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
        include_host_model_dll = False,
        treat_warnings_as_errors = ctx.attr.treat_warnings_as_errors if ctx.attr.override_treat_warnings_as_errors else toolchain.dotnetinfo.csharp_treat_warnings_as_errors[BuildSettingInfo].value,
        warnings_as_errors = ctx.attr.warnings_as_errors if ctx.attr.override_warnings_as_errors else toolchain.dotnetinfo.csharp_warnings_as_errors[BuildSettingInfo].value,
        warnings_not_as_errors = ctx.attr.warnings_not_as_errors if ctx.attr.override_warnings_not_as_errors else toolchain.dotnetinfo.csharp_warnings_not_as_errors[BuildSettingInfo].value,
        warning_level = ctx.attr.warning_level if ctx.attr.override_warning_level else toolchain.dotnetinfo.csharp_warning_level[BuildSettingInfo].value,
        project_sdk = ctx.attr.project_sdk,
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
