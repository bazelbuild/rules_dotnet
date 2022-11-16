load("//dotnet/private:providers.bzl", "DotnetBinaryInfo", "DotnetAssemblyInfo", "NuGetInfo", "DotnetCompileInfo", "DotnetCompileDepVariantInfo")

load(
    "//dotnet/private:common.bzl",
    "generate_depsjson",
    "generate_runtimeconfig",
    "is_core_framework",
    "is_standard_framework",
)
load("@bazel_skylib//lib:paths.bzl", "paths")
load("@bazel_skylib//rules:common_settings.bzl", "BuildSettingInfo")
load("@aspect_bazel_lib//lib:paths.bzl", "to_manifest_path")


def gather_compile_info(ctx):
    direct_deps = []
    transitive_deps = []

    for dep in ctx.attr.deps:
        if DotnetCompileInfo in dep:
            variant = DotnetCompileDepVariantInfo(
                label = dep.label,
                dotnet_compile_info = dep[DotnetCompileInfo],
                dotnet_assembly_info = None,
            )

            direct_deps.append(variant)
            transitive_deps.append(depset(dep[DotnetCompileInfo].deps, transitive = [ dep[DotnetCompileInfo].transitive_deps ]))

        # if DotnetCompileInfo in dep:
        #     variant = DotnetCompileDepVariantInfo(
        #         label = dep.label,
        #         dotnet_compile_info = dep[DotnetCompileInfo],
        #         dotnet_assembly_info = None,
        #     )

        #     direct_deps.append(variant)
        #     transitive_deps.append(depset(dep[DotnetCompileInfo].deps, transitive = [ dep[DotnetCompileInfo].transitive_deps ]))

        if NuGetInfo in dep and DotnetAssemblyInfo in dep:
            variant = DotnetCompileDepVariantInfo(
                label = dep.label,
                dotnet_compile_info = None,
                dotnet_assembly_info = dep[DotnetAssemblyInfo],
            )

            direct_deps.append(variant)
            # transitive_deps.append(depset(dep[DotnetAssemblyInfo].deps, transitive = [ dep[DotnetAssemblyInfo].transitive_deps ]))

    return DotnetCompileInfo(
        label = ctx.label,
        sources = ctx.files.srcs,
        deps = direct_deps,
        transitive_deps = depset([], transitive = transitive_deps),
    )
