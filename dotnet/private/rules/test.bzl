load(
    "@io_bazel_rules_dotnet//dotnet/private:context.bzl",
    "dotnet_context",
)
load(
    "@io_bazel_rules_dotnet//dotnet/private:providers.bzl",
    "DotnetLibrary",
    "DotnetResource",
)
load(
    "@io_bazel_rules_dotnet//dotnet/private:skylib/lib/paths.bzl",
    "paths",
)

def _unit_test(ctx):
    dotnet = dotnet_context(ctx)
    name = ctx.label.name

    if dotnet.assembly == None:
        empty = dotnet.declare_file(dotnet, path = "empty.exe")
        ctx.actions.run(
            outputs = [empty],
            inputs = ctx.attr._empty.files.to_list(),
            executable = ctx.attr._copy.files.to_list()[0],
            arguments = [empty.path, ctx.attr._empty.files.to_list()[0].path],
            mnemonic = "CopyEmpty",
        )

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
        executable = False,
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

    runfiles = ctx.runfiles(files = [launcher] + runner + ctx.attr.native_deps.files.to_list() + ctx.attr._xslt.files.to_list(), transitive_files = depset(transitive = [executable.runfiles, ctx.attr.testlauncher[DotnetLibrary].runfiles]))

    return [
        executable,
        DefaultInfo(
            files = depset([executable.result, launcher]),
            runfiles = runfiles,
            executable = launcher,
        ),
    ]

dotnet_nunit_test = rule(
    _unit_test,
    attrs = {
        "deps": attr.label_list(providers = [DotnetLibrary]),
        "resources": attr.label_list(providers = [DotnetResource]),
        "srcs": attr.label_list(allow_files = [".cs"]),
        "out": attr.string(),
        "defines": attr.string_list(),
        "unsafe": attr.bool(default = False),
        "data": attr.label_list(allow_files = True),
        "dotnet_context_data": attr.label(default = Label("@io_bazel_rules_dotnet//:dotnet_context_data")),
        "_manifest_prep": attr.label(default = Label("//dotnet/tools/manifest_prep")),
        "native_deps": attr.label(default = Label("@dotnet_sdk//:native_deps")),
        "testlauncher": attr.label(default = "@nunit2//:nunit-console-runner.exe", providers = [DotnetLibrary]),
        "_launcher": attr.label(default = Label("//dotnet/tools/launcher_mono_nunit:launcher_mono_nunit.exe")),
        "_copy": attr.label(default = Label("//dotnet/tools/copy")),
        "_xslt": attr.label(default = Label("@io_bazel_rules_dotnet//tools/converttests:n3.xslt"), allow_files = True),
        "keyfile": attr.label(allow_files = True),
        "_empty": attr.label(default = Label("//dotnet/tools/empty:empty.exe")),
    },
    toolchains = ["@io_bazel_rules_dotnet//dotnet:toolchain"],
    executable = True,
    test = True,
)

net_nunit_test = rule(
    _unit_test,
    attrs = {
        "deps": attr.label_list(providers = [DotnetLibrary]),
        "resources": attr.label_list(providers = [DotnetResource]),
        "srcs": attr.label_list(allow_files = [".cs"]),
        "out": attr.string(),
        "defines": attr.string_list(),
        "unsafe": attr.bool(default = False),
        "data": attr.label_list(allow_files = True),
        "dotnet_context_data": attr.label(default = Label("@io_bazel_rules_dotnet//:net_context_data")),
        "_manifest_prep": attr.label(default = Label("//dotnet/tools/manifest_prep")),
        "native_deps": attr.label(default = Label("@net_sdk//:native_deps")),
        "testlauncher": attr.label(default = "@nunit2//:net.nunit-console-runner.exe", providers = [DotnetLibrary]),
        "_launcher": attr.label(default = Label("//dotnet/tools/launcher_net_nunit:launcher_net_nunit.exe")),
        "_copy": attr.label(default = Label("//dotnet/tools/copy")),
        "_xslt": attr.label(default = Label("@io_bazel_rules_dotnet//tools/converttests:n3.xslt"), allow_files = True),
        "keyfile": attr.label(allow_files = True),
        "_empty": attr.label(default = Label("//dotnet/tools/empty:empty.exe")),
    },
    toolchains = ["@io_bazel_rules_dotnet//dotnet:toolchain_net"],
    executable = True,
    test = True,
)

net_nunit3_test = rule(
    _unit_test,
    attrs = {
        "deps": attr.label_list(providers = [DotnetLibrary]),
        "resources": attr.label_list(providers = [DotnetResource]),
        "srcs": attr.label_list(allow_files = [".cs"]),
        "out": attr.string(),
        "defines": attr.string_list(),
        "unsafe": attr.bool(default = False),
        "data": attr.label_list(allow_files = True),
        "dotnet_context_data": attr.label(default = Label("@io_bazel_rules_dotnet//:net_context_data")),
        "_manifest_prep": attr.label(default = Label("//dotnet/tools/manifest_prep")),
        "native_deps": attr.label(default = Label("@net_sdk//:native_deps")),
        "testlauncher": attr.label(default = "@nunit3_consolerunner//:nunit3.console.exe", providers = [DotnetLibrary]),
        "_launcher": attr.label(default = Label("//dotnet/tools/launcher_net_nunit3:launcher_net_nunit3.exe")),
        "_copy": attr.label(default = Label("//dotnet/tools/copy")),
        "_xslt": attr.label(default = Label("@io_bazel_rules_dotnet//tools/converttests:n3.xslt"), allow_files = True),
        "keyfile": attr.label(allow_files = True),
        "_empty": attr.label(default = Label("//dotnet/tools/empty:empty.exe")),
    },
    toolchains = ["@io_bazel_rules_dotnet//dotnet:toolchain_net"],
    executable = True,
    test = True,
)

core_xunit_test = rule(
    _unit_test,
    attrs = {
        "deps": attr.label_list(providers = [DotnetLibrary]),
        "resources": attr.label_list(providers = [DotnetResource]),
        "srcs": attr.label_list(allow_files = [".cs"]),
        "out": attr.string(),
        "defines": attr.string_list(),
        "unsafe": attr.bool(default = False),
        "data": attr.label_list(allow_files = True),
        "dotnet_context_data": attr.label(default = Label("@io_bazel_rules_dotnet//:core_context_data")),
        "native_deps": attr.label(default = Label("@core_sdk//:native_deps")),
        "testlauncher": attr.label(default = "@xunit//:xunit.console.exe", providers = [DotnetLibrary]),
        "_launcher": attr.label(default = Label("//dotnet/tools/launcher_core_xunit:launcher_core_xunit.exe")),
        "_copy": attr.label(default = Label("//dotnet/tools/copy")),
        "_xslt": attr.label(default = Label("@io_bazel_rules_dotnet//tools/converttests:n3.xslt"), allow_files = True),
        "keyfile": attr.label(allow_files = True),
        "_empty": attr.label(default = Label("//dotnet/tools/empty:empty.exe")),
    },
    toolchains = ["@io_bazel_rules_dotnet//dotnet:toolchain_core"],
    executable = True,
    test = True,
)

net_xunit_test = rule(
    _unit_test,
    attrs = {
        "deps": attr.label_list(providers = [DotnetLibrary]),
        "resources": attr.label_list(providers = [DotnetResource]),
        "srcs": attr.label_list(allow_files = [".cs"]),
        "out": attr.string(),
        "defines": attr.string_list(),
        "unsafe": attr.bool(default = False),
        "data": attr.label_list(allow_files = True),
        "dotnet_context_data": attr.label(default = Label("@io_bazel_rules_dotnet//:net_context_data")),
        "_manifest_prep": attr.label(default = Label("//dotnet/tools/manifest_prep")),
        "native_deps": attr.label(default = Label("@net_sdk//:native_deps")),
        "testlauncher": attr.label(default = "@xunit.runner.console//:net472_net_tool", providers = [DotnetLibrary]),
        "_launcher": attr.label(default = Label("//dotnet/tools/launcher_net_xunit:launcher_net_xunit.exe")),
        "_copy": attr.label(default = Label("//dotnet/tools/copy")),
        "_xslt": attr.label(default = Label("@io_bazel_rules_dotnet//tools/converttests:n3.xslt"), allow_files = True),
        "keyfile": attr.label(allow_files = True),
        "_empty": attr.label(default = Label("//dotnet/tools/empty:empty.exe")),
    },
    toolchains = ["@io_bazel_rules_dotnet//dotnet:toolchain_net"],
    executable = True,
    test = True,
)

dotnet_xunit_test = rule(
    _unit_test,
    attrs = {
        "deps": attr.label_list(providers = [DotnetLibrary]),
        "resources": attr.label_list(providers = [DotnetResource]),
        "srcs": attr.label_list(allow_files = [".cs"]),
        "out": attr.string(),
        "defines": attr.string_list(),
        "unsafe": attr.bool(default = False),
        "data": attr.label_list(allow_files = True),
        "dotnet_context_data": attr.label(default = Label("@io_bazel_rules_dotnet//:dotnet_context_data")),
        "_manifest_prep": attr.label(default = Label("//dotnet/tools/manifest_prep")),
        "native_deps": attr.label(default = Label("@dotnet_sdk//:native_deps")),
        "testlauncher": attr.label(default = "@xunit.runner.console//:mono_tool", providers = [DotnetLibrary]),
        "_launcher": attr.label(default = Label("//dotnet/tools/launcher_mono_xunit:launcher_mono_xunit.exe")),
        "_copy": attr.label(default = Label("//dotnet/tools/copy")),
        "_xslt": attr.label(default = Label("@io_bazel_rules_dotnet//tools/converttests:n3.xslt"), allow_files = True),
        "keyfile": attr.label(allow_files = True),
        "_empty": attr.label(default = Label("//dotnet/tools/empty:empty.exe")),
    },
    toolchains = ["@io_bazel_rules_dotnet//dotnet:toolchain"],
    executable = True,
    test = True,
)
