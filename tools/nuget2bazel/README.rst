nuget2bazel
===========

.. All external links are here
.. _Bazel: https://bazel.build/
.. _nuget_package: /dotnet/workspace.rst#nuget_package
.. ;;

Introduction
------------

Nuget packages often depend on other Nuget packages. By design, Bazel is not able to determine Nuget dependencies at run time. 
That's why a special tool is needed to extract those dependencies and list them directly. 

Moreover, Nuget packages are often built using different versions of the framework. Please take into consideration 
`runtime limitations <../../docs/runtime.rst>`_.

The tool
--------

The tool is used to generate rules_bazel compatible workspace rules for nuget packages: nuget_package_.
The tool maintains the list of installed packages in package.json and appropriate rules in WORKSPACE file.
Sample usage:

  .. code:: bash

    bazel run //tools/nuget2bazel:nuget2bazel.exe -- add -p c:/rules_dotnet ninject 3.3.0

    bazel run //tools/nuget2bazel:nuget2bazel.exe -- delete -p c:/rules_dotnet ninject 

By default the tool modifies WORKSPACE file in the provided directory with proper directives.

However, typically it is more convenient to modify .bzl file to declare dependencies 
in a separate function called in WORKSPACE. See for example `nuget.bzl <../../dotnet/private/deps/nuget.bat>`_.

To use custom nuget packages source two additional flags have to be provided:

  .. code:: bash

    bazel run //tools/nuget2bazel:nuget2bazel.exe -- add -p c:/rules_dotnet -u -n https://dotnet.myget.org/F/dotnet-corefxlab/api/v3/index.json System.Buffers.Primitives 0.1.2-e200127-1

  The flag '-n' provides the url for the repository. The nuget2bazel tools respects additional sources provided in %APPDATA%/nuget/nuget.config.

  The flag '-u' instructs the tool to generate the nuget_package rules with additional variable set: "source = source". This makes possible to provide additional to default nuget sources:

  .. code:: python

    source = ["https://www.nuget.org/api/v2/package", "https://dotnet.myget.org/F/dotnet-corefxlab/api/v2/package"]
    nuget_package(
        name = "system.buffers.primitives",
        package = "system.buffers.primitives",
        version = "0.1.2-e200127-1",
        sha256 = "47a5d3971de3d2f77beeec7421bf2d7414cfd3f3fa34147b836da58e50bd7213",
        source = source,
    ...

  Please note that the URLs provided in the source variable are not the URLs to index.json API endpoint. These are URLs for downloading the files by adding package name and version number.