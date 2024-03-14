"Generated"

load(":dotnet.packs.bzl", _packs = "packs")

def _packs_impl(_ctx):
    _packs()

packs_extension = module_extension(
    implementation = _packs_impl,
)
