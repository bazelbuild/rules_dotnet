"Common functinality for transitions"

load("@bazel_skylib//lib:sets.bzl", "sets")
load(
    "//dotnet/private:common.bzl",
    "FRAMEWORK_COMPATIBILITY",
    "TRANSITIVE_FRAMEWORK_COMPATIBILITY",
)
load("//dotnet/private:rids.bzl", "RUNTIME_GRAPH")

FRAMEWORK_COMPATABILITY_TRANSITION_OUTPUTS = {
    tfm: {
        "//dotnet:framework_compatible_%s" % framework: sets.contains(tfm_compatible_set, framework)
        for framework in FRAMEWORK_COMPATIBILITY.keys()
    }
    for (tfm, tfm_compatible_set) in TRANSITIVE_FRAMEWORK_COMPATIBILITY.items()
}

RID_COMPATABILITY_TRANSITION_OUTPUTS = {
    rid: {
        "//dotnet:rid_compatible_%s" % identifier: (identifier in compatible_rids) or (identifier == rid)
        for identifier in RUNTIME_GRAPH.keys()
    }
    for (rid, compatible_rids) in RUNTIME_GRAPH.items()
}
