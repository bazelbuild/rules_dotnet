load("@io_bazel_rules_dotnet//dotnet/private:core_toolchain.bzl", "core_toolchain")
load(
    "@io_bazel_rules_dotnet//dotnet/platform:list.bzl",
    "BAZEL_DOTNETARCH_CONSTRAINTS",
    "BAZEL_DOTNETOS_CONSTRAINTS",
    "DOTNETSDK_CONSTRAINTS",
    "DOTNET_CORE_FRAMEWORKS",
    "DOTNET_OS_ARCH",
    "PLATFORMS",
)

CORE_DEFAULT_VERSION = "v3.1.100"

CORE_SDK_REPOSITORIES = {
    "2.1.200": {
        "windows_amd64": (
            "https://download.microsoft.com/download/3/7/1/37189942-C91D-46E9-907B-CF2B2DE584C7/dotnet-sdk-2.1.200-win-x64.zip",
            "f3c92c52d88364ac4359716e11e13b67f0e4ea256676b56334a4eb88c728e7fd",
        ),
        "linux_amd64": (
            "https://download.microsoft.com/download/3/7/1/37189942-C91D-46E9-907B-CF2B2DE584C7/dotnet-sdk-2.1.200-linux-x64.tar.gz",
            "58977b4b232f5fe97f9825340ce473cf1ec1bad76eb512fe6b5e2210c76c09de",
        ),
        "darwin_amd64": (
            "https://download.microsoft.com/download/3/7/1/37189942-C91D-46E9-907B-CF2B2DE584C7/dotnet-sdk-2.1.200-osx-x64.tar.gz",
            "ac695c3319caf043e6b40861906cd4d396ba8922fd206332d2a778635667a2ba",
        ),
    },
    "2.1.502": {
        "windows_amd64": (
            "https://download.visualstudio.microsoft.com/download/pr/c88b53e5-121c-4bc9-af5d-47a9d154ea64/e62eff84357c48dc8052a9c6ce5dfb8a/dotnet-sdk-2.1.502-win-x64.zip",
            "2da94993092ebb27ffa4dcfe9e94c1acaafb34f9570ecfbc74291dcec9a8b213",
        ),
        "linux_amd64": (
            "https://download.visualstudio.microsoft.com/download/pr/4c8893df-3b05-48a5-b760-20f2db692c45/ff0545dbbb3c52f6fa38657ad97d65d8/dotnet-sdk-2.1.502-linux-x64.tar.gz",
            "f8bcee4cdc52e6b907f1a94102ec43977e84c62b7a54be6040e906a7b6ee4453",
        ),
        "darwin_amd64": (
            "https://download.visualstudio.microsoft.com/download/pr/50729ca4-03ce-4e19-af87-bfae014b0431/1c830d9dcffa7663702e32fab6953425/dotnet-sdk-2.1.502-osx-x64.tar.gz",
            "47fbc7cd65aacfd9e1002057ba29f1a567bd6c9923b1ff7aa5dcb4e48c85de95",
        ),
    },
    "2.1.503": {
        "windows_amd64": (
            "https://download.visualstudio.microsoft.com/download/pr/81e18dc2-7747-4b2d-9912-3be0f83050f1/5bc41cb27df3da63378df2d051be4b7f/dotnet-sdk-2.1.503-win-x64.zip",
            "d81c6fdf758cbb0f433dad32fa2087e5ba09f55590a0e85832a1da414ed8180d",
        ),
        "linux_amd64": (
            "https://download.visualstudio.microsoft.com/download/pr/04d83723-8370-4b54-b8b9-55708822fcde/63aab1f4d0be5246e3a92e1eb3063935/dotnet-sdk-2.1.503-linux-x64.tar.gz",
            "242c812b516de12baffd804a1aed5a6c7341ef6f1e9597a0df0f2eb1e0ddf5c7",
        ),
        "darwin_amd64": (
            "https://download.visualstudio.microsoft.com/download/pr/c922688d-74e8-4af5-bcc8-5850eafbca7f/cf3b9a0b06c0dfa3a5098f893a9730bd/dotnet-sdk-2.1.503-osx-x64.tar.gz",
            "5fb7bf37843645fab6e0c7397a15630c11aaa917c951035c0aaec5e2a8e93fe5",
        ),
    },
    "2.2.101": {
        "windows_amd64": (
            "https://download.visualstudio.microsoft.com/download/pr/25d4104d-1776-41cb-b96e-dff9e9bf1542/b878c013de90f0e6c91f6f3c98a2d592/dotnet-sdk-2.2.101-win-x64.zip",
            "fe13ce1eac2ebbc73fb069506d4951c57178935952a30ede029bf849279b4079",
        ),
        "linux_amd64": (
            "https://download.visualstudio.microsoft.com/download/pr/80e1d007-d6f0-402f-b047-779464dd989b/9ae5e2df9aa166b720bdb92d19977044/dotnet-sdk-2.2.101-linux-x64.tar.gz",
            "2b14129d8e0fa01ba027145022e0580796604f091a52fcb86d23c0fa1fa438e9",
        ),
        "darwin_amd64": (
            "https://download.visualstudio.microsoft.com/download/pr/55c65d12-5f99-45d3-aa14-35359a6d02ca/3f6bcd694e3bfbb84e6b99e65279bd1e/dotnet-sdk-2.2.101-osx-x64.tar.gz",
            "fc695c2c797da757251ce643d408e99e6325563bf08d46f1bf8d45a8ebc1aac6",
        ),
    },
    "2.2.402": {
        "windows_amd64": (
            "https://download.visualstudio.microsoft.com/download/pr/8ac3e8b7-9918-4e0c-b1be-5aa3e6afd00f/0be99c6ab9362b3c47050cdd50cba846/dotnet-sdk-2.2.402-win-x64.zip",
            "ffdd3d49efea67329cdad9262916bc0263831e79a89af0ee21bf2602a3a5c3b6",
        ),
        "linux_amd64": (
            "https://download.visualstudio.microsoft.com/download/pr/46411df1-f625-45c8-b5e7-08ab736d3daa/0fbc446088b471b0a483f42eb3cbf7a2/dotnet-sdk-2.2.402-linux-x64.tar.gz",
            "4dafe1e6e49c6ddeb658bd702ed7724c4eb393ed719e2d6f557536f17917579a",
        ),
        "darwin_amd64": (
            "https://download.visualstudio.microsoft.com/download/pr/2079de3a-714b-4fa5-840f-70e898b393ef/d631b5018560873ac350d692290881db/dotnet-sdk-2.2.402-osx-x64.tar.gz",
            "adb0aa3a809e097882f9a139af8a7fa9d8c7898ad5249f6cec376f843433c79f",
        ),
    },
    "3.0.100": {
        "windows_amd64": (
            "https://download.visualstudio.microsoft.com/download/pr/a24f4f34-ada1-433a-a437-5bc85fc2576a/7e886d06729949c15c96fe7e70faa8ae/dotnet-sdk-3.0.100-win-x64.zip",
            "faf8a92a523558e1659a6f9750c86610fe8430430f58099ccc659b83e3eee1bf",
        ),
        "linux_amd64": (
            "https://download.visualstudio.microsoft.com/download/pr/886b4a4c-30af-454b-8bec-81c72b7b4e1f/d1a0c8de9abb36d8535363ede4a15de6/dotnet-sdk-3.0.100-linux-x64.tar.gz",
            "12098fe29d5c857fd6093b1fd63eda9f91b92798e3748fcedc0e0727f1ac01c2",
        ),
        "darwin_amd64": (
            "https://download.visualstudio.microsoft.com/download/pr/b9251194-4118-41cb-ae05-6763fb002e5d/1d398b4e97069fa4968628080b617587/dotnet-sdk-3.0.100-osx-x64.tar.gz",
            "f0f8af049e0ecbeea9c9c37c16679d6fc2cd4c165510b00e3fad3cd8d0fe0160",
        ),
    },
    "3.1.100": {
        # https://dotnet.microsoft.com/download/dotnet-core/thank-you/sdk-3.1.100-windows-x64-binaries
        "windows_amd64": (
            "https://download.visualstudio.microsoft.com/download/pr/28a2c4ff-6154-473b-bd51-c62c76171551/ea47eab2219f323596c039b3b679c3d6/dotnet-sdk-3.1.100-win-x64.zip",
            "abcd034b230365d9454459e271e118a851969d82516b1529ee0bfea07f7aae52",
            # SHA512 Checsum provided
            # "94ee575d6104058cdd31370fc686b5d1aa23bf4a54611843c1f93afc82cad3523217b5f2eaddd4b5c136bca252d2c9047092f7054052c8683fa0f363ca28ad11",
        ),
        # https://dotnet.microsoft.com/download/dotnet-core/thank-you/sdk-3.1.100-linux-x64-binaries
        "linux_amd64": (
            "https://download.visualstudio.microsoft.com/download/pr/d731f991-8e68-4c7c-8ea0-fad5605b077a/49497b5420eecbd905158d86d738af64/dotnet-sdk-3.1.100-linux-x64.tar.gz",
            "3687b2a150cd5fef6d60a4693b4166994f32499c507cd04f346b6dda38ecdc46",
            # SHA512 Checsum provided
            # "5217ae1441089a71103694be8dd5bb3437680f00e263ad28317665d819a92338a27466e7d7a2b1f6b74367dd314128db345fa8fff6e90d0c966dea7a9a43bd21",
        ),
        # https://dotnet.microsoft.com/download/dotnet-core/thank-you/sdk-3.1.100-macos-x64-binaries
        "darwin_amd64": (
            "https://download.visualstudio.microsoft.com/download/pr/bea99127-a762-4f9e-aac8-542ad8aa9a94/afb5af074b879303b19c6069e9e8d75f/dotnet-sdk-3.1.100-osx-x64.tar.gz",
            "b38e6f8935d4b82b283d85c6b83cd24b5253730bab97e0e5e6f4c43e2b741aab",
            # SHA512 Checsum provided
            # "142922cfb98b0cae6b194c3da2478fdf70f2a67603d248bbf859938bd05c4a4a5facea05d49b0db8b382d8cf73f9a45246a2022c9cf0ccf1501b1138cd0b3e76",
        ),
    },
}

def _generate_toolchains():
    # Use all the above information to generate all the possible toolchains we might support
    toolchains = []
    for lang in ["csharp", "fsharp"]:
        for os_exec, arch_exec in DOTNET_OS_ARCH:
            for os, arch in DOTNET_OS_ARCH:
                for sdk in DOTNET_CORE_FRAMEWORKS:
                    constraints_target = [BAZEL_DOTNETARCH_CONSTRAINTS[arch], BAZEL_DOTNETOS_CONSTRAINTS[os], DOTNETSDK_CONSTRAINTS[sdk]]
                    constraints_exec = [BAZEL_DOTNETARCH_CONSTRAINTS[arch_exec], BAZEL_DOTNETOS_CONSTRAINTS[os_exec]]

                    host = os + "_" + arch + "_" + sdk + "_" + os_exec + "_" + arch_exec
                    toolchain_name = host + "_" + lang + "_toolchain"
                    toolchains.append(dict(
                        name = toolchain_name,
                        lang = lang,
                        os = os,
                        arch = arch,
                        sdk_version = sdk,
                        runtime_version = DOTNET_CORE_FRAMEWORKS.get(sdk)[3],
                        os_exec = os_exec,
                        arch_exec = arch_exec,
                        constraints_target = constraints_target,
                        constraints_exec = constraints_exec,
                    ))
    return toolchains

_toolchains = _generate_toolchains()

_label_prefix = "@io_bazel_rules_dotnet//dotnet/toolchain:"

def dotnet_register_toolchains():
    """The macro registers all toolchains."""

    # Use the final dictionaries to register all the toolchains
    labels = [
        _label_prefix + name.get("name")
        for name in _toolchains
    ]

    native.register_toolchains(*labels)

def declare_toolchains():
    # Use the final dictionaries to create all the toolchains
    for toolchain in _toolchains:
        core_toolchain(
            name = toolchain["name"],
            lang = toolchain["lang"],
            arch = toolchain["arch"],
            os = toolchain["os"],
            sdk_version = toolchain["sdk_version"],
            runtime_version = toolchain["runtime_version"],
            arch_exec = toolchain["arch_exec"],
            os_exec = toolchain["os_exec"],
            constraints_target = toolchain["constraints_target"],
            constraints_exec = toolchain["constraints_exec"],
        )

def declare_constraints():
    """Generates constraint_values and platform targets for valid platforms.
    """

    native.constraint_setting(
        name = "sdk",
    )

    for p in DOTNET_CORE_FRAMEWORKS:
        native.config_setting(
            name = p + "_config",
            constraint_values = [p],
        )
        native.constraint_value(
            name = p,
            constraint_setting = "@io_bazel_rules_dotnet//dotnet/toolchain:sdk",
        )

    for p in PLATFORMS:
        native.config_setting(
            name = p.name + "_config",
            constraint_values = p.constraints,
        )
        native.platform(
            name = p.name,
            constraint_values = p.constraints,
        )
