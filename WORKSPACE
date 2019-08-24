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

[http_archive(
    name = "{}_xunit_abstractions".format(framework),
    build_file = "@io_bazel_rules_dotnet//3rd_party:abstractions.xunit/repo_{}.bzl".format(framework),
    sha256 = "302dfe0b87993528b2e0c227b4aca4bec82ed136163d7b4b3f75f24f9d43f6fa",
    strip_prefix = "abstractions.xunit-2.0.1",
    urls = ["https://github.com/xunit/abstractions.xunit/archive/2.0.1.tar.gz"],
) for framework in DOTNET_CORE_FRAMEWORKS]

[http_archive(
    name = "{}_xunit_assert".format(framework),
    build_file = "@io_bazel_rules_dotnet//3rd_party:assert.xunit/repo_{}.bzl".format(framework),
    sha256 = "82e662c9a30b9468640d4e1b0db3fca58c22d5ac6f9b7ab8cc16ba1e35515d1c",
    strip_prefix = "assert.xunit-2.4.1",
    urls = ["https://github.com/xunit/assert.xunit/archive/2.4.1.tar.gz"],
) for framework in DOTNET_CORE_FRAMEWORKS]

[http_archive(
    name = "{}_testfx".format(framework),
    build_file = "@io_bazel_rules_dotnet//3rd_party:testfx/repo_{}.bzl".format(framework),
    strip_prefix = "testfx-1.4.0",
    urls = ["https://github.com/Microsoft/testfx/archive/1.4.0.tar.gz"],
) for framework in DOTNET_CORE_FRAMEWORKS]

[http_archive(
    name = "{}_xunit".format(framework),
    build_file = "//3rd_party:xunit/repo_{}.bzl".format(framework),
    sha256 = "01a73e2fd8675fb2237ba067f2f3f12baf6d388216145fcb8374d6085f056f71",
    strip_prefix = "xunit-2.4.1",
    urls = ["https://github.com/xunit/xunit/archive/2.4.1.tar.gz"],
) for framework in DOTNET_CORE_FRAMEWORKS]

http_archive(
    name = "xunit",
    build_file = "//3rd_party:xunit/repo_{}.bzl".format(DEFAULT_DOTNET_CORE_FRAMEWORK),
    sha256 = "01a73e2fd8675fb2237ba067f2f3f12baf6d388216145fcb8374d6085f056f71",
    strip_prefix = "xunit-2.4.1",
    urls = ["https://github.com/xunit/xunit/archive/2.4.1.tar.gz"],
)

http_archive(
    name = "xunit_assert",
    build_file = "@io_bazel_rules_dotnet//3rd_party:assert.xunit/repo_{}.bzl".format(DEFAULT_DOTNET_CORE_FRAMEWORK),
    sha256 = "82e662c9a30b9468640d4e1b0db3fca58c22d5ac6f9b7ab8cc16ba1e35515d1c",
    strip_prefix = "assert.xunit-2.4.1",
    urls = ["https://github.com/xunit/assert.xunit/archive/2.4.1.tar.gz"],
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
