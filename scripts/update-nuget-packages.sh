#! /usr/bin/env bash

SCRIPT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )

(
    cd "$SCRIPT_DIR" || exit 1
    (cd .. && dotnet tool restore && dotnet paket install)
    dotnet run --project ../tools/paket2bazel/paket2bazel.fsproj -- --dependencies-file "$(pwd)"/../paket.dependencies --output-folder "$(pwd)"/../dotnet 
    # bazel run @rules_dotnet//tools/paket2bazel:paket2bazel.exe -- --dependencies-file "$(pwd)"/../paket.dependencies --output-folder "$(pwd)"/../dotnet 
)
