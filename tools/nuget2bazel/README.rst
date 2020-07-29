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
