load(
    "@io_bazel_rules_dotnet//dotnet/private:providers.bzl",
    "DotnetLibrary",
)
load("@rules_dotnet_skylib//lib:dicts.bzl", "dicts")
load(
    "@io_bazel_rules_dotnet//dotnet/platform:list.bzl",
    "DOTNET_CORE_NAMES",
    "DOTNET_NET_NAMES",
)

def _dotnet_nuget_impl(
        ctx,
        build_file = None,
        build_file_content = None):
    """dotnet_nuget_impl emits actions for exposing nunit assmebly."""

    package = ctx.attr.package
    output_dir = ctx.path("")
    if ctx.attr.use_nuget_client and ctx.os.name.startswith("windows"):
        """use_nuget_client for private nuget feed (tfs/vsts/etc)"""
        nuget = ctx.path(ctx.attr._nuget_exe)
        nuget_cmd = [
            nuget,
            "install",
            "-Version",
            ctx.attr.version,
            "-OutputDirectory",
            output_dir,
            "-Source",
            ctx.attr.source,
            ctx.attr.package,
        ]
        result = ctx.execute(nuget_cmd)
        if result.return_code:
            fail("Nuget command failed: %s (%s)" % (result.stderr, " ".join(nuget_cmd)))
    else:
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

_dotnet_nuget_attrs = {
    "_nuget_exe": attr.label(default = Label("@nuget//file:nuget.exe")),
    # Sources to download the nuget packages from
    "source": attr.string(default = "https://www.nuget.org/api/v2/package"),
    # The name of the nuget package
    "package": attr.string(mandatory = True),
    # The version of the nuget package
    "version": attr.string(mandatory = True),
    "sha256": attr.string(mandatory = False),
    "use_nuget_client": attr.bool(default = False),
}

dotnet_nuget = repository_rule(
    _dotnet_nuget_impl,
    attrs = _dotnet_nuget_attrs,
)

def _dotnet_nuget_new_impl(repository_ctx):
    build_file = repository_ctx.attr.build_file
    build_file_content = repository_ctx.attr.build_file_content
    if not (build_file_content or build_file):
        fail("build_file or build_file_content is required")
    _dotnet_nuget_impl(repository_ctx, build_file, build_file_content)

dotnet_nuget_new = repository_rule(
    _dotnet_nuget_new_impl,
    attrs = dicts.add(_dotnet_nuget_attrs, {
        "build_file": attr.label(allow_files = True),
        "build_file_content": attr.string(),
    }),
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
load("@io_bazel_rules_dotnet//dotnet:defs.bzl", "dotnet_import_library", "core_import_library", "net_import_library", "core_import_binary", "net_import_binary", "core_libraryset", "net_libraryset", "dotnet_libraryset")
"""

def _nuget_package_impl(ctx):
    """nuget_package_impl emits actions for exposing nuget assmeblies."""

    content = _TEMPLATE2

    #if ctx.attr.core_lib != "":
    content += _get_importlib_withframework("core_import_library", "core_libraryset", "core", DOTNET_CORE_NAMES, ctx.attr.core_lib, ctx.attr.core_ref, ctx.attr.core_deps, ctx.attr.core_files, ctx.attr.version)
    content += _get_importlib_withframework("net_import_library", "net_libraryset", "net", DOTNET_NET_NAMES, ctx.attr.net_lib, ctx.attr.net_ref, ctx.attr.net_deps, ctx.attr.net_files, ctx.attr.version)
    content += _get_importlib("dotnet_import_library", "dotnet_libraryset", "mono", ctx.attr.mono_lib, ctx.attr.mono_ref, ctx.attr.mono_deps, ctx.attr.mono_files, ctx.attr.version)
    content += "alias(name=\"net\", actual=\":net48_net\")\n"
    content += "alias(name=\"core\", actual=\":netcoreapp3.1_core\")\n"

    if ctx.attr.core_tool != "":
        content += _get_importlib_withframework("core_import_binary", "core_libraryset", "core_tool", DOTNET_CORE_NAMES, ctx.attr.core_tool, None, ctx.attr.core_deps, ctx.attr.core_files, ctx.attr.version)
        content += "alias(name=\"core_too\", actual=\":netcoreapp3.1_core_tool\")\n"
    if ctx.attr.net_tool != "":
        content += _get_importlib_withframework("net_import_binary", "net_libraryset", "net_tool", DOTNET_NET_NAMES, ctx.attr.net_tool, None, ctx.attr.net_deps, ctx.attr.net_files, ctx.attr.version)
        content += "alias(name=\"net_tool\", actual=\":net48_net_tool\")\n"
    if ctx.attr.mono_tool != "":
        content += _get_importlib("dotnet_import_library", "dotnet_libraryset", "mono_tool", ctx.attr.mono_tool, None, ctx.attr.mono_deps, ctx.attr.mono_files, ctx.attr.version)

    package = ctx.attr.package
    output_dir = ctx.path("")
    url = ctx.attr.source + "/" + ctx.attr.package + "/" + ctx.attr.version
    ctx.download_and_extract(url, output_dir, ctx.attr.sha256, type = "zip")

    build_file_name = "BUILD" if not ctx.path("BUILD").exists else "BUILD.bazel"

    ctx.file(build_file_name, content)

_nuget_package_attrs = {
    # Sources to download the nuget packages from
    "source": attr.string(default = "https://www.nuget.org/api/v2/package"),
    # The name of the nuget package
    "package": attr.string(mandatory = True),
    # The version of the nuget package
    "version": attr.string(mandatory = True),
    "sha256": attr.string(mandatory = False),
    "core_lib": attr.string_dict(default = {}),
    "net_lib": attr.string_dict(default = {}),
    "mono_lib": attr.string(default = ""),
    "core_ref": attr.string_dict(default = {}),
    "net_ref": attr.string_dict(default = {}),
    "mono_ref": attr.string(default = ""),
    "core_tool": attr.string_dict(default = {}),
    "net_tool": attr.string_dict(default = {}),
    "mono_tool": attr.string(default = ""),
    "core_deps": attr.string_list_dict(),
    "net_deps": attr.string_list_dict(),
    "mono_deps": attr.label_list(providers = [DotnetLibrary]),
    "core_files": attr.string_list_dict(),
    "net_files": attr.string_list_dict(),
    "mono_files": attr.string_list(),
}

nuget_package = repository_rule(
    _nuget_package_impl,
    attrs = _nuget_package_attrs,
)
