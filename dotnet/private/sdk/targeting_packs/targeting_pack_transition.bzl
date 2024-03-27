"A transition that transitions between compatible target frameworks"

load(":targeting_pack_lookup_table.bzl", "targeting_pack_lookup_table")

def _impl(settings, attr):
    project_sdk = attr.project_sdk
    incoming_target_framework = settings["//dotnet:target_framework"]

    supported_tfms = targeting_pack_lookup_table.get(project_sdk)
    if supported_tfms:
        targeting_pack = supported_tfms.get(incoming_target_framework)
        if targeting_pack:
            return {"//dotnet/private/packs/targeting:empty_pack": targeting_pack}

    fail("No targeting pack found for project SDK/target framework: {}/{}".format(project_sdk, incoming_target_framework))

targeting_pack_transition = transition(
    implementation = _impl,
    inputs = ["//dotnet/private/sdk/targeting_packs:targeting_pack", "//dotnet:target_framework"],
    outputs = ["//dotnet/private/packs/targeting:targeting_pack"],
)
