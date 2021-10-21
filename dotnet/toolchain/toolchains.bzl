"Declares toolchains"

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
    "3.1.407": {
        # https://dotnet.microsoft.com/download/dotnet-core/thank-you/sdk-3.1.407-windows-x64-binaries
        "windows_amd64": (
            "https://download.visualstudio.microsoft.com/download/pr/095412cb-5d87-4049-9659-35d917835355/a889375c044572335acef05b19473f60/dotnet-sdk-3.1.407-win-x64.zip",
            "158a8414077544b215bdcf82c7a222cc3b9b6b71800d93f83f8f2c0637cea1e3",
            # SHA512 Checsum provided
            # "8ef2fb0526343a7a57ca982c96332c01fa7da827cee1db401e11b49ca8dacbbbc47c06a2f4333206492bcabde43155b08876c4cdaf9d22aaf3bcf0f6792a6162",
        ),
        # https://dotnet.microsoft.com/download/dotnet-core/thank-you/sdk-3.1.407-linux-x64-binaries
        "linux_amd64": (
            "https://download.visualstudio.microsoft.com/download/pr/ab82011d-2549-4e23-a8a9-a2b522a31f27/6e615d6177e49c3e874d05ee3566e8bf/dotnet-sdk-3.1.407-linux-x64.tar.gz",
            "a744359910206fe657c3a02dfa54092f288a44c63c7c86891e866f0678a7e911",
            # SHA512 Checsum provided
            # "b9c61061464a38df0a3eb5894a4a1229cd27d2ccba4168e434f4609b763630c01fbe1b2564826194d6d9b5ad86047e586312c0f35eafc3755dfe0ff9ba075c0c",
        ),
        # https://dotnet.microsoft.com/download/dotnet-core/thank-you/sdk-3.1.407-macos-x64-binaries
        "darwin_amd64": (
            "https://download.visualstudio.microsoft.com/download/pr/17fa8fae-ad2e-4871-872c-bd393801f191/5a54261a28d5a5b25f5aa5606981e145/dotnet-sdk-3.1.407-osx-x64.tar.gz",
            "58df8b4cac8965b8237faf7ddbc3ff6b1ecea4919fc4c8b955b752a96f9b7ff9",
            # SHA512 Checsum provided
            # "3ff849ee3f9f7f282bdb05df3680be2949604f8a805e53595953f27c02bcb17ae8ab16c2856a29573a5f22fc6e0fc448461e36c031088f33b51d677784e1ffd0",
        ),
    },
    "5.0.201": {
        # https://dotnet.microsoft.com/download/dotnet-core/thank-you/sdk-5.0.201-windows-x64-binaries
        "windows_amd64": (
            "https://download.visualstudio.microsoft.com/download/pr/989b7ad4-bdce-4c40-a323-7e348578867a/cb7c44c6b2a68063be8e991e8fe8a13d/dotnet-sdk-5.0.201-win-x64.zip",
            "c99352545d5c527c0279f05f92a01c376e77319fa73f08355e5bec1d47cda1c1",
            # SHA512 Checsum provided
            # "e7e1a2e27a91226974804c3949d3ee097b7d7a7ff9ccdbfb1afad742eb5c1ea20487f580f8266aa1d1fb9fb90ab0643c2c3a14e30dedf9f3a339768654dd567d",
        ),
        # https://dotnet.microsoft.com/download/dotnet-core/thank-you/sdk-5.0.201-linux-x64-binaries
        "linux_amd64": (
            "https://download.visualstudio.microsoft.com/download/pr/73a9cb2a-1acd-4d20-b864-d12797ca3d40/075dbe1dc3bba4aa85ca420167b861b6/dotnet-sdk-5.0.201-linux-x64.tar.gz",
            "9ff77087831e8ca32719566ec9ef537e136cfc02c5ff565e53f5509cc6e7b341",
            # SHA512 Checsum provided
            # "099084cc7935482e363bd7802d2fdd909b3d72d2e9706e9ba4df95e3d142a28b780d2b85e5fb4662dcaad18e91c7e06519184fae981a521425eed605770c3c5a",
        ),
        # https://dotnet.microsoft.com/download/dotnet-core/thank-you/sdk-5.0.201-macos-x64-binaries
        "darwin_amd64": (
            "https://download.visualstudio.microsoft.com/download/pr/b660bd50-30b1-4a69-ad8d-d83209ea6213/4fb0163b7fff707f204a100c24d82ef6/dotnet-sdk-5.0.201-osx-x64.tar.gz",
            "c7b0452f46892fb00f9a4d335ec95cffdd8d96b375cc5c509c65ce3b07b6bafa",
            # SHA512 Checsum provided
            # "28d1e55e9002e63a354f4b5994e83114229701fe84fee41d083f1de33af751a288cab0605da7d3b0d0c3bbc10979ca0a3dbe13722d29313031e7732ad7f8e6d1",
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

def dotnet_register_toolchains(name = None):
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

# buildifier: disable=function-docstring-args
def declare_constraints(name = None):
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
