#!/usr/bin/env bash

set -o errexit -o nounset -o pipefail

# Set by GH actions, see
# https://docs.github.com/en/actions/learn-github-actions/environment-variables#default-environment-variables
TAG=${GITHUB_REF_NAME}

# The prefix is chosen to match what GitHub generates for source archives
PREFIX="rules_dotnet-${TAG:1}"
ARCHIVE="rules_dotnet-$TAG.tar.gz"

git archive --format=tar --prefix=${PREFIX}/ ${TAG} | gzip > $ARCHIVE
SHA=$(shasum -a 256 $ARCHIVE | awk '{print $1}')

cat << EOF

## Using WORKSPACE

Paste this snippet into your \`WORKSPACE\` file:

\`\`\`starlark
load("@bazel_tools//tools/build_defs/repo:http.bzl", "http_archive")

http_archive(
    name = "rules_dotnet",
    sha256 = "${SHA}",
    strip_prefix = "${PREFIX}",
    url = "https://github.com/bazelbuild/rules_dotnet/releases/download/${TAG}/rules_dotnet-${TAG}.tar.gz",
)

load(
    "@rules_dotnet//dotnet:repositories.bzl",
    "dotnet_register_toolchains",
    "rules_dotnet_dependencies",
)

rules_dotnet_dependencies()

# Here you can specify the version of the .NET SDK to use.
dotnet_register_toolchains("dotnet", "7.0.101")

load("@rules_dotnet//dotnet:rules_dotnet_nuget_packages.bzl", "rules_dotnet_nuget_packages")

rules_dotnet_nuget_packages()
\`\`\`
EOF
