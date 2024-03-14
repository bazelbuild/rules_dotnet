"A transition that transitions between compatible target frameworks"

load("@bazel_skylib//lib:dicts.bzl", "dicts")
load(
    "//dotnet/private:common.bzl",
    "FRAMEWORK_COMPATIBILITY",
    "get_highest_compatible_target_framework",
)
load("//dotnet/private:rids.bzl", "RUNTIME_GRAPH")
load("//dotnet/private/transitions:common.bzl", "FRAMEWORK_COMPATABILITY_TRANSITION_OUTPUTS", "RID_COMPATABILITY_TRANSITION_OUTPUTS")

targeting_pack_tfm_map = {
    # .NET Standard
    "netstandard": Label("//dotnet/private/packs/targeting:netstandard.library.v2.0.3"),
    "netstandard1.0": Label("//dotnet/private/packs/targeting:netstandard.library.v2.0.3"),
    "netstandard1.1": Label("//dotnet/private/packs/targeting:netstandard.library.v2.0.3"),
    "netstandard1.2": Label("//dotnet/private/packs/targeting:netstandard.library.v2.0.3"),
    "netstandard1.3": Label("//dotnet/private/packs/targeting:netstandard.library.v2.0.3"),
    "netstandard1.4": Label("//dotnet/private/packs/targeting:netstandard.library.v2.0.3"),
    "netstandard1.5": Label("//dotnet/private/packs/targeting:netstandard.library.v2.0.3"),
    "netstandard1.6": Label("//dotnet/private/packs/targeting:netstandard.library.v2.0.3"),
    "netstandard2.0": Label("//dotnet/private/packs/targeting:netstandard.library.v2.0.3"),
    "netstandard2.1": Label("//dotnet/private/packs/targeting:netstandard.library.ref.v2.1.0"),

    # .NET Framework
    "net11": Label("//dotnet/private/packs/targeting:microsoft.netframework.referenceassemblies.v1.0.3"),
    "net20": Label("//dotnet/private/packs/targeting:microsoft.netframework.referenceassemblies.v1.0.3"),
    "net30": Label("//dotnet/private/packs/targeting:microsoft.netframework.referenceassemblies.v1.0.3"),
    "net35": Label("//dotnet/private/packs/targeting:microsoft.netframework.referenceassemblies.v1.0.3"),
    "net40": Label("//dotnet/private/packs/targeting:microsoft.netframework.referenceassemblies.v1.0.3"),
    "net403": Label("//dotnet/private/packs/targeting:microsoft.netframework.referenceassemblies.v1.0.3"),
    "net45": Label("//dotnet/private/packs/targeting:microsoft.netframework.referenceassemblies.v1.0.3"),
    "net451": Label("//dotnet/private/packs/targeting:microsoft.netframework.referenceassemblies.v1.0.3"),
    "net452": Label("//dotnet/private/packs/targeting:microsoft.netframework.referenceassemblies.v1.0.3"),
    "net46": Label("//dotnet/private/packs/targeting:microsoft.netframework.referenceassemblies.v1.0.3"),
    "net461": Label("//dotnet/private/packs/targeting:microsoft.netframework.referenceassemblies.v1.0.3"),
    "net462": Label("//dotnet/private/packs/targeting:microsoft.netframework.referenceassemblies.v1.0.3"),
    "net47": Label("//dotnet/private/packs/targeting:microsoft.netframework.referenceassemblies.v1.0.3"),
    "net471": Label("//dotnet/private/packs/targeting:microsoft.netframework.referenceassemblies.v1.0.3"),
    "net472": Label("//dotnet/private/packs/targeting:microsoft.netframework.referenceassemblies.v1.0.3"),
    "net48": Label("//dotnet/private/packs/targeting:microsoft.netframework.referenceassemblies.v1.0.3"),

    # .NET Core
    "netcoreapp1.0": Label("//dotnet/private/packs/targeting:netstandard.library.v2.0.3"),
    "netcoreapp1.1": Label("//dotnet/private/packs/targeting:netstandard.library.v2.0.3"),
    "netcoreapp2.0": Label("//dotnet/private/packs/targeting:netstandard.library.v2.0.3"),
    "netcoreapp2.1": Label("//dotnet/private/packs/targeting:netstandard.library.v2.0.3"),
    "netcoreapp2.2": Label("//dotnet/private/packs/targeting:netstandard.library.v2.0.3"),
    "netcoreapp3.0": Label("//dotnet/private/packs/targeting:microsoft.netcore.app.ref.v3.0.1"),
    "netcoreapp3.1": Label("//dotnet/private/packs/targeting:microsoft.netcore.app.ref.v3.1.0"),
    "net5.0": Label("//dotnet/private/packs/targeting:microsoft.netcore.app.ref.v5.0.0"),
    "net6.0": Label("//dotnet/private/packs/targeting:microsoft.netcore.app.ref.v6.0.25"),
    "net7.0": Label("//dotnet/private/packs/targeting:microsoft.netcore.app.ref.v7.0.14"),
    "net8.0": Label("//dotnet/private/packs/targeting:microsoft.netcore.app.ref.v8.0.0"),
}

def _get_targeting_pack_label(target_framework, max_runtime_version):
    pack = targeting_pack_tfm_map[target_framework]

    if pack:
        return pack
    else:
        return "//dotnet/private/packs/targeting:empty_pack"

def _impl(settings, attr):
    max_runtime_version = settings["@dotnet_toolchains//:sdk_runtime_version"]
    incoming_target_framework = settings["//dotnet:target_framework"]

    return {"//dotnet/private/packs/targeting:targeting_pack": _get_targeting_pack_label(incoming_target_framework, max_runtime_version)}

targeting_pack_transition = transition(
    implementation = _impl,
    inputs = ["@dotnet_toolchains//:sdk_runtime_version", "//dotnet/private/packs/targeting:targeting_pack", "//dotnet:target_framework"],
    outputs = ["//dotnet/private/packs/targeting:targeting_pack"],
)
