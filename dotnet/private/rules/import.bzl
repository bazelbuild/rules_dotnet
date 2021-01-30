load(
    "//dotnet/private:common.bzl",
    "as_iterable",
)
load(
    "//dotnet/private:context.bzl",
    "new_library",
)
load(
    "//dotnet/private:providers.bzl",
    "DotnetLibraryInfo",
)
load("@io_bazel_rules_dotnet//dotnet/private:rules/common.bzl", "collect_transitive_info")
load("@io_bazel_rules_dotnet//dotnet/private:rules/versions.bzl", "parse_version")
load("@io_bazel_rules_dotnet//dotnet/private:rules/runfiles.bzl", "CopyRunfiles")

def _import_library_impl(ctx):
    name = ctx.label.name

    deps = ctx.attr.deps
    src = ctx.attr.src
    result = src.files.to_list()[0]

    transitive = collect_transitive_info(deps)

    direct_runfiles = []
    direct_runfiles.append(result)

    if ctx.attr.data:
        data_l = [f for t in ctx.attr.data for f in as_iterable(t.files)]
        direct_runfiles += data_l

    runfiles = depset(direct = direct_runfiles)

    library = DotnetLibraryInfo(
        name = name,
        deps = deps,
        transitive = transitive,
        runfiles = runfiles,
        result = result,
        version = parse_version(ctx.attr.version),
        ref = ctx.attr.ref.files.to_list()[0] if ctx.attr.ref != None else result,
    )

    return [
        library,
        DefaultInfo(
            files = depset([library.result]),
            runfiles = ctx.runfiles(files = library.runfiles.to_list(), transitive_files = depset(transitive = [t.runfiles for t in library.transitive])),
        ),
    ]

def _import_binary_internal_impl(ctx):
    name = ctx.label.name

    deps = ctx.attr.deps
    src = ctx.attr.src

    # Binary import needs to be copied to be usable
    result = ctx.actions.declare_file(name)
    ctx.actions.run(
        outputs = [result],
        inputs = src.files.to_list(),
        executable = ctx.attr._copy.files.to_list()[0],
        arguments = [result.path, src.files.to_list()[0].path],
        mnemonic = "CopySrc",
    )

    transitive = collect_transitive_info(deps)

    direct_runfiles = []
    direct_runfiles.append(result)

    if ctx.attr.data:
        data_l = [f for t in ctx.attr.data for f in as_iterable(t.files)]
        direct_runfiles += data_l

    runfiles = depset(direct = direct_runfiles)

    executable = new_library(
        dotnet = ctx,
        name = name,
        deps = deps,
        transitive = transitive,
        runfiles = runfiles,
        result = result,
        version = parse_version(ctx.attr.version),
        ref = ctx.attr.ref.files.to_list()[0] if ctx.attr.ref != None else result,
    )

    launcher = ctx.actions.declare_file(executable.result.basename + "_0.exe")
    ctx.actions.run(
        outputs = [launcher],
        inputs = ctx.attr._launcher.files.to_list(),
        executable = ctx.attr._copy.files.to_list()[0],
        arguments = [launcher.path, ctx.attr._launcher.files.to_list()[0].path],
        mnemonic = "CopyLauncher",
    )

    # Calculate final runtiles including runtime-required files
    run_transitive = collect_transitive_info(ctx.attr.deps + ([ctx.attr.runtime] if ctx.attr.runtime != None else []))
    if ctx.attr.runner != None:
        direct_runfiles += ctx.attr.runner.files.to_list()

    runfiles = ctx.runfiles(files = direct_runfiles, transitive_files = depset(transitive = [t.runfiles for t in run_transitive] + [executable.runfiles]))
    runfiles = CopyRunfiles(ctx, runfiles, ctx.attr._copy, ctx.attr._symlink, executable, "./")

    return [
        executable,
        DefaultInfo(
            files = depset([executable.result]),
            runfiles = runfiles,
            executable = result,
        ),
    ]

core_import_library = rule(
    _import_library_impl,
    attrs = {
        "deps": attr.label_list(providers = [DotnetLibraryInfo], doc = "The direct dependencies of this dll. These may be [core_library](api.md#core_library) rules or compatible rules with the [DotnetLibraryInfo](api.md#dotnetlibraryinfo) provider."),
        "src": attr.label(allow_files = [".dll", ".exe"], mandatory = True, doc = "The file to be transformed into [DotnetLibraryInfo](api.md#dotnetlibraryinfo) provider."),
        "data": attr.label_list(allow_files = True, doc = "Additional files to copy with the target assembly. "),
        "version": attr.string(mandatory = True, doc = "Version of the imported assembly."),
        "ref": attr.label(allow_files = True, mandatory = False, doc = "[Reference assembly](https://docs.microsoft.com/en-us/dotnet/standard/assembly/reference-assemblies) for given library."),
    },
    provides = [DotnetLibraryInfo],
    executable = False,
    doc = "This imports an external dll and transforms it into [DotnetLibraryInfo](api.md#dotnetlibraryinfo) so it can be referenced as dependency by other rules.",
)

core_import_binary = rule(
    _import_library_impl,
    attrs = {
        "deps": attr.label_list(providers = [DotnetLibraryInfo], doc = "The direct dependencies of this dll. These may be [core_library](api.md#core_library) rules or compatible rules with the [DotnetLibraryInfo](api.md#dotnetlibraryinfo) provider."),
        "src": attr.label(allow_files = [".dll", ".exe"], mandatory = True, doc = "The file to be transformed into [DotnetLibraryInfo](api.md#dotnetlibraryinfo) provider."),
        "data": attr.label_list(allow_files = True, doc = "Additional files to copy with the target assembly."),
        "version": attr.string(mandatory = True, doc = "Version of the imported assembly."),
        "ref": attr.label(allow_files = True, mandatory = False, doc = "[Reference assembly](https://docs.microsoft.com/en-us/dotnet/standard/assembly/reference-assemblies) for given library."),
    },
    executable = False,
    doc = """This imports an external assembly and transforms it into .NET Core binary. 
    
    #TODO: it is identical to [core_import_library](api.md#core_import_library). Maybe [core_import_binary_internal](api.md#core_import_binary_internal) should be used instead?
    """,
)

core_import_binary_internal = rule(
    _import_binary_internal_impl,
    attrs = {
        "deps": attr.label_list(providers = [DotnetLibraryInfo], doc = "The direct dependencies of this dll. These may be [core_library](api.md#core_library) rules or compatible rules with the [DotnetLibraryInfo](api.md#dotnetlibraryinfo) provider."),
        "src": attr.label(allow_files = [".dll", ".exe"], mandatory = True, doc = "The file to be transformed into [DotnetLibraryInfo](api.md#dotnetlibraryinfo) provider."),
        "data": attr.label_list(allow_files = True, doc = "Additional files to copy with the target assembly."),
        "version": attr.string(mandatory = True, doc = "Version of the imported assembly."),
        "ref": attr.label(allow_files = True, mandatory = False, doc = "[Reference assembly](https://docs.microsoft.com/en-us/dotnet/standard/assembly/reference-assemblies) for given library."),
        "_launcher": attr.label(default = Label("//dotnet/tools/launcher_core:launcher_core.exe")),
        "_copy": attr.label(default = Label("//dotnet/tools/copy")),
        "_symlink": attr.label(default = Label("//dotnet/tools/symlink")),
        "runtime": attr.label(providers = [DotnetLibraryInfo], default = "@io_bazel_rules_dotnet//dotnet/stdlib.core:runtime"),
        "runner": attr.label(default = "@core_sdk//:runner"),
    },
    executable = True,
    doc = "The rules imports binary and implements all necessary wraping to allow for executing provided assembly.",
)
