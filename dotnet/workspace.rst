Dotnet workspace rules
======================

.. _dotnet_library: core.rst#dotnet_library
.. _toolchains: toolchains.rst
.. _dotnet_register_toolchains: toolchains.rst#dotnet_register_toolchains
.. _dotnet_toolchain: toolchains.rst#dotnet_toolchain
.. _http_archive: https://docs.bazel.build/versions/master/be/workspace.html#http_archive
.. _git_repository: https://docs.bazel.build/versions/master/be/workspace.html#git_repository
.. _nested workspaces: https://bazel.build/designs/2016/09/19/recursive-ws-parsing.html
.. _dotnet_import_library: core.rst#dotnet_import_library

.. role:: param(kbd)
.. role:: type(emphasis)
.. role:: value(code)
.. |mandatory| replace:: **mandatory value**

Workspace rules are either repository rules, or macros that are intended to be used from the
WORKSPACE file.

See also the toolchains_ rules, which contains the dotnet_register_toolchains_
workspace rule.

.. contents:: :depth: 1

-----


dotnet_repositories
~~~~~~~~~~~~~~~~~~~

Fetches remote repositories required by dotnet rules.

dotnet_nuget
~~~~~~~~~~~~

A simple repository rule to download and extract nuget package. Using dotnet_nuget_new_ is usually 
a better idea.


Attributes
^^^^^^^^^^

+----------------------------+-----------------------------+-----------------------------------------------+
| **Name**                   | **Type**                    | **Default value**                             |
+----------------------------+-----------------------------+-----------------------------------------------+
| :param:`name`              | :type:`string`              | |mandatory|                                   |
+----------------------------+-----------------------------+-----------------------------------------------+
| A unique name for this rule.                                                                             |
+----------------------------+-----------------------------+-----------------------------------------------+
| :param:`source`            | :type:`string`              | :value:`https://www.nuget.org/api/v2/package` |
+----------------------------+-----------------------------+-----------------------------------------------+
| The nuget base url for downloading the package. The final url is in the format                           | 
| {source}/{package}/{version}.                                                                            |
+----------------------------+-----------------------------+-----------------------------------------------+
| :param:`package`           | :type:`string`              | |mandatory|                                   |
+----------------------------+-----------------------------+-----------------------------------------------+
| The nuget package name                                                                                   | 
+----------------------------+-----------------------------+-----------------------------------------------+
| :param:`version`           | :type:`string`              | |mandatory|                                   |
+----------------------------+-----------------------------+-----------------------------------------------+
| The nuget package version.                                                                               | 
+----------------------------+-----------------------------+-----------------------------------------------+
| :param:`sha256`            | :type:`string`              | |mandatory|                                   |
+----------------------------+-----------------------------+-----------------------------------------------+
| The nuget package sha256 digest.                                                                         | 
+----------------------------+-----------------------------+-----------------------------------------------+


dotnet_nuget_new
~~~~~~~~~~~~~~~~

Repository rule to download and extract nuget package. Usually used with dotnet_import_library_. 


Attributes
^^^^^^^^^^

+----------------------------+-----------------------------+-----------------------------------------------+
| **Name**                   | **Type**                    | **Default value**                             |
+----------------------------+-----------------------------+-----------------------------------------------+
| :param:`name`              | :type:`string`              | |mandatory|                                   |
+----------------------------+-----------------------------+-----------------------------------------------+
| A unique name for this rule.                                                                             |
+----------------------------+-----------------------------+-----------------------------------------------+
| :param:`source`            | :type:`string`              | :value:`https://www.nuget.org/api/v2/package` |
+----------------------------+-----------------------------+-----------------------------------------------+
| The nuget base url for downloading the package. The final url is in the format                           | 
| {source}/{package}/{version}.                                                                            |
+----------------------------+-----------------------------+-----------------------------------------------+
| :param:`package`           | :type:`string`              | |mandatory|                                   |
+----------------------------+-----------------------------+-----------------------------------------------+
| The nuget package name                                                                                   | 
+----------------------------+-----------------------------+-----------------------------------------------+
| :param:`version`           | :type:`string`              | |mandatory|                                   |
+----------------------------+-----------------------------+-----------------------------------------------+
| The nuget package version.                                                                               | 
+----------------------------+-----------------------------+-----------------------------------------------+
| :param:`sha256`            | :type:`string`              | |mandatory|                                   |
+----------------------------+-----------------------------+-----------------------------------------------+
| The nuget package sha256 digest.                                                                         | 
+----------------------------+-----------------------------+-----------------------------------------------+
| :param:`build_file`        | :type:`label`               | :value:`None`                                 |
+----------------------------+-----------------------------+-----------------------------------------------+
| The build file to link into downloaded nnuget package.                                                   | 
+----------------------------+-----------------------------+-----------------------------------------------+
| :param:`build_file_content`| :type:`string`              | :value:`""`                                   |
+----------------------------+-----------------------------+-----------------------------------------------+
| The build file content to put into downloaded nnuget package.                                            | 
+----------------------------+-----------------------------+-----------------------------------------------+

Example
^^^^^^^

.. code:: python

    dotnet_nuget_new(
        name = "npgsql", 
        package="Npgsql", 
        version="3.2.7", 
        sha256="fa3e0cfbb2caa9946d2ce3d8174031a06320aad2c9e69a60f7739b9ddf19f172",
        build_file_content = """
    package(default_visibility = [ "//visibility:public" ])
    load("@io_bazel_rules_dotnet//dotnet:defs.bzl", "dotnet_import_library")

    dotnet_import_library(
        name = "npgsqllib",
        src = "lib/net451/Npgsql.dll"
    )    
        """
    )
