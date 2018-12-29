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
    "DOTNET_NET_FRAMEWORKS",
    "DOTNET_CORE_FRAMEWORKS",
)

DEFAULT_VERSION = "4.2.3"
CORE_DEFAULT_VERSION = "v2.1.502"
NET_ROSLYN_DEFAULT_VERSION = "2.10.0"
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
    "v2.1.200": {
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
    "v2.1.502": {
        "core_windows_amd64": (
            "https://download.visualstudio.microsoft.com/download/pr/c88b53e5-121c-4bc9-af5d-47a9d154ea64/e62eff84357c48dc8052a9c6ce5dfb8a/dotnet-sdk-2.1.502-win-x64.zip",
            "2da94993092ebb27ffa4dcfe9e94c1acaafb34f9570ecfbc74291dcec9a8b213",
        ),
        "core_linux_amd64": (
            "https://download.visualstudio.microsoft.com/download/pr/4c8893df-3b05-48a5-b760-20f2db692c45/ff0545dbbb3c52f6fa38657ad97d65d8/dotnet-sdk-2.1.502-linux-x64.tar.gz",
            "f8bcee4cdc52e6b907f1a94102ec43977e84c62b7a54be6040e906a7b6ee4453",
        ),
        "core_darwin_amd64": (
            "https://download.visualstudio.microsoft.com/download/pr/50729ca4-03ce-4e19-af87-bfae014b0431/1c830d9dcffa7663702e32fab6953425/dotnet-sdk-2.1.502-osx-x64.tar.gz",
            "47fbc7cd65aacfd9e1002057ba29f1a567bd6c9923b1ff7aa5dcb4e48c85de95",
        ),
    },
    "v2.2.101": {
        "core_windows_amd64": (
            "https://download.visualstudio.microsoft.com/download/pr/25d4104d-1776-41cb-b96e-dff9e9bf1542/b878c013de90f0e6c91f6f3c98a2d592/dotnet-sdk-2.2.101-win-x64.zip",
            "fe13ce1eac2ebbc73fb069506d4951c57178935952a30ede029bf849279b4079",
        ),
        "core_linux_amd64": (
            "https://download.visualstudio.microsoft.com/download/pr/80e1d007-d6f0-402f-b047-779464dd989b/9ae5e2df9aa166b720bdb92d19977044/dotnet-sdk-2.2.101-linux-x64.tar.gz",
            "2b14129d8e0fa01ba027145022e0580796604f091a52fcb86d23c0fa1fa438e9",
        ),
        "core_darwin_amd64": (
            "https://download.visualstudio.microsoft.com/download/pr/55c65d12-5f99-45d3-aa14-35359a6d02ca/3f6bcd694e3bfbb84e6b99e65279bd1e/dotnet-sdk-2.2.101-osx-x64.tar.gz",
            "fc695c2c797da757251ce643d408e99e6325563bf08d46f1bf8d45a8ebc1aac6",
        ),
    },
}

NET_ROSLYN_REPOSITORIES = {
    "2.6.0": {
        "net_windows_amd64": (
            "https://www.nuget.org/api/v2/package/Microsoft.Net.Compilers/2.6.0/",
            "4ec0a588dc7b538e3f05fb9637931941320defef8e8fde1a79392de9c2a5a276",
        ),
    },
    "2.6.1": {
        "net_windows_amd64": (
            "https://www.nuget.org/api/v2/package/Microsoft.Net.Compilers/2.6.1/",
            "49eaa49477f7409f15f6d4c92ea0176c94100fa063ed20ca6f5eb0ee16655848",
        ),
    },
    "2.7.0": {
        "net_windows_amd64": (
            "https://www.nuget.org/api/v2/package/Microsoft.Net.Compilers/2.7.0/",
            "e6ab3b41c4a30f3c98d4fd318a780d4051c4f35b2bb575b1ea11f621275f1597",
        ),
    },
    "2.8.0": {
        "net_windows_amd64": (
            "https://www.nuget.org/api/v2/package/Microsoft.Net.Compilers/2.8.0/",
            "cd0a53049e5c6f7f4d96f30c54c25321c547a2d36b588a820bbdeef0c6ff05b5",
        ),
    },
    "2.8.2": {
        "net_windows_amd64": (
            "https://www.nuget.org/api/v2/package/Microsoft.Net.Compilers/2.8.2/",
            "48d0d13d8667e16ce150fbb7d804d12d9b9bca8bba9003eaccf1f105cbd427f6",
        ),
    },
    "2.9.0": {
        "net_windows_amd64": (
            "https://www.nuget.org/api/v2/package/Microsoft.Net.Compilers/2.9.0/",
            "9af42dbb5d198f7e885671bf85ecca3e958d8a22a21dbd6e328b694d390562ce",
        ),
    },
    "2.10.0": {
        "net_windows_amd64": (
            "https://www.nuget.org/api/v2/package/Microsoft.Net.Compilers/2.10.0/",
            "854d162cbe3c90100922c970ba593631f2d106f7b757a99425d50dc5cdafbdc0",
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
                name = toolchain["name"],
                host = toolchain["host"],
            )
        elif toolchain["impl"] == "core":
            core_toolchain(
                name = toolchain["name"],
                host = toolchain["host"],
            )
        elif toolchain["impl"] == "net":
            if toolchain["name"] == "dotnet_net_windows_amd64":
                net_toolchain(
                    name = toolchain["name"],
                    host = toolchain["host"],
                )
            else:
                # Hardcoded empty rules for .NET on Linux and ocx
                net_empty_toolchain(
                    name = toolchain["name"],
                    host = toolchain["host"],
                )

def net_register_toolchains(net_version, net_roslyn_version = NET_ROSLYN_DEFAULT_VERSION, tools_version = "net472"):
    if net_roslyn_version not in NET_ROSLYN_REPOSITORIES:
        fail("Unknown .net Roslyn version {}".format(net_roslyn_version))

    net_download_sdk(
        name = "net_sdk_" + net_version,
        version = DOTNET_NET_FRAMEWORKS[net_version][3],
        toolsVersion = DOTNET_NET_FRAMEWORKS[tools_version][3],
        targetFrameworkString = DOTNET_NET_FRAMEWORKS[net_version][0],
        sdks = NET_ROSLYN_REPOSITORIES[net_roslyn_version],
    )

def core_register_toolchains(core_version):
    if core_version not in CORE_SDK_REPOSITORIES:
        fail("Unknown core version {}".format(core_version))

    core_download_sdk(
        name = "core_sdk_{}".format(core_version),
        version = core_version[1:],
        targetFrameworkString = DOTNET_CORE_FRAMEWORKS[core_version][0],
        sdks = CORE_SDK_REPOSITORIES[core_version],
    )
