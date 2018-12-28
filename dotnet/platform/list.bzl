DOTNETIMPL = {
    "mono": None,
    "core": None,
    "net": None,
}

DOTNETOS = {
    "darwin": "@bazel_tools//platforms:osx",
    "linux": "@bazel_tools//platforms:linux",
    "windows": "@bazel_tools//platforms:windows",
}

DOTNETARCH = {
    "amd64": "@bazel_tools//platforms:x86_64",
}

DOTNETIMPL_OS_ARCH = (
    ("mono", "darwin", "amd64"),
    ("mono", "linux", "amd64"),
    ("mono", "windows", "amd64"),
    ("core", "darwin", "amd64"),
    ("core", "linux", "amd64"),
    ("core", "windows", "amd64"),
    ("net", "windows", "amd64"),
    ("net", "linux", "amd64"),
    ("net", "darwin", "amd64"),
)

# struct:
# 0. Version string - as required by TargetFrameworkAttribute
# 1. FacadedBy - for netstandard  contains net framework which supports given version
# 2. Preprocesor directive
# 3. Version number - as used in C:/Program Files (x86)/Reference Assemblies/Microsoft/Framework/.NETFramework/ (without 'v')
DOTNET_NET_FRAMEWORKS = {
    "net45": (".NETFramework,Version=v4.5", None, "NET45", "4.5"),
    "net451": (".NETFramework,Version=v4.5.1", None, "NET451", "4.5.1"),
    "net452": (".NETFramework,Version=v4.5.2", None, "NET452", "4.5.2"),
    "net46": (".NETFramework,Version=v4.6", None, "NET46", "4.6"),
    "net461": (".NETFramework,Version=v4.6.1", None, "NET461", "4.6.1"),
    "net462": (".NETFramework,Version=v4.6.2", None, "NET462", "4.6.2"),
    "net47": (".NETFramework,Version=v4.7", None, "NET47", "4.7"),
    "net471": (".NETFramework,Version=v4.7.1", None, "NET471", "4.7.1"),
    "net472": (".NETFramework,Version=v4.7.2", None, "NET472", "4.7.2"),
    "netstandard1.0": (".NETStandard,Version=v1.0", "net472", "NETSTANDARD1_0", "4.7.2"),
    "netstandard1.1": (".NETStandard,Version=v1.1", "net472", "NETSTANDARD1_1", "4.7.2"),
    "netstandard1.2": (".NETStandard,Version=v1.2", "net472", "NETSTANDARD1_2", "4.7.2"),
    "netstandard1.3": (".NETStandard,Version=v1.3", "net472", "NETSTANDARD1_3", "4.7.2"),
    "netstandard1.4": (".NETStandard,Version=v1.4", "net472", "NETSTANDARD1_4", "4.7.2"),
    "netstandard1.5": (".NETStandard,Version=v1.5", "net472", "NETSTANDARD1_5", "4.7.2"),
    "netstandard1.6": (".NETStandard,Version=v1.6", "net472", "NETSTANDARD1_6", "4.7.2"),
    "netstandard2.0": (".NETStandard,Version=v2.0", "net472", "NETSTANDARD2_0", "4.7.2"),
}

# struct:
# 0. Version string - as required by TargetFrameworkAttribute
# 1. Preporocesor directive
# 2. TFM
DOTNET_CORE_FRAMEWORKS = {
    "v2.1.200": (".NETCore,Version=v2.1", "NETCOREAPP2_1", "netcoreapp2.1"),
    "v2.1.502": (".NETCore,Version=v2.1", "NETCOREAPP2_1", "netcoreapp2.1"),
    "v2.2.101": (".NETCore,Version=v2.2", "NETCOREAPP2_2", "netcoreapp2.2"),
}


def declare_config_settings():
    for impl in DOTNETIMPL:
        native.config_setting(
            name = impl,
            #constraint_values = ["//dotnet/toolchain:" + impl],
            values = {
                "compilation_mode": impl,
            },
        )
    for os in DOTNETOS:
        native.config_setting(
            name = os,
            constraint_values = ["//dotnet/toolchain:" + os],
        )
    for arch in DOTNETARCH:
        native.config_setting(
            name = arch,
            constraint_values = ["//dotnet/toolchain:" + arch],
        )
    for impl, os, arch in DOTNETIMPL_OS_ARCH:
        native.config_setting(
            name = impl + "_" + os + "_" + arch,
            constraint_values = [
                "//dotnet/toolchain:" + os,
                "//dotnet/toolchain:" + arch,
                "//dotnet/toolchain:" + impl,
            ],
        )
