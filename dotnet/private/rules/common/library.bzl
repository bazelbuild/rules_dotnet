"Common implementation for building .Net libraries"

load("@bazel_skylib//rules:common_settings.bzl", "BuildSettingInfo")
load("//dotnet/private:common.bzl", "collect_transitive_runfiles")

def build_library(ctx, compile_action):
    """Builds a .Net library from a compilation action

    Args:
        ctx: Bazel build ctx.
        compile_action: A compilation function
            Args:
                ctx: Bazel build ctx.
                tfm: Target framework string
            Returns:
                An DotnetAssemblyInfo provider
    Returns:
        A collection of the references, runfiles and native dlls.
    """
    tfm = ctx.attr._target_framework[BuildSettingInfo].value

    dotnet_assembly_info_provider = compile_action(ctx, tfm)
    result = [dotnet_assembly_info_provider]

    result.append(
        DefaultInfo(
            files = depset(dotnet_assembly_info_provider.libs + dotnet_assembly_info_provider.xml_docs),
            default_runfiles = collect_transitive_runfiles(
                ctx,
                dotnet_assembly_info_provider,
                ctx.attr.deps,
            ),
        ),
    )

    return result
