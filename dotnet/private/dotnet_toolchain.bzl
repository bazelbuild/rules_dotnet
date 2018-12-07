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

load(
    "@io_bazel_rules_dotnet//dotnet/private:common.bzl",
    "paths",
)
load("@io_bazel_rules_dotnet//dotnet/private:actions/assembly.bzl", "emit_assembly")
load("@io_bazel_rules_dotnet//dotnet/private:actions/resx.bzl", "emit_resx")

def _get_dotnet_runner(context_data, ext):
    for f in context_data._mono_bin.files:
        basename = paths.basename(f.path)
        if basename != "mono" + ext:
            continue
        return f
    fail("Could not find mono executable in dotnet_sdk (mono_bin)")

def _get_dotnet_mcs(context_data):
    for f in context_data._mcs_bin.files:
        basename = paths.basename(f.path)
        if basename != "mcs.exe":
            continue
        return f

    for f in context_data._lib.files:
        basename = paths.basename(f.path)
        if basename != "mcs.exe":
            continue
        return f
    fail("Could not find mcs.exe in dotnet_sdk (mcs_bin, lib)")

def _get_dotnet_resgen(context_data):
    for f in context_data._mcs_bin.files:
        basename = paths.basename(f.path)
        if basename != "resgen.exe":
            continue
        return f

    for f in context_data._lib.files:
        basename = paths.basename(f.path)
        if basename != "resgen.exe":
            continue
        return f

    fail("Could not find resgen.exe in dotnet_sdk (mcs_bin, lib)")

def _get_dotnet_tlbimp(context_data):
    return None

def _get_dotnet_stdlib(context_data):
    for f in context_data._lib.files:
        basename = paths.basename(f.path)
        if basename != "mscorlib.dll":
            continue
        dirname = paths.dirname(f.path)
        if dirname.find(context_data._libVersion) == -1:
            continue
        return f
    fail("Could not find mscorlib in dotnet_sdk (lib, %s)" % context_data._libVersion)

def _get_dotnet_stdlib_byname(shared, lib, libVersion, name):
    lname = name.lower()
    for f in lib.files:
        basename = paths.basename(f.path)
        if basename.lower() != lname:
            continue
        dirname = paths.dirname(f.path)
        if dirname.find(libVersion) == -1:
            continue
        return f
    fail("Could not find %s in dotnet_sdk (lib)" % name)

def _dotnet_toolchain_impl(ctx):
    return [platform_common.ToolchainInfo(
        name = ctx.label.name,
        default_dotnetimpl = ctx.attr.dotnetimpl,
        default_dotnetos = ctx.attr.dotnetos,
        default_dotnetarch = ctx.attr.dotnetarch,
        get_dotnet_runner = _get_dotnet_runner,
        get_dotnet_mcs = _get_dotnet_mcs,
        get_dotnet_resgen = _get_dotnet_resgen,
        get_dotnet_tlbimp = _get_dotnet_tlbimp,
        get_dotnet_stdlib = _get_dotnet_stdlib,
        actions = struct(
            assembly = emit_assembly,
            resx = emit_resx,
            com_ref = None,
            stdlib_byname = _get_dotnet_stdlib_byname,
        ),
        flags = struct(
            compile = (),
        ),
    )]

_dotnet_toolchain = rule(
    _dotnet_toolchain_impl,
    attrs = {
        # Minimum requirements to specify a toolchain
        "dotnetimpl": attr.string(mandatory = True),
        "dotnetos": attr.string(mandatory = True),
        "dotnetarch": attr.string(mandatory = True),
    },
)

def dotnet_toolchain(name, host, constraints = [], **kwargs):
    """See dotnet/toolchains.rst#dotnet-toolchain for full documentation."""

    elems = host.split("_")
    impl, os, arch = elems[0], elems[1], elems[2]
    host_constraints = constraints + [
        "@io_bazel_rules_dotnet//dotnet/toolchain:" + os,
        "@io_bazel_rules_dotnet//dotnet/toolchain:" + arch,
    ]

    impl_name = name + "-impl"
    _dotnet_toolchain(
        name = impl_name,
        dotnetimpl = impl,
        dotnetos = os,
        dotnetarch = arch,
        tags = ["manual"],
        visibility = ["//visibility:public"],
        **kwargs
    )
    native.toolchain(
        name = name,
        toolchain_type = "@io_bazel_rules_dotnet//dotnet:toolchain",
        exec_compatible_with = host_constraints,
        toolchain = ":" + impl_name,
    )
