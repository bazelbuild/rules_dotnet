"A transition that transitions between compatible target frameworks"

load("@bazel_skylib//lib:sets.bzl", "sets")
load(
    "//dotnet/private:common.bzl",
    "FRAMEWORK_COMPATIBILITY",
    "TRANSITIVE_FRAMEWORK_COMPATIBILITY",
)

# use pre-computed transition outputs
_transition_outputs = {
    tfm: {
        "@rules_dotnet//dotnet:framework_compatible_%s" % framework: sets.contains(tfm_compatible_set, framework)
        for framework in FRAMEWORK_COMPATIBILITY.keys()
    }
    for (tfm, tfm_compatible_set) in TRANSITIVE_FRAMEWORK_COMPATIBILITY.items()
}

def _impl(settings, _attr):
    tfm = settings["@rules_dotnet//dotnet:target_framework"]

    if tfm not in _transition_outputs:
        fail("Error setting @rules_dotnet//dotnet:target_framework: invalid value '" + tfm + "'. Allowed values are " + str(FRAMEWORK_COMPATIBILITY.keys()))

    return _transition_outputs[tfm]

nuget_transition = transition(
    implementation = _impl,
    inputs = ["@rules_dotnet//dotnet:target_framework"],
    outputs = ["@rules_dotnet//dotnet:framework_compatible_%s" % framework for framework in FRAMEWORK_COMPATIBILITY.keys()],
)
