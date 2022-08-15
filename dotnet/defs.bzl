"""Public API surface is re-exported here.

Users should not load files under "/dotnet"
"""

load(
    "//dotnet/private:rules/csharp/binary.bzl",
    _csharp_binary = "csharp_binary",
)
load(
    "//dotnet/private:rules/fsharp/binary.bzl",
    _fsharp_binary = "fsharp_binary",
)
load(
    "//dotnet/private:rules/csharp/library.bzl",
    _csharp_library = "csharp_library",
)
load(
    "//dotnet/private:rules/fsharp/library.bzl",
    _fsharp_library = "fsharp_library",
)
load(
    "//dotnet/private:rules/csharp/nunit_test.bzl",
    _csharp_nunit_test = "csharp_nunit_test",
)
load(
    "//dotnet/private:rules/fsharp/nunit_test.bzl",
    _fsharp_nunit_test = "fsharp_nunit_test",
)
load(
    "//dotnet/private:rules/csharp/test.bzl",
    _csharp_test = "csharp_test",
)
load(
    "//dotnet/private:rules/fsharp/test.bzl",
    _fsharp_test = "fsharp_test",
)
load(
    "//dotnet/private:rules/imports.bzl",
    _import_library = "import_library",
)
load(
    "@rules_dotnet//dotnet/private:rules/nuget_archive.bzl",
    _nuget_archive = "nuget_archive",
)
load(
    "@rules_dotnet//dotnet/private:rules/nuget_repo.bzl",
    _nuget_repo = "nuget_repo",
)

def _get_runtime_runtime_identifier(rid):
    if rid:
        return rid
    else:
        return select(
            {
                "@rules_dotnet//dotnet/private:linux-x64": "linux-x64",
                "@rules_dotnet//dotnet/private:linux-arm64": "linux-arm64",
                "@rules_dotnet//dotnet/private:macos-x64": "osx-x64",
                "@rules_dotnet//dotnet/private:macos-arm64": "osx-arm64",
                "@rules_dotnet//dotnet/private:windows-x64": "win-x64",
                "@rules_dotnet//dotnet/private:windows-arm64": "win-arm64",
            },
            no_match_error = "Could not infer default runtime identifier from the current host platform",
        )

def csharp_binary(runtime_identifier = None, use_apphost_shim = True, **kwargs):
    _csharp_binary(
        runtime_identifier = _get_runtime_runtime_identifier(runtime_identifier),
        apphost_shimmer = "@rules_dotnet//dotnet/private/tools/apphost_shimmer:apphost_shimmer" if use_apphost_shim else None,
        **kwargs
    )

def csharp_library(runtime_identifier = None, **kwargs):
    _csharp_library(
        runtime_identifier = _get_runtime_runtime_identifier(runtime_identifier),
        **kwargs
    )

def csharp_test(runtime_identifier = None, use_apphost_shim = True, **kwargs):
    _csharp_test(
        runtime_identifier = _get_runtime_runtime_identifier(runtime_identifier),
        apphost_shimmer = "@rules_dotnet//dotnet/private/tools/apphost_shimmer:apphost_shimmer" if use_apphost_shim else None,
        **kwargs
    )

def csharp_nunit_test(runtime_identifier = None, use_apphost_shim = True, **kwargs):
    _csharp_nunit_test(
        runtime_identifier = _get_runtime_runtime_identifier(runtime_identifier),
        apphost_shimmer = "@rules_dotnet//dotnet/private/tools/apphost_shimmer:apphost_shimmer" if use_apphost_shim else None,
        **kwargs
    )

def fsharp_binary(runtime_identifier = None, use_apphost_shim = True, **kwargs):
    _fsharp_binary(
        runtime_identifier = _get_runtime_runtime_identifier(runtime_identifier),
        apphost_shimmer = "@rules_dotnet//dotnet/private/tools/apphost_shimmer:apphost_shimmer" if use_apphost_shim else None,
        **kwargs
    )

def fsharp_library(runtime_identifier = None, **kwargs):
    _fsharp_library(
        runtime_identifier = _get_runtime_runtime_identifier(runtime_identifier),
        **kwargs
    )

def fsharp_test(runtime_identifier = None, use_apphost_shim = True, **kwargs):
    _fsharp_test(
        runtime_identifier = _get_runtime_runtime_identifier(runtime_identifier),
        apphost_shimmer = "@rules_dotnet//dotnet/private/tools/apphost_shimmer:apphost_shimmer" if use_apphost_shim else None,
        **kwargs
    )

def fsharp_nunit_test(runtime_identifier = None, use_apphost_shim = True, **kwargs):
    _fsharp_nunit_test(
        runtime_identifier = _get_runtime_runtime_identifier(runtime_identifier),
        apphost_shimmer = "@rules_dotnet//dotnet/private/tools/apphost_shimmer:apphost_shimmer" if use_apphost_shim else None,
        **kwargs
    )

import_library = _import_library
nuget_repo = _nuget_repo
nuget_archive = _nuget_archive
