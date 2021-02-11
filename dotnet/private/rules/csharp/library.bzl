load("@io_bazel_rules_dotnet//dotnet/private:context.bzl", "dotnet_context")
load(
    "@io_bazel_rules_dotnet//dotnet/private:providers.bzl",
    "DotnetLibraryInfo",
    "DotnetResourceListInfo",
)
load("@io_bazel_rules_dotnet//dotnet/platform:list.bzl", "DOTNET_CORE_FRAMEWORKS", "DOTNET_NETSTANDARD")
load("@io_bazel_rules_dotnet//dotnet/private:rules/versions.bzl", "parse_version")

def _library_impl(ctx):
    """_library_impl emits actions for compiling dotnet executable assembly."""
    dotnet = dotnet_context(ctx, "csharp")
    name = ctx.label.name

    library = dotnet.toolchain.actions.assembly(
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
        version = (0, 0, 0, 0, "") if ctx.attr.version == "" else parse_version(ctx.attr.version),
    )

    runfiles = ctx.runfiles(files = [], transitive_files = library.runfiles)

    return [
        library,
        DefaultInfo(
            files = depset([library.result]),
            runfiles = ctx.runfiles(files = [], transitive_files = depset(transitive = [t.runfiles for t in library.transitive])),
        ),
    ]

csharp_library = rule(
    _library_impl,
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
        "target_framework": attr.string(values = DOTNET_CORE_FRAMEWORKS.keys() + DOTNET_NETSTANDARD.keys() + [""], default = "", doc = "Target framework."),
        "nowarn": attr.string_list(doc = "The list of warnings to be ignored. The warnings are passed to -nowarn compiler opion."),
        "langversion": attr.string(default = "latest", doc = "Version of the language to use. See [this page](https://docs.microsoft.com/en-us/dotnet/csharp/language-reference/configure-language-version)."),
    },
    toolchains = ["@io_bazel_rules_dotnet//dotnet:toolchain_type_csharp_core"],
    executable = False,
    doc = """This builds a dotnet assembly from a set of source files.

    Providers
    ^^^^^^^^^

    * [DotnetLibraryInfo](api.md#dotnetlibraryinfo)
    * [DotnetResourceInfo](api.md#dotnetresourceinfo)

    Example:
    ^^^^^^^^
    ```python
    [csharp_library(
        name = "{}_TransitiveClass-core.dll".format(framework),
        srcs = [
            "TransitiveClass.cs",
        ],
        dotnet_context_data = "@io_bazel_rules_dotnet//:core_context_data_{}".format(framework),
        visibility = ["//visibility:public"],
        deps = [
            "@io_bazel_rules_dotnet//dotnet/stdlib.core/{}:libraryset".format(framework),
        ],
    ) for framework in DOTNET_CORE_FRAMEWORKS]
    ```
    """,
)
