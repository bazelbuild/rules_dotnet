load("@rules_dotnet_skylib//lib:paths.bzl", "paths")

_gac2_path = "C:/Windows/assembly"
_gac4_path = "C:/Windows/Microsoft.NET/assembly"

def _net_gac_impl(ctx, gac, prefix = None):
    name = ctx.attr.name
    version_token = "%s%s__%s" % (prefix if prefix != None else "", ctx.attr.version, ctx.attr.token)

    # csc.exe /reference:path 260 limit
    for arch in ["GAC", "GAC_MSIL", "GAC_32", "GAC_64"]:
        gac_path = ctx.path(paths.join(_gac2_path if gac == "gac2" else _gac4_path, arch, name, version_token))
        if gac_path.exists:
            ctx.symlink(gac_path, arch)

    build_file_content = r'''package(default_visibility = [ "//visibility:public" ])
load("@io_bazel_rules_dotnet//dotnet:defs.bzl", "net_import_library")

[net_import_library(
    name = gac_assembly_arch,
    src =  gac_assembly_arch + "/%s.dll"
) for gac_assembly_arch in ["GAC", "GAC_MSIL", "GAC_32", "GAC_64"]]    
  ''' % name
    ctx.file("BUILD", build_file_content)

_gac_attrs = {
    "version": attr.string(mandatory = True),
    "token": attr.string(mandatory = True),
}

def _net_gac2_impl(ctx):
    _net_gac_impl(ctx, "gac2")

def _net_gac4_impl(ctx):
    _net_gac_impl(ctx, "gac4", "v4.0_")

net_gac2 = repository_rule(
    _net_gac2_impl,
    attrs = _gac_attrs,
)

net_gac4 = repository_rule(
    _net_gac4_impl,
    attrs = _gac_attrs,
)
