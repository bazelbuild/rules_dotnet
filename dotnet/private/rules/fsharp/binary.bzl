load("//dotnet/private:context.bzl", "dotnet_context")
load("//dotnet/private:providers.bzl", "DotnetLibraryInfo", "DotnetResourceListInfo")
load("@io_bazel_rules_dotnet//dotnet/platform:list.bzl", "DOTNET_CORE_FRAMEWORKS", "DOTNET_NETSTANDARD")
load("@io_bazel_rules_dotnet//dotnet/private:rules/versions.bzl", "parse_version")
load("@io_bazel_rules_dotnet//dotnet/private:rules/common.bzl", "wrap_binary")

def _binary_impl(ctx):
    """_binary_impl emits actions for compiling executable assembly."""
    dotnet = dotnet_context(ctx, "fsharp")
    name = ctx.label.name
    subdir = name + "/"

    executable = dotnet.toolchain.actions.assembly(
        dotnet,
        name = name,
        srcs = ctx.attr.srcs,
        deps = ctx.attr.deps,
        resources = ctx.attr.resources,
        out = ctx.attr.out,
        defines = ctx.attr.defines,
        data = ctx.attr.data,
        executable = True,
        keyfile = ctx.attr.keyfile,
        subdir = subdir,
        target_framework = ctx.attr.target_framework,
        nowarn = ctx.attr.nowarn,
        langversion = ctx.attr.langversion,
        version = (0, 0, 0, 0, "") if ctx.attr.version == "" else parse_version(ctx.attr.version),
    )

    return wrap_binary(executable, dotnet)

fsharp_binary = rule(
    _binary_impl,
    attrs = {
        "deps": attr.label_list(providers = [DotnetLibraryInfo], doc = "The direct dependencies of this library. These may be dotnet_library rules or compatible rules with the [DotnetLibraryInfo](api.md#dotnetlibraryinfo) provider."),
        "version": attr.string(doc = "Version to be set for the assembly. The version is set by compiling in [AssemblyVersion](https://docs.microsoft.com/en-us/troubleshoot/visualstudio/general/assembly-version-assembly-file-version) attribute."),
        "resources": attr.label_list(providers = [DotnetResourceListInfo], doc = "The list of resources to compile with. Usually provided via reference to [core_resx](api.md#core_resx) or the rules compatible with [DotnetResourceInfo](api.md#dotnetresourceinfo) provider."),
        "srcs": attr.label_list(allow_files = [".fs"], doc = "The list of .fs source files that are compiled to create the assembly."),
        "out": attr.string(doc = "An alternative name of the output file."),
        "defines": attr.string_list(doc = "The list of defines passed via /define compiler option."),
        "data": attr.label_list(allow_files = True, doc = "The list of additional files to include in the list of runfiles for the assembly."),
        "keyfile": attr.label(allow_files = True, doc = "The key to sign the assembly with."),
        "_launcher": attr.label(default = Label("@io_bazel_rules_dotnet//dotnet/tools/launcher_core:launcher_core.exe")),
        "_copy": attr.label(default = Label("@io_bazel_rules_dotnet//dotnet/tools/copy")),
        "_symlink": attr.label(default = Label("@io_bazel_rules_dotnet//dotnet/tools/symlink")),
        "target_framework": attr.string(values = DOTNET_CORE_FRAMEWORKS.keys() + DOTNET_NETSTANDARD.keys() + [""], default = "", doc = "Target framework."),
        "nowarn": attr.string_list(doc = "The list of warnings to be ignored. The warnings are passed to -nowarn compiler opion."),
        "langversion": attr.string(default = "latest", doc = "Version of the language to use. See [this page](https://docs.microsoft.com/en-us/dotnet/csharp/language-reference/configure-language-version)."),
        "data_with_dirs": attr.label_keyed_string_dict(allow_files = True, doc = "Dictionary of {label:folder}. Files specified by <label> will be put in subdirectory <folder>."),
    },
    toolchains = ["@io_bazel_rules_dotnet//dotnet:toolchain_type_fsharp_core"],
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
    fsharp_binary(
        name = "Program.exe",
        srcs = [
            "Program.fs",
        ],
        deps = [
            "@io_bazel_rules_dotnet//dotnet/stdlib.core:libraryset",
        ],
    )
    ```
    """,
)
