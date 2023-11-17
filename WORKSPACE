workspace(name = "rules_dotnet")

load("@bazel_tools//tools/build_defs/repo:http.bzl", "http_archive")
load(":internal_deps.bzl", "rules_dotnet_internal_deps")

# Fetch deps needed only locally for development
rules_dotnet_internal_deps()

# Fetch dependencies needed by end-users
load(
    "//dotnet:repositories.bzl",
    "dotnet_register_toolchains",
    "rules_dotnet_dependencies",
)

rules_dotnet_dependencies()

dotnet_register_toolchains("dotnet", "8.0.100")

# Fetch NuGet packages needed by end-users
load("//dotnet:paket.rules_dotnet_nuget_packages.bzl", "rules_dotnet_nuget_packages")

rules_dotnet_nuget_packages()

load("//dotnet:paket.paket2bazel_dependencies.bzl", "paket2bazel_dependencies")

paket2bazel_dependencies()

# Fetch NuGet packages needed for our tests
load("//dotnet:paket.rules_dotnet_dev_nuget_packages.bzl", "rules_dotnet_dev_nuget_packages")

rules_dotnet_dev_nuget_packages()

# For running our own unit tests
load("@bazel_skylib//:workspace.bzl", "bazel_skylib_workspace")

bazel_skylib_workspace()

load("@rules_pkg//:deps.bzl", "rules_pkg_dependencies")

rules_pkg_dependencies()

load("@bazel_gazelle//:deps.bzl", "gazelle_dependencies")

############################################
# Gazelle, for generating bzl_library targets
load("@io_bazel_rules_go//go:deps.bzl", "go_register_toolchains", "go_rules_dependencies")

go_rules_dependencies()

go_register_toolchains(version = "1.20.5")

gazelle_dependencies()

# Used for Bazel CI
http_archive(
    name = "bazelci_rules",
    sha256 = "eca21884e6f66a88c358e580fd67a6b148d30ab57b1680f62a96c00f9bc6a07e",
    strip_prefix = "bazelci_rules-1.0.0",
    url = "https://github.com/bazelbuild/continuous-integration/releases/download/rules-1.0.0/bazelci_rules-1.0.0.tar.gz",
)

load("@bazelci_rules//:rbe_repo.bzl", "rbe_preconfig")

# Creates a default toolchain config for RBE.
# Use this as is if you are using the rbe_ubuntu16_04 container,
# otherwise refer to RBE docs.
rbe_preconfig(
    name = "buildkite_config",
    toolchain = "ubuntu1804-bazel-java11",
)
