workspace(name = "io_bazel_rules_dotnet")

load("@bazel_tools//tools/build_defs/repo:http.bzl", "http_archive")
load(
    "//dotnet:defs.bzl",
    "DEFAULT_DOTNET_CORE_FRAMEWORK",
    "DOTNET_CORE_FRAMEWORKS",
    "DOTNET_NET_FRAMEWORKS",
    "core_register_sdk",
    "dotnet_nuget_new",
    "dotnet_register_toolchains",
    "dotnet_repositories",
    "mono_register_sdk",
    "net_gac4",
    "net_register_sdk",
    "nuget_package",
    "vs2017_ref_net",
)

dotnet_repositories()

dotnet_register_toolchains()

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

# local_repository(
#     name = "io_bazel_rules_dotnet_3rd_party",
#     #path = "/home/nest-user/work/gopath/rules_dotnet",
#     path = "c:/rules_dotnet_3rd_party",
# )

# load("@io_bazel_rules_dotnet_3rd_party//:repositories.bzl", "rules_dotnet_3rd_party_dependencies")

# rules_dotnet_3rd_party_dependencies()
