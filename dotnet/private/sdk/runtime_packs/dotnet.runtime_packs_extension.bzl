"Generated"

load(":dotnet.runtime_packs.bzl", _runtime_packs = "runtime_packs")

def _runtime_packs_impl(_ctx):
    _runtime_packs()

runtime_packs_extension = module_extension(
    implementation = _runtime_packs_impl,
)
