#! /usr/bin/env bash

set -eou pipefail

# Unset the runfiles related envs to make sure that runfiles work outside of Bazel
export RUNFILES_DIR=""
export JAVA_RUNFILES=""
export RUNFILES_MANIFEST_FILE=""
export RUNFILES_MANIFEST_ONLY=""

# Set DOTNET_ROOT to the location of the dotnet runtime
# this way the framework dependent publish will use the
# dotnet installation that is located there to run the
# binary.
export  DOTNET_ROOT=$(dirname ./$1)

# Since we are in the runfiles tree of the sh_test target the binary
# is a symlink to the actual binary. We follow the symlink to the
# actual binary so that we can emulate starting outside runfiles
if [[ "$OSTYPE" == "linux-gnu"* ]]; then
    ./tests/publish/framework_dependent/framework_dependent/publish/linux-x64/app_to_publish
elif [[ "$OSTYPE" == "darwin"* ]]; then
    ./tests/publish/framework_dependent/framework_dependent/publish/osx-x64/app_to_publish
elif [[ "$OSTYPE" == "msys" ]] || [[ "$OSTYPE" == "cygwin" ]] || [[ "$OSTYPE" == "win32" ]]; then
    ./tests/publish/framework_dependent/framework_dependent/publish/win-x64/app_to_publish.exe
else
    echo "Could not figure out which OS is running the test"
    exit 1
fi

