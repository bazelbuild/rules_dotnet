workspace(name = "rules_dotnet")

load(":internal_deps.bzl", "rules_dotnet_internal_deps")
load("@bazel_tools//tools/build_defs/repo:http.bzl", "http_archive")

# gazelle:repo bazel_gazelle

# Fetch deps needed only locally for development
rules_dotnet_internal_deps()

# Fetch dependencies needed by end-users
load(
    "//dotnet:repositories.bzl",
    "dotnet_register_toolchains",
    "rules_dotnet_dependencies",
    "rules_dotnet_gazelle_dependencies",
)

rules_dotnet_dependencies()

dotnet_register_toolchains("dotnet", "7.0.101")

rules_dotnet_gazelle_dependencies()

# Gazelle, for generating bzl_library targets, go targets and test the dotnet gazelle plugin
load("@io_bazel_rules_go//go:deps.bzl", "go_register_toolchains", "go_rules_dependencies")
load("@bazel_gazelle//:deps.bzl", "gazelle_dependencies")
load("//:go_deps.bzl", "go_deps")

# gazelle:repository_macro go_deps.bzl%go_deps
go_deps()

go_rules_dependencies()

go_register_toolchains(version = "1.20.4")

gazelle_dependencies()

load("//dotnet:gazelle_setup.bzl", "rules_dotnet_gazelle_setup")

# gazelle:repo bazel_gazelle
rules_dotnet_gazelle_setup()

# Fetch NuGet packages needed by end-users
load("//dotnet:rules_dotnet_nuget_packages.bzl", "rules_dotnet_nuget_packages")

rules_dotnet_nuget_packages()

load("//dotnet:paket2bazel_dependencies.bzl", "paket2bazel_dependencies")

paket2bazel_dependencies()

# Fetch NuGet packages needed for our tests
load("//dotnet:rules_dotnet_dev_nuget_packages.bzl", "rules_dotnet_dev_nuget_packages")

rules_dotnet_dev_nuget_packages()

# For running our own unit tests
load("@bazel_skylib//:workspace.bzl", "bazel_skylib_workspace")

bazel_skylib_workspace()

load("@rules_pkg//:deps.bzl", "rules_pkg_dependencies")

rules_pkg_dependencies()

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
