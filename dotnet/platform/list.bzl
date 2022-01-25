"Rules constants"

load("//dotnet/private:valid_platform.bzl", "valid_platform")

BAZEL_DOTNETOS_CONSTRAINTS = {
    "darwin": "@platforms//os:osx",
    "linux": "@platforms//os:linux",
    "windows": "@platforms//os:windows",
}

BAZEL_DOTNETARCH_CONSTRAINTS = {
    "amd64": "@platforms//cpu:x86_64",
    "arm64": "@platforms//cpu:arm64",
}

DOTNET_OS_ARCH = (
    ("darwin", "amd64"),
    ("darwin", "arm64"),
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
    "3.1.100": (".NETCore,Version=v3.1", "NETCOREAPP3_1", "netcoreapp3.1", "3.1.0", True),
    "3.1.407": (".NETCore,Version=v3.1", "NETCOREAPP3_1", "netcoreapp3.1", "3.1.13", True),
    "5.0.201": (".NETCore,Version=v5.0", "NETCOREAPP5_0", "net5.0", "5.0.4", True),
    "5.0.404": (".NETCore,Version=v5.0", "NETCOREAPP5_0", "net5.0", "5.0.13", True),
    "6.0.101": (".NETCore,Version=v6.0", "NETCOREAPP6_0", "net6.0", "6.0.1", True),
}

DOTNET_CORE_NAMES = [
    "netcoreapp2.0",
    "netcoreapp2.1",
    "netcoreapp2.2",
    "netcoreapp3.0",
    "netcoreapp3.1",
    "net5.0",
    "net6.0",
] + DOTNET_NETSTANDARD.keys()

DEFAULT_DOTNET_CORE_FRAMEWORK = "v6.0.101"

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
            if not valid_platform(os, arch, sdk):
                continue

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
