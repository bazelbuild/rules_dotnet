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
| A unique name for this rule. It must have .dll extension.                                        |
+----------------------------+-----------------------------+---------------------------------------+
| :param:`deps`              | :type:`label_list`          | :value:`None`                         |
+----------------------------+-----------------------------+---------------------------------------+
| The direct dependencies of this library.                                                         |
| These may be dotnet_library rules or compatible rules with the DotnetLibrary_ provider.          |
+----------------------------+-----------------------------+---------------------------------------+
| :param:`resources`         | :type:`label_list`          | :value:`None`                         |
+----------------------------+-----------------------------+---------------------------------------+
| The list of resources to compile with. Usually provided via reference to dotnet_resx             |
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
| :param:`keyfile`           | :type:`label`               | :value:`None`                         |
+----------------------------+-----------------------------+---------------------------------------+
| The key to sign the assembly with.                                                               |
+----------------------------+-----------------------------+---------------------------------------+
| :param:`data`              | :type:`label_list`          | :value:`None`                         |
+----------------------------+-----------------------------+---------------------------------------+
| The list of additional files to include in the list of runfiles for compile assembly             |
+----------------------------+-----------------------------+---------------------------------------+

Example
^^^^^^^

.. code:: python

  dotnet_library(
      name = "foo_bar.dll",
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

  [core_library(
    name = "{}_TransitiveClass-core.dll".format(framework),
    srcs = [
        "TransitiveClass.cs",
    ],
    dotnet_context_data = "@io_bazel_rules_dotnet//:core_context_data_{}".format(framework),
    visibility = ["//visibility:public"],
    deps = [
        "@io_bazel_rules_dotnet//dotnet/stdlib.core/{}:system.private.corelib.dll".format(framework),
        "@io_bazel_rules_dotnet//dotnet/stdlib.core/{}:system.runtime.dll".format(framework),
    ],
  ) for framework in DOTNET_CORE_FRAMEWORKS]

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
| A unique name for this rule. It must have .exe extension.                                        |
+----------------------------+-----------------------------+---------------------------------------+
| :param:`deps`              | :type:`label_list`          | :value:`None`                         |
+----------------------------+-----------------------------+---------------------------------------+
| The direct dependencies of this library.                                                         |
| These may be dotnet_library rules or compatible rules with the DotnetLibrary_ provider.          |
+----------------------------+-----------------------------+---------------------------------------+
| :param:`resources`         | :type:`label_list`          | :value:`None`                         |
+----------------------------+-----------------------------+---------------------------------------+
| The list of resources to compile with. Usually provided via reference to dotnet_resx             |
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
| :param:`keyfile`           | :type:`label`               | :value:`None`                         |
+----------------------------+-----------------------------+---------------------------------------+
| The key to sign the assembly with.                                                               |
+----------------------------+-----------------------------+---------------------------------------+
| :param:`data`              | :type:`label_list`          | :value:`None`                         |
+----------------------------+-----------------------------+---------------------------------------+
| The list of additional files to be included as runfiles for the generated executable             |
+----------------------------+-----------------------------+---------------------------------------+

Example
^^^^^^^

.. code:: python

  dotnet_binary(
      name = "foo_bar.exe",
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

dotnet_nunit_test, net_nunit_test, net_nunit3_test, core_xunit_test, net_xunit_test, dotnet_xunit_test
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

This builds a set of tests that can be run with ``bazel test``.
'_nunit_' rules use NUnit2, '_nunit3_' rules use NUnit3, '_xunit_' rules use xunit.

To run all tests in the workspace, and print output on failure, run

::

  bazel test --test_output=errors //...

You can run specific tests by passing the `--test_filter=pattern <test_filter_>`_ argument to Bazel.
You can pass arguments to tests by passing `--test_arg=arg <test_arg_>`_ arguments to Bazel.


Attributes
^^^^^^^^^^

+----------------------------+-----------------------------+--------------------------------------------+
| **Name**                   | **Type**                    | **Default value**                          |
+----------------------------+-----------------------------+--------------------------------------------+
| :param:`name`              | :type:`string`              | |mandatory|                                |
+----------------------------+-----------------------------+--------------------------------------------+
| A unique name for this rule. It must have .dll extension.                                             |
+----------------------------+-----------------------------+--------------------------------------------+
| :param:`deps`              | :type:`label_list`          | :value:`None`                              |
+----------------------------+-----------------------------+--------------------------------------------+
| The direct dependencies of this library.                                                              |
| These may be dotnet_library rules or compatible rules with the DotnetLibrary_ provider.               |
+----------------------------+-----------------------------+--------------------------------------------+
| :param:`resources`         | :type:`label_list`          | :value:`None`                              |
+----------------------------+-----------------------------+--------------------------------------------+
| The list of resources to compile with. Usually provided via reference to dotnet_resx                  |
| or the rules compatible with DotnetResource_ provider                                                 |
+----------------------------+-----------------------------+--------------------------------------------+
| :param:`srcs`              | :type:`label_list`          | :value:`None`                              |
+----------------------------+-----------------------------+--------------------------------------------+
| The list of .cs source files that are compiled to create the assembly.                                |
| Only :value:`.cs` files are permitted                                                                 |
+----------------------------+-----------------------------+--------------------------------------------+
| :param:`out`               | :type:`string`              | :value:`""`                                |
+----------------------------+-----------------------------+--------------------------------------------+
| An alternative name of the output file                                                                |
+----------------------------+-----------------------------+--------------------------------------------+
| :param:`defines`           | :type:`string_list`         | :value:`None`                              |
+----------------------------+-----------------------------+--------------------------------------------+
| The list of defines passed via /define compiler option                                                |
+----------------------------+-----------------------------+--------------------------------------------+
| :param:`testlauncher`      | :type:`Label`               | :value:`<as required by unit framework>`   |
+----------------------------+-----------------------------+--------------------------------------------+
| The list of defines passed via /define compiler option                                                |
+----------------------------+-----------------------------+--------------------------------------------+


Test example
^^^^^^^^^^^^

.. code:: python

    dotnet_nunit_test(
        name = "MyTest.dll",
        srcs = [
            "MyTest.cs",
        ],
        deps = [
            "//examples/example_lib:MyClass",
            "@nunitv2//:netstandard1.0_net",
        ],
    )


dotnet_resx, net_resx, core_resx
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

This builds a dotnet .resources file from a single .resx file.

.NET Core version uses a custom tool to convert text .resx file to .resources files because no 
standard tool is provided.

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
| :param:`simpleresgen`      | :type:`Label`               | :value:`<as required>`                |
+----------------------------+-----------------------------+---------------------------------------+
| An alternative tool for generating resources file. It is used by .NET Core to use a custom       |
| //tools/simpleresgen tool                                                                        |
+----------------------------+-----------------------------+---------------------------------------+

Example
^^^^^^^

.. code:: python

    dotnet_resx(
        name = "Transform",
        src = ":src/ClientUtilities/util/Transform.resx",
    )


net_resx_multi
~~~~~~~~~~~~~~

This builds a dotnet .resources files from multiple .resx file (one for each).

Providers
^^^^^^^^^

* DotnetResource_

Attributes
^^^^^^^^^^

+-----------------------------+-----------------------------+---------------------------------------+
| **Name**                    | **Type**                    | **Default value**                     |
+-----------------------------+-----------------------------+---------------------------------------+
| :param:`name`               | :type:`string`              | |mandatory|                           |
+-----------------------------+-----------------------------+---------------------------------------+
| A unique name for this rule.                                                                      |
+-----------------------------+-----------------------------+---------------------------------------+
| :param:`srcs`               | :type:`label_list`          | |mandatory|                           |
+-----------------------------+-----------------------------+---------------------------------------+
| The source files to be embeded.                                                                   |
+-----------------------------+-----------------------------+---------------------------------------+
| :param:`identiferBase`      | :type:`string`              | :value:`""`                           |
+-----------------------------+-----------------------------+---------------------------------------+
| The logical name for given resource is constructred from identiferBase + "." +                    |
| "directory.repalce('/','.')" + "." + basename + ".resources". The resulting name that is used     |
| to load the resource.                                                                             |
+-----------------------------+-----------------------------+---------------------------------------+
| :param:`fixedIdentifierBase`| :type:`string`              | :value:`""`                           |
+-----------------------------+-----------------------------+---------------------------------------+
| The logical name for given resource is constructred from fixedIdentiferBase + "." +               |
| "." + basename + ".resources. The resulting name that is used to load the resource.               |
| Either identifierBase of fixedIdentifierBase must be specified                                    |
+-----------------------------+-----------------------------+---------------------------------------+
| :param:`simpleresgen`       | :type:`Label`               | :value:`<as required>`                |
+-----------------------------+-----------------------------+---------------------------------------+
| An alternative tool for generating resources file. It is used by .NET Core to use a custom        |
| //tools/simpleresgen tool                                                                         |
+-----------------------------+-----------------------------+---------------------------------------+


net_resource, core_resource
~~~~~~~~~~~~~~~~~~~~~~~~~~~

This wraps a resource so it can be embeded into an assembly.

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
| The source to be embeded.                                                                        |
+----------------------------+-----------------------------+---------------------------------------+
| :param:`identifer`         | :type:`string`              | :value:`""`                           |
+----------------------------+-----------------------------+---------------------------------------+
| The logical name for the resource; the name that is used to load the resource.                   |
| The default is the basename of the file name (no subfolder).                                     |
+----------------------------+-----------------------------+---------------------------------------+

net_resource_multi, core_resource_multi
~~~~~~~~~~~~~~~~~~

This wraps multiple resource files so they can be embeded into an assembly.

Providers
^^^^^^^^^

* DotnetResource_

Attributes
^^^^^^^^^^

+-----------------------------+-----------------------------+---------------------------------------+
| **Name**                    | **Type**                    | **Default value**                     |
+-----------------------------+-----------------------------+---------------------------------------+
| :param:`name`               | :type:`string`              | |mandatory|                           |
+-----------------------------+-----------------------------+---------------------------------------+
| A unique name for this rule.                                                                      |
+-----------------------------+-----------------------------+---------------------------------------+
| :param:`srcs`               | :type:`label_list`          | |mandatory|                           |
+-----------------------------+-----------------------------+---------------------------------------+
| The source files to be embeded.                                                                   |
+-----------------------------+-----------------------------+---------------------------------------+
| :param:`identiferBase`      | :type:`string`              | :value:`""`                           |
+-----------------------------+-----------------------------+---------------------------------------+
| The logical name for given resource is constructred from identiferBase + "." +                    |
| "directory.repalce('/','.')" + "." + filename. The resulting name that is used to load            |
| the resource.                                                                                     |
+-----------------------------+-----------------------------+---------------------------------------+
| :param:`fixedIdentifierBase`| :type:`string`              | :value:`""`                           |
+-----------------------------+-----------------------------+---------------------------------------+
| The logical name for given resource is constructred from fixedIdentiferBase + "." +               |
| "." + filename. The resulting name that is used to load the resource.                             |
| Either identifierBase of fixedIdentifierBase must be specified                                    |
+----------------------------+-----------------------------+---------------------------------------+


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


dotnet_stdlib, core_stdlib, net_stdlib
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

This imports a frameworkl dll and transforms it into DotnetLibrary_ so it can be referenced
as dependency by other rules. Uses by //dotnet/stdlib... packages. 

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
| :param:`data`              | :type:`label_list`          | :value:`None`                         |
+----------------------------+-----------------------------+---------------------------------------+
| The list of additional files to include in the list of runfiles for compile assembly             |
+----------------------------+-----------------------------+---------------------------------------+
| :param:`dll`               | :type:`label`               | :value:`""`                           |
+----------------------------+-----------------------------+---------------------------------------+
| The file to be transformed into DotnetLibrary_ provider. If empty then `name` is used.           |
+----------------------------+-----------------------------+---------------------------------------+



