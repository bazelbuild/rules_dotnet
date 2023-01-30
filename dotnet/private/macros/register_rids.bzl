"Register TFM flags and set up the compatibility chains"

load("@bazel_skylib//rules:common_settings.bzl", "bool_setting", "string_flag")
load(
    "//dotnet/private:rids.bzl",
    "RUNTIME_GRAPH",
)

# buildifier: disable=unnamed-macro
def register_rids():
    "Register RID flags. The `base` flag will allow us to choose the default RID via a transition that tansitions on OS/ARCH"
    string_flag(
        name = "rid",
        values = RUNTIME_GRAPH.keys(),
        build_setting_default = "base",
        visibility = ["//visibility:public"],
    )

    for rid in RUNTIME_GRAPH.keys():
        bool_setting(
            name = "rid_compatible_%s" % rid,
            build_setting_default = False,
            visibility = ["//visibility:public"],
        )

        flags = {":rid_compatible_%s" % f: repr(True) for f in RUNTIME_GRAPH[rid] + [rid]}

        native.config_setting(
            name = "rid_%s" % rid,
            flag_values = flags,
            visibility = ["//visibility:public"],
        )
