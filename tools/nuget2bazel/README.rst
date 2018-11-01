nuget2bazel
===========

.. All external links are here
.. _Bazel: https://bazel.build/
.. _nuget_package: /dotnet/workspace.rst#nuget_package
.. ;;

Documentation
-------------

The tool is used to generate rules_bazel compatible workspace rules for nuget packages: nuget_package_.
The tool maintains the list of installed packages in package.json and appropriate rules in WORKSPACE file.
Sample usage:

  .. code:: bash

    bazel run //tools/nuget2bazel -- add -p c:/rules_dotnet ninject 3.3.0

    bazel run //tools/nuget2bazel -- delete -p c:/rules_dotnet ninject 

