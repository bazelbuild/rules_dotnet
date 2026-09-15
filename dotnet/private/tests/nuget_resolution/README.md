# NuGet resolution tests

How a package's file layout turns into the assemblies a build resolves to.

`tests.bzl` is the whole surface. A test is one declaration: the files the
package ships, the framework and runtime identifier to build at, and what
should come out.

```python
nuget_resolution_test(
    name = "a_rid_assembly_replaces_the_lib_group_on_windows",
    files = [
        "lib/netstandard2.0/A.dll",
        "runtimes/win/lib/netstandard2.0/Win.dll",
    ],
    runtime_identifier = "win-x64",
    expected_libs = ["runtimes/win/lib/netstandard2.0/Win.dll"],
    expected_refs = ["lib/netstandard2.0/A.dll"],
)
```

Adding a case means adding a declaration; nothing has to be published first.
Each one becomes a package in the `@nuget_fixtures` repository, laid out by the
same code that unpacks a real `.nupkg`, so the test covers the whole chain from
file layout to resolved assemblies.

`internal/` holds the machinery: the shape of a declaration, the repository
rule that writes the layouts, the assertions, and the macro that turns
declarations into targets.
