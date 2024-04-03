"""Public API surface is re-exported here.

Users should not load files under "/dotnet"
"""

load(
    "//dotnet/private/rules/csharp:binary.bzl",
    _csharp_binary = "csharp_binary",
)
load(
    "//dotnet/private/rules/csharp:library.bzl",
    _csharp_library = "csharp_library",
)
load(
    "//dotnet/private/rules/csharp:nunit_test.bzl",
    _csharp_nunit_test = "csharp_nunit_test",
)
load(
    "//dotnet/private/rules/csharp:test.bzl",
    _csharp_test = "csharp_test",
)
load(
    "//dotnet/private/rules/fsharp:binary.bzl",
    _fsharp_binary = "fsharp_binary",
)
load(
    "//dotnet/private/rules/fsharp:library.bzl",
    _fsharp_library = "fsharp_library",
)
load(
    "//dotnet/private/rules/fsharp:nunit_test.bzl",
    _fsharp_nunit_test = "fsharp_nunit_test",
)
load(
    "//dotnet/private/rules/fsharp:test.bzl",
    _fsharp_test = "fsharp_test",
)
load(
    "//dotnet/private/rules/nuget:imports.bzl",
    _import_dll = "import_dll",
    _import_library = "import_library",
)
load(
    "//dotnet/private/rules/nuget:nuget_archive.bzl",
    _nuget_archive = "nuget_archive",
)
load(
    "//dotnet/private/rules/nuget:nuget_repo.bzl",
    _nuget_repo = "nuget_repo",
)
load(
    "//dotnet/private/rules/publish_binary:publish_binary.bzl",
    _publish_binary = "publish_binary",
)

def csharp_binary(
        use_apphost_shim = True,
        treat_warnings_as_errors = None,
        warnings_as_errors = None,
        warnings_not_as_errors = None,
        warning_level = None,
        strict_deps = None,
        **kwargs):
    _csharp_binary(
        treat_warnings_as_errors = treat_warnings_as_errors if treat_warnings_as_errors != None else False,
        override_treat_warnings_as_errors = True if treat_warnings_as_errors != None else False,
        warnings_as_errors = warnings_as_errors if warnings_as_errors != None else [],
        override_warnings_as_errors = True if warnings_as_errors != None else False,
        warnings_not_as_errors = warnings_not_as_errors if warnings_not_as_errors != None else [],
        override_warnings_not_as_errors = True if warnings_not_as_errors != None else False,
        warning_level = warning_level if warning_level != None else 3,
        override_warning_level = True if warning_level != None else False,
        strict_deps = strict_deps if strict_deps != None else True,
        override_strict_deps = True if strict_deps != None else False,
        apphost_shimmer = Label("//dotnet/private/tools/apphost_shimmer:apphost_shimmer") if use_apphost_shim else None,
        **kwargs
    )

def csharp_library(
        treat_warnings_as_errors = None,
        warnings_as_errors = None,
        warnings_not_as_errors = None,
        warning_level = None,
        strict_deps = None,
        **kwargs):
    _csharp_library(
        treat_warnings_as_errors = treat_warnings_as_errors if treat_warnings_as_errors != None else False,
        override_treat_warnings_as_errors = True if treat_warnings_as_errors != None else False,
        warnings_as_errors = warnings_as_errors if warnings_as_errors != None else [],
        override_warnings_as_errors = True if warnings_as_errors != None else False,
        warnings_not_as_errors = warnings_not_as_errors if warnings_not_as_errors != None else [],
        override_warnings_not_as_errors = True if warnings_not_as_errors != None else False,
        warning_level = warning_level if warning_level != None else 3,
        override_warning_level = True if warning_level != None else False,
        strict_deps = strict_deps if strict_deps != None else True,
        override_strict_deps = True if strict_deps != None else False,
        **kwargs
    )

def csharp_test(
        use_apphost_shim = True,
        treat_warnings_as_errors = None,
        warnings_as_errors = None,
        warnings_not_as_errors = None,
        warning_level = None,
        strict_deps = None,
        **kwargs):
    _csharp_test(
        treat_warnings_as_errors = treat_warnings_as_errors if treat_warnings_as_errors != None else False,
        override_treat_warnings_as_errors = True if treat_warnings_as_errors != None else False,
        warnings_as_errors = warnings_as_errors if warnings_as_errors != None else [],
        override_warnings_as_errors = True if warnings_as_errors != None else False,
        warnings_not_as_errors = warnings_not_as_errors if warnings_not_as_errors != None else [],
        override_warnings_not_as_errors = True if warnings_not_as_errors != None else False,
        warning_level = warning_level if warning_level != None else 3,
        override_warning_level = True if warning_level != None else False,
        strict_deps = strict_deps if strict_deps != None else True,
        override_strict_deps = True if strict_deps != None else False,
        apphost_shimmer = Label("//dotnet/private/tools/apphost_shimmer:apphost_shimmer") if use_apphost_shim else None,
        **kwargs
    )

def csharp_nunit_test(
        use_apphost_shim = True,
        treat_warnings_as_errors = None,
        warnings_as_errors = None,
        warnings_not_as_errors = None,
        warning_level = None,
        strict_deps = None,
        **kwargs):
    _csharp_nunit_test(
        treat_warnings_as_errors = treat_warnings_as_errors if treat_warnings_as_errors != None else False,
        override_treat_warnings_as_errors = True if treat_warnings_as_errors != None else False,
        warnings_as_errors = warnings_as_errors if warnings_as_errors != None else [],
        override_warnings_as_errors = True if warnings_as_errors != None else False,
        warnings_not_as_errors = warnings_not_as_errors if warnings_not_as_errors != None else [],
        override_warnings_not_as_errors = True if warnings_not_as_errors != None else False,
        warning_level = warning_level if warning_level != None else 3,
        override_warning_level = True if warning_level != None else False,
        strict_deps = strict_deps if strict_deps != None else True,
        override_strict_deps = True if strict_deps != None else False,
        apphost_shimmer = Label("//dotnet/private/tools/apphost_shimmer:apphost_shimmer") if use_apphost_shim else None,
        **kwargs
    )

def fsharp_binary(
        use_apphost_shim = True,
        treat_warnings_as_errors = None,
        warnings_as_errors = None,
        warnings_not_as_errors = None,
        warning_level = None,
        strict_deps = None,
        **kwargs):
    _fsharp_binary(
        treat_warnings_as_errors = treat_warnings_as_errors if treat_warnings_as_errors != None else False,
        override_treat_warnings_as_errors = True if treat_warnings_as_errors != None else False,
        warnings_as_errors = warnings_as_errors if warnings_as_errors != None else [],
        override_warnings_as_errors = True if warnings_as_errors != None else False,
        warnings_not_as_errors = warnings_not_as_errors if warnings_not_as_errors != None else [],
        override_warnings_not_as_errors = True if warnings_not_as_errors != None else False,
        warning_level = warning_level if warning_level != None else 3,
        override_warning_level = True if warning_level != None else False,
        strict_deps = strict_deps if strict_deps != None else True,
        override_strict_deps = True if strict_deps != None else False,
        apphost_shimmer = Label("//dotnet/private/tools/apphost_shimmer:apphost_shimmer") if use_apphost_shim else None,
        **kwargs
    )

def fsharp_library(
        treat_warnings_as_errors = None,
        warnings_as_errors = None,
        warnings_not_as_errors = None,
        warning_level = None,
        strict_deps = None,
        **kwargs):
    _fsharp_library(
        treat_warnings_as_errors = treat_warnings_as_errors if treat_warnings_as_errors != None else False,
        override_treat_warnings_as_errors = True if treat_warnings_as_errors != None else False,
        warnings_as_errors = warnings_as_errors if warnings_as_errors != None else [],
        override_warnings_as_errors = True if warnings_as_errors != None else False,
        warnings_not_as_errors = warnings_not_as_errors if warnings_not_as_errors != None else [],
        override_warnings_not_as_errors = True if warnings_not_as_errors != None else False,
        warning_level = warning_level if warning_level != None else 3,
        override_warning_level = True if warning_level != None else False,
        strict_deps = strict_deps if strict_deps != None else True,
        override_strict_deps = True if strict_deps != None else False,
        **kwargs
    )

def fsharp_test(
        use_apphost_shim = True,
        treat_warnings_as_errors = None,
        warnings_as_errors = None,
        warnings_not_as_errors = None,
        warning_level = None,
        strict_deps = None,
        **kwargs):
    _fsharp_test(
        treat_warnings_as_errors = treat_warnings_as_errors if treat_warnings_as_errors != None else False,
        override_treat_warnings_as_errors = True if treat_warnings_as_errors != None else False,
        warnings_as_errors = warnings_as_errors if warnings_as_errors != None else [],
        override_warnings_as_errors = True if warnings_as_errors != None else False,
        warnings_not_as_errors = warnings_not_as_errors if warnings_not_as_errors != None else [],
        override_warnings_not_as_errors = True if warnings_not_as_errors != None else False,
        warning_level = warning_level if warning_level != None else 3,
        override_warning_level = True if warning_level != None else False,
        strict_deps = strict_deps if strict_deps != None else True,
        override_strict_deps = True if strict_deps != None else False,
        apphost_shimmer = Label("//dotnet/private/tools/apphost_shimmer:apphost_shimmer") if use_apphost_shim else None,
        **kwargs
    )

def fsharp_nunit_test(
        use_apphost_shim = True,
        treat_warnings_as_errors = None,
        warnings_as_errors = None,
        warnings_not_as_errors = None,
        warning_level = None,
        strict_deps = None,
        **kwargs):
    _fsharp_nunit_test(
        treat_warnings_as_errors = treat_warnings_as_errors if treat_warnings_as_errors != None else False,
        override_treat_warnings_as_errors = True if treat_warnings_as_errors != None else False,
        warnings_as_errors = warnings_as_errors if warnings_as_errors != None else [],
        override_warnings_as_errors = True if warnings_as_errors != None else False,
        warnings_not_as_errors = warnings_not_as_errors if warnings_not_as_errors != None else [],
        override_warnings_not_as_errors = True if warnings_not_as_errors != None else False,
        warning_level = warning_level if warning_level != None else 3,
        override_warning_level = True if warning_level != None else False,
        strict_deps = strict_deps if strict_deps != None else True,
        override_strict_deps = True if strict_deps != None else False,
        apphost_shimmer = Label("//dotnet/private/tools/apphost_shimmer:apphost_shimmer") if use_apphost_shim else None,
        **kwargs
    )

publish_binary = _publish_binary
import_library = _import_library
import_dll = _import_dll
nuget_repo = _nuget_repo
nuget_archive = _nuget_archive
