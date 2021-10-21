.Net Rules for Bazel
===================
[![Gitpod ready-to-code](https://img.shields.io/badge/Gitpod-ready--to--code-908a85?logo=gitpod)](https://gitpod.io/#https://github.com/bazelbuild/rules_dotnet)

Build status
------------

  | Bazel CI |
  | --------------- |
  | [![Build status](https://badge.buildkite.com/76523cc666caab9ca91c2a08d9ac8f84af28cb25a92f387293.svg?branch=master)](https://buildkite.com/bazel/rules-dotnet-edge?branch=master)|


Documentation
-------------

The full documentation is [here](https://tomaszstrejczek.github.io/rules_dotnet/).


Overview
--------

This is a minimal viable set of C#/F# bindings for building C#/F# code with
[Core](https://en.wikipedia.org/wiki/.NET_Core)

Caveats
-------

[Bazel](https://bazel.build/) creates long paths. Therefore it is recommended to increase the length limit 
using newer version of Windows. Please see 
[here](https://docs.microsoft.com/en-us/windows/desktop/fileio/naming-a-file#maximum-path-length-limitation).

However, some Windows programs do not handle long path names. Most notably - Microsoft 
C compiler (cl.exe). Therefore TMP env variable should be set to something 
short (like X:\\ or c:\\TEMP). 

[Bazel](https://bazel.build/) and dotnet_rules rely on symbolic linking. On Windows it, typically, requires 
elevated permissions. However, newer versions of Windows have a [workaround](https://blogs.windows.com/buildingapps/2016/12/02/symlinks-windows-10/#IJuxPHWEkSSRqC7w.97).

Setup
-----

* The rules take full advantage of Bazel [platforms](https://docs.bazel.build/versions/master/platforms.html)
  and [toolchains](https://docs.bazel.build/versions/master/toolchains.html)

* When building any project the platform has to be specified. For example:

  ```bash
      bazel build --host_platform //dotnet/toolchain:linux_amd64_2.2.402 --platforms //dotnet/toolchain:linux_amd64_2.2.402 //...
  ```

* The platform specification has the form of //dotnet/toolchain:<os>_<arch>_<sdkversion>. 
  The available values are listed in dotnet/platform/list.bzl in variables DOTNET_OS_ARCH and DOTNET_CORE_FRAMEWORKS.
  Typically the --host_platform and --platforms values are set in [.bazelrc file](https://docs.bazel.build/versions/master/guide.html).

* Add the following to your `WORKSPACE` file to add the external repositories:

  ```python

    # A newer version should be fine
    load("@bazel_tools//tools/build_defs/repo:git.bzl", "git_repository")
    git_repository(
        name = "io_bazel_rules_dotnet",
        remote = "https://github.com/bazelbuild/rules_dotnet",
        branch = "master",
    )

    load("@io_bazel_rules_dotnet//dotnet:deps.bzl", "dotnet_repositories")

    dotnet_repositories()

    load("@io_bazel_rules_dotnet//dotnet:defs.bzl", "core_register_sdk", "dotnet_register_toolchains", "dotnet_repositories_nugets")

    dotnet_register_toolchains()
    dotnet_repositories_nugets()
  ```

  The [dotnet_repositories](docs/api.md#dotnet_repositories) rule fetches external dependencies which have to be defined before loading any other file of rules_dotnet. [dotnet_repositories_nugets](docs/api.md#dotnet_repositories_nugets) loads nuget packages 
  required by test rules.

  The [dotnet_register_toolchains](docs/api.md#dotnet_register_toolchains) configures toolchains.

* Add a file named ``BUILD.bazel`` in the root directory of your project. In general, you need one of these files in every directory with dotnet code.

  At the top of the file used rules should be imported:

  ```python

    load("@io_bazel_rules_dotnet//dotnet:defs.bzl", "csharp_library", "csharp_binary")
  ```

* See [nuget2bazel](docs/nuget2bazel.md) for using nuget dependencies.

* See ``examples`` folder for examples.

