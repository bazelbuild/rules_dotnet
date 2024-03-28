#!/usr/bin/env bash

set -eou pipefail

# To add a new go dependency, make the required changes to the go files (import and use) and then
# run this file.

cd "${BUILD_WORKSPACE_DIRECTORY}"

bazel run @go_sdk//:bin/go -- mod tidy
bazel run //:gazelle_update_repos
bazel run //:gazelle
