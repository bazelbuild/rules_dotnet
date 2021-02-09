load(
    "//dotnet/private:context.bzl",
    _dotnet_context = "dotnet_context",
)
load(
    "//dotnet/toolchain:toolchains.bzl",
    _dotnet_register_toolchains = "dotnet_register_toolchains",
)
load(
    "//dotnet/private:rules/binary.bzl",
    _core_binary = "core_binary",
)
load(
    "//dotnet/private:rules/library.bzl",
    _core_library = "core_library",
)
load(
    "//dotnet/private:rules/libraryset.bzl",
    _core_libraryset = "core_libraryset",
)
load(
    "//dotnet/private:rules/resx.bzl",
    _core_resx = "core_resx",
)
load(
    "//dotnet/private:rules/resource_core.bzl",
    _core_resource = "core_resource",
    _core_resource_multi = "core_resource_multi",
)
load(
    "//dotnet/private:rules/stdlib.bzl",
    _core_stdlib = "core_stdlib",
    _core_stdlib_internal = "core_stdlib_internal",
)
load(
    "//dotnet/private:rules/test.bzl",
    _core_nunit3_test = "core_nunit3_test",
    _core_xunit_test = "core_xunit_test",
)
load(
    "//dotnet/private:rules/nuget.bzl",
    _dotnet_nuget_new = "dotnet_nuget_new",
    _nuget_package = "nuget_package",
)
load(
    "//dotnet/private:rules/import.bzl",
    _core_import_binary = "core_import_binary",
    _core_import_library = "core_import_library",
)
load(
    "//dotnet/platform:list.bzl",
    _DEFAULT_DOTNET_CORE_FRAMEWORK = "DEFAULT_DOTNET_CORE_FRAMEWORK",
    _DOTNET_CORE_FRAMEWORKS = "DOTNET_CORE_FRAMEWORKS",
    _DOTNET_CORE_NAMES = "DOTNET_CORE_NAMES",
    _DOTNET_NETSTANDARD = "DOTNET_NETSTANDARD",
)
load(
    "//dotnet/private:nugets.bzl",
    _dotnet_repositories_nugets = "dotnet_repositories_nugets",
)

dotnet_context = _dotnet_context
dotnet_register_toolchains = _dotnet_register_toolchains
core_binary = _core_binary
core_library = _core_library
core_libraryset = _core_libraryset
core_resx = _core_resx
core_resource = _core_resource
core_resource_multi = _core_resource_multi
core_stdlib = _core_stdlib
core_stdlib_internal = _core_stdlib_internal
core_xunit_test = _core_xunit_test
core_nunit3_test = _core_nunit3_test
dotnet_nuget_new = _dotnet_nuget_new
nuget_package = _nuget_package
core_import_binary = _core_import_binary
core_import_library = _core_import_library
DOTNET_CORE_FRAMEWORKS = _DOTNET_CORE_FRAMEWORKS
DOTNET_CORE_NAMES = _DOTNET_CORE_NAMES
DEFAULT_DOTNET_CORE_FRAMEWORK = _DEFAULT_DOTNET_CORE_FRAMEWORK
DOTNET_NETSTANDARD = _DOTNET_NETSTANDARD
dotnet_repositories_nugets = _dotnet_repositories_nugets
