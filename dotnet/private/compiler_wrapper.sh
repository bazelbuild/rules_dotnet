#! /usr/bin/env bash
set -eou pipefail

# This wrapper script is used because the C#/F# compilers both embed absolute paths
# into their outputs and those paths are not deterministic. The compilers also
# allow overriding these paths using pathmaps. Since the paths can not be known
# at analysis time we need to override them at execution time.

DOTNET_EXECUTABLE="$1"
COMPILER="$2"
ARGS_FILE="$3"
OTHER_ARGS="${*:4}"

PATHMAP_FLAG="-pathmap"

# Needed because unfortunately the F# compiler uses a different flag name
if [[ $(basename "$COMPILER") == "fsc.dll" ]]; then
  PATHMAP_FLAG="--pathmap"
fi

PATHMAP="$PATHMAP_FLAG:$PWD=."


./"$DOTNET_EXECUTABLE" "$COMPILER" "$PATHMAP" "$ARGS_FILE" $OTHER_ARGS
