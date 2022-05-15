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
                stdrefs: .Net standard library references
            Returns:
                An DotnetAssemblyInfo provider
    Returns:
        A collection of the references, runfiles and native dlls.
    """
    providers = {}

    stdrefs = [ctx.attr._stdrefs] if ctx.attr.include_stdrefs else []

    for tfm in ctx.attr.target_frameworks:
        providers[tfm] = compile_action(ctx, tfm, stdrefs)

    fill_in_missing_frameworks(ctx.attr.name, providers)

    result = providers.values()
    result.append(DefaultInfo(
        files = depset([result[0].out]),
        default_runfiles = ctx.runfiles(files = [result[0].pdb]),
    ))

    return result