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

