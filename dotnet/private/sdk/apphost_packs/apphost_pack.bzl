".Net Runtime Pack"

load("//dotnet/private:providers.bzl", "DotnetAssemblyCompileInfo", "DotnetAssemblyRuntimeInfo", "DotnetRuntimePackInfo", "NuGetInfo")
load("//dotnet/private/transitions:tfm_transition.bzl", "tfm_transition")

def _apphost_pack_impl(ctx):
    compile_infos = []
    apphost_infos = []
    nuget_infos = []
    for pack in ctx.attr.packs:
        if pack[DotnetAssemblyCompileInfo]:
            compile_infos.append(pack[DotnetAssemblyCompileInfo])
        if pack[DotnetAssemblyRuntimeInfo]:
            apphost_infos.append(pack[DotnetAssemblyRuntimeInfo])
        if pack[NuGetInfo]:
            nuget_infos.append(pack[NuGetInfo])

    return [DotnetRuntimePackInfo(
        apphost_identifier = ctx.attr.apphost_identifier,
        assembly_apphost_infos = apphost_infos,
        nuget_infos = nuget_infos,
    )]

apphost_pack = rule(
    _apphost_pack_impl,
    doc = """.Net apphost Pack""",
    attrs = {
        "packs": attr.label_list(
            cfg = tfm_transition,
            doc = "List of .Net apphost Packs that make this pack",
        ),
        "target_framework": attr.string(
            doc = "The target framework of the apphost pack",
        ),
        "apphost_identifier": attr.string(
            doc = "The apphost identifier of the apphost pack",
        ),
    },
)
