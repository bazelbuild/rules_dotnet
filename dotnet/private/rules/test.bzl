load(
    "//dotnet/private:context.bzl",
    "dotnet_context",
)
load(
    "//dotnet/private:providers.bzl",
    "DotnetLibraryInfo",
    "DotnetResourceListInfo",
)
load(
    "//dotnet/private:rules/runfiles.bzl",
    "CopyRunfiles",
)
load(
    "//dotnet/private:rules/data_with_dirs.bzl",
    "CopyDataWithDirs",
)
load("@io_bazel_rules_dotnet//dotnet/private:rules/versions.bzl", "parse_version")
load("@io_bazel_rules_dotnet//dotnet/private:rules/common.bzl", "collect_transitive_info")

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
        version = (0, 0, 0, 0, "") if ctx.attr.version == "" else parse_version(ctx.attr.version),
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

    # Calculate final runtiles including runtime-required files
    run_transitive = collect_transitive_info(ctx.attr.deps + ([ctx.attr.dotnet_context_data._runtime] if ctx.attr.dotnet_context_data._runtime != None else []))
    if dotnet.runner != None:
        direct_runfiles += dotnet.runner.files.to_list()

    if ctx.attr._xslt:
        transitive_runfiles.append(ctx.attr._xslt.files)

    transitive_runfiles += [t.runfiles for t in run_transitive]
    transitive_runfiles.append(ctx.attr.testlauncher[DotnetLibraryInfo].runfiles)
    transitive_runfiles += [t.runfiles for t in ctx.attr.testlauncher[DotnetLibraryInfo].transitive]
    transitive_runfiles.append(executable.runfiles)

    runfiles = ctx.runfiles(files = direct_runfiles, transitive_files = depset(transitive = transitive_runfiles))
    runfiles = CopyRunfiles(dotnet._ctx, runfiles, ctx.attr._copy, ctx.attr._symlink, executable, subdir)

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

core_xunit_test = rule(
    _unit_test,
    attrs = {
        "deps": attr.label_list(providers = [DotnetLibraryInfo], doc = "The direct dependencies of this library. These may be dotnet_library rules or compatible rules with the [DotnetLibraryInfo](api.md#dotnetlibraryinfo) provider."),
        "resources": attr.label_list(providers = [DotnetResourceListInfo], doc = "The list of resources to compile with. Usually provided via reference to [core_resx](api.md#core_resx) or the rules compatible with [DotnetResourceInfo](api.md#dotnetresourceinfo) provider."),
        "srcs": attr.label_list(allow_files = [".cs"], doc = "The list of .cs source files that are compiled to create the assembly."),
        "out": attr.string(doc = "An alternative name of the output file."),
        "defines": attr.string_list(doc = "The list of defines passed via /define compiler option."),
        "unsafe": attr.bool(default = False, doc = "If true passes /unsafe flag to the compiler."),
        "data": attr.label_list(allow_files = True, doc = "The list of additional files to include in the list of runfiles for the assembly."),
        "dotnet_context_data": attr.label(default = Label("@io_bazel_rules_dotnet//:core_context_data"), doc = "The reference to label created with [core_context_data rule](api.md#core_context_data). It points the SDK to be used for compiling given target."),
        "testlauncher": attr.label(default = "@xunit.runner.console//:netcoreapp2.1_core_tool", providers = [DotnetLibraryInfo], doc = "Test launcher to use."),
        "_launcher": attr.label(default = Label("//dotnet/tools/launcher_core_xunit:launcher_core_xunit.exe"), doc = "Test launcher to use."),
        "_copy": attr.label(default = Label("//dotnet/tools/copy")),
        "_symlink": attr.label(default = Label("//dotnet/tools/symlink")),
        "_xslt": attr.label(default = Label("@io_bazel_rules_dotnet//tools/converttests:n3.xslt"), allow_files = True),
        "keyfile": attr.label(allow_files = True, doc = "The key to sign the assembly with."),
        "_empty": attr.label(default = Label("//dotnet/tools/empty:empty.exe")),
        "nowarn": attr.string_list(doc = "The list of warnings to be ignored. The warnings are passed to -nowarn compiler opion."),
        "langversion": attr.string(default = "latest", doc = "Version of the language to use. See [this page](https://docs.microsoft.com/en-us/dotnet/csharp/language-reference/configure-language-version)."),
        "data_with_dirs": attr.label_keyed_string_dict(allow_files = True, doc = "Dictionary of {label:folder}. Files specified by <label> will be put in subdirectory <folder>."),
        "version": attr.string(doc = "Version to be set for the assembly. The version is set by compiling in [AssemblyVersion](https://docs.microsoft.com/en-us/troubleshoot/visualstudio/general/assembly-version-assembly-file-version) attribute."),
    },
    toolchains = ["@io_bazel_rules_dotnet//dotnet:toolchain_type_core"],
    executable = True,
    test = True,
    doc = """This builds a set of tests that can be run with ``bazel test``.

    To run all tests in the workspace, and print output on failure, run
    ```bash
    bazel test --test_output=errors //...
    ```

    You can run specific tests by passing the `--test_filter=pattern <test_filter_>` argument to Bazel.
    You can pass arguments to tests by passing `--test_arg=arg <test_arg_>`_ arguments to Bazel.

    """,
)

core_nunit3_test = rule(
    _unit_test,
    attrs = {
        "deps": attr.label_list(providers = [DotnetLibraryInfo], doc = "The direct dependencies of this library. These may be dotnet_library rules or compatible rules with the [DotnetLibraryInfo](api.md#dotnetlibraryinfo) provider."),
        "resources": attr.label_list(providers = [DotnetResourceListInfo], doc = "The list of resources to compile with. Usually provided via reference to [core_resx](api.md#core_resx) or the rules compatible with [DotnetResourceInfo](api.md#dotnetresourceinfo) provider."),
        "srcs": attr.label_list(allow_files = [".cs"], doc = "The list of .cs source files that are compiled to create the assembly."),
        "out": attr.string(doc = "An alternative name of the output file."),
        "defines": attr.string_list(doc = "The list of defines passed via /define compiler option."),
        "unsafe": attr.bool(default = False, doc = "If true passes /unsafe flag to the compiler."),
        "data": attr.label_list(allow_files = True, doc = "The list of additional files to include in the list of runfiles for the assembly."),
        "dotnet_context_data": attr.label(default = Label("@io_bazel_rules_dotnet//:core_context_data"), doc = "The reference to label created with [core_context_data rule](api.md#core_context_data). It points the SDK to be used for compiling given target."),
        "testlauncher": attr.label(default = "@vstest//:vstest.console.exe", providers = [DotnetLibraryInfo], doc = "Test launcher to use."),
        "_launcher": attr.label(default = Label("//dotnet/tools/launcher_core_nunit3:launcher_core_nunit3.exe")),
        "_copy": attr.label(default = Label("//dotnet/tools/copy")),
        "_symlink": attr.label(default = Label("//dotnet/tools/symlink")),
        "_xslt": attr.label(allow_files = True),
        "keyfile": attr.label(allow_files = True, doc = "The key to sign the assembly with."),
        "_empty": attr.label(default = Label("//dotnet/tools/empty:empty.exe")),
        "nowarn": attr.string_list(doc = "The list of warnings to be ignored. The warnings are passed to -nowarn compiler opion."),
        "langversion": attr.string(default = "latest", doc = "Version of the language to use. See [this page](https://docs.microsoft.com/en-us/dotnet/csharp/language-reference/configure-language-version)."),
        "data_with_dirs": attr.label_keyed_string_dict(
            allow_files = True,
            default = {
                "@vstest//:Microsoft.TestPlatform.TestHostRuntimeProvider.dll": "Extensions",
                "@NUnit3TestAdapter//:extension": ".",
                "@JunitXml.TestLogger//:extension": ".",
            },
            doc = "Dictionary of {label:folder}. Files specified by <label> will be put in subdirectory <folder>.",
        ),
        "version": attr.string(doc = "Version to be set for the assembly. The version is set by compiling in [AssemblyVersion](https://docs.microsoft.com/en-us/troubleshoot/visualstudio/general/assembly-version-assembly-file-version) attribute."),
    },
    toolchains = ["@io_bazel_rules_dotnet//dotnet:toolchain_type_core"],
    executable = True,
    test = True,
    doc = """This builds a set of tests that can be run with ``bazel test``.

    To run all tests in the workspace, and print output on failure, run
    ```bash
    bazel test --test_output=errors //...
    ```

    You can run specific tests by passing the `--test_filter=pattern <test_filter_>` argument to Bazel.
    You can pass arguments to tests by passing `--test_arg=arg <test_arg_>`_ arguments to Bazel.

    """,
)
