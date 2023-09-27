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
    _publish_binary_wrapper = "publish_binary_wrapper",
)

def _get_runtime_runtime_identifier(rid):
    if rid:
        return rid
    else:
        return select(
            {
                Label("//dotnet/private:linux-x64"): "linux-x64",
                Label("//dotnet/private:linux-arm64"): "linux-arm64",
                Label("//dotnet/private:macos-x64"): "osx-x64",
                Label("//dotnet/private:macos-arm64"): "osx-arm64",
                Label("//dotnet/private:windows-x64"): "win-x64",
                Label("//dotnet/private:windows-arm64"): "win-arm64",
            },
            no_match_error = "Could not infer default runtime identifier from the current host platform",
        )

def csharp_binary(
        runtime_identifier = None,
        use_apphost_shim = True,
        treat_warnings_as_errors = None,
        warnings_as_errors = None,
        warnings_not_as_errors = None,
        warning_level = None,
        strict_deps = None,
        **kwargs):
    _csharp_binary(
        runtime_identifier = _get_runtime_runtime_identifier(runtime_identifier),
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
        runtime_identifier = None,
        treat_warnings_as_errors = None,
        warnings_as_errors = None,
        warnings_not_as_errors = None,
        warning_level = None,
        strict_deps = None,
        **kwargs):
    _csharp_library(
        runtime_identifier = _get_runtime_runtime_identifier(runtime_identifier),
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
        runtime_identifier = None,
        use_apphost_shim = True,
        treat_warnings_as_errors = None,
        warnings_as_errors = None,
        warnings_not_as_errors = None,
        warning_level = None,
        strict_deps = None,
        **kwargs):
    _csharp_test(
        runtime_identifier = _get_runtime_runtime_identifier(runtime_identifier),
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
        runtime_identifier = None,
        use_apphost_shim = True,
        treat_warnings_as_errors = None,
        warnings_as_errors = None,
        warnings_not_as_errors = None,
        warning_level = None,
        strict_deps = None,
        **kwargs):
    _csharp_nunit_test(
        runtime_identifier = _get_runtime_runtime_identifier(runtime_identifier),
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
        runtime_identifier = None,
        use_apphost_shim = True,
        treat_warnings_as_errors = None,
        warnings_as_errors = None,
        warnings_not_as_errors = None,
        warning_level = None,
        strict_deps = None,
        **kwargs):
    _fsharp_binary(
        runtime_identifier = _get_runtime_runtime_identifier(runtime_identifier),
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
        runtime_identifier = None,
        treat_warnings_as_errors = None,
        warnings_as_errors = None,
        warnings_not_as_errors = None,
        warning_level = None,
        strict_deps = None,
        **kwargs):
    _fsharp_library(
        runtime_identifier = _get_runtime_runtime_identifier(runtime_identifier),
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
        runtime_identifier = None,
        use_apphost_shim = True,
        treat_warnings_as_errors = None,
        warnings_as_errors = None,
        warnings_not_as_errors = None,
        warning_level = None,
        strict_deps = None,
        **kwargs):
    _fsharp_test(
        runtime_identifier = _get_runtime_runtime_identifier(runtime_identifier),
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
        runtime_identifier = None,
        use_apphost_shim = True,
        treat_warnings_as_errors = None,
        warnings_as_errors = None,
        warnings_not_as_errors = None,
        warning_level = None,
        strict_deps = None,
        **kwargs):
    _fsharp_nunit_test(
        runtime_identifier = _get_runtime_runtime_identifier(runtime_identifier),
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

def publish_binary(name, binary, target_framework, self_contained = False, runtime_packs = [], runtime_identifier = None, **kwargs):
    runtime_identifier = _get_runtime_runtime_identifier(runtime_identifier)

    _publish_binary(
        name = "{}_wrapped".format(name),
        binary = binary,
        target_framework = target_framework,
        self_contained = self_contained,
        runtime_packs = runtime_packs,
        tags = ["manual"],
    )

    _publish_binary_wrapper(
        name = name,
        wrapped_target = "{}_wrapped".format(name),
        target_framework = target_framework,
        runtime_identifier = _get_runtime_runtime_identifier(runtime_identifier),
        **kwargs
    )

import_library = _import_library
import_dll = _import_dll
nuget_repo = _nuget_repo
nuget_archive = _nuget_archive
