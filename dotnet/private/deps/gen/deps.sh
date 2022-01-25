#!/usr/bin/env bash
set -euo pipefail

DOTNET_TOOLCHAIN="$(uname -sm | tr 'A-Z ' 'a-z_')_6.0.101"
DOTNET_HOST_TOOLCHAIN="${DOTNET_TOOLCHAIN}"
TOOL="bazel run --host_platform=//dotnet/toolchain:${DOTNET_HOST_TOOLCHAIN} --platforms=//dotnet/toolchain:${DOTNET_TOOLCHAIN} //tools/nuget2bazel:nuget2bazel.exe --"
OUTPUT_DIR="$(git rev-parse --show-toplevel)/dotnet/private/deps/gen"

rm -f "${OUTPUT_DIR}/nuget.json"
cp "${OUTPUT_DIR}/base.bzl" "${OUTPUT_DIR}/nuget.bzl"

${TOOL} add -p "${OUTPUT_DIR}" -b nuget.bzl -c nuget.json -i -l  NETStandard.Library 2.0.3

${TOOL} add -p "${OUTPUT_DIR}" -b nuget.bzl -c nuget.json -i nunit 3.12.0
${TOOL} add -p "${OUTPUT_DIR}" -b nuget.bzl -c nuget.json -i -m nunit3-console.exe nunit.consolerunner 3.11.1

${TOOL} add -p "${OUTPUT_DIR}" -b nuget.bzl -c nuget.json -i Microsoft.Extensions.FileSystemGlobbing 3.1.3
${TOOL} add -p "${OUTPUT_DIR}" -b nuget.bzl -c nuget.json -i Microsoft.Extensions.DependencyModel 3.1.3

${TOOL} add -p "${OUTPUT_DIR}" -b nuget.bzl -c nuget.json -i -m xunit.console xunit.runner.console 2.4.1
${TOOL} add -p "${OUTPUT_DIR}" -b nuget.bzl -c nuget.json -i xunit.assert 2.4.1
${TOOL} add -p "${OUTPUT_DIR}" -b nuget.bzl -c nuget.json -i xunit 2.4.1

${TOOL} add -p "${OUTPUT_DIR}" -b nuget.bzl -c nuget.json -i -l NuGet.PackageManagement 5.11.0
${TOOL} add -p "${OUTPUT_DIR}" -b nuget.bzl -c nuget.json -i -l NuGet.Packaging.Core 5.11.0
${TOOL} add -p "${OUTPUT_DIR}" -b nuget.bzl -c nuget.json -i -l CommandLineParser 2.6.0
${TOOL} add -p "${OUTPUT_DIR}" -b nuget.bzl -c nuget.json -i -l System.Reflection.MetadataLoadContext 4.7.1
${TOOL} add -p "${OUTPUT_DIR}" -b nuget.bzl -c nuget.json -i -l System.Security.Cryptography.Pkcs 5.0.1
${TOOL} add -p "${OUTPUT_DIR}" -b nuget.bzl -c nuget.json -i -l SharpZipLib 1.2.0

# clean up nuget2bazel packages directory
rm -rf "${OUTPUT_DIR}/packages"

# lint generated dependencies file
buildifier --lint=fix "${OUTPUT_DIR}/nuget.bzl"
