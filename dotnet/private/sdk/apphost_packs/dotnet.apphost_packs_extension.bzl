"Generated"

load(":dotnet.apphost_packs.bzl", _apphost_packs = "apphost_packs")

def _apphost_packs_impl(_ctx):
    _apphost_packs()

apphost_packs_extension = module_extension(
    implementation = _apphost_packs_impl,
)
