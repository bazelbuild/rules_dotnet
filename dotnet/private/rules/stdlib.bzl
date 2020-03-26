load(
    "@io_bazel_rules_dotnet//dotnet/private:context.bzl",
    "dotnet_context",
)
load(
    "@io_bazel_rules_dotnet//dotnet/private:providers.bzl",
    "DotnetLibrary",
)

def _stdlib_impl(ctx):
    dotnet = dotnet_context(ctx)
    if ctx.attr.dll == "":
        name = ctx.label.name
    else:
        name = ctx.attr.dll

    if dotnet.stdlib_byname == None:
        library = dotnet.new_library(dotnet = dotnet)
        return [library]

    if ctx.attr.extra_shared_name:
        extra_shared = dotnet.extra_shared
        shared = None
        for i in extra_shared:
            if i.label.name.endswith(ctx.attr.extra_shared_name):
                shared = i
            
        if shared == None:
            fail("Shared " + ctx.attr.extra_shared_name + " was not found in " + ", ".join([str(i) for i in extra_shared]))
    else:
        shared = dotnet.shared
    result = dotnet.stdlib_byname(name = name, shared = shared, lib = dotnet.lib, libVersion = dotnet.libVersion)

    deps = ctx.attr.deps
    transitive = depset(direct = deps, transitive = [a[DotnetLibrary].transitive for a in deps])
    extra = depset(direct = [result], transitive = [t.files for t in ctx.attr.data])
    direct = extra.to_list()

    runfiles = depset(direct = direct, transitive = [a[DotnetLibrary].runfiles for a in deps])

    library = dotnet.new_library(
        dotnet = dotnet,
        name = name,
        deps = deps,
        transitive = transitive,
        runfiles = runfiles,
        result = result,
    )

    return [
        library,
        DefaultInfo(
            files = depset([library.result]),
            runfiles = ctx.runfiles(files = [], transitive_files = runfiles),
        ),
    ]

dotnet_stdlib = rule(
    _stdlib_impl,
    attrs = {
        "dll": attr.string(),
        "deps": attr.label_list(providers = [DotnetLibrary]),
        "data": attr.label_list(allow_files = True),
        "dotnet_context_data": attr.label(default = Label("@io_bazel_rules_dotnet//:dotnet_context_data")),
    },
    toolchains = ["@io_bazel_rules_dotnet//dotnet:toolchain"],
    executable = False,
)

core_stdlib = rule(
    _stdlib_impl,
    attrs = {
        "dll": attr.string(),
        "deps": attr.label_list(providers = [DotnetLibrary]),
        "data": attr.label_list(allow_files = True),
        "dotnet_context_data": attr.label(default = Label("@io_bazel_rules_dotnet//:core_context_data")),
        "extra_shared_name": attr.string(),
    },
    toolchains = ["@io_bazel_rules_dotnet//dotnet:toolchain_core"],
    executable = False,
)

net_stdlib = rule(
    _stdlib_impl,
    attrs = {
        "dll": attr.string(),
        "deps": attr.label_list(providers = [DotnetLibrary]),
        "data": attr.label_list(allow_files = True),
        "dotnet_context_data": attr.label(default = Label("@io_bazel_rules_dotnet//:net_context_data")),
    },
    toolchains = ["@io_bazel_rules_dotnet//dotnet:toolchain_net"],
    executable = False,
)
