FROM gitpod/workspace-base

############
### .Net ###
############
# Install .NET SDK (Current channel)
# Source: https://docs.microsoft.com/dotnet/core/install/linux-scripted-manual#scripted-install
USER gitpod
ENV DOTNET_VERSION=5.0
RUN mkdir -p /home/gitpod/dotnet && curl -fsSL https://dot.net/v1/dotnet-install.sh | bash /dev/stdin --channel ${DOTNET_VERSION} --install-dir /home/gitpod/dotnet
# This is a workaround until this bug has been resolved: https://github.com/gitpod-io/gitpod/issues/5090
# We copy the .Net installation to /tmp/dotnet in our prebuild script
# Once the bug has been fixed we should change the envs and remove the prebuild workaround
#ENV DOTNET_ROOT=/home/gitpod/dotnet
#ENV PATH=$PATH:/home/gitpod/dotnet
RUN cp -R /home/gitpod/dotnet /tmp/dotnet
ENV DOTNET_ROOT=/tmp/dotnet
ENV PATH=$PATH:/tmp/dotnet

# Install global .Net tools
RUN dotnet tool install -g fantomas-tool \
  && dotnet tool install -g paket
ENV PATH=$PATH:/home/gitpod/.dotnet/tools

##############
### Docker ###
##############
USER root
# https://docs.docker.com/engine/install/ubuntu/
RUN curl -o /var/lib/apt/dazzle-marks/docker.gpg -fsSL https://download.docker.com/linux/ubuntu/gpg \
    && apt-key add /var/lib/apt/dazzle-marks/docker.gpg \
    && add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable" \
    && install-packages docker-ce=5:19.03.15~3-0~ubuntu-focal docker-ce-cli=5:19.03.15~3-0~ubuntu-focal containerd.io

RUN curl -o /usr/bin/slirp4netns -fsSL https://github.com/rootless-containers/slirp4netns/releases/download/v1.1.11/slirp4netns-$(uname -m) \
    && chmod +x /usr/bin/slirp4netns

RUN curl -o /usr/local/bin/docker-compose -fsSL https://github.com/docker/compose/releases/download/1.29.2/docker-compose-Linux-x86_64 \
    && chmod +x /usr/local/bin/docker-compose

# https://github.com/wagoodman/dive
RUN curl -o /tmp/dive.deb -fsSL https://github.com/wagoodman/dive/releases/download/v0.10.0/dive_0.10.0_linux_amd64.deb \
    && apt install /tmp/dive.deb \
    && rm /tmp/dive.deb

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
