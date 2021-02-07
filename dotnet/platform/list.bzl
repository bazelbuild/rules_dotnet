BAZEL_DOTNETOS_CONSTRAINTS = {
    "darwin": "@bazel_tools//platforms:osx",
    "linux": "@bazel_tools//platforms:linux",
    "windows": "@bazel_tools//platforms:windows",
}

BAZEL_DOTNETARCH_CONSTRAINTS = {
    "amd64": "@bazel_tools//platforms:x86_64",
}

DOTNET_OS_ARCH = (
    ("darwin", "amd64"),
    ("linux", "amd64"),
    ("windows", "amd64"),
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
# 3. Runtime version
# 4. If NETStandard.Library present in the SDK
DOTNET_CORE_FRAMEWORKS = {
    "2.1.200": (".NETCore,Version=v2.1", "NETCOREAPP2_1", "netcoreapp2.1", "2.0.7", False),
    "2.1.502": (".NETCore,Version=v2.1", "NETCOREAPP2_1", "netcoreapp2.1", "2.1.6", False),
    "2.1.503": (".NETCore,Version=v2.1", "NETCOREAPP2_1", "netcoreapp2.1", "2.1.7", False),
    "2.2.101": (".NETCore,Version=v2.2", "NETCOREAPP2_2", "netcoreapp2.2", "2.2.0", False),
    "2.2.402": (".NETCore,Version=v2.2", "NETCOREAPP2_2", "netcoreapp2.2", "2.2.7", False),
    "3.0.100": (".NETCore,Version=v3.0", "NETCOREAPP3_0", "netcoreapp3.0", "3.0.0", True),
    "3.1.100": (".NETCore,Version=v3.1", "NETCOREAPP3_1", "netcoreapp3.1", "3.1.0", True),
}
DOTNET_CORE_NAMES = ["netcoreapp2.0", "netcoreapp2.1", "netcoreapp2.2", "netcoreapp3.0", "netcoreapp3.1"] + DOTNET_NETSTANDARD.keys()

DEFAULT_DOTNET_CORE_FRAMEWORK = "v3.1.100"

def _generate_constraints(names, bazel_constraints):
    return {
        name: bazel_constraints.get(name, "@io_bazel_rules_dotnet//dotnet/toolchain:" + name)
        for name in names
    }

DOTNETOS_CONSTRAINTS = _generate_constraints([p[0] for p in DOTNET_OS_ARCH], BAZEL_DOTNETOS_CONSTRAINTS)
DOTNETARCH_CONSTRAINTS = _generate_constraints([p[1] for p in DOTNET_OS_ARCH], BAZEL_DOTNETARCH_CONSTRAINTS)
DOTNETSDK_CONSTRAINTS = _generate_constraints([p for p in DOTNET_CORE_FRAMEWORKS], BAZEL_DOTNETARCH_CONSTRAINTS)

def _generate_platforms():
    platforms = []

    for os, arch in DOTNET_OS_ARCH:
        for sdk in DOTNET_CORE_FRAMEWORKS:
            constraints = [
                DOTNETOS_CONSTRAINTS[os],
                DOTNETARCH_CONSTRAINTS[arch],
                DOTNETSDK_CONSTRAINTS[sdk],
            ]

            platform = struct(
                name = os + "_" + arch + "_" + sdk,
                os = os,
                arch = arch,
                sdk = sdk,
                constraints = constraints,
            )
            platforms.append(platform)

    return platforms

PLATFORMS = _generate_platforms()
