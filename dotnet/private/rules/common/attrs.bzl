"The attributes used by binary/library/test rules"

load("@bazel_skylib//lib:dicts.bzl", "dicts")
load("//dotnet/private:providers.bzl", "DotnetAssemblyInfo")
load("//dotnet/private:macros/register_tfms.bzl", "nuget_framework_transition")

# These are attributes that are common across all the binary/library/test .Net rules
COMMON_ATTRS = {
    "deps": attr.label_list(
        doc = "Other libraries, binaries, or imported DLLs",
        providers = [DotnetAssemblyInfo],
        cfg = nuget_framework_transition,
    ),
    "keyfile": attr.label(
        doc = "The key file used to sign the assembly with a strong name.",
        allow_single_file = True,
    ),
    "langversion": attr.string(
        doc = "The version string for the language.",
    ),
    "resources": attr.label_list(
        doc = "A list of files to embed in the DLL as resources.",
        allow_files = True,
    ),
    "out": attr.string(
        doc = "File name, without extension, of the built assembly.",
    ),
    "target_frameworks": attr.string_list(
        doc = "A list of target framework monikers to build" +
              "See https://docs.microsoft.com/en-us/dotnet/standard/frameworks",
        allow_empty = True,
        default = [],
    ),
    "defines": attr.string_list(
        doc = "A list of preprocessor directive symbols to define.",
        default = [],
        allow_empty = True,
    ),
    "internals_visible_to": attr.string_list(
        doc = "Other libraries that can see the assembly's internal symbols. Using this rather than the InternalsVisibleTo assembly attribute will improve build caching.",
    ),
    "_target_framework": attr.label(
        default = "@rules_dotnet//dotnet:target_framework"
    ),
    "_windows_constraint": attr.label(default = "@platforms//os:windows"),
    "_allowlist_function_transition": attr.label(
        default = "@bazel_tools//tools/allowlists/function_transition_allowlist"
    ),
}

# These are attributes that are common across all binary/test rules
BINARY_COMMON_ATTRS = {
    "winexe": attr.bool(
        doc = "If true, output a winexe-style executable, otherwise" +
              "output a console-style executable.",
        default = False,
    ),
    "runtimeconfig_template": attr.label(
        doc = "A template file to use for generating runtimeconfig.json",
        default = ":runtimeconfig.json.tpl",
        allow_single_file = True,
    ),
    "depsjson_template": attr.label(
        doc = "A template file to use for generating deps.json",
        default = ":deps.json.tpl",
        allow_single_file = True,
    ),
    "_manifest_loader": attr.label(
        default = "@rules_dotnet//dotnet/private/tools/manifest_loader:ManifestLoader",
        providers = [DotnetAssemblyInfo],
    ),
    "_bash_runfiles": attr.label(
        default = "@bazel_tools//tools/bash/runfiles",
        allow_single_file = True,
    ),
    "_launcher_sh": attr.label(
        doc = "A template file for the launcher on Linux/MacOS",
        default = ":launcher.sh.tpl",
        allow_single_file = True,
    ),
    "_launcher_bat": attr.label(
        doc = "A template file for the launcher on Windows",
        default = ":launcher.bat.tpl",
        allow_single_file = True,
    ),
}

# These are attributes that are common across all the binary/library/test C# rules
CSHARP_COMMON_ATTRS = dicts.add(
    COMMON_ATTRS,
    {
        "srcs": attr.label_list(
            doc = "The source files used in the compilation.",
            allow_files = [".cs"],
        ),
        "additionalfiles": attr.label_list(
            doc = "Extra files to configure analyzers.",
            allow_files = True,
        ),
    },
)

# These are attributes that are common across all the binary C# rules
CSHARP_BINARY_COMMON_ATTRS = dicts.add(
    CSHARP_COMMON_ATTRS,
    BINARY_COMMON_ATTRS,
)

# These are attributes that are common across all the binary/library/test F# rules
FSHARP_COMMON_ATTRS = dicts.add(
    COMMON_ATTRS,
    {
        "srcs": attr.label_list(
            doc = "The source files used in the compilation.",
            allow_files = [".fs"],
        ),
    },
)

# These are attributes that are common across all the binary/library/test F# rules
FSHARP_BINARY_COMMON_ATTRS = dicts.add(
    FSHARP_COMMON_ATTRS,
    BINARY_COMMON_ATTRS,
)
