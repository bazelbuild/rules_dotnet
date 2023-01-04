FROM gitpod/workspace-full

############
### .Net ###
############
# Install .NET SDK (Current channel)
# Source: https://docs.microsoft.com/dotnet/core/install/linux-scripted-manual#scripted-install
USER gitpod

# Remove this hack when the kernel bug is resolved.
# ref. https://github.com/gitpod-io/gitpod/issues/8901
RUN bash \
    && { echo 'if [ ! -z $GITPOD_REPO_ROOT ]; then'; \
        echo '\tCONTAINER_DIR=$(awk '\''{ print $6 }'\'' /proc/self/maps | grep ^\/run\/containerd | head -n 1 | cut -d '\''/'\'' -f 1-6)'; \
        echo '\tif [ ! -z $CONTAINER_DIR ]; then'; \
        echo '\t\t[[ ! -d $CONTAINER_DIR ]] && sudo mkdir -p $CONTAINER_DIR && sudo ln -s / $CONTAINER_DIR/rootfs'; \
        echo '\tfi'; \
        echo 'fi'; } >> /home/gitpod/.bashrc.d/110-dotnet
RUN chmod +x /home/gitpod/.bashrc.d/110-dotnet

ENV DOTNET_VERSION=6.0
ENV DOTNET_ROOT=/home/gitpod/dotnet
ENV PATH=$PATH:$DOTNET_ROOT
ENV PATH=$PATH:/home/gitpod/.dotnet/tools
RUN mkdir -p $DOTNET_ROOT && curl -fsSL https://dot.net/v1/dotnet-install.sh | bash /dev/stdin --channel $DOTNET_VERSION --install-dir $DOTNET_ROOT
RUN dotnet tool install --global --version 4.7.3 fantomas-tool
RUN dotnet tool install --global paket
ENV NUGET_PACKAGES=/workspace/nuget_cache


#########################################################
### Create bin folder under $HOME for random binaries ###
#########################################################
USER gitpod
RUN mkdir $HOME/bin
ENV PATH=$PATH:$HOME/bin

#########################################
### Bazel and Bazel releated binaries ###
#########################################
# Install bazelisk and make it available on PATH as it as bazel
RUN curl -o bazelisk-linux-amd64 -fsSL https://github.com/bazelbuild/bazelisk/releases/download/v1.12.0/bazelisk-linux-amd64 \
  && mv ./bazelisk-linux-amd64 $HOME/bin/bazel \
  && chmod +x $HOME/bin/bazel

# Install bazel-watcher
RUN curl -o ibazel_linux_amd64 -fsSL https://github.com/bazelbuild/bazel-watcher/releases/download/v0.16.2/ibazel_linux_amd64 \
  && mv ./ibazel_linux_amd64 $HOME/bin/ibazel \
  && chmod +x $HOME/bin/ibazel

# Install buildifier
RUN curl -o buildifier-linux-amd64 -fsSL https://github.com/bazelbuild/buildtools/releases/download/5.1.0/buildifier-linux-amd64 \
  && mv ./buildifier-linux-amd64 $HOME/bin/buildifier \
  && chmod +x $HOME/bin/buildifier

# Install buildozer
RUN curl -o buildozer-linux-amd64 -fsSL https://github.com/bazelbuild/buildtools/releases/download/5.1.0/buildozer-linux-amd64 \
  && mv ./buildozer-linux-amd64 $HOME/bin/buildozer \
  && chmod +x $HOME/bin/buildozer

# pre-commit and shellcheck
USER root
RUN install-packages shellcheck \
    && pip3 install pre-commit

USER gitpod
