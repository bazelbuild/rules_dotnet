"A transition that transitions between compatible target frameworks"

load("@bazel_skylib//lib:sets.bzl", "sets")
load("@bazel_skylib//lib:dicts.bzl", "dicts")
load(
    "//dotnet/private:common.bzl",
    "FRAMEWORK_COMPATIBILITY",
    "TRANSITIVE_FRAMEWORK_COMPATIBILITY",
    "get_highest_compatible_target_framework",
)

# use pre-computed transition outputs
_transition_outputs = {
    tfm: {
        "@rules_dotnet//dotnet:framework_compatible_%s" % framework: sets.contains(tfm_compatible_set, framework)
        for framework in FRAMEWORK_COMPATIBILITY.keys()
    }
    for (tfm, tfm_compatible_set) in TRANSITIVE_FRAMEWORK_COMPATIBILITY.items()
}

def _impl(settings, attr):
    incoming_tfm = settings["@rules_dotnet//dotnet:target_framework"]

    if incoming_tfm not in _transition_outputs:
        fail("Error setting @rules_dotnet//dotnet:target_framework: invalid value '" + incoming_tfm + "'. Allowed values are " + str(FRAMEWORK_COMPATIBILITY.keys()))

    target_frameworks = []
    if hasattr(attr, "target_framework"):
        target_frameworks.append(attr.target_framework)
    if hasattr(attr, "target_frameworks"):
        target_frameworks += attr.target_frameworks

    transitioned_tfm = get_highest_compatible_target_framework(incoming_tfm, target_frameworks)

    if transitioned_tfm == None:
        fail("Label {0} does not support the target framework: {1}".format(attr.name, incoming_tfm))

    return dicts.add({"@rules_dotnet//dotnet:target_framework": transitioned_tfm}, _transition_outputs[incoming_tfm])

tfm_transition = transition(
    implementation = _impl,
    inputs = ["@rules_dotnet//dotnet:target_framework"],
    outputs = ["@rules_dotnet//dotnet:target_framework"] + ["@rules_dotnet//dotnet:framework_compatible_%s" % framework for framework in FRAMEWORK_COMPATIBILITY.keys()],
)
