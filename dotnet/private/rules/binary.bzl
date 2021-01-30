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
load("@io_bazel_rules_dotnet//dotnet/platform:list.bzl", "DOTNET_CORE_FRAMEWORKS", "DOTNET_NETSTANDARD")
load("@io_bazel_rules_dotnet//dotnet/private:rules/versions.bzl", "parse_version")
load("@io_bazel_rules_dotnet//dotnet/private:rules/common.bzl", "collect_transitive_info")

def _binary_impl(ctx):
    """_binary_impl emits actions for compiling executable assembly."""
    dotnet = dotnet_context(ctx)
    name = ctx.label.name
    subdir = name + "/"

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
        subdir = subdir,
        target_framework = ctx.attr.target_framework,
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

    # Calculate final runtiles including runtime-required files
    run_transitive = collect_transitive_info(ctx.attr.deps + ([ctx.attr.dotnet_context_data._runtime] if ctx.attr.dotnet_context_data._runtime != None else []))
    direct_runfiles = []
    if dotnet.runner != None:
        direct_runfiles += dotnet.runner.files.to_list()

    #runfiles = ctx.runfiles(files = runner + ctx.attr.native_dep.files.to_list(), transitive_files = depset(transitive = [t.runfiles for t in executable.transitive]))
    runfiles = ctx.runfiles(files = direct_runfiles, transitive_files = depset(transitive = [t.runfiles for t in run_transitive] + [executable.runfiles]))
    runfiles = CopyRunfiles(dotnet._ctx, runfiles, ctx.attr._copy, ctx.attr._symlink, executable, subdir)

    return [
        executable,
        DefaultInfo(
            files = depset([executable.result, launcher]),
            runfiles = runfiles,
            executable = launcher,
        ),
    ]

core_binary = rule(
    _binary_impl,
    attrs = {
        "deps": attr.label_list(providers = [DotnetLibraryInfo], doc = "The direct dependencies of this library. These may be dotnet_library rules or compatible rules with the [DotnetLibraryInfo](api.md#dotnetlibraryinfo) provider."),
        "version": attr.string(doc = "Version to be set for the assembly. The version is set by compiling in [AssemblyVersion](https://docs.microsoft.com/en-us/troubleshoot/visualstudio/general/assembly-version-assembly-file-version) attribute."),
        "resources": attr.label_list(providers = [DotnetResourceListInfo], doc = "The list of resources to compile with. Usually provided via reference to [core_resx](api.md#core_resx) or the rules compatible with [DotnetResourceInfo](api.md#dotnetresourceinfo) provider."),
        "srcs": attr.label_list(allow_files = [".cs"], doc = "The list of .cs source files that are compiled to create the assembly."),
        "out": attr.string(doc = "An alternative name of the output file."),
        "defines": attr.string_list(doc = "The list of defines passed via /define compiler option."),
        "unsafe": attr.bool(default = False, doc = "If true passes /unsafe flag to the compiler."),
        "data": attr.label_list(allow_files = True, doc = "The list of additional files to include in the list of runfiles for the assembly."),
        "keyfile": attr.label(allow_files = True, doc = "The key to sign the assembly with."),
        "dotnet_context_data": attr.label(default = Label("@io_bazel_rules_dotnet//:core_context_data"), doc = "The reference to label created with [core_context_data rule](api.md#core_context_data). It points the SDK to be used for compiling given target."),
        "_launcher": attr.label(default = Label("//dotnet/tools/launcher_core:launcher_core.exe")),
        "_copy": attr.label(default = Label("//dotnet/tools/copy")),
        "_symlink": attr.label(default = Label("//dotnet/tools/symlink")),
        "target_framework": attr.string(values = DOTNET_CORE_FRAMEWORKS.keys() + DOTNET_NETSTANDARD.keys() + [""], default = "", doc = "Target framework."),
        "nowarn": attr.string_list(doc = "The list of warnings to be ignored. The warnings are passed to -nowarn compiler opion."),
        "langversion": attr.string(default = "latest", doc = "Version of the language to use. See [this page](https://docs.microsoft.com/en-us/dotnet/csharp/language-reference/configure-language-version)."),
    },
    toolchains = ["@io_bazel_rules_dotnet//dotnet:toolchain_type_core"],
    executable = True,
    doc = """This builds an executable from a set of source files.
    
    You can run the binary with ``bazel run``, or you can build it with ``bazel build`` and run it directly.

    Providers
    ^^^^^^^^^

    * [DotnetLibraryInfo](api.md#dotnetlibraryinfo)
    * [DotnetResourceInfo](api.md#dotnetresourceinfo)

    Example:
    ^^^^^^^^
    ```python
    core_binary(
        name = "Program.exe",
        srcs = [
            "Program.cs",
        ],
        deps = [
            "@io_bazel_rules_dotnet//dotnet/stdlib.core:libraryset",
        ],
    )
    ```
    """,
)
