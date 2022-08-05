"A transition that transitions between compatible target frameworks"

load(
    "//dotnet/private:common.bzl",
    "FRAMEWORK_COMPATIBILITY",
)
load("//dotnet/private:transitions/common.bzl", "FRAMEWORK_COMPATABILITY_TRANSITION_OUTPUTS")

def _impl(settings, _attr):
    tfm = settings["@rules_dotnet//dotnet:target_framework"]

    if tfm not in FRAMEWORK_COMPATABILITY_TRANSITION_OUTPUTS:
        fail("Error setting @rules_dotnet//dotnet:target_framework: invalid value '" + tfm + "'. Allowed values are " + str(FRAMEWORK_COMPATIBILITY.keys()))

    return FRAMEWORK_COMPATABILITY_TRANSITION_OUTPUTS[tfm]

nuget_transition = transition(
    implementation = _impl,
    inputs = ["@rules_dotnet//dotnet:target_framework"],
    outputs = ["@rules_dotnet//dotnet:framework_compatible_%s" % framework for framework in FRAMEWORK_COMPATIBILITY.keys()],
)
