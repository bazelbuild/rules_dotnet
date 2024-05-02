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

#############################
# Install system utilities
#############################
RUN sudo apt-get update && export DEBIAN_FRONTEND=noninteractive \
  && sudo apt-get -y install \
    file \
  && sudo apt-get clean && sudo rm -rf /var/lib/apt/lists/*

COPY --chown=vscode ./devcontainer.bazelrc /home/vscode/.bazelrc
