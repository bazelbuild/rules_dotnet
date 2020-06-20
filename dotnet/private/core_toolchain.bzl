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
load("@io_bazel_rules_dotnet//dotnet/private:actions/assembly_core.bzl", "emit_assembly_core")
load("@io_bazel_rules_dotnet//dotnet/private:actions/resx_core.bzl", "emit_resx_core")

def _get_dotnet_runner(context_data, ext):
    return context_data._runner

def _get_dotnet_mcs(context_data):
    return context_data._csc

def _get_dotnet_resgen(context_data):
    return None

def _get_dotnet_tlbimp(context_data):
    return None

def _get_dotnet_stdlib(context_data):
    return None

def _get_dotnet_stdlib_byname(shared, lib, libVersion, name, attr_ref = None):
    lname = name.lower()
    for f in shared.files.to_list():
        basename = paths.basename(f.path)
        if basename.lower() != lname:
            continue
        return f

    for f in lib.files.to_list():
        basename = paths.basename(f.path)
        if basename.lower() != lname:
            continue
        return f
    if attr_ref:
        return attr_ref.files.to_list()[0]
    else:
        fail("Could not find %s in core_sdk (shared, lib)" % name)

def _core_toolchain_impl(ctx):
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
            assembly = emit_assembly_core,
            resx = emit_resx_core,
            com_ref = None,
            stdlib_byname = _get_dotnet_stdlib_byname,
        ),
        flags = struct(
            compile = (),
        ),
    )]

_core_toolchain = rule(
    _core_toolchain_impl,
    attrs = {
        # Minimum requirements to specify a toolchain
        "dotnetimpl": attr.string(mandatory = True),
        "dotnetos": attr.string(mandatory = True),
        "dotnetarch": attr.string(mandatory = True),
    },
)

def core_toolchain(name, arch, os,  constraints, **kwargs):
    """See dotnet/toolchains.rst#core-toolchain for full documentation."""

    impl_name = name + "-impl"
    _core_toolchain(
        name = impl_name,
        dotnetimpl = "core",
        dotnetos = os,
        dotnetarch = arch,
        tags = ["manual"],
        visibility = ["//visibility:public"],
        **kwargs
    )

    native.toolchain(
        name = name,
        toolchain_type = "@io_bazel_rules_dotnet//dotnet:toolchain_type_core",
        exec_compatible_with = constraints,
        toolchain = ":" + impl_name,
    )
