"Generated"

load(":dotnet.targeting_packs.bzl", _targeting_packs = "targeting_packs")

def _targeting_packs_impl(_ctx):
    _targeting_packs()

targeting_packs_extension = module_extension(
    implementation = _targeting_packs_impl,
)
