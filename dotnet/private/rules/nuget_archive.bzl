"NuGet Archive"

load(
    "//dotnet/private:common.bzl",
    "COR_FRAMEWORKS",
    "FRAMEWORK_COMPATIBILITY",
    "NET_FRAMEWORKS",
    "STD_FRAMEWORKS",
)

def _is_windows(repository_ctx):
    """Returns true if the host operating system is windows."""
    os_name = repository_ctx.os.name.lower()
    if os_name.find("windows") != -1:
        return True
    return False

def _read_dir(repository_ctx, src_dir):
    """Returns a string with all files in a directory.

    Finds all files inside a directory, traversing subfolders and following
    symlinks. The returned string contains the full path of all files
    separated by line breaks.
    """
    if _is_windows(repository_ctx):
        src_dir = src_dir.replace("/", "\\")
        find_result = repository_ctx.execute(["cmd.exe", "/c", "dir", src_dir, "/b", "/s", "/a-d"])

        # src_files will be used in genrule.outs where the paths must
        # use forward slashes.
        result = find_result.stdout.replace("\\", "/")
    else:
        find_result = repository_ctx.execute(["find", src_dir, "-follow", "-type", "f"])
        result = find_result.stdout
    return result

def _create_framework_select(name, group):
    if not group:
        return None

    result = ["tfm_filegroup(\"%s\", {\n" % name]

    for (tfm, items) in group.items():
        result.append(' "')
        result.append(tfm)
        result.append('": [')
        result.append(",".join(["\n   \"{}\"".format(item) for item in items if not item.endswith("_._")]))
        result.append("],\n")

    result.append("})")

    return "".join(result)

def _sanitize_path(file_path):
    # On linux the relative file path starts with ./
    if file_path.startswith("./"):
        return file_path[2:]

    return file_path

def _process_lib_file(groups, file):
    i = file.find("/")
    tfm_start = i + 1
    tfm_end = file.find("/", i + 1)
    tfm = file[tfm_start:tfm_end]

    if tfm not in FRAMEWORK_COMPATIBILITY:
        return

    # If the folder is empty we do nothing
    if file.find("/", tfm_end + 1) != -1:
        return

    if not groups.get("lib"):
        groups["lib"] = {}

    group = groups["lib"]

    if not group.get(tfm):
        group[tfm] = []

    # If the folder contains a _._ file we create the group but do not add the file to it
    # to indicate that there was an _._ file in the folder.
    if file.endswith("_._"):
        return

    if not file.endswith(".dll") or file.endswith(".resources.dll"):
        return

    group[tfm].append(file)

    return

def _process_ref_file(groups, file):
    i = file.find("/")
    tfm_start = i + 1
    tfm_end = file.find("/", i + 1)
    tfm = file[tfm_start:tfm_end]

    if tfm not in FRAMEWORK_COMPATIBILITY:
        return

    # If the folder is empty we do nothing
    if file.find("/", tfm_end + 1) != -1:
        return

    if not groups.get("ref"):
        groups["ref"] = {}

    group = groups["ref"]

    if not group.get(tfm):
        group[tfm] = []

    # If the folder contains a _._ file we create the group but do not add the file to it
    # to indicate that there was an _._ file in the folder.
    if file.endswith("_._"):
        return

    if not file.endswith(".dll") or file.endswith(".resources.dll"):
        return

    group[tfm].append(file)

    return

def _process_analyzer_file(groups, file):
    if (not file.endswith(".dll")) or file.endswith("resources.dll"):
        return

    group = groups["analyzers"]
    group["dotnet"].append(file)

    return

def _process_content_file(groups, file):
    group = groups["contentFiles"]
    group["any"].append(file)

    return

def _process_typeprovider_file(groups, file):
    # See https://github.com/fsharp/fslang-design/blob/main/tooling/FST-1003-loading-type-provider-design-time-components.md

    if not file.endswith(".dll"):
        return

    parts = file.split("/")

    if len(parts) < 3:
        return

    tfm = parts[2]

    if tfm not in FRAMEWORK_COMPATIBILITY:
        return

    if not groups.get("lib"):
        groups["lib"] = {}

    group = groups["lib"]

    if not group.get(tfm):
        group[tfm] = []

    group[tfm].append(file)

    return

def _process_key_and_file(groups, key, file):
    # todo runtime specific
    # todo resource dlls
    if key == "lib":
        _process_lib_file(groups, file)
    elif key == "ref":
        _process_ref_file(groups, file)
    elif key == "analyzers":
        _process_analyzer_file(groups, file)
    elif key == "contentFiles":
        _process_content_file(groups, file)
    elif key == "typeproviders":
        _process_typeprovider_file(groups, file)

    return

def _nuget_archive_impl(ctx):
    nuget_sources = ["https://www.nuget.org/api/v2/package/{id}/{version}"]
    urls = [s.format(id = ctx.attr.id, version = ctx.attr.version) for s in nuget_sources]
    auth = {url: {
        "type": "basic",
        "login": "user",
        "password": "TODO",
    } for url in urls}

    ctx.download_and_extract(urls, type = "zip", integrity = ctx.attr.hash, auth = auth)

    files = _read_dir(ctx, ".").replace(str(ctx.path(".")) + "/", "").splitlines()

    groups = {
        "analyzers": {
            "dotnet": [],
        },
        "contentFiles": {
            "any": [],
        },
    }

    for file in files:
        file = _sanitize_path(file)
        i = file.find("/")
        key = file[:i]

        _process_key_and_file(groups, key, file)

    # in some runtime specific edge cases there exist certain tfm refs but the libs are not shipped
    if groups.get("ref") and groups.get("lib"):
        libs = groups.get("lib")
        for (tfm, _) in groups.get("ref").items():
            if tfm not in libs:
                libs[tfm] = []

    ctx.file("BUILD.bazel", r"""package(default_visibility = ["//visibility:public"])
exports_files(glob(["**"]))
load("@rules_dotnet//dotnet/private:rules/nuget_archive.bzl", "tfm_filegroup")
""" + "\n".join([
        _create_framework_select("libs", groups.get("lib")) or "filegroup(name = \"libs\", srcs = [])",
        _create_framework_select("refs", groups.get("ref")) or _create_framework_select("refs", groups.get("lib")) or "filegroup(name = \"refs\", srcs = [])",
        "filegroup(name = \"analyzers\", srcs = [%s])" % ",".join(["\n  \"%s\"" % a for a in groups.get("analyzers")["dotnet"]]),
        "filegroup(name = \"data\", srcs = [])",
        "filegroup(name = \"content_files\", srcs = [%s])" % ",".join(["\n  \"%s\"" % a for a in groups.get("contentFiles")["any"]]),
    ]))

nuget_archive = repository_rule(
    _nuget_archive_impl,
    attrs = {
        "id": attr.string(),
        "version": attr.string(),
        "hash": attr.string(),
    },
)

# This function is public because it's used by the nuget_archive repository rule.
# buildifier: disable=function-docstring
def tfm_filegroup(name, tfms):
    std = []
    net = []
    cor = []

    for (tfm, value) in tfms.items():
        if tfm in COR_FRAMEWORKS:
            cor.append((tfm, value))
        elif tfm in STD_FRAMEWORKS:
            std.append((tfm, value))
        elif tfm in NET_FRAMEWORKS:
            net.append((tfm, value))
        else:
            fail("unknown framework %s" % tfm)

    # there can be a conflict between std and (cor/net) packages where both have a
    # candidate but none encapsulates the other. If this can be the case we
    # bootstrap different filegroups for each framework type (cor, std, net) and
    # determine which filegroup to hit using alias().
    if std and (net or cor):
        native.filegroup(
            name = "%s_std" % name,
            srcs = select({"@rules_dotnet//dotnet:tfm_%s" % tfm: value for (tfm, value) in std}),
        )

        if net:
            native.filegroup(
                name = "%s_net" % name,
                srcs = select({"@rules_dotnet//dotnet:tfm_%s" % tfm: value for (tfm, value) in net}),
            )

        if cor:
            native.filegroup(
                name = "%s_cor" % name,
                srcs = select({"@rules_dotnet//dotnet:tfm_%s" % tfm: value for (tfm, value) in cor}),
            )

        return native.alias(
            name = name,
            actual = select({
                # targeting net(core)
                "@rules_dotnet//dotnet:tfm_netcoreapp1.0": (":%s_cor" % name) if cor else (":%s_std" % name),
                # targeting netframework
                "@rules_dotnet//dotnet:tfm_net11": (":%s_net" % name) if net else (":%s_std" % name),
                # targeting netstandard
                "//conditions:default": (":%s_std" % name),
            }),
        )

    return native.filegroup(
        name = name,
        srcs = select({"@rules_dotnet//dotnet:tfm_%s" % tfm: value for (tfm, value) in tfms.items()}),
    )
