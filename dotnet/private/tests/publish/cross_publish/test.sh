#!/usr/bin/env bash

set -euo pipefail

if [[ $# -ne 3 ]]; then
    echo >&2 "Usage: $0 /path/to/binary expected_file_type expected_arch"
    exit 1
fi

binary="$1"
expected_file_type="$2"
expected_arch="$3"

out="$(file "$(readlink "${binary}")")"

if [[ "${out}" != *"${expected_file_type}"* || "${out}" != *"${expected_arch}"* ]]; then
    echo >&2 "Wrong file type: ${out}"
    exit 1
fi
