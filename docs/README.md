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

Point the extension at it and at the lock file Paket writes next to it:

```starlark
paket = use_extension("@rules_dotnet//dotnet:paket.bzl", "paket")
paket.parse(
    dependencies = "//:paket.dependencies",
    lock = "//:paket.lock",
)
use_repo(paket, "paket.main")
```

`@rules_dotnet//tools/paket` is the Paket CLI on the build's own .NET toolchain, so
it needs no local .NET install. Every Paket command works (`update`,
`outdated`, `why`), and it runs in the directory you invoke it from.

### Referring to packages

Each [dependency group](https://fsprojects.github.io/Paket/groups.html) becomes
a repository named after it, holding one lower cased target per package:
`@paket.main//argu` for the implicit top group, `@paket.build//fake.core` for a
group named `Build`. Versions are left out, since a group resolves one version
of each package.

```starlark
csharp_binary(
    name = "app",
    srcs = ["Program.cs"],
    target_frameworks = ["net10.0"],
    deps = ["@paket.main//argu"],
)
```

`bazel mod tidy` keeps the `use_repo` call in step with the lock file.

Do not mix groups in one target. Paket resolves each group separately, so two
groups can hold incompatible versions of the same transitive dependency.

A package that ships a [dotnet tool](https://learn.microsoft.com/en-us/dotnet/core/tools/global-tools)
also exposes it as an executable, at `@paket.main//csharpier/tools:csharpier`.

### Package sources and verification

Packages are downloaded from the feeds their group lists in `paket.lock`, in
order, authenticating from your `.netrc` or the one `paket.parse` names.

Paket records no hashes, so `paket.parse` looks them up from the feed's
registration metadata and keeps them in `MODULE.bazel.lock`, where they are
pinned and visible in review. Feeds that do not publish it yield no hash and
their packages are pinned by version alone; `verify_integrity = False` skips
the lookup.

## Remote execution

The rules support remote execution out of the box. The remote runners do need to have the required .Net
system dependencies installed though. A common missing system dependency in existing RBE images is `libicu`.

## Persistent workers

The C# compile actions can run in a [Bazel persistent worker](https://bazel.build/remote/persistent).
It is off while it is new, so turn it on with:

```
build --@rules_dotnet//dotnet/settings:use_compiler_worker=true
```

Most of the wall time of a small C# compilation is not compilation: it is Roslyn reading the
~170 reference assemblies of the targeting pack, which is identical work for every target in
the build. Roslyn keeps that metadata in its build server, but a plain Bazel action cannot
reach the server, because every action gets its own sandbox and therefore its own temporary
directory. A worker lives across compilations, so the server it starts is reused and Bazel owns
its lifetime.

Measured on a generated 500-library graph (826 compile actions):

| | without worker | with worker |
| --- | --- | --- |
| Clean build wall time | 64.6s | **11.2s** |
| Critical path | 28.4s | **4.8s** |
| Mean per compile | 1,929ms | 680ms |

Bazel runs 4 worker instances by default, which is then the limiting factor on a wide machine.
Raise it alongside the flag above:

```
build --worker_max_instances=CSharpCompile=HOST_CPUS
```

The build servers are shared between the workers, so that costs almost no extra memory (~390MB
in total in the measurement above, whatever the worker count), and they shut themselves down 60
seconds after the last compilation.

With the flag on, `--strategy=CSharpCompile=sandboxed` still runs each compile as its own
process: the worker binary compiles a single target and exits when Bazel does not pass
`--persistent_worker`. That is also what happens under remote execution, where the worker
strategy does not apply.

F# compiles do not use a worker. fsc has no build server to keep warm, and hosting it in the
worker process is not an option because it terminates the process it runs in when a compilation
fails, which would lose the diagnostics along with the worker.
