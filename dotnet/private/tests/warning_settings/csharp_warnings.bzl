"C# Warning settings"

load("@bazel_skylib//lib:unittest.bzl", "analysistest")
load("//dotnet:defs.bzl", "csharp_library")
load("//dotnet/private/tests:utils.bzl", "ACTION_ARGS_TEST_ARGS", "action_args_test", "action_args_test_impl")

csharp_treat_warnings_as_errors_config_wrapper_test = analysistest.make(
    action_args_test_impl,
    attrs = ACTION_ARGS_TEST_ARGS,
    config_settings = {str(Label("//dotnet/settings:csharp_treat_warnings_as_errors")): True},
)

csharp_warnings_as_errors_config_wrapper_test = analysistest.make(
    action_args_test_impl,
    attrs = ACTION_ARGS_TEST_ARGS,
    config_settings = {str(Label("//dotnet/settings:csharp_warnings_as_errors")): ["CS0025", "CS0026"]},
)

csharp_warnings_not_as_errors_config_wrapper_test = analysistest.make(
    action_args_test_impl,
    attrs = ACTION_ARGS_TEST_ARGS,
    config_settings = {
        str(Label("//dotnet/settings:csharp_treat_warnings_as_errors")): True,
        str(Label("//dotnet/settings:csharp_warnings_not_as_errors")): ["CS0025", "CS0026"],
    },
)

csharp_warning_level_config_wrapper_test = analysistest.make(
    action_args_test_impl,
    attrs = ACTION_ARGS_TEST_ARGS,
    config_settings = {str(Label("//dotnet/settings:csharp_warning_level")): 5},
)

# buildifier: disable=function-docstring
# buildifier: disable=unnamed-macro
def csharp_warnings():
    csharp_library(
        name = "csharp",
        srcs = ["warnings.cs"],
        targeting_packs = ["@paket.rules_dotnet_dev_nuget_packages//microsoft.netcore.app.ref"],
        target_frameworks = ["net6.0"],
        tags = ["manual"],
    )

    csharp_treat_warnings_as_errors_config_wrapper_test(
        name = "csharp_treat_warnings_as_errors_config_test",
        target_under_test = ":csharp",
        action_mnemonic = "CSharpCompile",
        expected_partial_args = ["/warnaserror+"],
    )

    csharp_warnings_as_errors_config_wrapper_test(
        name = "csharp_warnings_as_errors_config_wrapper_test",
        target_under_test = ":csharp",
        action_mnemonic = "CSharpCompile",
        expected_partial_args = ["/warnaserror+:CS0025", "/warnaserror+:CS0026"],
    )

    csharp_warnings_not_as_errors_config_wrapper_test(
        name = "csharp_warnings_not_as_errors_config_wrapper_test",
        target_under_test = ":csharp",
        action_mnemonic = "CSharpCompile",
        expected_partial_args = ["/warnaserror-:CS0025", "/warnaserror-:CS0026"],
    )

    csharp_warning_level_config_wrapper_test(
        name = "csharp_warning_level_config_wrapper_test",
        target_under_test = ":csharp",
        action_mnemonic = "CSharpCompile",
        expected_partial_args = ["/warn:5"],
    )

    csharp_library(
        name = "csharp_all_warnings",
        srcs = ["warnings.cs"],
        targeting_packs = ["@paket.rules_dotnet_dev_nuget_packages//microsoft.netcore.app.ref"],
        target_frameworks = ["net6.0"],
        treat_warnings_as_errors = True,
        tags = ["manual"],
    )

    action_args_test(
        name = "csharp_all_warnings_test",
        target_under_test = ":csharp_all_warnings",
        action_mnemonic = "CSharpCompile",
        expected_partial_args = ["/warnaserror+"],
    )

    csharp_library(
        name = "csharp_warnings_as_errors",
        srcs = ["warnings.cs"],
        targeting_packs = ["@paket.rules_dotnet_dev_nuget_packages//microsoft.netcore.app.ref"],
        target_frameworks = ["net6.0"],
        warnings_as_errors = ["CS0025", "CS0026"],
        tags = ["manual"],
    )

    action_args_test(
        name = "csharp_warnings_as_errors_test",
        target_under_test = ":csharp_warnings_as_errors",
        action_mnemonic = "CSharpCompile",
        expected_partial_args = ["/warnaserror+:CS0025", "/warnaserror+:CS0026"],
    )

    csharp_library(
        name = "csharp_warnings_not_as_errors",
        srcs = ["warnings.cs"],
        targeting_packs = ["@paket.rules_dotnet_dev_nuget_packages//microsoft.netcore.app.ref"],
        target_frameworks = ["net6.0"],
        treat_warnings_as_errors = True,
        warnings_not_as_errors = ["CS0025", "CS0026"],
        tags = ["manual"],
    )

    action_args_test(
        name = "csharp_warnings_not_as_errors_test",
        target_under_test = ":csharp_warnings_not_as_errors",
        action_mnemonic = "CSharpCompile",
        expected_partial_args = ["/warnaserror-:CS0025", "/warnaserror-:CS0026"],
    )

    csharp_library(
        name = "csharp_warning_level",
        srcs = ["warnings.cs"],
        targeting_packs = ["@paket.rules_dotnet_dev_nuget_packages//microsoft.netcore.app.ref"],
        target_frameworks = ["net6.0"],
        warning_level = 5,
        tags = ["manual"],
    )

    action_args_test(
        name = "csharp_warning_level_test",
        target_under_test = ":csharp_warning_level",
        action_mnemonic = "CSharpCompile",
        expected_partial_args = ["/warn:5"],
    )
