"NuGet structure tests"

load("@bazel_skylib//lib:unittest.bzl", "analysistest", "asserts")

# buildifier: disable=bzl-visibility
load("//dotnet/private:providers.bzl", "DotnetAssemblyInfo")

def _get_nuget_relative_paths(files):
    # The path of the files is of the form external/<packagename>.v<version>/<path within nuget package>
    # So we remove the first two parts of the path to get the path within the nuget package.
    nuget_paths_parts = [file.path.split("/")[2:] for file in files]
    return ["/".join(path_parts) for path_parts in nuget_paths_parts]

def _nuget_structure_test_impl(ctx):
    env = analysistest.begin(ctx)

    target_under_test = analysistest.target_under_test(env)
    provider = target_under_test[DotnetAssemblyInfo]

    libs_files = _get_nuget_relative_paths(provider.libs)
    asserts.true(
        env,
        sorted(ctx.attr.expected_libs) == sorted(libs_files),
        "\nExpected libs:\n{}\nActual libs:\n{}".format(ctx.attr.expected_libs, libs_files),
    )

    prefs_files = _get_nuget_relative_paths(provider.prefs)
    asserts.true(
        env,
        sorted(ctx.attr.expected_refs) == sorted(prefs_files),
        "\nExpected prefs:\n{}\nActual prefs:\n{}".format(ctx.attr.expected_refs, prefs_files),
    )

    irefs_files = _get_nuget_relative_paths(provider.irefs)
    asserts.true(
        env,
        sorted(ctx.attr.expected_refs) == sorted(irefs_files),
        "\nExpected irefs:\n{}\nActual irefs:\n{}".format(ctx.attr.expected_refs, irefs_files),
    )

    analyzers_files = _get_nuget_relative_paths(provider.analyzers)
    asserts.true(
        env,
        sorted(ctx.attr.expected_analyzers) == sorted(analyzers_files),
        "\nExpected analyzers:\n{}\nActual analyzers:\n{}".format(ctx.attr.expected_analyzers, analyzers_files),
    )

    data_files = _get_nuget_relative_paths(provider.data)
    asserts.true(
        env,
        sorted(ctx.attr.expected_data) == sorted(data_files),
        "\nExpected data:\n{}\nActual data:\n{}".format(ctx.attr.expected_data, data_files),
    )

    return analysistest.end(env)

nuget_structure_test = analysistest.make(
    _nuget_structure_test_impl,
    attrs = {
        "expected_libs": attr.string_list(default = []),
        "expected_refs": attr.string_list(default = []),
        "expected_analyzers": attr.string_list(default = []),
        "expected_data": attr.string_list(default = []),
    },
)

def _test_nuget_structure():
    nuget_structure_test(
        name = "nuget_structure_should_parse_typeprovider_folder_correctly",
        target_under_test = "@rules_dotnet_test_deps//fsharp.data",
        expected_libs = ["lib/netstandard2.0/FSharp.Data.dll", "typeproviders/fsharp41/netstandard2.0/FSharp.Data.DesignTime.dll"],
        expected_refs = ["lib/netstandard2.0/FSharp.Data.dll", "typeproviders/fsharp41/netstandard2.0/FSharp.Data.DesignTime.dll"],
    )

def nuget_structure_suite(name):
    _test_nuget_structure()

    native.test_suite(
        name = name,
        tests = [
            ":nuget_structure_should_parse_typeprovider_folder_correctly",
        ],
    )
