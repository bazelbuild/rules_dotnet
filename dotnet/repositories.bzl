"""
Rules to load all the .NET SDK & framework dependencies of rules_dotnet.
"""

load("@bazel_tools//tools/build_defs/repo:http.bzl", "http_archive")
load("@bazel_tools//tools/build_defs/repo:utils.bzl", "maybe")
load("//dotnet/private:toolchains_repo.bzl", "PLATFORMS", "toolchains_repo")
load("//dotnet/private:versions.bzl", "TOOL_VERSIONS")
load("//tools/paket2bazel/deps:paket.bzl", "paket")
load("//dotnet/private:rules/nuget_repo.bzl", "nuget_repo")

# WARNING: any changes in this function may be BREAKING CHANGES for users
# because we'll fetch a dependency which may be different from one that
# they were previously fetching later in their WORKSPACE setup, and now
# ours took precedence. Such breakages are challenging for users, so any
# changes in this function should be marked as BREAKING in the commit message
# and released only in semver majors.
# buildifier: disable=function-docstring
def rules_dotnet_dependencies():
    # The minimal version of bazel_skylib we require
    maybe(
        http_archive,
        name = "bazel_skylib",
        urls = [
            "https://mirror.bazel.build/github.com/bazelbuild/bazel-skylib/releases/download/1.2.1/bazel-skylib-1.2.1.tar.gz",
            "https://github.com/bazelbuild/bazel-skylib/releases/download/1.2.1/bazel-skylib-1.2.1.tar.gz",
        ],
        sha256 = "f7be3474d42aae265405a592bb7da8e171919d74c16f082a5457840f06054728",
    )

    nuget_repo(
        name = "rules_dotnet_deps",
        packages = [
            ("Microsoft.NETCore.App.Ref", "6.0.5", "sha512-quj/gyLoZLypJO7PwsZ8ib6ZSgFv1C9s5SJgwzl/gztynTJ/3oO/stA2gNMf0C33vTJ0J3SSF/kRPQ/ifY5xZg==", [], ["Microsoft.CSharp|4.4.0", "Microsoft.Win32.Primitives|4.3.0", "Microsoft.Win32.Registry|4.4.0", "runtime.debian.8-x64.runtime.native.System|4.3.0", "runtime.debian.8-x64.runtime.native.System.IO.Compression|4.3.0", "runtime.debian.8-x64.runtime.native.System.Net.Http|4.3.0", "runtime.debian.8-x64.runtime.native.System.Net.Security|4.3.0", "runtime.debian.8-x64.runtime.native.System.Security.Cryptography|4.3.0", "runtime.debian.8-x64.runtime.native.System.Security.Cryptography.OpenSsl|4.3.0", "runtime.fedora.23-x64.runtime.native.System|4.3.0", "runtime.fedora.23-x64.runtime.native.System.IO.Compression|4.3.0", "runtime.fedora.23-x64.runtime.native.System.Net.Http|4.3.0", "runtime.fedora.23-x64.runtime.native.System.Net.Security|4.3.0", "runtime.fedora.23-x64.runtime.native.System.Security.Cryptography|4.3.0", "runtime.fedora.23-x64.runtime.native.System.Security.Cryptography.OpenSsl|4.3.0", "runtime.fedora.24-x64.runtime.native.System|4.3.0", "runtime.fedora.24-x64.runtime.native.System.IO.Compression|4.3.0", "runtime.fedora.24-x64.runtime.native.System.Net.Http|4.3.0", "runtime.fedora.24-x64.runtime.native.System.Net.Security|4.3.0", "runtime.fedora.24-x64.runtime.native.System.Security.Cryptography|4.3.0", "runtime.fedora.24-x64.runtime.native.System.Security.Cryptography.OpenSsl|4.3.0", "runtime.opensuse.13.2-x64.runtime.native.System|4.3.0", "runtime.opensuse.13.2-x64.runtime.native.System.IO.Compression|4.3.0", "runtime.opensuse.13.2-x64.runtime.native.System.Net.Http|4.3.0", "runtime.opensuse.13.2-x64.runtime.native.System.Net.Security|4.3.0", "runtime.opensuse.13.2-x64.runtime.native.System.Security.Cryptography|4.3.0", "runtime.opensuse.13.2-x64.runtime.native.System.Security.Cryptography.OpenSsl|4.3.0", "runtime.opensuse.42.1-x64.runtime.native.System|4.3.0", "runtime.opensuse.42.1-x64.runtime.native.System.IO.Compression|4.3.0", "runtime.opensuse.42.1-x64.runtime.native.System.Net.Http|4.3.0", "runtime.opensuse.42.1-x64.runtime.native.System.Net.Security|4.3.0", "runtime.opensuse.42.1-x64.runtime.native.System.Security.Cryptography|4.3.0", "runtime.opensuse.42.1-x64.runtime.native.System.Security.Cryptography.OpenSsl|4.3.0", "runtime.osx.10.10-x64.runtime.native.System|4.3.0", "runtime.osx.10.10-x64.runtime.native.System.IO.Compression|4.3.0", "runtime.osx.10.10-x64.runtime.native.System.Net.Http|4.3.0", "runtime.osx.10.10-x64.runtime.native.System.Net.Security|4.3.0", "runtime.osx.10.10-x64.runtime.native.System.Security.Cryptography|4.3.0", "runtime.osx.10.10-x64.runtime.native.System.Security.Cryptography.Apple|4.3.0", "runtime.osx.10.10-x64.runtime.native.System.Security.Cryptography.OpenSsl|4.3.0", "runtime.rhel.7-x64.runtime.native.System|4.3.0", "runtime.rhel.7-x64.runtime.native.System.IO.Compression|4.3.0", "runtime.rhel.7-x64.runtime.native.System.Net.Http|4.3.0", "runtime.rhel.7-x64.runtime.native.System.Net.Security|4.3.0", "runtime.rhel.7-x64.runtime.native.System.Security.Cryptography|4.3.0", "runtime.rhel.7-x64.runtime.native.System.Security.Cryptography.OpenSsl|4.3.0", "runtime.ubuntu.14.04-x64.runtime.native.System|4.3.0", "runtime.ubuntu.14.04-x64.runtime.native.System.IO.Compression|4.3.0", "runtime.ubuntu.14.04-x64.runtime.native.System.Net.Http|4.3.0", "runtime.ubuntu.14.04-x64.runtime.native.System.Net.Security|4.3.0", "runtime.ubuntu.14.04-x64.runtime.native.System.Security.Cryptography|4.3.0", "runtime.ubuntu.14.04-x64.runtime.native.System.Security.Cryptography.OpenSsl|4.3.0", "runtime.ubuntu.16.04-x64.runtime.native.System|4.3.0", "runtime.ubuntu.16.04-x64.runtime.native.System.IO.Compression|4.3.0", "runtime.ubuntu.16.04-x64.runtime.native.System.Net.Http|4.3.0", "runtime.ubuntu.16.04-x64.runtime.native.System.Net.Security|4.3.0", "runtime.ubuntu.16.04-x64.runtime.native.System.Security.Cryptography|4.3.0", "runtime.ubuntu.16.04-x64.runtime.native.System.Security.Cryptography.OpenSsl|4.3.0", "runtime.ubuntu.16.10-x64.runtime.native.System|4.3.0", "runtime.ubuntu.16.10-x64.runtime.native.System.IO.Compression|4.3.0", "runtime.ubuntu.16.10-x64.runtime.native.System.Net.Http|4.3.0", "runtime.ubuntu.16.10-x64.runtime.native.System.Net.Security|4.3.0", "runtime.ubuntu.16.10-x64.runtime.native.System.Security.Cryptography|4.3.0", "runtime.ubuntu.16.10-x64.runtime.native.System.Security.Cryptography.OpenSsl|4.3.0", "System.AppContext|4.3.0", "System.Buffers|4.4.0", "System.Collections|4.3.0", "System.Collections.Concurrent|4.3.0", "System.Collections.Immutable|1.4.0", "System.Collections.NonGeneric|4.3.0", "System.Collections.Specialized|4.3.0", "System.ComponentModel|4.3.0", "System.ComponentModel.EventBasedAsync|4.3.0", "System.ComponentModel.Primitives|4.3.0", "System.ComponentModel.TypeConverter|4.3.0", "System.Console|4.3.0", "System.Data.Common|4.3.0", "System.Diagnostics.Contracts|4.3.0", "System.Diagnostics.Debug|4.3.0", "System.Diagnostics.DiagnosticSource|4.4.0", "System.Diagnostics.FileVersionInfo|4.3.0", "System.Diagnostics.Process|4.3.0", "System.Diagnostics.StackTrace|4.3.0", "System.Diagnostics.TextWriterTraceListener|4.3.0", "System.Diagnostics.Tools|4.3.0", "System.Diagnostics.TraceSource|4.3.0", "System.Diagnostics.Tracing|4.3.0", "System.Dynamic.Runtime|4.3.0", "System.Globalization|4.3.0", "System.Globalization.Calendars|4.3.0", "System.Globalization.Extensions|4.3.0", "System.IO|4.3.0", "System.IO.Compression|4.3.0", "System.IO.Compression.ZipFile|4.3.0", "System.IO.FileSystem|4.3.0", "System.IO.FileSystem.AccessControl|4.4.0", "System.IO.FileSystem.DriveInfo|4.3.0", "System.IO.FileSystem.Primitives|4.3.0", "System.IO.FileSystem.Watcher|4.3.0", "System.IO.IsolatedStorage|4.3.0", "System.IO.MemoryMappedFiles|4.3.0", "System.IO.Pipes|4.3.0", "System.IO.UnmanagedMemoryStream|4.3.0", "System.Linq|4.3.0", "System.Linq.Expressions|4.3.0", "System.Linq.Queryable|4.3.0", "System.Net.Http|4.3.0", "System.Net.NameResolution|4.3.0", "System.Net.Primitives|4.3.0", "System.Net.Requests|4.3.0", "System.Net.Security|4.3.0", "System.Net.Sockets|4.3.0", "System.Net.WebHeaderCollection|4.3.0", "System.ObjectModel|4.3.0", "System.Private.DataContractSerialization|4.3.0", "System.Reflection|4.3.0", "System.Reflection.Emit|4.3.0", "System.Reflection.Emit.ILGeneration|4.3.0", "System.Reflection.Emit.Lightweight|4.3.0", "System.Reflection.Extensions|4.3.0", "System.Reflection.Metadata|1.5.0", "System.Reflection.Primitives|4.3.0", "System.Reflection.TypeExtensions|4.3.0", "System.Resources.ResourceManager|4.3.0", "System.Runtime|4.3.0", "System.Runtime.Extensions|4.3.0", "System.Runtime.Handles|4.3.0", "System.Runtime.InteropServices|4.3.0", "System.Runtime.InteropServices.RuntimeInformation|4.3.0", "System.Runtime.Loader|4.3.0", "System.Runtime.Numerics|4.3.0", "System.Runtime.Serialization.Formatters|4.3.0", "System.Runtime.Serialization.Json|4.3.0", "System.Runtime.Serialization.Primitives|4.3.0", "System.Security.AccessControl|4.4.0", "System.Security.Claims|4.3.0", "System.Security.Cryptography.Algorithms|4.3.0", "System.Security.Cryptography.Cng|4.4.0", "System.Security.Cryptography.Csp|4.3.0", "System.Security.Cryptography.Encoding|4.3.0", "System.Security.Cryptography.OpenSsl|4.4.0", "System.Security.Cryptography.Primitives|4.3.0", "System.Security.Cryptography.X509Certificates|4.3.0", "System.Security.Cryptography.Xml|4.4.0", "System.Security.Principal|4.3.0", "System.Security.Principal.Windows|4.4.0", "System.Text.Encoding|4.3.0", "System.Text.Encoding.Extensions|4.3.0", "System.Text.RegularExpressions|4.3.0", "System.Threading|4.3.0", "System.Threading.Overlapped|4.3.0", "System.Threading.Tasks|4.3.0", "System.Threading.Tasks.Extensions|4.3.0", "System.Threading.Tasks.Parallel|4.3.0", "System.Threading.Thread|4.3.0", "System.Threading.ThreadPool|4.3.0", "System.Threading.Timer|4.3.0", "System.ValueTuple|4.3.0", "System.Xml.ReaderWriter|4.3.0", "System.Xml.XDocument|4.3.0", "System.Xml.XmlDocument|4.3.0", "System.Xml.XmlSerializer|4.3.0", "System.Xml.XPath|4.3.0", "System.Xml.XPath.XDocument|4.3.0"]),
            ("Microsoft.NET.HostModel", "3.1.6", "sha512-hzPXcTF6xmZZMmtumMgI7wcsWvU/S4oszoBWVZuASIVRDkjKJJ+QVesvhdjH2+JaqjxCHwQ2TagOtR7yGgT2Hg==", [], []),
            # TODO: Nuget tool deps, maybe not force end users to download them if they are not using it?
            ("McMaster.Extensions.CommandLineUtils", "2.5.0", "sha512-00uJOWYKPCPqDB6RxyOLXNnoPGeRmzKTZhu5OdZJaWn5+JV/n6mzB3/M+Z1yMpkabag3Lym9S11G/ITLrptOiw==", [], []),
            ("Nuget.Commands", "5.10.0", "sha512-Q7ANXnmLUPC4pWgCZjBy2R7vRDABiaJz5NsBtoErE0dLylx/zQWRMyoa+m4Y478SKvUpt7S1V7LhAOlMRCTPpg==", [], []),
            ("Nuget.Common", "5.10.0", None, [], []),
            ("Nuget.Configuration", "5.10.0", None, [], []),
            ("Nuget.DependencyResolver.Core", "5.10.0", None, [], []),
            ("Nuget.Frameworks", "5.10.0", None, [], []),
            ("Nuget.PackageManagement", "5.10.0", None, [], []),
            ("Nuget.Packaging.Core", "5.10.0", None, [], []),
            ("Nuget.Packaging", "5.10.0", None, [], []),
            ("Nuget.ProjectModel", "5.10.0", None, [], []),
            ("Nuget.Protocol", "5.10.0", None, [], []),
            ("Nuget.Resolver", "5.10.0", None, [], []),
            ("Nuget.Versioning", "5.10.0", None, ["Nuget.Credentials", "Nuget.LibraryModel"], []),
            ("Nuget.Credentials", "5.10.0", None, [], []),
            ("Nuget.LibraryModel", "5.10.0", None, [], []),
            # TODO: Create a toolchain for NUnit
            ("NUnit", "3.12.0", "sha512-HAhwFxr+Z+PJf8hXzc747NecvsDwEZ+3X8SA5+GIRM43GAy1Ap+TQPMHsWCnisfes5vPZ1/a2md/91u+shoTsQ==", [], []),
            ("NUnitLite", "3.12.0", "sha512-M9VVS4x3KURXFS4HTl2b7uJOX7vOi2wzpHACmNX6ANlBmb0/hIehJLciiVvddD3ubIIL81EF4Qk54kpsUOtVFQ==", [], []),
        ],
    )

    # paket2bazel dependencies
    # This should probably be moved to a separate macro so that
    # Those who are not using Paket will not have to download the paket2bazel dependencies
    paket()

########
# Remaining content of the file is only used to support toolchains.
########
_DOC = "Fetch external tools needed for dotnet toolchain"
_ATTRS = {
    "dotnet_version": attr.string(mandatory = True, values = TOOL_VERSIONS.keys()),
    "platform": attr.string(mandatory = True, values = PLATFORMS.keys()),
}

def _dotnet_repo_impl(repository_ctx):
    url = TOOL_VERSIONS[repository_ctx.attr.dotnet_version][repository_ctx.attr.platform]["url"]
    repository_ctx.download_and_extract(
        url = url,
        integrity = TOOL_VERSIONS[repository_ctx.attr.dotnet_version][repository_ctx.attr.platform]["hash"],
    )
    build_content = """#Generated by dotnet/repositories.bzl
load("@rules_dotnet//dotnet:toolchain.bzl", "dotnet_toolchain")
load("@rules_cc//cc:defs.bzl", "cc_binary")
load("@rules_dotnet//dotnet:defs.bzl", "dotnet_wrapper")

exports_files(
    # csharp compiler: csc
    glob([
        "sdk/**/Roslyn/bincore/**/*",
    ]),
    visibility = ["//visibility:public"],
)

filegroup(
    name = "runtime",
    srcs = select({{
        "@bazel_tools//src/conditions:windows": ["dotnet.exe"],
        "//conditions:default": ["dotnet"],
    }}),
    data = glob([
        "host/**/*",
        "shared/**/*",
    ]) + select({{
        "@bazel_tools//src/conditions:windows": ["dotnet.exe"],
        "//conditions:default": ["dotnet"],
    }}),
    visibility = ["//visibility:public"],
)

filegroup(
    name = "apphost",
    srcs = glob([
        "sdk/**/AppHostTemplate/apphost.exe", # windows
        "sdk/**/AppHostTemplate/apphost",
    ]),
    visibility = ["//visibility:public"],
)

filegroup(
    name = "fsc_binary",
    # We glob both fsc.dll and fsc.exe for backwards compatibility
    # Pre .Net 5.0 the file was called fsc.exe but has been changed to fsc.dll
    srcs = glob([
        "sdk/**/FSharp/fsc.dll*",
        "sdk/**/FSharp/fsc.exe*",
    ]),
    visibility = ["//visibility:public"],
)

cc_binary(
    name = "dotnetw",
    srcs = [":main-cc"],
    data = select({{
        "@bazel_tools//src/conditions:windows": ["dotnet.exe"],
        "//conditions:default": ["dotnet"],
    }}),
    visibility = ["//visibility:public"],
    deps = ["@bazel_tools//tools/cpp/runfiles"],
)

dotnet_wrapper(
    name = "main-cc",
    dotnet = select({{
        "@bazel_tools//src/conditions:windows": ["dotnet.exe"],
        "//conditions:default": ["dotnet"],
    }}),
)

dotnet_toolchain(
    name = "dotnet_toolchain", 
    runtime = ":runtime",
    csharp_compiler = ":sdk/{sdk_version}/Roslyn/bincore/csc.dll",
    fsharp_compiler = ":fsc_binary",
    apphost = ":apphost",
    sdk_version = "{sdk_version}",
    runtime_version = "{runtime_version}",
    runtime_tfm = "{runtime_tfm}",
    csharp_default_version = "{csharp_default_version}",
    fsharp_default_version = "{fsharp_default_version}",
)
""".format(
        sdk_version = repository_ctx.attr.dotnet_version,
        runtime_version = TOOL_VERSIONS[repository_ctx.attr.dotnet_version]["runtimeVersion"],
        runtime_tfm = TOOL_VERSIONS[repository_ctx.attr.dotnet_version]["runtimeTfm"],
        csharp_default_version = TOOL_VERSIONS[repository_ctx.attr.dotnet_version]["csharpDefaultVersion"],
        fsharp_default_version = TOOL_VERSIONS[repository_ctx.attr.dotnet_version]["fsharpDefaultVersion"],
    )

    # Base BUILD file for this repository
    repository_ctx.file("BUILD.bazel", build_content)

dotnet_repositories = repository_rule(
    _dotnet_repo_impl,
    doc = _DOC,
    attrs = _ATTRS,
)

# Wrapper macro around everything above, this is the primary API
def dotnet_register_toolchains(name, dotnet_version, **kwargs):
    """Convenience macro for users which does typical setup.

    - create a repository for each built-in platform like "dotnet_linux_amd64" -
      this repository is lazily fetched when node is needed for that platform.
    - create a repository exposing toolchains for each platform like "dotnet_platforms"
    - register a toolchain pointing at each platform
    Users can avoid this macro and do these steps themselves, if they want more control.
    Args:
        name: base name for all created repos, like "dotnet"
        dotnet_version: The .Net SDK version to use e.g. 6.0.300
        **kwargs: passed to each dotnet_repositories call
    """
    for platform in PLATFORMS.keys():
        dotnet_repositories(
            name = name + "_" + platform,
            platform = platform,
            dotnet_version = dotnet_version,
            **kwargs
        )
        native.register_toolchains("@%s_toolchains//:%s_toolchain" % (name, platform))

    toolchains_repo(
        name = name + "_toolchains",
        user_repository_name = name,
    )
