"NuGet structure tests"

load("//dotnet/private/tests/nuget_structure:common.bzl", "nuget_structure_test", "nuget_test_wrapper")

# buildifier: disable=unnamed-macro
def resolution_structure():
    "Tests for the resolution of files depending on target framework"
    nuget_test_wrapper(
        name = "System.Memory.netstandard2.0",
        target_framework = "netstandard2.0",
        runtime_identifier = "linux-x64",
        package = "@paket.rules_dotnet_dev_nuget_packages//system.memory",
    )

    nuget_structure_test(
        name = "should_resolve_system.memory_netstandard2.0_linux-x64_correctly",
        target_under_test = ":System.Memory.netstandard2.0",
        expected_libs = ["lib/netstandard2.0/System.Memory.dll"],
        expected_refs = ["lib/netstandard2.0/System.Memory.dll"],
    )
