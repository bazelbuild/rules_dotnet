DOTNETIMPL = [
    "core",
]

DOTNETOS = {
    "darwin": "@bazel_tools//platforms:osx",
    "linux": "@bazel_tools//platforms:linux",
    "windows": "@bazel_tools//platforms:windows",
}

DOTNETARCH = {
    "amd64": "@bazel_tools//platforms:x86_64",
}

DOTNETIMPL_OS_ARCH = (
    ("core", "darwin", "amd64"),
    ("core", "linux", "amd64"),
    ("core", "windows", "amd64"),
)

DOTNET_NETSTANDARD = {
    "netstandard1.0": (".NETStandard,Version=v1.0", "NETSTANDARD1_0"),
    "netstandard1.1": (".NETStandard,Version=v1.1", "NETSTANDARD1_1"),
    "netstandard1.2": (".NETStandard,Version=v1.2", "NETSTANDARD1_2"),
    "netstandard1.3": (".NETStandard,Version=v1.3", "NETSTANDARD1_3"),
    "netstandard1.4": (".NETStandard,Version=v1.4", "NETSTANDARD1_4"),
    "netstandard1.5": (".NETStandard,Version=v1.5", "NETSTANDARD1_5"),
    "netstandard1.6": (".NETStandard,Version=v1.6", "NETSTANDARD1_6"),
    "netstandard2.0": (".NETStandard,Version=v2.0", "NETSTANDARD2_0"),
    "netstandard2.1": (".NETStandard,Version=v2.1", "NETSTANDARD2_1"),
    "netstandard2.2": (".NETStandard,Version=v2.2", "NETSTANDARD2_2"),
}

# struct:
# 0. Version string - as required by TargetFrameworkAttribute and use for the download
# 1. Preporocesor directive
# 2. TFM
# 3. Runtime folder version
DOTNET_CORE_FRAMEWORKS = {
    "v2.1.200": (".NETCore,Version=v2.1", "NETCOREAPP2_1", "netcoreapp2.1", "2.0.7"),
    "v2.1.502": (".NETCore,Version=v2.1", "NETCOREAPP2_1", "netcoreapp2.1", "2.1.6"),
    "v2.1.503": (".NETCore,Version=v2.1", "NETCOREAPP2_1", "netcoreapp2.1", "2.1.7"),
    "v2.2.101": (".NETCore,Version=v2.2", "NETCOREAPP2_2", "netcoreapp2.2", "2.2.0"),
    "v2.2.402": (".NETCore,Version=v2.2", "NETCOREAPP2_2", "netcoreapp2.2", "2.2.7"),
    "v3.0.100": (".NETCore,Version=v3.0", "NETCOREAPP3_0", "netcoreapp3.0", "3.0.0"),
    "v3.1.100": (".NETCore,Version=v3.1", "NETCOREAPP3_1", "netcoreapp3.1", "3.1.0"),
}
DOTNET_CORE_NAMES = ["netcoreapp2.0", "netcoreapp2.1", "netcoreapp2.2", "netcoreapp3.0", "netcoreapp3.1"] + DOTNET_NETSTANDARD.keys()

DEFAULT_DOTNET_CORE_FRAMEWORK = "v3.1.100"
