workspace(name = "rules_dotnet")

# skylib begin
load("@bazel_tools//tools/build_defs/repo:http.bzl", "http_archive")
load(":internal_deps.bzl", "rules_dotnet_internal_deps")

# Fetch deps needed only locally for development
rules_dotnet_internal_deps()

http_archive(
    name = "bazel_skylib",
    sha256 = "c6966ec828da198c5d9adbaa94c05e3a1c7f21bd012a0b29ba8ddbccb2c93b0d",
    urls = [
        "https://mirror.bazel.build/github.com/bazelbuild/bazel-skylib/releases/download/1.1.1/bazel-skylib-1.1.1.tar.gz",
        "https://github.com/bazelbuild/bazel-skylib/releases/download/1.1.1/bazel-skylib-1.1.1.tar.gz",
    ],
)

load("@bazel_skylib//:workspace.bzl", "bazel_skylib_workspace")

bazel_skylib_workspace()

http_archive(
    name = "aspect_bazel_lib",
    sha256 = "e00a57d37a8d8b629951e43d1af9b079429b6ea9710752f08910f13afdb825f0",
    strip_prefix = "bazel-lib-1.10.1",
    url = "https://github.com/aspect-build/bazel-lib/archive/refs/tags/v1.10.1.tar.gz",
)

load("@aspect_bazel_lib//lib:repositories.bzl", "aspect_bazel_lib_dependencies")

aspect_bazel_lib_dependencies()

# skylib end

load(
    "//dotnet:repositories.bzl",
    "dotnet_register_toolchains",
    "rules_dotnet_dependencies",
)

rules_dotnet_dependencies()

dotnet_register_toolchains("dotnet", "6.0.300")

load("//tests:dependencies.bzl", "test_dependencies")

test_dependencies()
