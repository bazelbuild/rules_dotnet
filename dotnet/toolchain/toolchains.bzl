load(
    "@io_bazel_rules_dotnet//dotnet/private:dotnet_toolchain.bzl",
    "dotnet_toolchain",
)
load(
    "@io_bazel_rules_dotnet//dotnet/private:core_toolchain.bzl",
    "core_toolchain",
)
load(
    "@io_bazel_rules_dotnet//dotnet/private:net_toolchain.bzl",
    "net_toolchain",
)
load(
    "@io_bazel_rules_dotnet//dotnet/private:net_empty_toolchain.bzl",
    "net_empty_toolchain",
)
load(
    "@io_bazel_rules_dotnet//dotnet/private:sdk.bzl",
    "dotnet_download_sdk",
    "dotnet_host_sdk",
    "dotnet_local_sdk",
)
load(
    "@io_bazel_rules_dotnet//dotnet/private:sdk_core.bzl",
    "core_download_sdk",
)
load(
    "@io_bazel_rules_dotnet//dotnet/private:sdk_net.bzl",
    "net_download_sdk",
)
load(
    "@io_bazel_rules_dotnet//dotnet/platform:list.bzl",
    "DOTNETARCH",
    "DOTNETIMPL",
    "DOTNETIMPL_OS_ARCH",
    "DOTNETOS",
)

DEFAULT_VERSION = "4.2.3"
CORE_DEFAULT_VERSION = "2.1.200"
NET_ROSLYN_DEFAULT_VERSION = "2.8.2"
NET_DEFAULT_VERSION = "4.7.2"

SDK_REPOSITORIES = {
    "4.2.3": {
        "mono_darwin_amd64": (
            "http://bazel-mirror.storage.googleapis.com/download.mono-project.com/archive/4.2.3/macos-10-x86/MonoFramework-MDK-4.2.3.4.macos10.xamarin.x86.tar.gz",
            "a7afb92d4a81f17664a040c8f36147e57a46bb3c33314b73ec737ad73608e08b",
        ),
    },
}

CORE_SDK_REPOSITORIES = {
    "2.1.200": {
        "core_windows_amd64": (
            "https://download.microsoft.com/download/3/7/1/37189942-C91D-46E9-907B-CF2B2DE584C7/dotnet-sdk-2.1.200-win-x64.zip",
            "f3c92c52d88364ac4359716e11e13b67f0e4ea256676b56334a4eb88c728e7fd",
        ),
        "core_linux_amd64": (
            "https://download.microsoft.com/download/3/7/1/37189942-C91D-46E9-907B-CF2B2DE584C7/dotnet-sdk-2.1.200-linux-x64.tar.gz",
            "58977b4b232f5fe97f9825340ce473cf1ec1bad76eb512fe6b5e2210c76c09de",
        ),
        "core_darwin_amd64": (
            "https://download.microsoft.com/download/3/7/1/37189942-C91D-46E9-907B-CF2B2DE584C7/dotnet-sdk-2.1.200-osx-x64.tar.gz",
            "ac695c3319caf043e6b40861906cd4d396ba8922fd206332d2a778635667a2ba",
        ),
    },
}

NET_ROSLYN_REPOSITORIES = {
    "2.8.2": {
        "net_windows_amd64": (
            "https://www.nuget.org/api/v2/package/Microsoft.Net.Compilers/2.8.2/",
            "48d0d13d8667e16ce150fbb7d804d12d9b9bca8bba9003eaccf1f105cbd427f6",
        ),
    },
}

def _generate_toolchains():
    # Use all the above information to generate all the possible toolchains we might support
    toolchains = []
    for impl, os, arch in DOTNETIMPL_OS_ARCH:
        host = "{}_{}_{}".format(impl, os, arch)
        toolchain_name = "dotnet_{}".format(host)
        csc_flags = []
        toolchains.append(dict(
            name = toolchain_name,
            impl = impl,
            host = host,
            csc_flags = csc_flags,
        ))
    return toolchains

_toolchains = _generate_toolchains()

_label_prefix = "@io_bazel_rules_dotnet//dotnet/toolchain:"

def dotnet_register_toolchains(dotnet_version = DEFAULT_VERSION, core_version = CORE_DEFAULT_VERSION, net_version = NET_DEFAULT_VERSION, net_roslyn_version = NET_ROSLYN_DEFAULT_VERSION):
    """See /dotnet/toolchains.rst#dostnet-register-toolchains for full documentation."""
    if "dotnet_download_sdk" not in native.existing_rules() and "dotnet_host_sdk" not in native.existing_rules() and "dotnet_local_sdk" not in native.existing_rules():
        if dotnet_version in SDK_REPOSITORIES:
            dotnet_download_sdk(
                name = "dotnet_sdk",
                sdks = SDK_REPOSITORIES[dotnet_version],
            )
        elif dotnet_version == "host":
            dotnet_host_sdk(
                name = "dotnet_sdk",
            )
        elif dotnet_version != None:
            fail("Unknown dotnet version {}".format(dotnet_version))

    if "core_download_sdk" not in native.existing_rules():
        if core_version in CORE_SDK_REPOSITORIES:
            core_download_sdk(
                name = "core_sdk",
                version = core_version,
                sdks = CORE_SDK_REPOSITORIES[core_version],
            )
        elif core_version != None:
            fail("Unknown core version {}".format(core_version))

    if "net_download_sdk" not in native.existing_rules():
        if net_roslyn_version in NET_ROSLYN_REPOSITORIES:
            net_download_sdk(
                name = "net_sdk",
                version = net_version,
                sdks = NET_ROSLYN_REPOSITORIES[net_roslyn_version],
            )
        elif net_roslyn_version != None:
            fail("Unknown .net Roslyn version {}".format(net_roslyn_version))

    # Use the final dictionaries to register all the toolchains
    for toolchain in _toolchains:
        name = _label_prefix + toolchain["name"]
        native.register_toolchains(name)

def declare_constraints():
    for os, constraint in DOTNETOS.items():
        if constraint:
            native.alias(
                name = os,
                actual = constraint,
            )
        else:
            native.constraint_value(
                name = os,
                constraint_setting = "@bazel_tools//platforms:os",
            )
    for arch, constraint in DOTNETARCH.items():
        if constraint:
            native.alias(
                name = arch,
                actual = constraint,
            )
        else:
            native.constraint_value(
                name = arch,
                constraint_setting = "@bazel_tools//platforms:cpu",
            )
    native.constraint_setting(name = "dotnetimpl")
    for impl, constraint in DOTNETIMPL.items():
        native.constraint_value(
            name = impl,
            constraint_setting = ":dotnetimpl",
        )

    for impl, os, arch in DOTNETIMPL_OS_ARCH:
        native.platform(
            name = impl + "_" + os + "_" + arch,
            constraint_values = [
                ":" + impl,
                ":" + os,
                ":" + arch,
            ],
        )

def declare_toolchains():
    # Use the final dictionaries to create all the toolchains
    for toolchain in _toolchains:
        if toolchain["impl"] == "mono":
            dotnet_toolchain(
                # Required fields
                name = toolchain["name"],
                host = toolchain["host"],
            )
        elif toolchain["impl"] == "core":
            core_toolchain(
                # Required fields
                name = toolchain["name"],
                host = toolchain["host"],
            )
        elif toolchain["impl"] == "net":
            if toolchain["name"] == "dotnet_net_windows_amd64":
                net_toolchain(
                    # Required fields
                    name = toolchain["name"],
                    host = toolchain["host"],
                )
            else:
                # Hardcoded empty rules for .NET on Linux and ocx
                net_empty_toolchain(
                    # Required fields
                    name = toolchain["name"],
                    host = toolchain["host"],
                )
