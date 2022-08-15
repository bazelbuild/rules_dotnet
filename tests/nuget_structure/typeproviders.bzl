"NuGet structure tests"

load("//tests/nuget_structure:common.bzl", "nuget_structure_test", "nuget_test_wrapper")

def typeproviders_structure():
    "Tests for the typeproviders folder"
    nuget_test_wrapper(
        name = "fsharp.data",
        target_framework = "net6.0",
        runtime_identifier = "linux-x64",
        package = "@rules_dotnet_test_deps//fsharp.data",
    )

    nuget_structure_test(
        name = "nuget_structure_should_parse_typeprovider_folder_correctly",
        target_under_test = ":fsharp.data",
        expected_libs = ["lib/netstandard2.0/FSharp.Data.dll", "typeproviders/fsharp41/netstandard2.0/FSharp.Data.DesignTime.dll"],
        expected_refs = ["lib/netstandard2.0/FSharp.Data.dll", "typeproviders/fsharp41/netstandard2.0/FSharp.Data.DesignTime.dll"],
    )
