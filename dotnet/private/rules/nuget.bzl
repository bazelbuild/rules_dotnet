load(
    "//dotnet/private:providers.bzl",
    "DotnetLibraryInfo",
)
load(
    "//dotnet/platform:list.bzl",
    "DOTNET_CORE_FRAMEWORKS",
    "DOTNET_CORE_NAMES",
)

def _dotnet_nuget_impl(
        ctx,
        build_file = None,
        build_file_content = None):
    """dotnet_nuget_impl emits actions for exposing nunit assmebly."""

    package = ctx.attr.package
    output_dir = ctx.path("")
    url = ctx.attr.source + "/" + ctx.attr.package + "/" + ctx.attr.version
    ctx.download_and_extract(url, output_dir, ctx.attr.sha256, type = "zip")

    build_file_name = "BUILD" if not ctx.path("BUILD").exists else "BUILD.bazel"

    if build_file_content:
        ctx.file(build_file_name, build_file_content)
    elif build_file:
        ctx.symlink(ctx.path(build_file), build_file_name)
    else:
        ctx.template(
            build_file_name,
            Label("@io_bazel_rules_dotnet//dotnet/private:BUILD.nuget.bazel"),
            executable = False,
        )

def _dotnet_nuget_new_impl(repository_ctx):
    build_file = repository_ctx.attr.build_file
    build_file_content = repository_ctx.attr.build_file_content
    if not (build_file_content or build_file):
        fail("build_file or build_file_content is required")
    _dotnet_nuget_impl(repository_ctx, build_file, build_file_content)

dotnet_nuget_new = repository_rule(
    _dotnet_nuget_new_impl,
    attrs = {
        "_nuget_exe": attr.label(default = Label("@nuget//file:nuget.exe")),
        "source": attr.string(
            default = "https://www.nuget.org/api/v2/package",
            doc = "Nuget repository to download the nuget package from. The final url is in the format shape \\{source\\}/\\{package\\}/\\{version\\}.",
        ),
        "package": attr.string(mandatory = True, doc = "The name of the nuget package."),
        "version": attr.string(mandatory = True, doc = "The version of the nuget package."),
        "sha256": attr.string(mandatory = False, doc = "Sha256 digest of the downloaded package."),
        "build_file": attr.label(
            allow_files = True,
            doc = "The file to use as the BUILD file for this repository. " +
                  "This attribute is an absolute label (use '@//' for the main repo). The file does not need to be named BUILD, " +
                  "but can be (something like BUILD.new-repo-name may work well for distinguishing it from the repository's " +
                  "actual BUILD files. Either build_file or build_file_content can be specified, but not both.",
        ),
        "build_file_content": attr.string(doc = "The content for the BUILD file for this repository. Either build_file or build_file_content can be specified, but not both."),
    },
    doc = """Repository rule to download and extract nuget package. Usually [nuget_package](#nuget_package) is a better choice.
    
    Usually used with [dotnet_import_library](#dotnet_import_library).    
    
    Example:
    ```python
    dotnet_nuget_new(
        name = "npgsql", 
        package="Npgsql", 
        version="3.2.7", 
        sha256="fa3e0cfbb2caa9946d2ce3d8174031a06320aad2c9e69a60f7739b9ddf19f172",
        build_file_content = \"\"\"
    package(default_visibility = [ "//visibility:public" ])
    load("@io_bazel_rules_dotnet//dotnet:defs.bzl", "dotnet_import_library")

    dotnet_import_library(
        name = "npgsqllib",
        src = "lib/net451/Npgsql.dll"
    )   
        \"\"\"
    )
    ```
    """,
)

_FUNC = """
{}(
    name = "{}",
    src = "{}",
    deps = [
        {}
    ],
    data = [
        {}
    ],
    version = "{}",
)

"""

_FUNC_WITH_REF = """
{}(
    name = "{}",
    src = "{}",
    ref = "{}",
    deps = [
        {}
    ],
    data = [
        {}
    ],
    version = "{}",
)

"""

_FUNC2 = """
{}(
    name = "{}",
    deps = [
        {}
    ],
    data = [
        {}
    ],
)

"""

def _get_importlib(func, func2, name, lib, ref, deps, files, version):
    depsstr = ""
    for d in deps:
        depsstr += "    \"{}\",\n".format(d)
    datastr = ""
    for f in files:
        datastr += "    \"{}\",\n".format(f)

    if lib != "":
        if ref != "" and ref != None:
            result = _FUNC_WITH_REF.format(func, name, lib, ref, depsstr, datastr, version)
        else:
            result = _FUNC.format(func, name, lib, depsstr, datastr, version)
    else:
        result = _FUNC2.format(func2, name, depsstr, datastr)

    return result

def _get_importlib_withframework(func, func2, name, frameworks, lib, ref, deps, files, version):
    result = ""
    for framework in frameworks:
        depsstr = ""
        if deps.get(framework) != None:
            for d in deps[framework]:
                depsstr += "    \"{}\",\n".format(d)

        datastr = ""
        if files.get(framework) != None:
            for f in files[framework]:
                datastr += "    \"{}\",\n".format(f)

        if lib.get(framework) != None:
            if ref != None and ref.get(framework) != None:
                result += _FUNC_WITH_REF.format(func, "{}_{}".format(framework, name), lib[framework], ref[framework], depsstr, datastr, version)
            else:
                result += _FUNC.format(func, "{}_{}".format(framework, name), lib[framework], depsstr, datastr, version)
        else:
            result += _FUNC2.format(func2, "{}_{}".format(framework, name), depsstr, datastr)

    return result

_TEMPLATE2 = """
package(default_visibility = [ "//visibility:public" ])
load("@io_bazel_rules_dotnet//dotnet:defs.bzl", "core_import_library", "core_import_binary", "core_libraryset")
"""

def _nuget_package_impl(ctx):
    """nuget_package_impl emits actions for exposing nuget assmeblies."""

    content = _TEMPLATE2

    #if ctx.attr.core_lib != "":
    content += _get_importlib_withframework("core_import_library", "core_libraryset", "core", DOTNET_CORE_NAMES, ctx.attr.core_lib, ctx.attr.core_ref, ctx.attr.core_deps, ctx.attr.core_files, ctx.attr.version)

    if ctx.attr.core_tool != "":
        content += _get_importlib_withframework("core_import_binary", "core_libraryset", "core_tool", DOTNET_CORE_NAMES, ctx.attr.core_tool, None, ctx.attr.core_deps, ctx.attr.core_files, ctx.attr.version)

    # Generate library alias selecting proper configuration depending on platform
    content += """alias(name = "lib",actual = select({"""
    for sdk in DOTNET_CORE_FRAMEWORKS:
        key = "@io_bazel_rules_dotnet//dotnet/toolchain:" + sdk + "_config"
        val = DOTNET_CORE_FRAMEWORKS.get(sdk)[2] + "_core"
        content = content + """"{}": "{}",""".format(key, val)
    content += """}, no_match_error = "framework not known"), visibility=["//visibility:public"])\n"""

    # Generate tool alias selecting proper configuration depending on platform
    if ctx.attr.core_tool != "":
        content += """alias(name = "tool",actual = select({"""
        for sdk in DOTNET_CORE_FRAMEWORKS:
            key = "@io_bazel_rules_dotnet//dotnet/toolchain:" + sdk + "_config"
            val = DOTNET_CORE_FRAMEWORKS.get(sdk)[2] + "_core_tool"
            content = content + """"{}": "{}",""".format(key, val)
        content += """}, no_match_error = "framework not known"), visibility=["//visibility:public"])\n"""

    package = ctx.attr.package
    output_dir = ctx.path("")
    urls = [s + "/" + ctx.attr.package + "/" + ctx.attr.version for s in ctx.attr.source]
    ctx.download_and_extract(urls, output_dir, ctx.attr.sha256, type = "zip")

    build_file_name = "BUILD" if not ctx.path("BUILD").exists else "BUILD.bazel"

    ctx.file(build_file_name, content)

_nuget_package_attrs = {
    # Sources to download the nuget packages from
    "source": attr.string_list(
        default = ["https://www.nuget.org/api/v2/package"],
        doc = "The nuget base url for downloading the package. The final url is in the format {source}/{package}/{version}.",
    ),
    # The name of the nuget package
    "package": attr.string(mandatory = True, doc = "The nuget package name."),
    # The version of the nuget package
    "version": attr.string(mandatory = True, doc = "The nuget package version."),
    "sha256": attr.string(mandatory = False, doc = "The nuget package sha256 digest."),
    "core_lib": attr.string_dict(default = {}, doc = "The path to .net core assembly within the nuget package."),
    "net_lib": attr.string_dict(default = {}),
    "mono_lib": attr.string(default = ""),
    "core_ref": attr.string_dict(default = {}, doc = "The path to .net core reference assembly within the nuget package."),
    "net_ref": attr.string_dict(default = {}),
    "mono_ref": attr.string(default = ""),
    "core_tool": attr.string_dict(default = {}, doc = "The path to .net core assembly within the nuget package (tools subdirectory)."),
    "net_tool": attr.string_dict(default = {}),
    "mono_tool": attr.string(default = ""),
    "core_deps": attr.string_list_dict(doc = "The list of the dependencies of the package (core)."),
    "net_deps": attr.string_list_dict(),
    "mono_deps": attr.label_list(providers = [DotnetLibraryInfo]),
    "core_files": attr.string_list_dict(doc = "The list of additional files within the package to be used as runfiles (necessary to run)."),
    "net_files": attr.string_list_dict(),
    "mono_files": attr.string_list(),
}

nuget_package = repository_rule(
    _nuget_package_impl,
    attrs = _nuget_package_attrs,
    doc = """Repository rule to download and extract nuget package. The rule is usually generated by [nuget2bazel](nuget2bazel.md) tool.

       Example
       ^^^^^^^
       
       ```python
       nuget_package(
        name = "commandlineparser",
        package = "commandlineparser",
        sha256 = "09e60ff23e6953b4fe7d267ef552d8ece76404acf44842012f84430e8b877b13",
        core_lib = "lib/netstandard1.5/CommandLine.dll",
        core_deps = [
            "@io_bazel_rules_dotnet//dotnet/stdlib.core:system.collections.dll",
            "@io_bazel_rules_dotnet//dotnet/stdlib.core:system.console.dll",
            "@io_bazel_rules_dotnet//dotnet/stdlib.core:system.diagnostics.debug.dll",
            "@io_bazel_rules_dotnet//dotnet/stdlib.core:system.globalization.dll",
            "@io_bazel_rules_dotnet//dotnet/stdlib.core:system.io.dll",
            "@io_bazel_rules_dotnet//dotnet/stdlib.core:system.linq.dll",
            "@io_bazel_rules_dotnet//dotnet/stdlib.core:system.linq.expressions.dll",
            "@io_bazel_rules_dotnet//dotnet/stdlib.core:system.reflection.dll",
            "@io_bazel_rules_dotnet//dotnet/stdlib.core:system.reflection.extensions.dll",
            "@io_bazel_rules_dotnet//dotnet/stdlib.core:system.reflection.typeextensions.dll",
            "@io_bazel_rules_dotnet//dotnet/stdlib.core:system.resources.resourcemanager.dll",
            "@io_bazel_rules_dotnet//dotnet/stdlib.core:system.runtime.dll",
            "@io_bazel_rules_dotnet//dotnet/stdlib.core:system.runtime.extensions.dll",
        ],
        core_files = [
            "lib/netstandard1.5/CommandLine.dll",
            "lib/netstandard1.5/CommandLine.xml",
        ],
        )
        ```
        """,
)
