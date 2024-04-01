"A transition that transitions between compatible target frameworks"

load("//dotnet/private:providers.bzl", "DotnetBinaryInfo")
load(":apphost_pack_lookup_table.bzl", "apphost_pack_lookup_table")

def _impl(settings, attr):
    project_sdk = attr.project_sdk
    incoming_target_framework = settings["//dotnet:target_framework"]
    incoming_rid = settings["//dotnet:rid"]

    supported_tfms = apphost_pack_lookup_table.get(project_sdk)
    if supported_tfms:
        supported_rids = supported_tfms.get(incoming_target_framework)
        if supported_rids:
            apphost_pack = supported_rids.get(incoming_rid)
            if apphost_pack:
                return {"//dotnet/private/sdk/apphost_packs:apphost_pack": apphost_pack}

    fail("No apphost pack found for project SDK/target framework: {}/{}".format(project_sdk, incoming_target_framework))

apphost_pack_transition = transition(
    implementation = _impl,
    inputs = ["//dotnet/private/sdk/apphost_packs:apphost_pack", "//dotnet:target_framework", "//dotnet:rid"],
    outputs = ["//dotnet/private/sdk/apphost_packs:apphost_pack"],
)
