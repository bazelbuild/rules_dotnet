load("@io_bazel_rules_dotnet//dotnet/private:context.bzl", "dotnet_context")
load(
    "@io_bazel_rules_dotnet//dotnet/private:providers.bzl",
    "DotnetLibrary",
    "DotnetResourceList",
)
load("@io_bazel_rules_dotnet//dotnet/platform:list.bzl", "DOTNET_CORE_FRAMEWORKS", "DOTNET_NETSTANDARD", "DOTNET_NET_FRAMEWORKS")

def _library_impl(ctx):
    """_library_impl emits actions for compiling dotnet executable assembly."""
    dotnet = dotnet_context(ctx)
    name = ctx.label.name

    # Handle case of empty toolchain on linux and darwin
    if dotnet.assembly == None:
        library = dotnet.new_library(dotnet = dotnet)
        return [library]

    library = dotnet.assembly(
        dotnet,
        name = name,
        srcs = ctx.attr.srcs,
        deps = ctx.attr.deps,
        resources = ctx.attr.resources,
        out = ctx.attr.out,
        defines = ctx.attr.defines,
        unsafe = ctx.attr.unsafe,
        data = ctx.attr.data,
        keyfile = ctx.attr.keyfile,
        executable = False,
        target_framework = ctx.attr.target_framework,
        nowarn = ctx.attr.nowarn,
        langversion = ctx.attr.langversion,
    )

    runfiles = ctx.runfiles(files = [], transitive_files = library.runfiles)

    return [
        library,
        DefaultInfo(
            files = depset([library.result]),
            runfiles = runfiles,
        ),
    ]

dotnet_library = rule(
    _library_impl,
    attrs = {
        "deps": attr.label_list(providers = [DotnetLibrary]),
        "resources": attr.label_list(providers = [DotnetResourceList]),
        "srcs": attr.label_list(allow_files = [".cs"]),
        "out": attr.string(),
        "defines": attr.string_list(),
        "unsafe": attr.bool(default = False),
        "data": attr.label_list(allow_files = True),
        "keyfile": attr.label(allow_files = True),
        "dotnet_context_data": attr.label(default = Label("@io_bazel_rules_dotnet//:dotnet_context_data")),
        "target_framework": attr.string(values = DOTNET_NET_FRAMEWORKS.keys() + DOTNET_NETSTANDARD.keys() + [""], default = ""),
        "nowarn": attr.string_list(),
        "langversion": attr.string(default = "latest"),
    },
    toolchains = ["@io_bazel_rules_dotnet//dotnet:toolchain"],
    executable = False,
)

core_library = rule(
    _library_impl,
    attrs = {
        "deps": attr.label_list(providers = [DotnetLibrary]),
        "resources": attr.label_list(providers = [DotnetResourceList]),
        "srcs": attr.label_list(allow_files = [".cs"]),
        "out": attr.string(),
        "defines": attr.string_list(),
        "unsafe": attr.bool(default = False),
        "data": attr.label_list(allow_files = True),
        "keyfile": attr.label(allow_files = True),
        "dotnet_context_data": attr.label(default = Label("@io_bazel_rules_dotnet//:core_context_data")),
        "target_framework": attr.string(values = DOTNET_CORE_FRAMEWORKS.keys() + DOTNET_NETSTANDARD.keys() + [""], default = ""),
        "nowarn": attr.string_list(),
        "langversion": attr.string(default = "latest"),
    },
    toolchains = ["@io_bazel_rules_dotnet//dotnet:toolchain_core"],
    executable = False,
)

net_library = rule(
    _library_impl,
    attrs = {
        "deps": attr.label_list(providers = [DotnetLibrary]),
        "resources": attr.label_list(providers = [DotnetResourceList]),
        "srcs": attr.label_list(allow_files = [".cs"]),
        "out": attr.string(),
        "defines": attr.string_list(),
        "unsafe": attr.bool(default = False),
        "data": attr.label_list(allow_files = True),
        "keyfile": attr.label(allow_files = True),
        "dotnet_context_data": attr.label(default = Label("@io_bazel_rules_dotnet//:net_context_data")),
        "target_framework": attr.string(values = DOTNET_NET_FRAMEWORKS.keys() + DOTNET_NETSTANDARD.keys() + [""], default = ""),
        "nowarn": attr.string_list(),
        "langversion": attr.string(default = "latest"),
    },
    toolchains = ["@io_bazel_rules_dotnet//dotnet:toolchain_net"],
    executable = False,
)
