#! /usr/bin/env bash
# Regenerates the Starlark tables that describe the .NET SDK.
#
# Usage: ./update-sdk.sh [versions|rids|packs|frameworks|paket ...]
set -eou pipefail

SCRIPT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )
REPO_ROOT=$( cd -- "$SCRIPT_DIR/../../../.." &> /dev/null && pwd )

cd "$REPO_ROOT"
bazel run //dotnet/private/sdk/gen -- "$SCRIPT_DIR/.." "$@"
buildifier -r -lint fix "$SCRIPT_DIR/.."
