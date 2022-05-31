load("@bazel_skylib//lib:sets.bzl", "sets")
load("@bazel_skylib//rules:common_settings.bzl", "bool_setting")
load(
    "//dotnet/private:providers.bzl",
    "FRAMEWORK_COMPATIBILITY",
)

def register_tfms():
    transitive = {}

    for (framework, compat) in FRAMEWORK_COMPATIBILITY.items():
        # the transitive closure of compatible frameworks
        transitive[framework] = sets.union(sets.make([framework]), *[transitive[c] for c in compat])
        

    for (framework, compat) in FRAMEWORK_COMPATIBILITY.items():
        bool_setting(
            name = "framework_compatible_%s" % framework,
            # temporarily just enable a set of flags here
            build_setting_default = sets.contains(transitive["net5.0"], framework),
            visibility = ["//visibility:public"]
        )

        # when activating a certain target framework there should be a transation
        # that enables pricesly all compatible framework versions. This allows us to 
        # create config_settings for each tfm that a nuget package provides Where the 
        # best match is correctly picked because it has the largest set of compatible frameworks.

        # e.g. a setting with {"net6.0": "True", "net5.0": "True", ...} takes precedence over {"net5.0": "True", ...}
        flags = { ":framework_compatible_%s" % f: repr(True) for f in sets.to_list(transitive[framework]) }
        
        native.config_setting(
            name = "tfm_%s" % framework,
            flag_values = flags,
        )

        # we could find two compatible tfms that form an antichain when 
        # there exists a newer version of netstandard than is supported 
        # by the highest net(core). 
