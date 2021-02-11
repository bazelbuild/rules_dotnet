load(
    "//dotnet/private:context.bzl",
    _DotnetContextInfo = "DotnetContextInfo",
    _dotnet_context = "dotnet_context",
    _new_library = "new_library",
    _new_resource = "new_resource",
)
load(
    "//dotnet/private:providers.bzl",
    _DotnetLibraryInfo = "DotnetLibraryInfo",
    _DotnetResourceInfo = "DotnetResourceInfo",
    _DotnetResourceListInfo = "DotnetResourceListInfo",
)
load(
    "//dotnet/toolchain:toolchains.bzl",
    _dotnet_register_toolchains = "dotnet_register_toolchains",
)
load(
    "//dotnet/private:rules/csharp/binary.bzl",
    _csharp_binary = "csharp_binary",
)
load(
    "//dotnet/private:rules/csharp/library.bzl",
    _csharp_library = "csharp_library",
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
    "//dotnet/private:rules/csharp/test.bzl",
    _csharp_nunit3_test = "csharp_nunit3_test",
    _csharp_xunit_test = "csharp_xunit_test",
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
load("@io_bazel_rules_dotnet//dotnet/private:actions/assembly_core.bzl", _emit_assembly_core = "emit_assembly_core")
load("@io_bazel_rules_dotnet//dotnet/private:actions/resx_core.bzl", _emit_resx_core = "emit_resx_core")
load("@io_bazel_rules_dotnet//dotnet/private:sdk_core.bzl", _core_download_sdk = "core_download_sdk")
load("@io_bazel_rules_dotnet//dotnet/private:repositories.bzl", _dotnet_repositories = "dotnet_repositories")

dotnet_context = _dotnet_context
DotnetContextInfo = _DotnetContextInfo
dotnet_register_toolchains = _dotnet_register_toolchains
csharp_binary = _csharp_binary
csharp_library = _csharp_library
core_libraryset = _core_libraryset
core_resx = _core_resx
core_resource = _core_resource
core_resource_multi = _core_resource_multi
core_stdlib = _core_stdlib
core_stdlib_internal = _core_stdlib_internal
csharp_xunit_test = _csharp_xunit_test
csharp_nunit3_test = _csharp_nunit3_test
dotnet_nuget_new = _dotnet_nuget_new
nuget_package = _nuget_package
core_import_binary = _core_import_binary
core_import_library = _core_import_library
DOTNET_CORE_FRAMEWORKS = _DOTNET_CORE_FRAMEWORKS
DOTNET_CORE_NAMES = _DOTNET_CORE_NAMES
DEFAULT_DOTNET_CORE_FRAMEWORK = _DEFAULT_DOTNET_CORE_FRAMEWORK
DOTNET_NETSTANDARD = _DOTNET_NETSTANDARD
dotnet_repositories_nugets = _dotnet_repositories_nugets
DotnetLibraryInfo = _DotnetLibraryInfo
DotnetResourceInfo = _DotnetResourceInfo
DotnetResourceListInfo = _DotnetResourceListInfo
emit_assembly_core = _emit_assembly_core
emit_resx_core = _emit_resx_core
new_library = _new_library
new_resource = _new_resource
core_download_sdk = _core_download_sdk
dotnet_repositories = _dotnet_repositories
