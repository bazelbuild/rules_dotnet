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
    "dotnet_host_sdk",
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
    "DOTNETOS",
    "DOTNETIMPL",
    "DOTNET_NET_FRAMEWORKS",
    "DOTNET_CORE_FRAMEWORKS",
    "DEFAULT_DOTNET_CORE_FRAMEWORK",
    "DEFAULT_DOTNET_NET_FRAMEWORK",
)

DEFAULT_VERSION = "4.2.3"
CORE_DEFAULT_VERSION = "v3.1.100"
NET_ROSLYN_DEFAULT_VERSION = "2.10.0"
NET_DEFAULT_VERSION = "net48"
NET_DEFAULT_TOOLS_VERSION = "net48"

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
    "v2.1.503": {
        "core_windows_amd64": (
            "https://download.visualstudio.microsoft.com/download/pr/81e18dc2-7747-4b2d-9912-3be0f83050f1/5bc41cb27df3da63378df2d051be4b7f/dotnet-sdk-2.1.503-win-x64.zip",
            "d81c6fdf758cbb0f433dad32fa2087e5ba09f55590a0e85832a1da414ed8180d",
        ),
        "core_linux_amd64": (
            "https://download.visualstudio.microsoft.com/download/pr/04d83723-8370-4b54-b8b9-55708822fcde/63aab1f4d0be5246e3a92e1eb3063935/dotnet-sdk-2.1.503-linux-x64.tar.gz",
            "242c812b516de12baffd804a1aed5a6c7341ef6f1e9597a0df0f2eb1e0ddf5c7",
        ),
        "core_darwin_amd64": (
            "https://download.visualstudio.microsoft.com/download/pr/c922688d-74e8-4af5-bcc8-5850eafbca7f/cf3b9a0b06c0dfa3a5098f893a9730bd/dotnet-sdk-2.1.503-osx-x64.tar.gz",
            "5fb7bf37843645fab6e0c7397a15630c11aaa917c951035c0aaec5e2a8e93fe5",
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
    "v2.2.402": {
        "core_windows_amd64": (
            "https://download.visualstudio.microsoft.com/download/pr/8ac3e8b7-9918-4e0c-b1be-5aa3e6afd00f/0be99c6ab9362b3c47050cdd50cba846/dotnet-sdk-2.2.402-win-x64.zip",
            "ffdd3d49efea67329cdad9262916bc0263831e79a89af0ee21bf2602a3a5c3b6",
        ),
        "core_linux_amd64": (
            "https://download.visualstudio.microsoft.com/download/pr/46411df1-f625-45c8-b5e7-08ab736d3daa/0fbc446088b471b0a483f42eb3cbf7a2/dotnet-sdk-2.2.402-linux-x64.tar.gz",
            "4dafe1e6e49c6ddeb658bd702ed7724c4eb393ed719e2d6f557536f17917579a",
        ),
        "core_darwin_amd64": (
            "https://download.visualstudio.microsoft.com/download/pr/2079de3a-714b-4fa5-840f-70e898b393ef/d631b5018560873ac350d692290881db/dotnet-sdk-2.2.402-osx-x64.tar.gz",
            "adb0aa3a809e097882f9a139af8a7fa9d8c7898ad5249f6cec376f843433c79f",
        ),
    },
    "v3.0.100": {
        "core_windows_amd64": (
            "https://download.visualstudio.microsoft.com/download/pr/a24f4f34-ada1-433a-a437-5bc85fc2576a/7e886d06729949c15c96fe7e70faa8ae/dotnet-sdk-3.0.100-win-x64.zip",
            "faf8a92a523558e1659a6f9750c86610fe8430430f58099ccc659b83e3eee1bf",
        ),
        "core_linux_amd64": (
            "https://download.visualstudio.microsoft.com/download/pr/886b4a4c-30af-454b-8bec-81c72b7b4e1f/d1a0c8de9abb36d8535363ede4a15de6/dotnet-sdk-3.0.100-linux-x64.tar.gz",
            "12098fe29d5c857fd6093b1fd63eda9f91b92798e3748fcedc0e0727f1ac01c2",
        ),
        "core_darwin_amd64": (
            "https://download.visualstudio.microsoft.com/download/pr/b9251194-4118-41cb-ae05-6763fb002e5d/1d398b4e97069fa4968628080b617587/dotnet-sdk-3.0.100-osx-x64.tar.gz",
            "f0f8af049e0ecbeea9c9c37c16679d6fc2cd4c165510b00e3fad3cd8d0fe0160",
        ),
    },
    "v3.1.100": {
        # https://dotnet.microsoft.com/download/dotnet-core/thank-you/sdk-3.1.100-windows-x64-binaries
        "core_windows_amd64": (
            "https://download.visualstudio.microsoft.com/download/pr/28a2c4ff-6154-473b-bd51-c62c76171551/ea47eab2219f323596c039b3b679c3d6/dotnet-sdk-3.1.100-win-x64.zip",
            "abcd034b230365d9454459e271e118a851969d82516b1529ee0bfea07f7aae52",
            # SHA512 Checsum provided
            # "94ee575d6104058cdd31370fc686b5d1aa23bf4a54611843c1f93afc82cad3523217b5f2eaddd4b5c136bca252d2c9047092f7054052c8683fa0f363ca28ad11",
        ),
        # https://dotnet.microsoft.com/download/dotnet-core/thank-you/sdk-3.1.100-linux-x64-binaries
        "core_linux_amd64": (
            "https://download.visualstudio.microsoft.com/download/pr/d731f991-8e68-4c7c-8ea0-fad5605b077a/49497b5420eecbd905158d86d738af64/dotnet-sdk-3.1.100-linux-x64.tar.gz",
            "3687b2a150cd5fef6d60a4693b4166994f32499c507cd04f346b6dda38ecdc46",
            # SHA512 Checsum provided
            # "5217ae1441089a71103694be8dd5bb3437680f00e263ad28317665d819a92338a27466e7d7a2b1f6b74367dd314128db345fa8fff6e90d0c966dea7a9a43bd21",
        ),
        # https://dotnet.microsoft.com/download/dotnet-core/thank-you/sdk-3.1.100-macos-x64-binaries
        "core_darwin_amd64": (
            "https://download.visualstudio.microsoft.com/download/pr/bea99127-a762-4f9e-aac8-542ad8aa9a94/afb5af074b879303b19c6069e9e8d75f/dotnet-sdk-3.1.100-osx-x64.tar.gz",
            "b38e6f8935d4b82b283d85c6b83cd24b5253730bab97e0e5e6f4c43e2b741aab",
            # SHA512 Checsum provided
            # "142922cfb98b0cae6b194c3da2478fdf70f2a67603d248bbf859938bd05c4a4a5facea05d49b0db8b382d8cf73f9a45246a2022c9cf0ccf1501b1138cd0b3e76",
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
            "2e38aa455b5a1acce260a8ea30696804e6fa66aa366a04118f0cb4c8d7d08cf9",
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
            "ec357a48b5ce3a2890c744967f4057a6c2c953fdd407bd57c003c9d300fe015f",
        ),
    },
    "2.8.2": {
        "net_windows_amd64": (
            "https://www.nuget.org/api/v2/package/Microsoft.Net.Compilers/2.8.2/",
            "96684975e6934859e3a9f42536d2ffeb63f8e5761eb38838d0604d4cc31e0b47",
        ),
    },
    "2.9.0": {
        "net_windows_amd64": (
            "https://www.nuget.org/api/v2/package/Microsoft.Net.Compilers/2.9.0/",
            "63a6828a1a4ada4b813f48784b1797b4b270a8c0559fcafc64666efb3de84bfd",
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
    for arch in DOTNETARCH:
        for os in DOTNETOS:
            for impl in DOTNETIMPL:
                constraints = [DOTNETARCH[arch], DOTNETOS[os]]

                host = "{}_{}_{}".format(impl, os, arch)
                toolchain_name = "dotnet_{}".format(host)
                toolchains.append(dict(
                    name = toolchain_name,
                    impl = impl,
                    os = os,
                    arch = arch,
                    constraints = constraints,
                ))
    return toolchains


_toolchains = _generate_toolchains()

_label_prefix = "@io_bazel_rules_dotnet//dotnet/toolchain:"

def dotnet_register_toolchains(dotnet_version = DEFAULT_VERSION, core_version = CORE_DEFAULT_VERSION, net_version = NET_DEFAULT_VERSION, net_roslyn_version = NET_ROSLYN_DEFAULT_VERSION):
    """See /dotnet/toolchains.rst#dostnet-register-toolchains for full documentation."""

    # Use the final dictionaries to register all the toolchains
    for toolchain in _toolchains:
        name = _label_prefix + toolchain["name"]
        native.register_toolchains(name)
    

def declare_toolchains():
    # Use the final dictionaries to create all the toolchains
    for toolchain in _toolchains:
        if toolchain["impl"] == "mono":
            dotnet_toolchain(
                name = toolchain["name"],
                arch = toolchain["arch"],
                os = toolchain["os"],
                constraints = toolchain["constraints"],
            )
        elif toolchain["impl"] == "core":
            core_toolchain(
                name = toolchain["name"],
                arch = toolchain["arch"],
                os = toolchain["os"],
                constraints = toolchain["constraints"],
            )
        elif toolchain["impl"] == "net":
            if toolchain["os"] == "windows" and toolchain["arch"]=="amd64":
                net_toolchain(
                    name = toolchain["name"],
                    arch = toolchain["arch"],
                    os = toolchain["os"],
                    constraints = toolchain["constraints"],
                )
            else:
                # Hardcoded empty rules for .NET on Linux and ocx
                net_empty_toolchain(
                    name = toolchain["name"],
                    arch = toolchain["arch"],
                    os = toolchain["os"],
                    constraints = toolchain["constraints"],
                )

def net_register_sdk(net_version = NET_DEFAULT_VERSION, net_roslyn_version = NET_ROSLYN_DEFAULT_VERSION, tools_version = NET_DEFAULT_TOOLS_VERSION, name = "net_sdk"):
    if net_roslyn_version not in NET_ROSLYN_REPOSITORIES:
        fail("Unknown .net Roslyn version {}".format(net_roslyn_version))

    net_download_sdk(
        name = name if name else "net_sdk_" + net_version,
        version = DOTNET_NET_FRAMEWORKS[net_version][3],
        toolsVersion = DOTNET_NET_FRAMEWORKS[tools_version][3],
        sdks = NET_ROSLYN_REPOSITORIES[net_roslyn_version],
    )

def core_register_sdk(core_version = CORE_DEFAULT_VERSION, name = "core_sdk"):
    if core_version not in CORE_SDK_REPOSITORIES:
        fail("Unknown core version {}".format(core_version))

    core_download_sdk(
        name = name if name else "core_sdk_{}".format(core_version),
        version = core_version[1:],
        sdks = CORE_SDK_REPOSITORIES[core_version],
    )

def mono_register_sdk():
    """See /dotnet/toolchains.rst#dostnet-register-toolchains for full documentation."""
    dotnet_host_sdk(
        name = "dotnet_sdk",
    )
