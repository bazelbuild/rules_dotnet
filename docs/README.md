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

## Runfiles

XML documentation files are build outputs, not runtime inputs: the .NET runtime never loads
them, and `publish_binary` has never shipped them. They are therefore not staged into runfiles,
which on a 500 library graph takes a binary's runfiles from 842 entries to 519 and the time
spent materialising runfiles trees down by about 17%. The files are still produced and are
still in the target's `DefaultInfo`, so `bazel build` on a library gives you its `.xml` as
before.

The one behaviour change: an application that reads its *own* XML documentation at run time -
ASP.NET Core API documentation generators do this - will no longer find it under `bazel run`
or `bazel test`. Add it back explicitly for those targets:

```python
csharp_binary(
    name = "api",
    data = [":api_xml"],  # or list the library target that produces it
    ...
)
```

For CI that builds but does not test, `--nobuild_runfile_links` skips materialising the trees
altogether.

## Publishing

`publish_binary` assembles its output with one script that copies every file into place. A
self-contained publish copies the whole runtime pack, so that script is long: on a generated
application it places 617 files into 14 directories.

Each directory is created once and the files that keep their name are copied in batches, rather
than running `mkdir -p` and `cp` per file. That script went from 1,234 processes to 30, and from
2.40s to 0.36s for byte identical output - it had been the slowest action in the build.

Windows still runs one `copy` per file, because `copy` concatenates when handed several sources,
but it shares the directory creation.
