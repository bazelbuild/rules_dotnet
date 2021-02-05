load("@rules_dotnet_skylib//lib:paths.bzl", "paths")

def _vs2017_ref_net_impl(ctx):
    prefix = "vs"
    for vs_type in ["Community", "Professional", "Enterprise"]:
        vs_ref_path = paths.join(
            "C:/Program Files (x86)/Microsoft Visual Studio/2017",
            vs_type,
            "Common7/IDE/ReferenceAssemblies",
        )
        if ctx.path(vs_ref_path).exists:
            ctx.symlink(vs_ref_path, prefix)

    build_file_content = r'''package(default_visibility = [ "//visibility:public" ])
load("@io_bazel_rules_dotnet//dotnet:defs.bzl", "net_import_library")
[net_import_library(
    name = vs_ref_assembly[:-len(".dll")],
    src =  vs_ref_assembly
) for ref_version in ["v2.0", "v4.0", "v4.5"] 
    for vs_ref_assembly in glob(["%s/" + ref_version + "/*.dll"])]    
  ''' % prefix
    ctx.file("BUILD", build_file_content)

vs2017_ref_net = repository_rule(
    implementation = _vs2017_ref_net_impl,
)
