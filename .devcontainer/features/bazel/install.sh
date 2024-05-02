#!/usr/bin/env bash

set -eou pipefail

if [ $(uname -m) == "x86_64" ]; then
  TARGETARCH=amd64
else
  TARGETARCH=arm64
fi

# Install bazelisk
curl -o /usr/local/bin/bazelisk-linux-$TARGETARCH -fsSL https://github.com/bazelbuild/bazelisk/releases/download/v1.19.0/bazelisk-linux-$TARGETARCH \
  && mv /usr/local/bin/bazelisk-linux-$TARGETARCH /usr/local/bin/bazelisk \
  && chmod +x /usr/local/bin/bazelisk \
  && ln -s /usr/local/bin/bazelisk /usr/local/bin/bazel

# Install bazel-watcher
curl -o /usr/local/bin/ibazel_linux_$TARGETARCH -fsSL https://github.com/bazelbuild/bazel-watcher/releases/download/v0.24.0/ibazel_linux_$TARGETARCH \
  && mv /usr/local/bin/ibazel_linux_$TARGETARCH /usr/local/bin/ibazel \
  && chmod +x /usr/local/bin/ibazel

# Install buildifier
curl -o /usr/local/bin/buildifier-linux-$TARGETARCH -fsSL https://github.com/bazelbuild/buildtools/releases/download/v6.4.0/buildifier-linux-$TARGETARCH \
  && mv /usr/local/bin/buildifier-linux-$TARGETARCH /usr/local/bin/buildifier \
  && chmod +x /usr/local/bin/buildifier

# Install buildozer
curl -o /usr/local/bin/buildozer-linux-$TARGETARCH -fsSL https://github.com/bazelbuild/buildtools/releases/download/v6.4.0/buildozer-linux-$TARGETARCH \
  && mv /usr/local/bin/buildozer-linux-$TARGETARCH /usr/local/bin/buildozer \
  && chmod +x /usr/local/bin/buildozer

# Install Starlark larnguage server
curl -o /usr/local/bin/starpls-linux-$TARGETARCH -fsSL https://github.com/withered-magic/starpls/releases/download/v0.1.12/starpls-linux-$TARGETARCH \
  && mv /usr/local/bin/starpls-linux-$TARGETARCH /usr/local/bin/starpls \
  && chmod +x /usr/local/bin/starpls

