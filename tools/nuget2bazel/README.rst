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

    bazel run //tools/nuget2bazel -- add -p c:/rules_dotnet ninject 3.3.0

    bazel run //tools/nuget2bazel -- delete -p c:/rules_dotnet ninject 


