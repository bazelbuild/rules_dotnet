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
DOTNET_ROOT=$(dirname ./"$1")
export DOTNET_ROOT

function cp_dereference {
    local src=$1
    local dst=$2

    if [ -h "$dst" ] ; then
        target=$(readlink "$1")
        rm "$1"
        cp "$target" "$1"
    fi
    if [[ -d "$src" ]]; then
        mkdir -p "$dst"
        cp -r --preserve=links "$src"/* "$dst"
    else
        cp "$src" "$dst"
    fi
}

# Since we are in the runfiles tree of the sh_test target the binary
# is a symlink to the actual binary. We follow the symlink to the
# actual binary so that we can emulate starting outside runfiles
if [[ "$OSTYPE" == "linux-gnu"* ]]; then
    ./dotnet/private/tests/publish/framework_dependent/framework_dependent/publish/linux-x64/app_to_publish
elif [[ "$OSTYPE" == "darwin"* ]]; then
    ./dotnet/private/tests/publish/framework_dependent/framework_dependent/publish/osx-x64/app_to_publish
elif [[ "$OSTYPE" == "msys" ]] || [[ "$OSTYPE" == "cygwin" ]] || [[ "$OSTYPE" == "win32" ]]; then
    # This is a silly hack to get around long path issues on windows
    target=$(readlink ./dotnet/private/tests/publish/framework_dependent/framework_dependent/publish/win-x64/app_to_publish.exe)

    cp -a "$(dirname "${target}")" ./win
    ./win/app_to_publish.exe 
else
    echo "Could not figure out which OS is running the test"
    exit 1
fi

