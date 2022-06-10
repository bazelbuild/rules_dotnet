load("@bazel_skylib//lib:sets.bzl", "sets")
load("@bazel_skylib//rules:common_settings.bzl", "string_flag", "bool_setting")
load(
    "//dotnet/private:providers.bzl",
    "FRAMEWORK_COMPATIBILITY",
)

def _collect_transitive():
    t = {}
    for (framework, compat) in FRAMEWORK_COMPATIBILITY.items():
        # the transitive closure of compatible frameworks
        t[framework] = sets.union(sets.make([framework]), *[t[c] for c in compat])
    return t

TRANSITIVE_FRAMEWORK_COMPATIBILITY = _collect_transitive()

# use pre-computed transition outputs
_transition_outputs = { 
    tfm: { 
        "@rules_dotnet//dotnet:framework_compatible_%s" % framework: sets.contains(tfm_compatible_set, framework) for framework in FRAMEWORK_COMPATIBILITY.keys() 
    } for (tfm, tfm_compatible_set) in TRANSITIVE_FRAMEWORK_COMPATIBILITY.items() 
}

def _impl(settings, attr):
    _ignore = attr
    tfm = settings["@rules_dotnet//dotnet:target_framework"]

    if tfm not in _transition_outputs:
        fail("Error setting @rules_dotnet//dotnet:target_framework: invalid value '" + tfm + "'. Allowed values are " + str(FRAMEWORK_COMPATIBILITY.keys()))

    return _transition_outputs[tfm]

nuget_framework_transition = transition(
    implementation = _impl,
    inputs = ["@rules_dotnet//dotnet:target_framework"],
    outputs = ["@rules_dotnet//dotnet:framework_compatible_%s" % framework for framework in FRAMEWORK_COMPATIBILITY.keys()],
)

def register_tfms():
    string_flag(
        name = "target_framework",
        values = FRAMEWORK_COMPATIBILITY.keys(),
        build_setting_default = "net6.0",
        visibility = ["//visibility:public"]
    )

    for framework in FRAMEWORK_COMPATIBILITY.keys():
        bool_setting(
            name = "framework_compatible_%s" % framework,
            build_setting_default = False,
            visibility = ["//visibility:public"]
        )

        # when activating a certain target framework there should be a transation
        # that enables pricesly all compatible framework versions. This allows us to 
        # create config_settings for each tfm that a nuget package provides Where the 
        # best match is correctly picked because it has the largest set of compatible frameworks.

        # e.g. a setting with {"net6.0": "True", "net5.0": "True", ...} takes precedence over {"net5.0": "True", ...}
        flags = { ":framework_compatible_%s" % f: repr(True) for f in sets.to_list(TRANSITIVE_FRAMEWORK_COMPATIBILITY[framework]) }

        native.config_setting(
            name = "tfm_%s" % framework,
            flag_values = flags,
        )
