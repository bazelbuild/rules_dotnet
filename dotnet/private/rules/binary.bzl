load(
    "@io_bazel_rules_dotnet//dotnet/private:context.bzl",
    "dotnet_context",
)
load(
    "@io_bazel_rules_dotnet//dotnet/private:providers.bzl",
    "DotnetLibrary",
    "DotnetResource",
    "DotnetResourceList",
)
load(
    "@io_bazel_rules_dotnet//dotnet/private:skylib/lib/paths.bzl",
    "paths",
)

def CopyRunfiles(dotnet, runfiles, copy, executable):
    created = []
    for f in runfiles.files.to_list():
        if f.basename != executable.result.basename:
            if f.basename.find("hostfxr") >= 0:
                version = f.path.split("/")
                newfile = dotnet.declare_file(dotnet, path = "host/fxr/{}/{}".format(version[-2], version[-1]))
            else:
                newfile = dotnet.declare_file(dotnet, path = f.basename)
            dotnet.actions.run(
                outputs = [newfile],
                inputs = [f],
                executable = copy.files.to_list()[0],
                arguments = [newfile.path, f.path],
                mnemonic = "CopyFile",
            )
            created.append(newfile)

    return dotnet._ctx.runfiles(files = created)

def _binary_impl(ctx):
    """_binary_impl emits actions for compiling executable assembly."""
    dotnet = dotnet_context(ctx)
    name = ctx.label.name

    if dotnet.assembly == None:
        empty = dotnet.declare_file(dotnet, path = "empty.sh")
        dotnet.actions.write(output = empty, content = "echo assembly generations is not supported on this platform'")
        library = dotnet.new_library(dotnet = dotnet)
        return [library, DefaultInfo(executable = empty)]

    executable = dotnet.assembly(
        dotnet,
        name = name,
        srcs = ctx.attr.srcs,
        deps = ctx.attr.deps,
        resources = ctx.attr.resources,
        out = ctx.attr.out,
        defines = ctx.attr.defines,
        unsafe = ctx.attr.unsafe,
        data = ctx.attr.data,
        executable = True,
        keyfile = ctx.attr.keyfile,
    )

    launcher = dotnet.declare_file(dotnet, path = executable.result.basename + "_0.exe")
    ctx.actions.run(
        outputs = [launcher],
        inputs = ctx.attr._launcher.files.to_list(),
        executable = ctx.attr._copy.files.to_list()[0],
        arguments = [launcher.path, ctx.attr._launcher.files.to_list()[0].path],
        mnemonic = "CopyLauncher",
    )

    if dotnet.runner != None:
        runner = [dotnet.runner]
    else:
        runner = []

    #runfiles = ctx.runfiles(files = [launcher] + runner + ctx.attr.native_deps.files.to_list(), transitive_files = executable.runfiles)
    runfiles = ctx.runfiles(files = runner + ctx.attr.native_deps.files.to_list(), transitive_files = executable.runfiles)

    runfiles = CopyRunfiles(dotnet, runfiles, ctx.attr._copy, executable)

    return [
        executable,
        DefaultInfo(
            files = depset([executable.result, launcher]),
            runfiles = runfiles,
            executable = launcher,
        ),
    ]

dotnet_binary = rule(
    _binary_impl,
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
        "native_deps": attr.label(default = Label("@dotnet_sdk//:native_deps")),
        "_launcher": attr.label(default = Label("//dotnet/tools/launcher_mono:launcher_mono.exe")),
        "_copy": attr.label(default = Label("//dotnet/tools/copy")),
    },
    toolchains = ["@io_bazel_rules_dotnet//dotnet:toolchain"],
    executable = True,
)

core_binary = rule(
    _binary_impl,
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
        "native_deps": attr.label(default = Label("@core_sdk//:native_deps")),
        "_launcher": attr.label(default = Label("//dotnet/tools/launcher_core:launcher_core.exe")),
        "_copy": attr.label(default = Label("//dotnet/tools/copy")),
    },
    toolchains = ["@io_bazel_rules_dotnet//dotnet:toolchain_core"],
    executable = True,
)

net_binary = rule(
    _binary_impl,
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
        "native_deps": attr.label(default = Label("@net_sdk//:native_deps")),
        "_launcher": attr.label(default = Label("//dotnet/tools/launcher_net:launcher_net.exe")),
        "_copy": attr.label(default = Label("//dotnet/tools/copy")),
    },
    toolchains = ["@io_bazel_rules_dotnet//dotnet:toolchain_net"],
    executable = True,
)
