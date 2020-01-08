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
    "@io_bazel_rules_dotnet//dotnet/private:repositories.bzl",
    _dotnet_repositories = "dotnet_repositories",
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
    "@io_bazel_rules_dotnet//dotnet/private:rules/resx.bzl",
    _core_resx = "core_resx",
    _dotnet_resx = "dotnet_resx",
    _net_resx = "net_resx",
    _net_resx_multi = "net_resx_multi",
)
load(
    "@io_bazel_rules_dotnet//dotnet/private:rules/resource_core.bzl",
    _core_resource = "core_resource",
    _net_resource = "net_resource",
    _net_resource_multi = "net_resource_multi",
    _core_resource_multi = "core_resource_multi",
)
load(
    "@io_bazel_rules_dotnet//dotnet/private:rules/test.bzl",
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
    _DOTNET_NET_FRAMEWORKS = "DOTNET_NET_FRAMEWORKS",
)

dotnet_context = _dotnet_context
dotnet_register_toolchains = _dotnet_register_toolchains
mono_register_sdk = _mono_register_sdk
net_register_sdk = _net_register_sdk
core_register_sdk = _core_register_sdk
dotnet_toolchain = _dotnet_toolchain
dotnet_repositories = _dotnet_repositories
core_binary = _core_binary
dotnet_binary = _dotnet_binary
net_binary = _net_binary
core_library = _core_library
dotnet_library = _dotnet_library
net_library = _net_library
core_resx = _core_resx
dotnet_resx = _dotnet_resx
net_resx = _net_resx
net_resx_multi = _net_resx_multi
core_resource = _core_resource
net_resource = _net_resource
net_resource_multi = _net_resource_multi
core_resource_multi = _core_resource_multi
core_xunit_test = _core_xunit_test
dotnet_nunit_test = _dotnet_nunit_test
dotnet_xunit_test = _dotnet_xunit_test
net_nunit3_test = _net_nunit3_test
net_nunit_test = _net_nunit_test
net_xunit_test = _net_xunit_test
dotnet_nuget = _dotnet_nuget
dotnet_nuget_new = _dotnet_nuget_new
nuget_package = _nuget_package
core_import_binary = _core_import_binary
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
DEFAULT_DOTNET_CORE_FRAMEWORK = _DEFAULT_DOTNET_CORE_FRAMEWORK
core_context_data = _core_context_data
dotnet_context_data = _dotnet_context_data
net_context_data = _net_context_data
