#!/usr/bin/env bash

set -o pipefail -o errexit -o nounset
exec "$DOTNET_BINARY__DOTNET_EXECUTABLE" "$@"
