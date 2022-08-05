"Common functinality for transitions"

load("@bazel_skylib//lib:sets.bzl", "sets")
load(
    "//dotnet/private:common.bzl",
    "FRAMEWORK_COMPATIBILITY",
    "TRANSITIVE_FRAMEWORK_COMPATIBILITY",
)

FRAMEWORK_COMPATABILITY_TRANSITION_OUTPUTS = {
    tfm: {
        "@rules_dotnet//dotnet:framework_compatible_%s" % framework: sets.contains(tfm_compatible_set, framework)
        for framework in FRAMEWORK_COMPATIBILITY.keys()
    }
    for (tfm, tfm_compatible_set) in TRANSITIVE_FRAMEWORK_COMPATIBILITY.items()
}
