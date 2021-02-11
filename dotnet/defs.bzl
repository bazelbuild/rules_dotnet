load(
    "@io_bazel_rules_dotnet//dotnet/private:context.bzl",
    _dotnet_context = "dotnet_context",
)
load(
    "@io_bazel_rules_dotnet//dotnet/toolchain:toolchains.bzl",
    _dotnet_register_toolchains = "dotnet_register_toolchains",
)
load(
    "@io_bazel_rules_dotnet//dotnet/private:rules/csharp/binary.bzl",
    _csharp_binary = "csharp_binary",
)
load(
    "@io_bazel_rules_dotnet//dotnet/private:rules/csharp/library.bzl",
    _csharp_library = "csharp_library",
)
load(
    "@io_bazel_rules_dotnet//dotnet/private:rules/fsharp/binary.bzl",
    _fsharp_binary = "fsharp_binary",
)
load(
    "@io_bazel_rules_dotnet//dotnet/private:rules/fsharp/library.bzl",
    _fsharp_library = "fsharp_library",
)
load(
    "@io_bazel_rules_dotnet//dotnet/private:rules/libraryset.bzl",
    _core_libraryset = "core_libraryset",
)
load(
    "@io_bazel_rules_dotnet//dotnet/private:rules/resx.bzl",
    _core_resx = "core_resx",
)
load(
    "@io_bazel_rules_dotnet//dotnet/private:rules/resource_core.bzl",
    _core_resource = "core_resource",
    _core_resource_multi = "core_resource_multi",
)
load(
    "@io_bazel_rules_dotnet//dotnet/private:rules/stdlib.bzl",
    _core_stdlib = "core_stdlib",
    _core_stdlib_internal = "core_stdlib_internal",
)
load(
    "@io_bazel_rules_dotnet//dotnet/private:rules/csharp/test.bzl",
    _csharp_nunit3_test = "csharp_nunit3_test",
    _csharp_xunit_test = "csharp_xunit_test",
)
load(
    "@io_bazel_rules_dotnet//dotnet/private:rules/fsharp/test.bzl",
    _fsharp_nunit3_test = "fsharp_nunit3_test",
    _fsharp_xunit_test = "fsharp_xunit_test",
)
load(
    "@io_bazel_rules_dotnet//dotnet/private:rules/nuget.bzl",
    _dotnet_nuget_new = "dotnet_nuget_new",
    _nuget_package = "nuget_package",
)
load(
    "@io_bazel_rules_dotnet//dotnet/private:rules/import.bzl",
    _core_import_binary = "core_import_binary",
    _core_import_library = "core_import_library",
)
load(
    "@io_bazel_rules_dotnet//dotnet/platform:list.bzl",
    _DEFAULT_DOTNET_CORE_FRAMEWORK = "DEFAULT_DOTNET_CORE_FRAMEWORK",
    _DOTNET_CORE_FRAMEWORKS = "DOTNET_CORE_FRAMEWORKS",
    _DOTNET_CORE_NAMES = "DOTNET_CORE_NAMES",
    _DOTNET_NETSTANDARD = "DOTNET_NETSTANDARD",
)
load(
    "@io_bazel_rules_dotnet//dotnet/private:nugets.bzl",
    _dotnet_repositories_nugets = "dotnet_repositories_nugets",
)

dotnet_context = _dotnet_context
dotnet_register_toolchains = _dotnet_register_toolchains
csharp_binary = _csharp_binary
csharp_library = _csharp_library
fsharp_binary = _fsharp_binary
fsharp_library = _fsharp_library
core_libraryset = _core_libraryset
core_resx = _core_resx
core_resource = _core_resource
core_resource_multi = _core_resource_multi
core_stdlib = _core_stdlib
core_stdlib_internal = _core_stdlib_internal
csharp_xunit_test = _csharp_xunit_test
csharp_nunit3_test = _csharp_nunit3_test
fsharp_xunit_test = _fsharp_xunit_test
fsharp_nunit3_test = _fsharp_nunit3_test
dotnet_nuget_new = _dotnet_nuget_new
nuget_package = _nuget_package
core_import_binary = _core_import_binary
core_import_library = _core_import_library
DOTNET_CORE_FRAMEWORKS = _DOTNET_CORE_FRAMEWORKS
DOTNET_CORE_NAMES = _DOTNET_CORE_NAMES
DEFAULT_DOTNET_CORE_FRAMEWORK = _DEFAULT_DOTNET_CORE_FRAMEWORK
DOTNET_NETSTANDARD = _DOTNET_NETSTANDARD
dotnet_repositories_nugets = _dotnet_repositories_nugets
