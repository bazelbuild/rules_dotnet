"""
Toolchain rules used by dotnet.
"""

# load("@rules_dotnet_skylib//lib:paths.bzl", "paths")
load("@io_bazel_rules_dotnet//dotnet/private:actions/assembly_core.bzl", "emit_assembly_core")
load("@io_bazel_rules_dotnet//dotnet/private:actions/resx_core.bzl", "emit_resx_core")

def _core_toolchain_impl(ctx):
    return [platform_common.ToolchainInfo(
        name = ctx.label.name,
        os = ctx.attr.os,
        arch = ctx.attr.arch,
        os_exec = ctx.attr.os_exec,
        arch_exec = ctx.attr.arch_exec,
        sdk_version = ctx.attr.sdk_version,
        runtime_version = ctx.attr.runtime_version,
        sdk_exec_csc = ctx.attr.sdk_exec_csc,
        sdk_exec_runner = ctx.attr.sdk_exec_runner,
        sdk_target_host = ctx.attr.sdk_target_host,
        sdk_target_runner = ctx.attr.sdk_target_runner,
        sdk_runtime = ctx.attr.sdk_runtime,
        # get_dotnet_runner = _get_dotnet_runner,
        # get_dotnet_mcs = _get_dotnet_mcs,
        # get_dotnet_resgen = _get_dotnet_resgen,
        # get_dotnet_stdlib = _get_dotnet_stdlib,
        actions = struct(
            assembly = emit_assembly_core,
            resx = emit_resx_core,
            com_ref = None,
            #stdlib_byname = _get_dotnet_stdlib_byname,
            stdlib_byname = None,
        ),
        flags = struct(
            compile = (),
        ),
    )]

_core_toolchain = rule(
    _core_toolchain_impl,
    attrs = {
        # Minimum requirements to specify a toolchain
        "os": attr.string(mandatory = True),
        "arch": attr.string(mandatory = True),
        "os_exec": attr.string(mandatory = True),
        "arch_exec": attr.string(mandatory = True),
        "sdk_version": attr.string(mandatory = True),
        "runtime_version": attr.string(mandatory = True),
        "sdk_exec_csc": attr.label(mandatory = True),
        "sdk_exec_runner": attr.label(mandatory = True),
        "sdk_target_host": attr.label(mandatory = True),
        "sdk_target_runner": attr.label(mandatory = True),
        "sdk_runtime": attr.label(mandatory = True),
    },
)

def core_toolchain(name, os, arch, os_exec, arch_exec, sdk_version, runtime_version, constraints_target, constraints_exec):
    """See dotnet/toolchains.rst#core-toolchain for full documentation."""

    impl_name = name + "-impl"
    _core_toolchain(
        name = impl_name,
        os = os,
        arch = arch,
        os_exec = os_exec,
        arch_exec = arch_exec,
        sdk_version = sdk_version,
        runtime_version = runtime_version,
        sdk_exec_csc = "@core_sdk_{}_{}_{}//:csc".format(os_exec, arch_exec, sdk_version),
        sdk_exec_runner = "@core_sdk_{}_{}_{}//:runner".format(os_exec, arch_exec, sdk_version),
        sdk_target_host = "@core_sdk_{}_{}_{}//:host".format(os, arch, sdk_version),
        sdk_target_runner = "@core_sdk_{}_{}_{}//:runner".format(os, arch, sdk_version),
        sdk_runtime = "@core_sdk_{}_{}_{}//:runtime".format(os_exec, arch_exec, sdk_version),
        tags = ["manual"],
        visibility = ["//visibility:public"],
    )

    native.toolchain(
        name = name,
        toolchain_type = "@io_bazel_rules_dotnet//dotnet:toolchain_type_core",
        exec_compatible_with = constraints_exec,
        target_compatible_with = constraints_target,
        toolchain = ":" + impl_name,
    )
