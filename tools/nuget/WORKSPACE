load("@bazel_tools//tools/build_defs/repo:git.bzl", "git_repository")

git_repository(
     name = "io_bazel_rules_dotnet",
     remote = "https://github.com/tomdegoede/rules_dotnet",
     commit = "48155ef3fa8a2bff3d55852010afce3305daffc5"
)

sdk_version = "v3.1.100"

# git_repository(
#      name = "io_bazel_rules_dotnet",
#      remote = "https://github.com/bazelbuild/rules_dotnet",
#      tag = "0.0.4",
# )

# sdk_version = "v3.0.100"

load("@io_bazel_rules_dotnet//dotnet:defs.bzl", "core_register_sdk", "dotnet_repositories", "dotnet_register_toolchains", "nuget_package")

# Disabled because of naming collissions with newtonsoft.json
# dotnet_repositories()

dotnet_register_toolchains(core_version = sdk_version)

# core_register_sdk("v2.2.402", name = "core_sdk")
core_register_sdk(sdk_version, name = "core_sdk")

load(":deps.bzl", "deps")
deps()
