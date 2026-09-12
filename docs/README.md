# Getting started

## Design

### Dependency resolution

These rules try their best to follow the conventions that are used in the
project files that MSBuild uses. MSBuild is not used behind the scenes
but the compilers and tools that are part of the .Net toolchain are
used directly instead.

The biggest change compared to MSBuild out of the box is that by default
these rules do not propagate transitive dependencies to compilation actions.
This is similar to setting `<DisableTransitiveProjectReferences>true</DisableTransitiveProjectReferences>`
in MSBuild.

This behaviour can be overridden by using the following flag when invoking bazel:
```
--@rules_dotnet//dotnet/settings:strict_deps=false
```
You can add this flag to your `.bazelrc` file to make it the default.

### Debug/Release configurations
These rules follow the Bazel idiomatic way of handling compilation modes by reading the `--compilation_mode` flag.
If the flag is set to either `dbg` or `fastbuild` the rules will compile with relase optimizations disabled.
If the flag is set to `opt` the rules will compile with the release optimizations enabled.

By default Bazel sets the compilation mode to `fastbuild`.

If you want to e.g. enable optimizations in CI you can add `common --compilation_mode=opt` to your CI `.bazelrc` file.

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

The minimal supported Bazel version is 7.0.0 and bzlmod has to enabled.

From the release you wish to use: https://github.com/bazel-contrib/rules_dotnet/releases copy the WORKSPACE snippet into your WORKSPACE file.

If you are using Windows you need to make sure that symlinks and runfiles are enabled.
You can do that by adding the following snippet to your `.bazelrc` file:

```
startup --windows_enable_symlinks
build --enable_runfiles
```

More information on these flags can be found here:

[--windows_enable_symlinks](https://docs.bazel.build/versions/main/command-line-reference.html#flag--windows_enable_symlinks)

[--enable_runfiles](https://docs.bazel.build/versions/main/command-line-reference.html#flag--enable_runfiles)

Various examples of how each rule can be used are in the [examples](../examples) folder.

## IDE Support

Currently the rules do not support IDE support out of the box so for
proper IDE support the MSBuild project files need to be manually maintained.

## NuGet packages

NuGet packages are resolved with [Paket](https://fsprojects.github.io/Paket/),
whose lock file pins an exact version for every package.

### Setting Paket up

Declare your packages in `paket.dependencies`:

```
source https://api.nuget.org/v3/index.json
framework: net10.0

nuget FSharp.Core 10.1.201
nuget Argu 6.2.3
```

Run `@rules_dotnet//tools/paket -- install` in the same directory as the 
`paket.dependencies` file to generate the `paket.lock` file.

Add the following snippet to your MODULE.bazel file:

```starlark
paket = use_extension("@rules_dotnet//dotnet:paket.bzl", "paket")
paket.parse(
    dependencies = "//:paket.dependencies",
    lock = "//:paket.lock",
)
use_repo(paket, "paket.main")
```

`@rules_dotnet//tools/paket`. Every Paket command works (`update`,
`outdated`, `why`), and it runs in the directory you invoke it from.

### Referring to packages

Each [dependency group](https://fsprojects.github.io/Paket/groups.html) becomes
a repository named after it, holding one lower cased target per package:

Example:
If you have the following `paket.dependencies`:

```text
source https://api.nuget.org/v3/index.json
framework: net10.0

nuget System.Text.Json 10.1.201

group iaac
    source https://api.nuget.org/v3/index.json

    nuget Pulumi 3.101.2
```

The top-level group becomes `@paket.main`, and the `iaac` group becomes `@paket.iaac`.
and you can refer to them in your Bazel targets using the `@paket.<group>//<package>` syntax
in the `deps` attribute of your Bazel targets.

```starlark
csharp_binary(
    name = "app",
    srcs = ["Program.cs"],
    target_frameworks = ["net10.0"],
    deps = ["@paket.main//system.text.json"],
)
```

Do not mix groups in one target. Paket resolves each group separately, so two
groups can hold incompatible versions of the same transitive dependency.

A package that ships a [dotnet tool](https://learn.microsoft.com/en-us/dotnet/core/tools/global-tools)
also exposes it as an executable, at `@paket.<group>//<package>/tools:<tool>`.

## Remote execution

The rules support remote execution out of the box. The remote runners do need to have the required .Net
system dependencies installed though. A common missing system dependency in existing RBE images is `libicu`.

## C# Persistent workers

The C# compile actions can run in a [Bazel persistent worker](https://bazel.build/remote/persistent).
It is off by default, so turn it on with:

```
build --@rules_dotnet//dotnet/settings:use_compiler_worker=true
```

You can control the number of worker instances with:

```
build --worker_max_instances=CSharpCompile=HOST_CPUS
```

### Pruning unused references

When using the compiler worker an additional optimization becomes possible: pruning unused references.
What this does is track which references are actually used by the compiler and if they are unused
they will be ignored by Bazel in subsequent builds. This can lead to better cache reuse.

To enable this optimization, set the following flags:

```
build --@rules_dotnet//dotnet/settings:use_compiler_worker=true
build --@rules_dotnet//dotnet/settings:prune_unused_references=true
```

## Path mapping

The C# and F# compile actions support [Bazel path mapping](https://bazel.build/reference/command-line-reference#flag--experimental_output_paths).
Path mapping strips the configuration segment out of the paths a compile action sees, so the *same*
compilation reached through two different configurations produces one cache entry instead of two.

Enable it with:

```
common --experimental_output_paths=strip
```

This pays off when a build reaches the same libraries in more than one configuration e.g. when
publishing one application for several runtime identifiers, since the RID changes the
configuration of the whole library graph without changing a single compiler argument.
