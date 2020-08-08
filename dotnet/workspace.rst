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
.. _nuget2bazel: /tools/nuget2bazel/README.rst

.. role:: param(literal)
.. role:: type(emphasis)
.. role:: value(code)
.. |mandatory| replace:: **mandatory value**

Workspace rules are either repository rules, or macros that are intended to be used from the
WORKSPACE file.

See also the toolchains_ rules, which contains the dotnet_register_toolchains_
workspace rule.

.. contents:: :depth: 1

-----


.. _dotnet_repositories:

dotnet_repositories
~~~~~~~~~~~~~~~~~~~

Fetches remote repositories required before loading other rules_dotnet files. It fetches basic dependencies.

For example: bazel_skylib is loaded.

dotnet_repositories_nugets
~~~~~~~~~~~~~~~~~~~~~~~~~~

Fetches nuget repositories required by rules.


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
| :param:`sha256`            | :type:`string`              | :value:`None`                                 |
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
| :param:`sha256`            | :type:`string`              | :value:`None`                                 |
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
    
    net_gac2(
        name = "Microsoft.VisualStudio.QualityTools.UnitTestFramework",
        version = "10.1.0.0",
        token = "b03f5f7f11d50a3a"
    )

    net_gac4(
        name = "System.ComponentModel.DataAnnotations",
        version = "4.0.0.0",
        token = "31bf3856ad364e35"
    )
    
    vs2017_ref_net(name = "vs_ref_2017")
        """
    )

nuget_package
~~~~~~~~~~~~~

Repository rule to download and extract nuget package. The rule is usually generated by nuget2bazel_ tool. 


Attributes
^^^^^^^^^^

+----------------------------+------------------------------+------------------------------------------------+
| **Name**                   | **Type**                     | **Default value**                              |
| :param:`name`              | :type:`string`               | |mandatory|                                    |
+----------------------------+------------------------------+------------------------------------------------+
| A unique name for this rule.                                                                               |
+----------------------------+------------------------------+------------------------------------------------+
| :param:`source`            | :type:`list of string`       | :value:`[https://www.nuget.org/api/v2/package`]|
+----------------------------+------------------------------+------------------------------------------------+
| The nuget base url for downloading the package. The final url is in the format                             |
| {source}/{package}/{version}.                                                                              |
+----------------------------+------------------------------+------------------------------------------------+
| :param:`package`           | :type:`string`               | |mandatory|                                    |
+----------------------------+------------------------------+------------------------------------------------+
| The nuget package name                                                                                     | 
+----------------------------+------------------------------+------------------------------------------------+
| :param:`version`           | :type:`string`               | |mandatory|                                    |
+----------------------------+------------------------------+------------------------------------------------+
| The nuget package version.                                                                                 | 
+----------------------------+------------------------------+------------------------------------------------+
| :param:`sha256`            | :type:`string`               | :value:`None`                                  |
+----------------------------+------------------------------+------------------------------------------------+
| The nuget package sha256 digest.                                                                           | 
+----------------------------+------------------------------+------------------------------------------------+
| :param:`core_lib`          | :type:`string`               | |mandatory|                                    |
+----------------------------+------------------------------+------------------------------------------------+
| The path to .net core assembly within the nuget package                                                    | 
+----------------------------+------------------------------+------------------------------------------------+
| :param:`net_lib`           | :type:`string`               | |mandatory|                                    |
+----------------------------+------------------------------+------------------------------------------------+
| The path to .net assembly within the nuget package                                                         | 
+----------------------------+------------------------------+------------------------------------------------+
| :param:`mono_lib`          | :type:`string`               | |mandatory|                                    |
+----------------------------+------------------------------+------------------------------------------------+
| The path to mono assembly within the nuget package                                                         | 
+----------------------------+------------------------------+------------------------------------------------+
| :param:`core_tool`         | :type:`string`               | |mandatory|                                    |
+----------------------------+------------------------------+------------------------------------------------+
| The path to .net core assembly within the nuget package (tools subdirectory)                               | 
+----------------------------+------------------------------+------------------------------------------------+
| :param:`net_tool`          | :type:`string`               | |mandatory|                                    |
+----------------------------+------------------------------+------------------------------------------------+
| The path to .net assembly within the nuget package (tools subdirectory)                                    | 
+----------------------------+------------------------------+------------------------------------------------+
| :param:`mono_tool`         | :type:`string`               | |mandatory|                                    |
+----------------------------+------------------------------+------------------------------------------------+
| The path to mono assembly within the nuget package (tools subdirectory)                                    | 
+----------------------------+------------------------------+------------------------------------------------+
| :param:`core_deps`         | :type:`list of DotnetLibrary`| :value:`None`                                  |
+----------------------------+------------------------------+------------------------------------------------+
| The list of the dependencies of the package (core)                                                         | 
+----------------------------+------------------------------+------------------------------------------------+
| :param:`net_deps`          | :type:`list of DotnetLibrary`| :value:`None`                                  |
+----------------------------+------------------------------+------------------------------------------------+
| The list of the dependencies of the package (net)                                                          | 
+----------------------------+------------------------------+------------------------------------------------+
| :param:`mono_deps`         | :type:`list of DotnetLibrary`| :value:`None`                                  |
+----------------------------+------------------------------+------------------------------------------------+
| The list of the dependencies of the package (mono)                                                         | 
+----------------------------+------------------------------+------------------------------------------------+
| :param:`core_files`        | :type:`list of string`       | :value:`None`                                  |
+----------------------------+------------------------------+------------------------------------------------+
| The list of additional files within the package to be used as runfiles (necessary to run) (core)           | 
+----------------------------+------------------------------+------------------------------------------------+
| :param:`net_files`         | :type:`list of string`       | :value:`None`                                  |
+----------------------------+------------------------------+------------------------------------------------+
| The list of additional files within the package to be used as runfiles (necessary to run) (net)            | 
+----------------------------+------------------------------+------------------------------------------------+
| :param:`mono_files`        | :type:`list of string`       | :value:`None`                                  |
+----------------------------+------------------------------+------------------------------------------------+
| The list of additional files within the package to be used as runfiles (necessary to run) (mono)           | 
+----------------------------+------------------------------+------------------------------------------------+


Example
^^^^^^^

.. code:: python

    nuget_package(
        name = "commandlineparser",
        package = "commandlineparser",
        sha256 = "09e60ff23e6953b4fe7d267ef552d8ece76404acf44842012f84430e8b877b13",
        core_lib = "lib/netstandard1.5/CommandLine.dll",
        net_lib = "lib/net45/CommandLine.dll",
        mono_lib = "lib/net45/CommandLine.dll",
        core_deps = [
            "@io_bazel_rules_dotnet//dotnet/stdlib.core:system.collections.dll",
            "@io_bazel_rules_dotnet//dotnet/stdlib.core:system.console.dll",
            "@io_bazel_rules_dotnet//dotnet/stdlib.core:system.diagnostics.debug.dll",
            "@io_bazel_rules_dotnet//dotnet/stdlib.core:system.globalization.dll",
            "@io_bazel_rules_dotnet//dotnet/stdlib.core:system.io.dll",
            "@io_bazel_rules_dotnet//dotnet/stdlib.core:system.linq.dll",
            "@io_bazel_rules_dotnet//dotnet/stdlib.core:system.linq.expressions.dll",
            "@io_bazel_rules_dotnet//dotnet/stdlib.core:system.reflection.dll",
            "@io_bazel_rules_dotnet//dotnet/stdlib.core:system.reflection.extensions.dll",
            "@io_bazel_rules_dotnet//dotnet/stdlib.core:system.reflection.typeextensions.dll",
            "@io_bazel_rules_dotnet//dotnet/stdlib.core:system.resources.resourcemanager.dll",
            "@io_bazel_rules_dotnet//dotnet/stdlib.core:system.runtime.dll",
            "@io_bazel_rules_dotnet//dotnet/stdlib.core:system.runtime.extensions.dll",
        ],
        net_deps = [
            "@io_bazel_rules_dotnet//dotnet/stdlib.core:system.collections.dll",
            "@io_bazel_rules_dotnet//dotnet/stdlib.core:system.console.dll",
            "@io_bazel_rules_dotnet//dotnet/stdlib.core:system.diagnostics.debug.dll",
            "@io_bazel_rules_dotnet//dotnet/stdlib.core:system.globalization.dll",
            "@io_bazel_rules_dotnet//dotnet/stdlib.core:system.io.dll",
            "@io_bazel_rules_dotnet//dotnet/stdlib.core:system.linq.dll",
            "@io_bazel_rules_dotnet//dotnet/stdlib.core:system.linq.expressions.dll",
            "@io_bazel_rules_dotnet//dotnet/stdlib.core:system.reflection.dll",
            "@io_bazel_rules_dotnet//dotnet/stdlib.core:system.reflection.extensions.dll",
            "@io_bazel_rules_dotnet//dotnet/stdlib.core:system.reflection.typeextensions.dll",
            "@io_bazel_rules_dotnet//dotnet/stdlib.core:system.resources.resourcemanager.dll",
            "@io_bazel_rules_dotnet//dotnet/stdlib.core:system.runtime.dll",
            "@io_bazel_rules_dotnet//dotnet/stdlib.core:system.runtime.extensions.dll",
        ],
        mono_deps = [
            "@io_bazel_rules_dotnet//dotnet/stdlib.core:system.collections.dll",
            "@io_bazel_rules_dotnet//dotnet/stdlib.core:system.console.dll",
            "@io_bazel_rules_dotnet//dotnet/stdlib.core:system.diagnostics.debug.dll",
            "@io_bazel_rules_dotnet//dotnet/stdlib.core:system.globalization.dll",
            "@io_bazel_rules_dotnet//dotnet/stdlib.core:system.io.dll",
            "@io_bazel_rules_dotnet//dotnet/stdlib.core:system.linq.dll",
            "@io_bazel_rules_dotnet//dotnet/stdlib.core:system.linq.expressions.dll",
            "@io_bazel_rules_dotnet//dotnet/stdlib.core:system.reflection.dll",
            "@io_bazel_rules_dotnet//dotnet/stdlib.core:system.reflection.extensions.dll",
            "@io_bazel_rules_dotnet//dotnet/stdlib.core:system.reflection.typeextensions.dll",
            "@io_bazel_rules_dotnet//dotnet/stdlib.core:system.resources.resourcemanager.dll",
            "@io_bazel_rules_dotnet//dotnet/stdlib.core:system.runtime.dll",
            "@io_bazel_rules_dotnet//dotnet/stdlib.core:system.runtime.extensions.dll",
        ],
        core_files = [
            "lib/netstandard1.5/CommandLine.dll",
            "lib/netstandard1.5/CommandLine.xml",
        ],
        net_files = [
            "lib/net45/CommandLine.dll",
            "lib/net45/CommandLine.XML",
        ],
        mono_files = [
            "lib/net45/CommandLine.dll",
            "lib/net45/CommandLine.XML",
        ],
        )

        dotnet_import_library(
            name = "npgsqllib",
            src = "lib/net451/Npgsql.dll"
        )
        
        net_gac2(
            name = "Microsoft.VisualStudio.QualityTools.UnitTestFramework",
            version = "10.1.0.0",
            token = "b03f5f7f11d50a3a"
    )

    net_gac4(
        name = "System.ComponentModel.DataAnnotations",
        version = "4.0.0.0",
        token = "31bf3856ad364e35"
    )
    
    vs2017_ref_net(name = "vs_ref_2017")
        """
    )
