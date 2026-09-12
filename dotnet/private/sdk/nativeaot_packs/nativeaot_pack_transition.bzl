"A transition that selects the NativeAOT runtime pack for the target framework"

load("//dotnet/private:common.bzl", "get_highest_compatible_runtime_identifier")
load("//dotnet/private/sdk:packs.bzl", "NATIVEAOT_PACK_LOOKUP_TABLE")

_SETTING = "//dotnet/private/sdk/nativeaot_packs:nativeaot_pack"

def _impl(settings, _attr):
    supported_rids = NATIVEAOT_PACK_LOOKUP_TABLE.get(settings["//dotnet:target_framework"])

    if supported_rids:
        rid = get_highest_compatible_runtime_identifier(settings["//dotnet:rid"], supported_rids.keys())
        pack = supported_rids.get(rid)

        if pack:
            return {_SETTING: pack}

    # Every publish carries this attribute but only a NativeAOT one reads it,
    # so a missing pack is reported at the point of use.
    return {_SETTING: settings[_SETTING]}

nativeaot_pack_transition = transition(
    implementation = _impl,
    inputs = [_SETTING, "//dotnet:target_framework", "//dotnet:rid"],
    outputs = [_SETTING],
)
