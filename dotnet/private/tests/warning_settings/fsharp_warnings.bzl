"F# Warning settings"

load("@bazel_skylib//lib:unittest.bzl", "analysistest")
load("//dotnet:defs.bzl", "fsharp_library")
load("//dotnet/private/tests:utils.bzl", "ACTION_ARGS_TEST_ARGS", "action_args_test", "action_args_test_impl")

fsharp_treat_warnings_as_errors_config_wrapper_test = analysistest.make(
    action_args_test_impl,
    attrs = ACTION_ARGS_TEST_ARGS,
    config_settings = {str(Label("//dotnet/settings:fsharp_treat_warnings_as_errors")): True},
)

fsharp_warnings_as_errors_config_wrapper_test = analysistest.make(
    action_args_test_impl,
    attrs = ACTION_ARGS_TEST_ARGS,
    config_settings = {str(Label("//dotnet/settings:fsharp_warnings_as_errors")): ["FS0025", "FS0026"]},
)

fsharp_warnings_not_as_errors_config_wrapper_test = analysistest.make(
    action_args_test_impl,
    attrs = ACTION_ARGS_TEST_ARGS,
    config_settings = {
        str(Label("//dotnet/settings:fsharp_treat_warnings_as_errors")): True,
        str(Label("//dotnet/settings:fsharp_warnings_not_as_errors")): ["FS0025", "FS0026"],
    },
)

fsharp_warning_level_config_wrapper_test = analysistest.make(
    action_args_test_impl,
    attrs = ACTION_ARGS_TEST_ARGS,
    config_settings = {str(Label("//dotnet/settings:fsharp_warning_level")): 5},
)

# buildifier: disable=function-docstring
# buildifier: disable=unnamed-macro
def fsharp_warnings():
    fsharp_library(
        name = "fsharp",
        srcs = ["warnings.fs"],
        targeting_packs = ["@paket.rules_dotnet_dev_nuget_packages//microsoft.netcore.app.ref"],
        target_frameworks = ["net6.0"],
        tags = ["manual"],
    )

    fsharp_treat_warnings_as_errors_config_wrapper_test(
        name = "fsharp_treat_warnings_as_errors_config_test",
        target_under_test = ":fsharp",
        action_mnemonic = "FSharpCompile",
        expected_partial_args = ["/warnaserror+"],
    )

    fsharp_warnings_as_errors_config_wrapper_test(
        name = "fsharp_warnings_as_errors_config_wrapper_test",
        target_under_test = ":fsharp",
        action_mnemonic = "FSharpCompile",
        expected_partial_args = ["/warnaserror+:FS0025", "/warnaserror+:FS0026"],
    )

    fsharp_warnings_not_as_errors_config_wrapper_test(
        name = "fsharp_warnings_not_as_errors_config_wrapper_test",
        target_under_test = ":fsharp",
        action_mnemonic = "FSharpCompile",
        expected_partial_args = ["/warnaserror-:FS0025", "/warnaserror-:FS0026"],
    )

    fsharp_warning_level_config_wrapper_test(
        name = "fsharp_warning_level_config_wrapper_test",
        target_under_test = ":fsharp",
        action_mnemonic = "FSharpCompile",
        expected_partial_args = ["/warn:5"],
    )

    fsharp_library(
        name = "fsharp_all_warnings",
        srcs = ["warnings.fs"],
        targeting_packs = ["@paket.rules_dotnet_dev_nuget_packages//microsoft.netcore.app.ref"],
        target_frameworks = ["net6.0"],
        treat_warnings_as_errors = True,
        tags = ["manual"],
    )

    action_args_test(
        name = "fsharp_all_warnings_test",
        target_under_test = ":fsharp_all_warnings",
        action_mnemonic = "FSharpCompile",
        expected_partial_args = ["/warnaserror+"],
    )

    fsharp_library(
        name = "fsharp_warnings_as_errors",
        srcs = ["warnings.fs"],
        targeting_packs = ["@paket.rules_dotnet_dev_nuget_packages//microsoft.netcore.app.ref"],
        target_frameworks = ["net6.0"],
        warnings_as_errors = ["FS0025", "FS0026"],
        tags = ["manual"],
    )

    action_args_test(
        name = "fsharp_warnings_as_errors_test",
        target_under_test = ":fsharp_warnings_as_errors",
        action_mnemonic = "FSharpCompile",
        expected_partial_args = ["/warnaserror+:FS0025", "/warnaserror+:FS0026"],
    )

    fsharp_library(
        name = "fsharp_warnings_not_as_errors",
        srcs = ["warnings.fs"],
        targeting_packs = ["@paket.rules_dotnet_dev_nuget_packages//microsoft.netcore.app.ref"],
        target_frameworks = ["net6.0"],
        treat_warnings_as_errors = True,
        warnings_not_as_errors = ["FS0025", "FS0026"],
        tags = ["manual"],
    )

    action_args_test(
        name = "fsharp_warnings_not_as_errors_test",
        target_under_test = ":fsharp_warnings_not_as_errors",
        action_mnemonic = "FSharpCompile",
        expected_partial_args = ["/warnaserror-:FS0025", "/warnaserror-:FS0026"],
    )

    fsharp_library(
        name = "fsharp_warning_level",
        srcs = ["warnings.fs"],
        targeting_packs = ["@paket.rules_dotnet_dev_nuget_packages//microsoft.netcore.app.ref"],
        target_frameworks = ["net6.0"],
        warning_level = 5,
        tags = ["manual"],
    )

    action_args_test(
        name = "fsharp_warning_level_test",
        target_under_test = ":fsharp_warning_level",
        action_mnemonic = "FSharpCompile",
        expected_partial_args = ["/warn:5"],
    )
