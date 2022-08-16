filegroup(
    name = "bzl_srcs",
    srcs = glob(["**/*.bzl"]),
    visibility = ["//docs:__pkg__"],
)

exports_files([
    "nunit/shim.cs",
    "nunit/shim.fs",
    "runtimeconfig.json.tpl",
    "runtimeconfig_without_loader.json.tpl",
    "deps.json.tpl",
    "launcher.sh.tpl",
    "launcher.bat.tpl",
])

config_setting(
    name = "linux-x64",
    constraint_values = [
        "@platforms//cpu:x86_64",
        "@platforms//os:linux",
    ],
)

config_setting(
    name = "linux-arm64",
    constraint_values = [
        "@platforms//cpu:arm64",
        "@platforms//os:linux",
    ],
)

config_setting(
    name = "macos-x64",
    constraint_values = [
        "@platforms//cpu:x86_64",
        "@platforms//os:macos",
    ],
)

config_setting(
    name = "macos-arm64",
    constraint_values = [
        "@platforms//cpu:aarch64",
        "@platforms//os:macos",
    ],
)

config_setting(
    name = "windows-x64",
    constraint_values = [
        "@platforms//cpu:x86_64",
        "@platforms//os:windows",
    ],
)

config_setting(
    name = "windows-arm64",
    constraint_values = [
        "@platforms//cpu:arm64",
        "@platforms//os:windows",
    ],
)
