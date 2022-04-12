FROM gitpod/workspace-base

############
### .Net ###
############
# Install .NET SDK (Current channel)
# Source: https://docs.microsoft.com/dotnet/core/install/linux-scripted-manual#scripted-install
USER gitpod
# Until the following issue is fixed: https://github.com/gitpod-io/gitpod/issues/8901
# ENV TRIGGER_REBUILD=1
# ENV DOTNET_VERSION=6.0
# ENV DOTNET_ROOT=/home/gitpod/dotnet
# ENV PATH=$PATH:$DOTNET_ROOT
# ENV PATH=$PATH:/home/gitpod/.dotnet/tools
# RUN mkdir -p $DOTNET_ROOT && curl -fsSL https://dot.net/v1/dotnet-install.sh | bash /dev/stdin --channel $DOTNET_VERSION --install-dir $DOTNET_ROOT
# RUN dotnet tool install --global --version 4.7.3 fantomas-tool
# RUN dotnet tool install --global paket
# ENV NUGET_PACKAGES=/workspace/nuget_cache

ENV DOTNET_VERSION=6.0
ENV DOTNET_ROOT=/workspace/dotnet
ENV PATH=$PATH:$DOTNET_ROOT
ENV PATH=$PATH:/workspace/dotnet-tools
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
RUN curl -o bazelisk-linux-amd64 -fsSL https://github.com/bazelbuild/bazelisk/releases/download/v1.10.1/bazelisk-linux-amd64 \
  && mv ./bazelisk-linux-amd64 $HOME/bin/bazel \
  && chmod +x $HOME/bin/bazel

# Install bazel-watcher
RUN curl -o ibazel_linux_amd64 -fsSL https://github.com/bazelbuild/bazel-watcher/releases/download/v0.15.10/ibazel_linux_amd64 \
  && mv ./ibazel_linux_amd64 $HOME/bin/ibazel \
  && chmod +x $HOME/bin/ibazel

# Install buildifier
RUN curl -o buildifier-linux-amd64 -fsSL https://github.com/bazelbuild/buildtools/releases/download/4.2.2/buildifier-linux-amd64 \
  && mv ./buildifier-linux-amd64 $HOME/bin/buildifier \
  && chmod +x $HOME/bin/buildifier

# Install buildozer
RUN curl -o buildozer-linux-amd64 -fsSL https://github.com/bazelbuild/buildtools/releases/download/4.2.2/buildozer-linux-amd64 \
  && mv ./buildozer-linux-amd64 $HOME/bin/buildozer \
  && chmod +x $HOME/bin/buildozer
