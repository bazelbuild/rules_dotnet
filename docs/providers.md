Dotnet providers
================

The [providers](https://docs.bazel.build/versions/master/skylark/rules.html#providers) are the outputs of 
the rules, you generaly get them by having a dependency on a rule, and then asking for a provider of a specific type.

The Dotnet providers are designed primarily for the efficiency of the dotnet rules, the information
they share is mostly there because it is required for the core rules to work.

All the providers are designed to hold only immutable data. This is partly because its a cleaner
design choice to be able to assume a provider will never change, but also because only immutable
objects are allowed to be stored in a depset, and it's really useful to have depsets of providers.
Specifically the `deps` and `transitive` fields on [DotnetLibraryInfo](api.md#dotnetlibraryinfo) only work
because they are immutable.

