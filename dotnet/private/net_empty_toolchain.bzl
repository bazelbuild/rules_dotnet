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
Since .NET is supoprted only on Windows, we cerate an empty toolchain which is used by net
rules on other platforms. This way targets specified for incompatible platforms gracefully
and silently are skupped
"""

def _net_empty_toolchain_impl(ctx):
    return [platform_common.ToolchainInfo(
        name = ctx.label.name,
        dotnetimpl = ctx.attr.dotnetimpl,
        dotnetos = ctx.attr.dotnetos,
        dotnetarch = ctx.attr.dotnetarch,
        get_dotnet_runner = None,
        get_dotnet_mcs = None,
        get_dotnet_resgen = None,
        get_dotnet_tlbimp = None,
        get_dotnet_stdlib = None,
        actions = struct(
            assembly = None,
            resx = None,
            com_ref = None,
            stdlib_byname = None,
        ),
        flags = struct(
            compile = (),
        ),
    )]

_net_empty_toolchain = rule(
    _net_empty_toolchain_impl,
    attrs = {
        # Minimum requirements to specify a toolchain
        "dotnetimpl": attr.string(mandatory = True),
        "dotnetos": attr.string(mandatory = True),
        "dotnetarch": attr.string(mandatory = True),
    },
)

def net_empty_toolchain(name, arch, os, constraints, **kwargs):
    """See dotnet/toolchains.rst#net-toolchain for full documentation."""

    impl_name = name + "-impl"
    _net_empty_toolchain(
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
