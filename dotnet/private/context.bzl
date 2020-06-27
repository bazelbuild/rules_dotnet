load(
    "@io_bazel_rules_dotnet//dotnet/private:providers.bzl",
    "DotnetLibrary",
    "DotnetResource",
)

DotnetContext = provider()

def _declare_file(dotnet, path = None, ext = None, sibling = None):
    result = path if path else dotnet._ctx.label.name
    if ext:
        result += ext
    return dotnet.actions.declare_file(result, sibling = sibling)

def new_library(dotnet, name = None, deps = None, transitive = None, result = None, pdb = None, runfiles = None, version = None, ref = None):
    return DotnetLibrary(
        name = dotnet.label.name if not name else name,
        label = dotnet.label,
        deps = deps,
        transitive = transitive,
        result = result,
        pdb = pdb,
        runfiles = runfiles,
        version = version,
        ref = ref,
    )

def _new_resource(dotnet, name, result, identifier = None, **kwargs):
    return DotnetResource(
        name = name,
        label = dotnet.label,
        result = result,
        identifier = result.basename if not identifier else identifier,
        **kwargs
    )

def dotnet_context(ctx, attr = None):
    if not attr:
        attr = ctx.attr

    context_data = attr.dotnet_context_data
    toolchain = ctx.toolchains[context_data._toolchain_type]

    ext = ""
    if toolchain.dotnetos == "windows":
        ext = ".exe"

    # Handle empty toolchain for .NET on linux and osx
    if toolchain.get_dotnet_runner == None:
        runner = None
        mcs = None
        stdlib = None
        resgen = None
        tlbimp = None
    else:
        runner = toolchain.get_dotnet_runner(context_data, ext)
        mcs = toolchain.get_dotnet_mcs(context_data)
        stdlib = toolchain.get_dotnet_stdlib(context_data)
        resgen = toolchain.get_dotnet_resgen(context_data)
        tlbimp = toolchain.get_dotnet_tlbimp(context_data)

    return DotnetContext(
        # Fields
        label = ctx.label,
        toolchain = toolchain,
        actions = ctx.actions,
        assembly = toolchain.actions.assembly,
        resx = toolchain.actions.resx,
        com_ref = toolchain.actions.com_ref,
        stdlib_byname = toolchain.actions.stdlib_byname,
        exe_extension = ext,
        runner = runner,
        mcs = mcs,
        stdlib = stdlib,
        resgen = resgen,
        tlbimp = tlbimp,
        declare_file = _declare_file,
        new_library = new_library,
        new_resource = _new_resource,
        workspace_name = ctx.workspace_name,
        libVersion = context_data._libVersion,
        framework = context_data._framework,
        lib = context_data._lib,
        shared = context_data._shared,
        debug = ctx.var["COMPILATION_MODE"] == "dbg",
        _ctx = ctx,
    )

def _dotnet_context_data(ctx):
    return struct(
        _mcs_bin = ctx.attr.mcs_bin,
        _mono_bin = ctx.attr.mono_bin,
        _lib = ctx.attr.lib,
        _tools = ctx.attr.tools,
        _shared = ctx.attr.shared,
        _host = ctx.attr.host,
        _libVersion = ctx.attr.libVersion,
        _toolchain_type = ctx.attr._toolchain_type,
        _framework = ctx.attr.framework,
        _runner = ctx.attr.runner,
        _csc = ctx.attr.csc,
        _runtime = ctx.attr.runtime,
    )

dotnet_context_data = rule(
    _dotnet_context_data,
    attrs = {
        "mcs_bin": attr.label(
            allow_files = True,
            default = "@dotnet_sdk//:mcs_bin",
        ),
        "mono_bin": attr.label(
            allow_files = True,
            default = "@dotnet_sdk//:mono_bin",
        ),
        "lib": attr.label(
            allow_files = True,
            default = "@dotnet_sdk//:lib",
        ),
        "tools": attr.label(
            allow_files = True,
            default = "@dotnet_sdk//:lib",
        ),
        "shared": attr.label(
            allow_files = True,
            default = "@dotnet_sdk//:lib",
        ),
        "host": attr.label(
            allow_files = True,
            default = "@dotnet_sdk//:lib",
        ),
        "runtime": attr.label(providers = [DotnetLibrary]),
        "libVersion": attr.string(
            default = "4.5",
        ),
        "framework": attr.string(
            default = "",
        ),
        "_toolchain_type": attr.string(
            default = "@io_bazel_rules_dotnet//dotnet:toolchain_type_mono",
        ),
        "runner": attr.label(executable = True, cfg = "host", default = "@dotnet_sdk//:runner"),
        "csc": attr.label(executable = True, cfg = "host", default = "@dotnet_sdk//:csc"),
    },
    toolchains = ["@io_bazel_rules_dotnet//dotnet:toolchain_type_mono"],
)

core_context_data = rule(
    _dotnet_context_data,
    attrs = {
        "mcs_bin": attr.label(
            allow_files = True,
        ),
        "mono_bin": attr.label(
            allow_files = True,
        ),
        "lib": attr.label(
            allow_files = True,
        ),
        "tools": attr.label(
            allow_files = True,
        ),
        "shared": attr.label(
            allow_files = True,
        ),
        "host": attr.label(
            allow_files = True,
        ),
        "runtime": attr.label(providers = [DotnetLibrary], default = "@io_bazel_rules_dotnet//dotnet/stdlib.core:runtime"),
        "libVersion": attr.string(
            default = "",
        ),
        "framework": attr.string(
            default = "",
        ),
        "_toolchain_type": attr.string(
            default = "@io_bazel_rules_dotnet//dotnet:toolchain_type_core",
        ),
        "runner": attr.label(executable = True, cfg = "host", default = "@core_sdk//:runner"),
        #"csc": attr.label(executable = True, cfg = "host", default = "@core_sdk//:csc"),
        "csc": attr.label(executable = True, cfg = "host", default = "@io_bazel_rules_dotnet//dotnet/stdlib.core:csc.dll"),
    },
    toolchains = ["@io_bazel_rules_dotnet//dotnet:toolchain_type_core"],
)

net_context_data = rule(
    _dotnet_context_data,
    attrs = {
        "mcs_bin": attr.label(
            allow_files = True,
            default = "@net_sdk//:mcs_bin",
        ),
        "mono_bin": attr.label(
            allow_files = True,
            default = "@net_sdk//:mono_bin",
        ),
        "lib": attr.label(
            allow_files = True,
            default = "@net_sdk//:lib",
        ),
        "tools": attr.label(
            allow_files = True,
            default = "@net_sdk//:tools",
        ),
        "shared": attr.label(
            allow_files = True,
            default = "@net_sdk//:lib",
        ),
        "host": attr.label(
            allow_files = True,
            default = "@net_sdk//:mcs_bin",
        ),
        "runtime": attr.label(providers = [DotnetLibrary]),
        "libVersion": attr.string(
            mandatory = True,
        ),
        "framework": attr.string(
            default = "",
        ),
        "_toolchain_type": attr.string(
            default = "@io_bazel_rules_dotnet//dotnet:toolchain_type_net",
        ),
        "runner": attr.label(default = None),
        "csc": attr.label(executable = True, cfg = "host", default = "@net_sdk//:csc"),
    },
    toolchains = ["@io_bazel_rules_dotnet//dotnet:toolchain_type_net"],
)
