Core dotnet rules
=================

.. _test_filter: https://docs.bazel.build/versions/master/user-manual.html#flag--test_filter
.. _test_arg: https://docs.bazel.build/versions/master/user-manual.html#flag--test_arg
.. _DotnetLibrary: providers.rst#DotnetLibrary
.. _DotnetResource: providers.rst#DotnetResource
.. _"Make variable": https://docs.bazel.build/versions/master/be/make-variables.html
.. _Bourne shell tokenization: https://docs.bazel.build/versions/master/be/common-definitions.html#sh-tokenization
.. _data dependencies: https://docs.bazel.build/versions/master/build-ref.html#data
.. _shard_count: https://docs.bazel.build/versions/master/be/common-definitions.html#test.shard_count
.. _build constraints: https://golang.org/pkg/go/build/#hdr-Build_Constraints
.. _select: https://docs.bazel.build/versions/master/be/functions.html#select
.. _config_setting: https://docs.bazel.build/versions/master/be/general.html#config_setting
.. _dotnet_nuget_new: workspace.rst#dotnet_nuget_new

.. role:: param(literal)
.. role:: type(emphasis)
.. role:: value(code)
.. |mandatory| replace:: **mandatory value**

These are the core dotnet rules, required for basic operation.
The intent is that theses rules are sufficient to match the capabilities of the normal dotnet tools.

.. contents:: :depth: 2

-----

API
---

dotnet_library, core_library, net_library
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

This builds a dotnet assembly from a set of source files. The rule generates assebly respectively
for Mono, .NET Core and .NET.

Providers
^^^^^^^^^

* DotnetLibrary_
* DotnetResource_

Attributes
^^^^^^^^^^

+----------------------------+-----------------------------+---------------------------------------+
| **Name**                   | **Type**                    | **Default value**                     |
+----------------------------+-----------------------------+---------------------------------------+
| :param:`name`              | :type:`string`              | |mandatory|                           |
+----------------------------+-----------------------------+---------------------------------------+
| A unique name for this rule.                                                                     |
+----------------------------+-----------------------------+---------------------------------------+
| :param:`deps`              | :type:`label_list`          | :value:`None`                         |
+----------------------------+-----------------------------+---------------------------------------+
| The direct dependencies of this library.                                                         |
| These may be dotnet_library rules or compatible rules with the DotnetLibrary_ provider.          |
+----------------------------+-----------------------------+---------------------------------------+
| :param:`resources`         | :type:`label_list`          | :value:`None`                         |
+----------------------------+-----------------------------+---------------------------------------+
| The list of resources to compile with. Usually provided via reference to dotnet_resx_            |
| or the rules compatible with DotnetResource_ provider                                            |
+----------------------------+-----------------------------+---------------------------------------+
| :param:`srcs`              | :type:`label_list`          | :value:`None`                         |
+----------------------------+-----------------------------+---------------------------------------+
| The list of .cs source files that are compiled to create the assembly.                           |
| Only :value:`.cs` files are permitted                                                            |
+----------------------------+-----------------------------+---------------------------------------+
| :param:`out`               | :type:`string`              | :value:`""`                           |
+----------------------------+-----------------------------+---------------------------------------+
| An alternative name of the output file                                                           |
+----------------------------+-----------------------------+---------------------------------------+
| :param:`defines`           | :type:`string_list`         | :value:`None`                         |
+----------------------------+-----------------------------+---------------------------------------+
| The list of defines passed via /define compiler option                                           |
+----------------------------+-----------------------------+---------------------------------------+
| :param:`unsafe`            | :type:`bool`                | :value:`False`                        |
+----------------------------+-----------------------------+---------------------------------------+
| If true passes /unsafe flag to the compiler                                                      |
+----------------------------+-----------------------------+---------------------------------------+
| :param:`data`              | :type:`label_list`          | :value:`None`                         |
+----------------------------+-----------------------------+---------------------------------------+
| The list of additional files to include in the list of runfiles for compile assembly             |
+----------------------------+-----------------------------+---------------------------------------+

Example
^^^^^^^

.. code:: python

  dotnet_library(
      name = "foo_bar",
      srcs = [
          "foo.cs",
          "bar.cs",
      ],
      deps = [
          "//examples/example_lib:MyClass",
          "@npgsql//:npgsqllib",
      ],
      visibility = ["//visibility:public"],
  )

dotnet_binary, net_binary, core_binary
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

This builds an executable from a set of source files (respectively for Mono, .NET and .NET Core).
You can run the binary with ``bazel run``, or you can
build it with ``bazel build`` and run it directly.


Providers
^^^^^^^^^

* DotnetLibrary_
* DotnetResource_

Attributes
^^^^^^^^^^

+----------------------------+-----------------------------+---------------------------------------+
| **Name**                   | **Type**                    | **Default value**                     |
+----------------------------+-----------------------------+---------------------------------------+
| :param:`name`              | :type:`string`              | |mandatory|                           |
+----------------------------+-----------------------------+---------------------------------------+
| A unique name for this rule.                                                                     |
+----------------------------+-----------------------------+---------------------------------------+
| :param:`deps`              | :type:`label_list`          | :value:`None`                         |
+----------------------------+-----------------------------+---------------------------------------+
| The direct dependencies of this library.                                                         |
| These may be dotnet_library rules or compatible rules with the DotnetLibrary_ provider.          |
+----------------------------+-----------------------------+---------------------------------------+
| :param:`resources`         | :type:`label_list`          | :value:`None`                         |
+----------------------------+-----------------------------+---------------------------------------+
| The list of resources to compile with. Usually provided via reference to dotnet_resx_            |
| or the rules compatible with DotnetResource_ provider                                            |
+----------------------------+-----------------------------+---------------------------------------+
| :param:`srcs`              | :type:`label_list`          | :value:`None`                         |
+----------------------------+-----------------------------+---------------------------------------+
| The list of .cs source files that are compiled to create the assembly.                           |
| Only :value:`.cs` files are permitted                                                            |
+----------------------------+-----------------------------+---------------------------------------+
| :param:`out`               | :type:`string`              | :value:`""`                           |
+----------------------------+-----------------------------+---------------------------------------+
| An alternative name of the output file                                                           |
+----------------------------+-----------------------------+---------------------------------------+
| :param:`defines`           | :type:`string_list`         | :value:`None`                         |
+----------------------------+-----------------------------+---------------------------------------+
| The list of defines passed via /define compiler option                                           |
+----------------------------+-----------------------------+---------------------------------------+
| :param:`unsafe`            | :type:`bool`                | :value:`False`                        |
+----------------------------+-----------------------------+---------------------------------------+
| If true passes /unsafe flag to the compiler                                                      |
+----------------------------+-----------------------------+---------------------------------------+
| :param:`data`              | :type:`label_list`          | :value:`None`                         |
+----------------------------+-----------------------------+---------------------------------------+
| The list of additional files to be included as runfiles for the generated executable             |
+----------------------------+-----------------------------+---------------------------------------+

Example
^^^^^^^

.. code:: python

  dotnet_binary(
      name = "foo_bar",
      srcs = [
          "foo.cs",
          "bar.cs",
      ],
      deps = [
          "//examples/example_lib:MyClass",
          "@npgsql//:npgsqllib",
      ],
      visibility = ["//visibility:public"],
  )

dotnet_nunit_test
~~~~~~~~~~~~~~~~~

This builds a set of tests that can be run with ``bazel test``.
Currently it uses nunit2.

To run all tests in the workspace, and print output on failure, run

::

  bazel test --test_output=errors //...

You can run specific tests by passing the `--test_filter=pattern <test_filter_>`_ argument to Bazel.
You can pass arguments to tests by passing `--test_arg=arg <test_arg_>`_ arguments to Bazel.


Attributes
^^^^^^^^^^

+----------------------------+-----------------------------+---------------------------------------+
| **Name**                   | **Type**                    | **Default value**                     |
+----------------------------+-----------------------------+---------------------------------------+
| :param:`name`              | :type:`string`              | |mandatory|                           |
+----------------------------+-----------------------------+---------------------------------------+
| A unique name for this rule.                                                                     |
+----------------------------+-----------------------------+---------------------------------------+
| :param:`deps`              | :type:`label_list`          | :value:`None`                         |
+----------------------------+-----------------------------+---------------------------------------+
| The direct dependencies of this library.                                                         |
| These may be dotnet_library rules or compatible rules with the DotnetLibrary_ provider.          |
+----------------------------+-----------------------------+---------------------------------------+
| :param:`resources`         | :type:`label_list`          | :value:`None`                         |
+----------------------------+-----------------------------+---------------------------------------+
| The list of resources to compile with. Usually provided via reference to dotnet_resx_            |
| or the rules compatible with DotnetResource_ provider                                            |
+----------------------------+-----------------------------+---------------------------------------+
| :param:`srcs`              | :type:`label_list`          | :value:`None`                         |
+----------------------------+-----------------------------+---------------------------------------+
| The list of .cs source files that are compiled to create the assembly.                           |
| Only :value:`.cs` files are permitted                                                            |
+----------------------------+-----------------------------+---------------------------------------+
| :param:`out`               | :type:`string`              | :value:`""`                           |
+----------------------------+-----------------------------+---------------------------------------+
| An alternative name of the output file                                                           |
+----------------------------+-----------------------------+---------------------------------------+
| :param:`defines`           | :type:`string_list`         | :value:`None`                         |
+----------------------------+-----------------------------+---------------------------------------+
| The list of defines passed via /define compiler option                                           |
+----------------------------+-----------------------------+---------------------------------------+


Test example
^^^^^^^^^^^^

.. code:: python

    dotnet_nunit_test(
        name = "MyTest",
        srcs = [
            "MyTest.cs",
        ],
        deps = [
            "//examples/example_lib:MyClass",
            "@nunit2//:nunit.framework",
        ],
    )


dotnet_resx
~~~~~~~~~~~

This builds a dotnet .resources file from a single .resx file.

Providers
^^^^^^^^^

* DotnetResource_

Attributes
^^^^^^^^^^

+----------------------------+-----------------------------+---------------------------------------+
| **Name**                   | **Type**                    | **Default value**                     |
+----------------------------+-----------------------------+---------------------------------------+
| :param:`name`              | :type:`string`              | |mandatory|                           |
+----------------------------+-----------------------------+---------------------------------------+
| A unique name for this rule.                                                                     |
+----------------------------+-----------------------------+---------------------------------------+
| :param:`src`               | :type:`label`               | |mandatory|                           |
+----------------------------+-----------------------------+---------------------------------------+
| The .resx source file that is transformed into .resources file.                                  |
| Only :value:`.resx` files are permitted                                                          |
+----------------------------+-----------------------------+---------------------------------------+
| :param:`identifer`         | :type:`string`              | :value:`""`                           |
+----------------------------+-----------------------------+---------------------------------------+
| The logical name for the resource; the name that is used to load the resource.                   |
| The default is the basename of the file name (no subfolder).                                     |
+----------------------------+-----------------------------+---------------------------------------+
| :param:`out`               | :type:`string`              | :value:`""`                           |
+----------------------------+-----------------------------+---------------------------------------+
| An alternative name of the output file                                                           |
+----------------------------+-----------------------------+---------------------------------------+

Example
^^^^^^^

.. code:: python

    dotnet_resx(
        name = "Transform",
        src = ":src/ClientUtilities/util/Transform.resx",
    )


dotnet_import_library, core_import_library, net_import_library, dotnet_import_binary, core_import_binary, net_import_binary
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

This imports an external dll and transforms it into DotnetLibrary_ so it can be referenced
as dependency by other rules. Often used with dotnet_nuget_new_. 

Providers
^^^^^^^^^

* DotnetLibrary_

Attributes
^^^^^^^^^^

+----------------------------+-----------------------------+---------------------------------------+
| **Name**                   | **Type**                    | **Default value**                     |
+----------------------------+-----------------------------+---------------------------------------+
| :param:`name`              | :type:`string`              | |mandatory|                           |
+----------------------------+-----------------------------+---------------------------------------+
| A unique name for this rule.                                                                     |
+----------------------------+-----------------------------+---------------------------------------+
| :param:`deps`              | :type:`label_list`          | :value:`None`                         |
+----------------------------+-----------------------------+---------------------------------------+
| The direct dependencies of this dll.                                                             |
| These may be dotnet_library rules or compatible rules with the DotnetLibrary_ provider.          |
+----------------------------+-----------------------------+---------------------------------------+
| :param:`src`               | :type:`label`               | |mandatory|                           |
+----------------------------+-----------------------------+---------------------------------------+
| The file to be transformed into DotnetLibrary_ provider                                          |
+----------------------------+-----------------------------+---------------------------------------+

Example
^^^^^^^
See dotnet_nuget_new_.


