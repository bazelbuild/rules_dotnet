workspace(name = "rules_dotnet")

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

dotnet_register_toolchains("dotnet", "6.0.300")

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

############################################
# Gazelle, for generating bzl_library targets
load("@io_bazel_rules_go//go:deps.bzl", "go_register_toolchains", "go_rules_dependencies")
load("@bazel_gazelle//:deps.bzl", "gazelle_dependencies")

go_rules_dependencies()

go_register_toolchains(version = "1.17.2")

gazelle_dependencies()
