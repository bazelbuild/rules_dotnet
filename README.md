[![Gitpod ready-to-code](https://img.shields.io/badge/Gitpod-ready--to--code-908a85?logo=gitpod)](https://gitpod.io/#https://github.com/bazelbuild/rules_dotnet)
[![Build status](https://badge.buildkite.com/703775290818dcb2af754f503ed54dc11bb124fce2a6bf1606.svg?branch=master)](https://buildkite.com/bazel/rules-dotnet-edge)

# Bazel rules for .Net

This ruleset is a alternative to using MSBuild with [.Net](https://dot.net)
By using this ruleset instead of MSBuild you gain the Bazel promise of `{Fast, Correct} - Choose two`

This document will not enumerate all the possible gains that Bazel can bring and instead
it's recommended to take a look at the [Bazel documentation](https://bazel.build/) for a
primer on Bazel.

## Installation

The minimal supported Bazel version is: 5.3.0

From the release you wish to use: https://github.com/bazelbuild/rules_dotnet/releases copy the WORKSPACE snippet into your WORKSPACE file.

If you are using Windows you need to make sure that symlinks and runfiles are enabled.
You can do that by adding the following snippet to your `.bazelrc` file:

```
startup --windows_enable_symlinks
build --enable_runfiles
```

More information on these flags can be found here:

[--windows_enable_symlinks](https://docs.bazel.build/versions/main/command-line-reference.html#flag--windows_enable_symlinks)

[--enable_runfiles](https://docs.bazel.build/versions/main/command-line-reference.html#flag--enable_runfiles)

TODO: Create the release process

## Usage

Documentation can be found in the [docs](docs/) folder.

Examples can be found in the [examples](examples/) folder.

TODO: Set up docs generation

## Unsupported workloads

The following workloads are not supported by these rules at this given time:

- VisualBasic
- Razor
- Blazor/WebAssembly
- Workloads that require Mono

Contributions to add the missing workloads are welcomed and the maintainers
will do their best to guide if needed.

## Design

These rules try their best to follow the conventions that are used in the
project files that MSBuild uses. MSBuild is not used behind the scenes
but the compilers and tools that are part of the .Net toolchain are
used directly instead.

The biggest change compared to MSBuild out of the box is that by default
these rules do not propagate transitive dependencies to compilation actions.
This is similar to setting `<DisableTransitiveProjectReferences>true</DisableTransitiveProjectReferences>`
in MSBuild.

Transitive dependency propagation can be configured on per-target basis
and when the toolchain is configured.

### IDE Support

Currently the rules do not support IDE support out of the box so for
proper IDE support the MSBuild project files need to be manually maintained.

### NuGet packages

NuGet packages are fully supported by the rules in two ways

#### NuGet packages with packages.lock.json

TODO: Write or link to documentation on how to use this

#### NuGet packages with Paket

[Paket](https://fsprojects.github.io/Paket/) is a great choice for managing dependencies in .Net
and one of the reasons for Paket being a great fit with Bazel is that it supports a lock file
out of the box.

See the [paket2bazel](tools/paket2bazel/) docs for instructions on how to set Paket up with Bazel.
