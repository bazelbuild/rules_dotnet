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
compilation reached through two different configurations produces one cache **key** instead of two.

```
common --experimental_output_paths=strip
```

The case it exists for is a build that reaches the same libraries in more than one configuration -
publishing one application for several runtime identifiers, say, since the RID reconfigures the
whole library graph without changing a single compiler argument. Measured on one application
published for six RIDs on top of a generated 300 library graph, clean each time:

| | no cache | with `--disk_cache` |
| --- | --- | --- |
| `--experimental_output_paths=off` | 92.1s | 86.7s, 0 cache hits |
| `--experimental_output_paths=strip` | 105.4s | **26.9s, 1,833 cache hits** |

Two things follow, and both matter more than the headline.

### It only pays off with a cache

One cache key is not one action. Each configuration still has its own output paths and still has to
put files there, so on a cold build with nowhere to read from, the six compilations all run whether
or not their keys match. The win comes from the five that *find their outputs already built* - which
needs somewhere to look, either `--disk_cache` or a remote cache. Without one, path mapping is cost
with no benefit: the middle column above is 14% slower than not using it at all.

### It forces workers to be sandboxed

Path mapping needs the indirection a sandbox provides, so Bazel silently upgrades a worker that
declares `supports-path-mapping` from non-sandboxed to sandboxed:

```
$ bazel build //... --experimental_output_paths=strip --worker_verbose
INFO: Created new sandboxed singleplex CSharpCompile worker ...

$ bazel build //... --experimental_output_paths=off --worker_verbose
INFO: Created new non-sandboxed singleplex CSharpCompile worker ...
```

A sandboxed worker stages its inputs for every action instead of reusing what is already in its
exec root. On a generated 300 library C# graph in a single configuration - nothing to share between
configurations, so nothing for path mapping to win - that costs about 30%:

| | clean build wall time |
| --- | --- |
| `--experimental_output_paths=off` | 10.8s |
| `--experimental_output_paths=strip` | 14.1s |

And because the sandbox is a requirement rather than a preference, any strategy that takes it away
turns into a hard failure rather than a slow build:

```
$ bazel build //... --strategy=CSharpCompile=local
ERROR: ... Compiling main failed: CSharpCompile spawn, which requires sandboxing due to
path mapping, cannot be executed with any of the available strategies: [standalone].
```

The same happens with `--spawn_strategy=local` and with a `no-sandbox` tag applied to the
compile actions. Turn path mapping off in those builds.

### It cannot be used on Windows

Bazel has [no sandboxing on Windows](https://github.com/bazelbuild/bazel/discussions/18401), so
there is no strategy there that can satisfy the requirement and *every* compile fails with the
error above. Path mapping is a Linux and macOS option only. This repository's `.bazelrc` switches
it on per platform for that reason:

```
common --enable_platform_specific_config
build:linux --experimental_output_paths=strip
build:macos --experimental_output_paths=strip
```

Put it behind the same guard rather than in a bare `common` line if your workspace builds on
Windows at all.

## Which flags work together

What the compile actions ask Bazel for:

| Action | Execution requirements |
| --- | --- |
| `CSharpCompile` | `supports-path-mapping`, plus `supports-workers` and `requires-worker-protocol: json` when `use_compiler_worker=true` |
| `FSharpCompile` | `supports-path-mapping` |

| Combination | Result |
| --- | --- |
| `--experimental_output_paths=strip` + `use_compiler_worker=true` | Works. Workers become sandboxed singleplex. |
| `--experimental_output_paths=strip` + `--disk_cache` or remote cache | Works, and is the only combination path mapping pays for itself in. |
| `--experimental_output_paths=strip` + `--strategy=CSharpCompile=sandboxed` | Works. Workers off, path mapping still applies. |
| `--experimental_output_paths=strip` + `--strategy=CSharpCompile=local` | **Hard error.** Path mapping requires a sandbox. |
| `--experimental_output_paths=strip` + `--spawn_strategy=local` | **Hard error**, same reason. |
| `--experimental_output_paths=strip` + `no-sandbox` on the compile actions | **Hard error**, same reason. |
| `--experimental_output_paths=strip` on Windows | **Hard error.** Bazel has no sandbox there, so no strategy qualifies. |
| `--experimental_output_paths=off` + any strategy | Works. No sandbox is forced. |
| `prune_unused_references=true` + `--experimental_output_paths=strip` | Works. |
| `prune_unused_references=true` + `--strategy=CSharpCompile=sandboxed` | Works. The binary writes the unused inputs list whether or not it is a persistent worker. |

`use_compiler_worker` and `prune_unused_references` above are the `--@rules_dotnet//dotnet/settings:`
flags from [C# Persistent workers](#c-persistent-workers); both are off by default.

`CSharpCompile` never declares `supports-multiplex-workers`, so it is always singleplex and
`--experimental_worker_multiplex_sandboxing`, `--worker_max_multiplex_instances` and
`--noworker_multiplex` have no effect on it. `--worker_max_instances=CSharpCompile=...` does.

`--worker_sandboxing` does not need to be set: path mapping already forces the sandbox where it is
required, and setting it turns on sandboxing for every other worker in the build as well.
