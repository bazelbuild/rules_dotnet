load(
    "@io_bazel_rules_dotnet//dotnet/private:context.bzl",
    _core_context_data = "core_context_data",
    _dotnet_context = "dotnet_context",
    _dotnet_context_data = "dotnet_context_data",
    _net_context_data = "net_context_data",
)
load(
    "@io_bazel_rules_dotnet//dotnet/toolchain:toolchains.bzl",
    _core_register_sdk = "core_register_sdk",
    _dotnet_register_toolchains = "dotnet_register_toolchains",
    _mono_register_sdk = "mono_register_sdk",
    _net_register_sdk = "net_register_sdk",
)
load(
    "@io_bazel_rules_dotnet//dotnet/private:dotnet_toolchain.bzl",
    _dotnet_toolchain = "dotnet_toolchain",
)
load(
    "@io_bazel_rules_dotnet//dotnet/private:rules/binary.bzl",
    _core_binary = "core_binary",
    _dotnet_binary = "dotnet_binary",
    _net_binary = "net_binary",
)
load(
    "@io_bazel_rules_dotnet//dotnet/private:rules/library.bzl",
    _core_library = "core_library",
    _dotnet_library = "dotnet_library",
    _net_library = "net_library",
)
load(
    "@io_bazel_rules_dotnet//dotnet/private:rules/libraryset.bzl",
    _core_libraryset = "core_libraryset",
    _dotnet_libraryset = "dotnet_libraryset",
    _net_libraryset = "net_libraryset",
)
load(
    "@io_bazel_rules_dotnet//dotnet/private:rules/resx.bzl",
    _core_resx = "core_resx",
    _dotnet_resx = "dotnet_resx",
    _net_resx = "net_resx",
    _net_resx_multi = "net_resx_multi",
)
load(
    "@io_bazel_rules_dotnet//dotnet/private:rules/resource_core.bzl",
    _core_resource = "core_resource",
    _core_resource_multi = "core_resource_multi",
    _net_resource = "net_resource",
    _net_resource_multi = "net_resource_multi",
)
load(
    "@io_bazel_rules_dotnet//dotnet/private:rules/stdlib.bzl",
    _core_stdlib = "core_stdlib",
    _core_stdlib_internal = "core_stdlib_internal",
    _dotnet_stdlib = "dotnet_stdlib",
    _net_stdlib = "net_stdlib",
)
load(
    "@io_bazel_rules_dotnet//dotnet/private:rules/test.bzl",
    _core_nunit3_test = "core_nunit3_test",
    _core_xunit_test = "core_xunit_test",
    _dotnet_nunit_test = "dotnet_nunit_test",
    _dotnet_xunit_test = "dotnet_xunit_test",
    _net_nunit3_test = "net_nunit3_test",
    _net_nunit_test = "net_nunit_test",
    _net_xunit_test = "net_xunit_test",
)
load(
    "@io_bazel_rules_dotnet//dotnet/private:rules/nuget.bzl",
    _dotnet_nuget = "dotnet_nuget",
    _dotnet_nuget_new = "dotnet_nuget_new",
    _nuget_package = "nuget_package",
)
load(
    "@io_bazel_rules_dotnet//dotnet/private:rules/import.bzl",
    _core_import_binary = "core_import_binary",
    _core_import_binary_internal = "core_import_binary_internal",
    _core_import_library = "core_import_library",
    _dotnet_import_binary = "dotnet_import_binary",
    _dotnet_import_library = "dotnet_import_library",
    _net_import_binary = "net_import_binary",
    _net_import_library = "net_import_library",
)
load(
    "@io_bazel_rules_dotnet//dotnet/private:rules/com_ref.bzl",
    _net_com_library = "net_com_library",
)
load(
    "@io_bazel_rules_dotnet//dotnet/private:rules/gac_net.bzl",
    _net_gac2 = "net_gac2",
    _net_gac4 = "net_gac4",
)
load(
    "@io_bazel_rules_dotnet//dotnet/private:rules/vs_ref_net.bzl",
    _vs2017_ref_net = "vs2017_ref_net",
)
load(
    "@io_bazel_rules_dotnet//dotnet/platform:list.bzl",
    _DEFAULT_DOTNET_CORE_FRAMEWORK = "DEFAULT_DOTNET_CORE_FRAMEWORK",
    _DOTNET_CORE_FRAMEWORKS = "DOTNET_CORE_FRAMEWORKS",
    _DOTNET_CORE_NAMES = "DOTNET_CORE_NAMES",
    _DOTNET_NETSTANDARD = "DOTNET_NETSTANDARD",
    _DOTNET_NET_FRAMEWORKS = "DOTNET_NET_FRAMEWORKS",
    _DOTNET_NET_NAMES = "DOTNET_NET_NAMES",
)
load(
    "@io_bazel_rules_dotnet//dotnet/private:nugets.bzl",
    _dotnet_repositories_nugets = "dotnet_repositories_nugets",
)

dotnet_context = _dotnet_context
dotnet_register_toolchains = _dotnet_register_toolchains
mono_register_sdk = _mono_register_sdk
net_register_sdk = _net_register_sdk
core_register_sdk = _core_register_sdk
dotnet_toolchain = _dotnet_toolchain
core_binary = _core_binary
dotnet_binary = _dotnet_binary
net_binary = _net_binary
core_library = _core_library
dotnet_library = _dotnet_library
net_library = _net_library
core_libraryset = _core_libraryset
dotnet_libraryset = _dotnet_libraryset
net_libraryset = _net_libraryset
core_resx = _core_resx
dotnet_resx = _dotnet_resx
net_resx = _net_resx
net_resx_multi = _net_resx_multi
core_resource = _core_resource
net_resource = _net_resource
net_resource_multi = _net_resource_multi
core_resource_multi = _core_resource_multi
core_stdlib = _core_stdlib
core_stdlib_internal = _core_stdlib_internal
dotnet_stdlib = _dotnet_stdlib
net_stdlib = _net_stdlib
core_xunit_test = _core_xunit_test
core_nunit3_test = _core_nunit3_test
dotnet_nunit_test = _dotnet_nunit_test
dotnet_xunit_test = _dotnet_xunit_test
net_nunit3_test = _net_nunit3_test
net_nunit_test = _net_nunit_test
net_xunit_test = _net_xunit_test
dotnet_nuget = _dotnet_nuget
dotnet_nuget_new = _dotnet_nuget_new
nuget_package = _nuget_package
core_import_binary = _core_import_binary
core_import_binary_internal = _core_import_binary_internal
core_import_library = _core_import_library
dotnet_import_binary = _dotnet_import_binary
dotnet_import_library = _dotnet_import_library
net_import_binary = _net_import_binary
net_import_library = _net_import_library
net_com_library = _net_com_library
net_gac2 = _net_gac2
net_gac4 = _net_gac4
vs2017_ref_net = _vs2017_ref_net
DOTNET_NET_FRAMEWORKS = _DOTNET_NET_FRAMEWORKS
DOTNET_CORE_FRAMEWORKS = _DOTNET_CORE_FRAMEWORKS
DOTNET_CORE_NAMES = _DOTNET_CORE_NAMES
DOTNET_NET_NAMES = _DOTNET_NET_NAMES
DEFAULT_DOTNET_CORE_FRAMEWORK = _DEFAULT_DOTNET_CORE_FRAMEWORK
DOTNET_NETSTANDARD = _DOTNET_NETSTANDARD
core_context_data = _core_context_data
dotnet_context_data = _dotnet_context_data
net_context_data = _net_context_data
dotnet_repositories_nugets = _dotnet_repositories_nugets
