#! /usr/bin/env bash
set -eou pipefail

SCRIPT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )

(
    cd "$SCRIPT_DIR" || exit 1
    dotnet tool restore
    dotnet restore
    dotnet run -- "$(pwd)/.."
    buildifier -r -lint fix ./..
)
