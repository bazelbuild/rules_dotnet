#! /usr/bin/env bash

# This script only updates the settings if it's run in a Gitpod workspace.
if [[ -n "${GITPOD_WORKSPACE_URL}" ]]; then
    if [[ -f ".bazelrc.user" ]]; then
        rm .bazelrc.user
    fi

    cp -R /home/gitpod/dotnet /tmp/dotnet
    cat <<EOT >> .bazelrc.user
build --disk_cache=/workspace/bazel-disk-cache
build --repository_cache=/workspace/bazel-repository-cache
build --local_cpu_resources="HOST_CPUS*2"
build --local_ram_resources="HOST_RAM*0.9"
build --sandbox_tmpfs_path=/tmp
build --sandbox_base=/dev/shm
build --jobs=32
build --host_platform @io_bazel_rules_dotnet//dotnet/toolchain:linux_amd64_5.0.201
build --platforms @io_bazel_rules_dotnet//dotnet/toolchain:linux_amd64_5.0.201
startup --output_user_root=/workspace/bazel_user_root
startup --output_base=/workspace/bazel_output_base
EOT
    mkdir -p .vscode && cp .gitpod/vscode.settings.json .vscode/settings.json
fi

