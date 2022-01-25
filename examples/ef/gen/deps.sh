#!/usr/bin/env bash
set -euo pipefail

EXAMPLE_NAME="ef"
OUTPUT_DIR="$(git rev-parse --show-toplevel)/examples/${EXAMPLE_NAME}/gen"

DOTNET_TOOLCHAIN="$(uname -sm | tr 'A-Z ' 'a-z_')_6.0.101"
DOTNET_HOST_TOOLCHAIN="${DOTNET_TOOLCHAIN}"

TOOL="bazel run --host_platform=//dotnet/toolchain:${DOTNET_HOST_TOOLCHAIN} --platforms=//dotnet/toolchain:${DOTNET_TOOLCHAIN} //tools/nuget2bazel:nuget2bazel.exe --"

rm -f "${OUTPUT_DIR}/nuget.json"
cp "${OUTPUT_DIR}/base.bzl" "${OUTPUT_DIR}/nuget.bzl"

${TOOL} add -p "${OUTPUT_DIR}" -b nuget.bzl -c nuget.json -i -l  microsoft.entityframeworkcore 3.1.3

# clean up nuget2bazel packages directory
rm -rf "${OUTPUT_DIR}/packages"

# lint generated dependencies file
buildifier --lint=fix "${OUTPUT_DIR}/nuget.bzl"
