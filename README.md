# C# Rules

## Rules


* [csharp_library](#csharp_library)
* [csharp_binary](#csharp_library)
* [csharp_nunit_test](#csharp_nunit_test)
* [nuget_package](#nuget_package)
* [dll_import](#dll_import)

__WARNING:__ Theses rules are not compatible with
[sandboxing](https://bazel.io/blog/2015/09/11/sandboxing.html).


## Overview

This is a minimal viable set of C# bindings for building csharp code with
mono. It's still pretty rough but it works as a proof of concept that could
grow into something more. If windows support ever happens for Bazel then this
might become especially valuable.

## Setup

Add the following to your `WORKSPACE` file to add the external repositories:

```python
git_repository(
    name = "io_bazel_rules_dotnet",
    remote = "https://github.com/bazelbuild/rules_dotnet.git",
    tag = "0.0.3",
)

load(
    "@io_bazel_rules_dotnet//dotnet:csharp.bzl",
    "csharp_repositories",
    "nuget_package",
)

csharp_repositories(use_local_mono = True)

nuget_package(
  name = "some_name",
  package = "Some.Package",
  version = "0.1.2",
)
```

The `csharp_repositories` rule fetches external dependencies, namely
the mono repository, the nuget binary, and the nunit binary. Setting
`use_local_mono` to `True` will use your installed mono framework
instead of downloading one. If you are on OS X you can set
`use_local_mono` to `False` and mono will be downloaded for you by
bazel. Support for downloading mono on Linux is coming soon.

## Examples

### csharp_library

```python
csharp_library(
    name = "MyLib",
    srcs = ["MyLib.cs"],
    deps = ["//my/dependency:SomeLib"],
)
```

### csharp_binary

```python
csharp_binary(
    name = "MyApp",
    main = "MyApp", # optional name of the main class.
    srcs = ["MyApp.cs"],
    deps = ["//my/dependency:MyLib"],
)
```

### csharp\_nunit\_test

```python
csharp_nunit_test(
    name = "MyApp",
    srcs = ["MyApp.cs"],
    deps = ["//my/dependency:MyLib"],
)
```

### nuget\_package

In the WORKSPACE file for your project record a nuget dependency like so.
This is a repository rule so it will not work unless it is in a workspace
file.

```python
nuget_package(
    name="ndesk_options", # referenced via path @ndesk_options//:dylibs
    package="NDesk.Options",
    version="0.2.1",
)
```

### dll\_import

Add a collection of dotnet assembly dll's to be used as a dependency.

```python
dll_import(
    name="some_lib",
    srcs=[
      "Some.dll"
      "Some.Other.dll",
    ]
)
```

## Things still missing:

- Handle .resx files correctly.
- .Net Modules
- Conditionally building documentation.
- Pulling Mono in through a mono.WORKSPACE file.
  - Still need to implement this for linux.
- Multiple target framework support for nuget packages.

## Future nice to haves:

- nuget_packages repository rule that will handle multiple different nuget packages in one rule.
- Building csproj and sln files for VS and MonoDevelop.
- Windows .NET framwork support

<a name="csharp_library"></a>
## csharp_library

```python
csharp_library(name, srcs, deps, warn=4, csc)
```

Builds a C# .NET library and its corresponding documentation.

<table class="table table-condensed table-bordered table-params">
  <colgroup>
    <col class="col-param" />
    <col class="param-description" />
  </colgroup>
  <thead>
    <tr>
      <th colspan="2">Attributes</th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <td><code>name</code></td>
      <td>
        <p><code>Name, required</code></p>
        <p>Unique name for this rule</p>
      </td>
    </tr>
    <tr>
      <td><code>srcs</code></td>
      <td>
        <p><code>List of Labels; required</code></p>
        <p>Csharp .cs or .resx files.</p>
      </td>
    </tr>
    <tr>
      <td><code>deps</code></td>
      <td>
        <p><code>List of Labels; optional</code></p>
        <p>Dependencies for this rule.</p>
      </td>
    </tr>
    <tr>
      <td><code>warn</code></td>
      <td>
        <p><code>Int; optional; default is 4</code></p>
        <p>Compiler warn level for this library. (Defaults to 4.)</p>
      </td>
    </tr>
    <tr>
      <td><code>csc</code></td>
      <td>
        <p><code>string; optional</code></p>
        <p>Override the default csharp compiler.</p>
        <p>
          <strong>Note:</strong> This attribute may removed in future
          versions.
        </p>
      </td>
    </tr>
  </tbody>
</table>

<a name="csharp_binary"></a>
## csharp_binary

```python
csharp_binary(name, srcs, deps, main_class, warn=4, csc)
```

Builds a C# .NET binary.

<table class="table table-condensed table-bordered table-params">
  <colgroup>
    <col class="col-param" />
    <col class="param-description" />
  </colgroup>
  <thead>
    <tr>
      <th colspan="2">Attributes</th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <td><code>name</code></td>
      <td>
        <p><code>Name, required</code></p>
        <p>Unique name for this rule</p>
      </td>
    </tr>
    <tr>
      <td><code>srcs</code></td>
      <td>
        <p><code>List of Labels; required</code></p>
        <p>Csharp .cs or .resx files.</p>
      </td>
    </tr>
    <tr>
      <td><code>deps</code></td>
      <td>
        <p><code>List of Labels; optional</code></p>
        <p>Dependencies for this rule.</p>
      </td>
    </tr>
    <tr>
      <td><code>main_class</code></td>
      <td>
        <p><code>String; optional</code>
        <p>Name of class with <code>main()</code> method to use as entry point.</p>
      </td>
    </tr>
    <tr>
      <td><code>warn</code></td>
      <td>
        <p><code>Int; optional; default is 4</code></p>
        <p>Compiler warn level for this binary. (Defaults to 4.)</p>
      </td>
    </tr>
    <tr>
      <td><code>csc</code></td>
      <td>
        <p><code>string; optional</code></p>
        <p>Override the default csharp compiler.</p>
        <p>
          <strong>Note:</strong> This attribute may removed in future
          versions.
        </p>
      </td>
    </tr>
  </tbody>
</table>

<a name="csharp_nunit_test"></a>
## csharp\_nunit\_test

```python
csharp_nunit_test(name, srcs, deps, warn=4, csc)
```

Builds a C# .NET test binary that uses the [NUnit](http://www.nunit.org/) unit
testing framework.

<table class="table table-condensed table-bordered table-params">
  <colgroup>
    <col class="col-param" />
    <col class="param-description" />
  </colgroup>
  <thead>
    <tr>
      <th colspan="2">Attributes</th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <td><code>name</code></td>
      <td>
        <p><code>Name, required</code></p>
        <p>Unique name for this rule</p>
      </td>
    </tr>
    <tr>
      <td><code>srcs</code></td>
      <td>
        <p><code>List of Labels; required</code></p>
        <p>Csharp .cs or .resx files.</p>
      </td>
    </tr>
    <tr>
      <td><code>deps</code></td>
      <td>
        <p><code>List of Labels; optional</code></p>
        <p>Dependencies for this rule.</p>
      </td>
    </tr>
    <tr>
      <td><code>warn</code></td>
      <td>
        <p><code>Int; optional; default is 4</code></p>
        <p>Compiler warn level for this test. (Defaults to 4.)</p>
      </td>
    </tr>
    <tr>
      <td><code>csc</code></td>
      <td>
        <p><code>string; optional</code></p>
        <p>Override the default csharp compiler.</p>
        <p>
          <strong>Note:</strong> This attribute may removed in future
          versions.
        </p>
      </td>
    </tr>
  </tbody>
</table>

<a name="nuget_package"></a>
## nuget\_package

```python
nuget_package(name, package, version, package_sources)
```

A repository_rule that adds a nuget package dependency for the Workspace.


<table class="table table-condensed table-bordered table-params">
  <colgroup>
    <col class="col-param" />
    <col class="param-description" />
  </colgroup>
  <thead>
    <tr>
      <th colspan="2">Attributes</th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <td><code>name</code></td>
      <td>
        <p><code>Name, required</code></p>
        <p>Unique name for this rule</p>
      </td>
    <tr>
      <td><code>package</code></td>
      <td>
        <p><code>String, Required</code></p>
        <p>Name of the nuget package.</p>
      </td>
    </tr>
    <tr>
      <td><code>version</code></td>
      <td>
        <p><code>String, Required</code></p>
        <p>Version of the nuget package to install.</p>
      </td>
    </tr>
    <tr>
      <td><code>package\_sources</code></td>
      <td>
        <p><code>List of strings, optional</code></p>
        <p>Sources to pull nuget packages from. Either url or path.</p>
      </td>
    </tr>
  </tbody>
</table>

```python
dll_import(name, srcs)
```

A repository_rule that adds a nuget package dependency for the Workspace.


<table class="table table-condensed table-bordered table-params">
  <colgroup>
    <col class="col-param" />
    <col class="param-description" />
  </colgroup>
  <thead>
    <tr>
      <th colspan="2">Attributes</th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <td><code>name</code></td>
      <td>
        <p><code>Name, required</code></p>
        <p>Unique name for this rule</p>
      </td>
    <tr>
    <tr>
      <td><code>srcs</code></td>
      <td>
        <p><code>Labels, required</code></p>
        <p>List of dotnet dll assemblies to use.</p>
      </td>
    <tr>
  </tbody>
</table>
