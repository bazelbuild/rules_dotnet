# Copyright 2016 The Bazel Go Rules Authors. All rights reserved.
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#    http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
"""
Toolchain rules used by dotnet.
"""

load("@rules_dotnet_skylib//lib:paths.bzl", "paths")
load("@io_bazel_rules_dotnet//dotnet/private:actions/assembly_net.bzl", "emit_assembly_net")
load("@io_bazel_rules_dotnet//dotnet/private:actions/resx_net.bzl", "emit_resx_net")
load("@io_bazel_rules_dotnet//dotnet/private:actions/com_ref_net.bzl", "emit_com_ref_net")

def _get_dotnet_runner(context_data, ext):
    return None

def _get_dotnet_mcs(context_data):
    return context_data._csc

def _get_dotnet_resgen(context_data):
    return _get_dotnet_tool(context_data, "resgen.exe")

def _get_dotnet_tlbimp(context_data):
    return _get_dotnet_tool(context_data, "tlbimp.exe")

def _get_dotnet_tool(context_data, name):
    for f in context_data._tools.files.to_list():
        basename = paths.basename(f.path)
        if basename.lower() != name:
            continue
        return f
    fail("Could not find %s in net_sdk (tools)" % name)

def _get_dotnet_stdlib(context_data):
    for f in context_data._lib.files.to_list():
        basename = paths.basename(f.path)
        if basename != "mscorlib.dll":
            continue
        return f
    fail("Could not find mscorlib in net_sdk (lib, %s)" % context_data._libVersion)

def _get_dotnet_stdlib_byname(shared, lib, libVersion, name, attr_ref = None):
    lname = name.lower()
    for f in shared.files.to_list():
        basename = paths.basename(f.path)
        if basename.lower() != lname:
            continue
        return f
    fail("Could not find %s in net_sdk (shared)" % name)

def _net_toolchain_impl(ctx):
    return [platform_common.ToolchainInfo(
        name = ctx.label.name,
        dotnetimpl = ctx.attr.dotnetimpl,
        dotnetos = ctx.attr.dotnetos,
        dotnetarch = ctx.attr.dotnetarch,
        get_dotnet_runner = _get_dotnet_runner,
        get_dotnet_mcs = _get_dotnet_mcs,
        get_dotnet_resgen = _get_dotnet_resgen,
        get_dotnet_tlbimp = _get_dotnet_tlbimp,
        get_dotnet_stdlib = _get_dotnet_stdlib,
        actions = struct(
            assembly = emit_assembly_net,
            resx = emit_resx_net,
            com_ref = emit_com_ref_net,
            stdlib_byname = _get_dotnet_stdlib_byname,
        ),
        flags = struct(
            compile = (),
        ),
    )]

_net_toolchain = rule(
    _net_toolchain_impl,
    attrs = {
        # Minimum requirements to specify a toolchain
        "dotnetimpl": attr.string(mandatory = True),
        "dotnetos": attr.string(mandatory = True),
        "dotnetarch": attr.string(mandatory = True),
    },
)

def net_toolchain(name, arch, os, constraints, **kwargs):
    """See dotnet/toolchains.rst#net-toolchain for full documentation."""

    impl_name = name + "-impl"
    _net_toolchain(
        name = impl_name,
        dotnetimpl = "net",
        dotnetos = os,
        dotnetarch = arch,
        tags = ["manual"],
        visibility = ["//visibility:public"],
        **kwargs
    )
    native.toolchain(
        name = name,
        toolchain_type = "@io_bazel_rules_dotnet//dotnet:toolchain_type_net",
        exec_compatible_with = constraints,
        toolchain = ":" + impl_name,
    )
