Release 0.0.5 (2020-04-03)
--------------------------

Incompatible changes:

  - dotnet_repositories is move to @io_bazel_rules_dotnet//dotnet:deps.bzl
    because it has to be called before loading any other rules_dotnet files.
  - dotnet_repositories_nugets() is added @io_bazel_rules_dotnet//dotnet:defs.bzl.
    It registers all nuget packages used by test rules.

Important changes:

  - Extension names .dll, .exe are now required when defining rules_dotnet targets
    to improve compatibility with all frameworks.   
  - netcoreapp3.1 support added.
  - Continous integration jobs (travis-ci, appveyor and azure-pipelines) are fixed.

This release contains contributions from Pierre Lule, tomaszstrejczek and tomdegoede.

Release 0.0.6 (2021-01-31)
--------------------------

Incompatible changes:

  - Support for Mono and .NET Framework is dropped. They and .NET Core diverged significantly.
    Maintaining common version of rules for all the platforms turned out to be too cumbersome.
    If you need rules for Mono or .NET Framework, I suggest creating separate set of rules.
  - nuget_package rule is dropped. nuget_package_new should be used instead.
  - Rename providers to follow recommended patter *Info.

Important changes:

  - Converted documentation to markdown and [stardoc](https://github.com/bazelbuild/stardoc).   


This release contains contributions from Jimmy Reichley, Helgevold Consulting, and tomaszstrejczek.

Release 0.0.7 (2021-02-21)
--------------------------

Incompatible changes:

  - Switching to using platforms & toolchains. 

Important changes:

  - F# support added.
  - Sandboxing supported.

This release contains contributions from Daniel P. Purkhús, samhowes, and tomaszstrejczek.
