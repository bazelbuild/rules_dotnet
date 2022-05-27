"""
Common implementation for building a .Net library
"""

load(
    "//dotnet/private:common.bzl",
    "fill_in_missing_frameworks",
)

def build_library(ctx, compile_action):
    """Builds a .Net library from a compilation action

    Args:
        ctx: Bazel build ctx.
        compile_action: A compilation function
            Args:
                ctx: Bazel build ctx.
                tfm: Target framework string
                sdk: .Net project SDK label
            Returns:
                An DotnetAssemblyInfo provider
    Returns:
        A collection of the references, runfiles and native dlls.
    """
    providers = {}

    sdk = ctx.attr.sdk

    for tfm in ctx.attr.target_frameworks:
        providers[tfm] = compile_action(ctx, tfm, ctx.attr.sdk)

    fill_in_missing_frameworks(ctx.attr.name, providers)

    result = providers.values()
    result.append(DefaultInfo(
        files = depset(result[0].out),
        runfiles = ctx.runfiles(files = result[0].pdb),
    ))

    return result
