# Getting started

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

## Unsupported workloads

The following workloads are not supported by these rules at this given time:

- VisualBasic
- Razor
- Blazor/WebAssembly
- Workloads that require Mono

Contributions to add the missing workloads are welcomed and the maintainers
will do their best to guide if needed.

## Usage

### Installation

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

### C#

[csharp_binary](./csharp_binary.md)

[csharp_library](./csharp_library.md)

[csharp_test](./csharp_test.md)

[csharp_nunit_test](./csharp_nunit_test.md)

### F#

[fsharp_binary](./fsharp_binary.md)

[fsharp_library](./fsharp_library.md)

[fsharp_test](./fsharp_test.md)

[fsharp_nunit_test](./fsharp_nunit_test.md)

Various examples of how each rule can be used are in the [examples](../examples) folder.

## IDE Support

Currently the rules do not support IDE support out of the box so for
proper IDE support the MSBuild project files need to be manually maintained.

## NuGet packages

NuGet packages are fully supported by the rules in two ways

### NuGet packages with packages.lock.json

TODO: Write or link to documentation on how to use this

### NuGet packages with Paket

[Paket](https://fsprojects.github.io/Paket/) is a great choice for managing dependencies in .Net
and one of the reasons for Paket being a great fit with Bazel is that it supports a lock file
out of the box.

See the [paket2bazel](tools/paket2bazel/) docs for instructions on how to set Paket up with Bazel.

## Remote execution

The rules support remote execution out of the box. The remote runners do need to have the required .Net
system dependencies installed though. A common missing system dependency in existing RBE images is `libicu`.
You can also work around the missing `libicu` by setting `DOTNET_SYSTEM_GLOBALIZATION_INVARIANT=1` using
the `--action_env/--test_env/--host_action_env` Bazel flags.
