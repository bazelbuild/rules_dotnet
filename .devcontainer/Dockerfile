# See here for image contents: https://github.com/microsoft/vscode-dev-containers/tree/v0.245.0/containers/ubuntu/.devcontainer/base.Dockerfile

# [Choice] Ubuntu version (use ubuntu-22.04 or ubuntu-18.04 on local arm64/Apple Silicon): ubuntu-22.04, ubuntu-20.04, ubuntu-18.04
ARG VARIANT
FROM mcr.microsoft.com/vscode/devcontainers/base:0-${VARIANT}
ARG TARGETARCH

#########################################################
### Create bin folder under $HOME for random binaries ###
#########################################################
USER vscode
RUN mkdir $HOME/bin
ENV PATH=$PATH:$HOME/bin

#########################################
### Bazel and Bazel releated binaries ###
#########################################
# Install bazelisk
RUN curl -o $HOME/bin/bazelisk-linux-$TARGETARCH -fsSL https://github.com/bazelbuild/bazelisk/releases/download/v1.19.0/bazelisk-linux-$TARGETARCH \
  && mv $HOME/bin/bazelisk-linux-$TARGETARCH $HOME/bin/bazelisk \
  && chmod +x $HOME/bin/bazelisk \
  && ln -s $HOME/bin/bazelisk $HOME/bin/bazel

# Install bazel-watcher
RUN curl -o $HOME/bin/ibazel_linux_$TARGETARCH -fsSL https://github.com/bazelbuild/bazel-watcher/releases/download/v0.24.0/ibazel_linux_$TARGETARCH \
  && mv $HOME/bin/ibazel_linux_$TARGETARCH $HOME/bin/ibazel \
  && chmod +x $HOME/bin/ibazel

# Install buildifier
RUN curl -o $HOME/bin/buildifier-linux-$TARGETARCH -fsSL https://github.com/bazelbuild/buildtools/releases/download/v6.4.0/buildifier-linux-$TARGETARCH \
  && mv $HOME/bin/buildifier-linux-$TARGETARCH $HOME/bin/buildifier \
  && chmod +x $HOME/bin/buildifier

# Install buildozer
RUN curl -o $HOME/bin/buildozer-linux-$TARGETARCH -fsSL https://github.com/bazelbuild/buildtools/releases/download/v6.4.0/buildozer-linux-$TARGETARCH \
  && mv $HOME/bin/buildozer-linux-$TARGETARCH $HOME/bin/buildozer \
  && chmod +x $HOME/bin/buildozer

COPY --chown=vscode ./devcontainer.bazelrc /home/vscode/.bazelrc
