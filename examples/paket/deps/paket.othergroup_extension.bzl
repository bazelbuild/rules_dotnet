"Generated"

load(":paket.othergroup.bzl", _othergroup = "othergroup")

def _othergroup_impl(_ctx):
    _othergroup()

othergroup_extension = module_extension(
    implementation = _othergroup_impl,
)
