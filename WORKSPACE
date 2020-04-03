workspace(name = "io_bazel_rules_dotnet")

load("@io_bazel_rules_dotnet//dotnet:deps.bzl", "dotnet_repositories")

dotnet_repositories()

load(
    "@io_bazel_rules_dotnet//dotnet:defs.bzl",
    "DEFAULT_DOTNET_CORE_FRAMEWORK",
    "DOTNET_CORE_FRAMEWORKS",
    "DOTNET_NET_FRAMEWORKS",
    "core_register_sdk",
    "dotnet_register_toolchains",
    "dotnet_repositories_nugets",
    "mono_register_sdk",
    "net_gac4",
    "net_register_sdk",
)

dotnet_register_toolchains()

dotnet_repositories_nugets()

mono_register_sdk()

[net_register_sdk(
    framework,
) for framework in DOTNET_NET_FRAMEWORKS]

[core_register_sdk(
    framework,
) for framework in DOTNET_CORE_FRAMEWORKS]

# Default core_sdk
core_register_sdk(
    DEFAULT_DOTNET_CORE_FRAMEWORK,
    name = "core_sdk",
)

# Default net_sdk
net_register_sdk(
    "net471",
    name = "net_sdk",
)

net_gac4(
    name = "System.ComponentModel.DataAnnotations",
    token = "31bf3856ad364e35",
    version = "4.0.0.0",
)

# The rule is left as an example. It is commented out, because our CI server doesn't have VS2017 installed
# vs2017_ref_net(name = "vs2017_ref")

load("@io_bazel_rules_dotnet//tests:bazel_tests.bzl", "test_environment")

test_environment()
