"""
Rules for importing NuGet packages.
"""

load("@bazel_tools//tools/build_defs/repo:http.bzl", "http_archive")

def _get_build_file_content(name, build_file, build_file_content):
    if build_file == None and build_file_content == None:
        return """
load("@rules_dotnet//dotnet:defs.bzl", "setup_basic_nuget_package")
setup_basic_nuget_package(\"{0}\")
""".format(name)

    return build_file_content

def import_nuget_package(
        name,
        dir = None,
        file = None,
        build_file = None,
        build_file_content = None,
        sha256 = None):
    """Import a vendored NuGet package from either a directory or .nupkg file.

    Rather than downloading the package over HTTP from a package source, an
    extracted package directory or a .nupkg file can be used. These may be
    checked into your repository within your workspace, or somewhere else on
    your disk.

    Exactly one of either the dir or file arguments must be provided. They can
    either be a relative path in the workspace, or an absolute path. Note that
    paths on Windows use forward slashes.

    At most one of build_file or build_file_content may be provided. If neither
    are, a default BUILD file will be used that makes a "best effort" to wire
    up the package. See docs/UsingNuGetPacakges.md for more info.

    Args:
      name: A unique name for the package's workspace.
      dir: A directory containing an extracted package.
      file: A path to a nupkg file
      build_file: The path to a BUILD file to use for the package.
      build_file_content: A string containing the contents of a BUILD file.
      sha256: The SHA256 of the package.

        This is only used when importing nupkg files. You may or may not find
        it useful, but it will silence a DEBUG message from Bazel regarding
        reproducibility.
    """

    if dir == None and file == None:
        fail("At least one of dir or file must be provided.")
    if dir != None and file != None:
        fail("Only one of dir or file may be provided.")

    build_file_content = _get_build_file_content(name, build_file, build_file_content)

    if dir != None:
        native.new_local_repository(
            name = name,
            build_file = build_file,
            build_file_content = build_file_content,
            path = dir,
        )
    else:
        http_archive(
            name = name,
            urls = ["file:" + file],
            type = "zip",
            sha256 = sha256,
            build_file = build_file,
            build_file_content = build_file_content,
        )

def nuget_package(
        name,
        package,
        version,
        nuget_sources = None,
        sha256 = None,
        integrity = None,
        build_file = None,
        build_file_content = None):
    """Download an external NuGet package.

    At most one of build_file or build_file_content may be provided. If neither
    are, a default BUILD file will be used that makes a "best effort" to wire
    up the package. See docs/UsingNuGetPacakges.md for more info.

    Args:
      name: A unique name for the package's workspace.
      package: The name of the package in the NuGet feed.
      version: The version of the package in the NuGet feed.
      nuget_sources: A list of nuget package sources. Defaults to nuget.org.
      sha256: The SHA256 of the package.
      integrity: Expected checksum in Subresource Integrity format of the package.
      build_file: The path to a BUILD file to use for the package.
      build_file_content: A string containing the contents of a BUILD file.
    """

    nuget_sources = nuget_sources or ["https://www.nuget.org/api/v2/package"]
    urls = ["{}/{}/{}".format(s, package, version) for s in nuget_sources]

    build_file_content = _get_build_file_content(package, build_file, build_file_content)

    http_archive(
        name = name,
        urls = urls,
        type = "zip",
        sha256 = sha256,
        integrity = integrity,
        build_file = build_file,
        build_file_content = build_file_content,
    )
