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
    "@io_bazel_rules_dotnet//dotnet/private:rules/runfiles.bzl",
    "CopyRunfiles",
)
load(
    "@io_bazel_rules_dotnet//dotnet/private:rules/data_with_dirs.bzl",
    "CopyDataWithDirs",
)

def _unit_test(ctx):
    dotnet = dotnet_context(ctx)
    name = ctx.label.name
    subdir = name + "/"

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
        subdir = subdir,
        nowarn = ctx.attr.nowarn,
        langversion = ctx.attr.langversion,
    )

    launcher = dotnet.declare_file(dotnet, path = subdir + executable.result.basename + "_0.exe")
    ctx.actions.run(
        outputs = [launcher],
        inputs = ctx.attr._launcher.files.to_list(),
        executable = ctx.attr._copy.files.to_list()[0],
        arguments = [launcher.path, ctx.attr._launcher.files.to_list()[0].path],
        mnemonic = "CopyLauncher",
    )

    direct_runfiles = [launcher]
    transitive_runfiles = []

    if dotnet.runner != None:
        direct_runfiles.append(dotnet.runner)

    transitive_runfiles.append(ctx.attr.native_deps.files)
    if ctx.attr._xslt:
        transitive_runfiles.append(ctx.attr._xslt.files)

    transitive_runfiles.append(executable.runfiles)
    transitive_runfiles.append(ctx.attr.testlauncher[DotnetLibrary].runfiles)

    runfiles = ctx.runfiles(files = direct_runfiles, transitive_files = depset(transitive = transitive_runfiles))
    runfiles = CopyRunfiles(dotnet, runfiles, ctx.attr._copy, ctx.attr._symlink, executable, subdir)

    if ctx.attr.data_with_dirs:
        runfiles = runfiles.merge(CopyDataWithDirs(dotnet, ctx.attr.data_with_dirs, ctx.attr._copy, subdir))

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
        "testlauncher": attr.label(default = "@nunitrunnersv2//:mono_tool", providers = [DotnetLibrary]),
        "_launcher": attr.label(default = Label("//dotnet/tools/launcher_mono_nunit:launcher_mono_nunit.exe")),
        "_copy": attr.label(default = Label("//dotnet/tools/copy")),
        "_symlink": attr.label(default = Label("//dotnet/tools/symlink")),
        "_xslt": attr.label(default = Label("@io_bazel_rules_dotnet//tools/converttests:n3.xslt"), allow_files = True),
        "keyfile": attr.label(allow_files = True),
        "_empty": attr.label(default = Label("//dotnet/tools/empty:empty.exe")),
        "nowarn": attr.string_list(),
        "langversion": attr.string(default = "latest"),
        "data_with_dirs": attr.label_keyed_string_dict(allow_files = True),
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
        "testlauncher": attr.label(default = "@nunitrunnersv2//:netstandard1.0_net_tool", providers = [DotnetLibrary]),
        "_launcher": attr.label(default = Label("//dotnet/tools/launcher_net_nunit:launcher_net_nunit.exe")),
        "_copy": attr.label(default = Label("//dotnet/tools/copy")),
        "_symlink": attr.label(default = Label("//dotnet/tools/symlink")),
        "_xslt": attr.label(default = Label("@io_bazel_rules_dotnet//tools/converttests:n3.xslt"), allow_files = True),
        "keyfile": attr.label(allow_files = True),
        "_empty": attr.label(default = Label("//dotnet/tools/empty:empty.exe")),
        "nowarn": attr.string_list(),
        "langversion": attr.string(default = "latest"),
        "data_with_dirs": attr.label_keyed_string_dict(allow_files = True),
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
        "testlauncher": attr.label(default = "@nunit.consolerunner//:netstandard1.0_net_tool", providers = [DotnetLibrary]),
        "_launcher": attr.label(default = Label("//dotnet/tools/launcher_net_nunit3:launcher_net_nunit3.exe")),
        "_copy": attr.label(default = Label("//dotnet/tools/copy")),
        "_symlink": attr.label(default = Label("//dotnet/tools/symlink")),
        "_xslt": attr.label(default = Label("@io_bazel_rules_dotnet//tools/converttests:n3.xslt"), allow_files = True),
        "keyfile": attr.label(allow_files = True),
        "_empty": attr.label(default = Label("//dotnet/tools/empty:empty.exe")),
        "nowarn": attr.string_list(),
        "langversion": attr.string(default = "latest"),
        "data_with_dirs": attr.label_keyed_string_dict(allow_files = True),
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
        "testlauncher": attr.label(default = "@xunit.runner.console//:netcoreapp2.1_core_tool", providers = [DotnetLibrary]),
        "_launcher": attr.label(default = Label("//dotnet/tools/launcher_core_xunit:launcher_core_xunit.exe")),
        "_copy": attr.label(default = Label("//dotnet/tools/copy")),
        "_symlink": attr.label(default = Label("//dotnet/tools/symlink")),
        "_xslt": attr.label(default = Label("@io_bazel_rules_dotnet//tools/converttests:n3.xslt"), allow_files = True),
        "keyfile": attr.label(allow_files = True),
        "_empty": attr.label(default = Label("//dotnet/tools/empty:empty.exe")),
        "nowarn": attr.string_list(),
        "langversion": attr.string(default = "latest"),
        "data_with_dirs": attr.label_keyed_string_dict(allow_files = True),
    },
    toolchains = ["@io_bazel_rules_dotnet//dotnet:toolchain_core"],
    executable = True,
    test = True,
)

core_nunit3_test = rule(
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
        "testlauncher": attr.label(default = "@vstest//:vstest.console.exe", providers = [DotnetLibrary]),
        "_launcher": attr.label(default = Label("//dotnet/tools/launcher_core_nunit3:launcher_core_nunit3.exe")),
        "_copy": attr.label(default = Label("//dotnet/tools/copy")),
        "_symlink": attr.label(default = Label("//dotnet/tools/symlink")),
        "_xslt": attr.label(allow_files = True),
        "keyfile": attr.label(allow_files = True),
        "_empty": attr.label(default = Label("//dotnet/tools/empty:empty.exe")),
        "nowarn": attr.string_list(),
        "langversion": attr.string(default = "latest"),
        "data_with_dirs": attr.label_keyed_string_dict(
            allow_files = True,
            default = {
                "@vstest//:Microsoft.TestPlatform.TestHostRuntimeProvider.dll": "Extensions",
                "@NUnit3TestAdapter//:extension": "Extensions",
                "@JunitXml.TestLogger//:extension": "Extensions",
            },
        ),
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
        "_symlink": attr.label(default = Label("//dotnet/tools/symlink")),
        "_xslt": attr.label(default = Label("@io_bazel_rules_dotnet//tools/converttests:n3.xslt"), allow_files = True),
        "keyfile": attr.label(allow_files = True),
        "_empty": attr.label(default = Label("//dotnet/tools/empty:empty.exe")),
        "nowarn": attr.string_list(),
        "langversion": attr.string(default = "latest"),
        "data_with_dirs": attr.label_keyed_string_dict(allow_files = True),
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
        "_symlink": attr.label(default = Label("//dotnet/tools/symlink")),
        "_xslt": attr.label(default = Label("@io_bazel_rules_dotnet//tools/converttests:n3.xslt"), allow_files = True),
        "keyfile": attr.label(allow_files = True),
        "_empty": attr.label(default = Label("//dotnet/tools/empty:empty.exe")),
        "nowarn": attr.string_list(),
        "langversion": attr.string(default = "latest"),
        "data_with_dirs": attr.label_keyed_string_dict(allow_files = True),
    },
    toolchains = ["@io_bazel_rules_dotnet//dotnet:toolchain"],
    executable = True,
    test = True,
)
