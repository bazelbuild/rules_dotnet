Dotnet toolchains
=================
.. _core: core.bzl
.. _rules_go: https://github.com/bazelbuild/rules_go
.. _go_toolchains: https://github.com/bazelbuild/rules_go/blob/master/go/toolchains.rst
.. _DotnetLibrary: providers.bzl#DotnetLibrary
.. _DotnetResource: providers.bzl#DotnetResource

.. role:: param(literal)
.. role:: type(emphasis)
.. role:: value(code)
.. |mandatory| replace:: **mandatory value**


The design and implementation is heavily based on rules_go_ `toolchains <go_toolchains_>`_.

-----

Design
------

The Dotnet toolchain consists of three main layers, `the sdk`_ and `the toolchain`_ and `the context`_.

The SDK
~~~~~~~

At the bottom there are frameworks (.NET, Core or Mono). More than one version of the
framework may be used at the same time.

The frameworks are bound to ``@dotnet_sdk`` for Mono, ``@core_sdk_<version>`` for .NET Core
and ``@net_sdk_<version>`` for .NET Framework. They can be referred to directly if needed, but 
in general you should always access it through the toolchain.

The net_register_sdk_, mono_register_sdk_ and core_register_sdk_ family of rules are 
responsible for downloading these, and adding just enough of a build file to expose the 
contents to Bazel.


The toolchain
~~~~~~~~~~~~~

This a wrapper over the sdk that provides enough extras to match, target and work on a specific
platforms. It should be considered an opaque type, you only ever use it through `the context`_.

Declaration
^^^^^^^^^^^

Toolchains are declared using the dotnet_toolchain macro.

Toolchains are pre-declared for all the known combinations of host and target, and the names
are a predictable
"<**host**>"
So for instance if the rules_dotnet repository is loaded with
it's default name, the following toolchain labels (along with many others) will be available

  .. code:: python

    @io_bazel_rules_dotnet//dotnet/toolchain:net_linux_amd64
  
The toolchains are not usable until you register them.

Registration
^^^^^^^^^^^^

Normally you would just call dotnet_register_toolchains_ from your WORKSPACE to register all the
pre-declared toolchains, and allow normal selection logic to pick the right one.

It is fine to add more toolchains to the available set if you like. Because the normal
toolchain matching mechanism prefers the first declared match, you can also override individual
toolchains by declaring and registering toolchains with the same constraints *before* calling
dotnet_register_toolchains_.

If you wish to have more control over the toolchains you can instead just make direct
calls to dotnet_register_toolchains_ with only the toolchains you wish to install. You can see an
example of this in `limiting the available toolchains <https://docs.bazel.build/versions/master/toolchains.html#toolchain-resolution>`_.


The context
~~~~~~~~~~~

This is the type you use if you are writing custom rules that need dotnet toochain.

Use
^^^

If you are writing a new rule that wants to use the Dotnet toolchain, you need to do a couple of things.
First, you have to declare that you want to consume the toolchain on the rule declaration.

.. code:: python

  load("@io_bazel_rules_dotnet//dotnet:def.bzl", "dotnet_context")

  my_rule = rule(
      _my_rule_impl,
      attrs = {
          ...
         "dotnet_context_data": attr.label(default = Label("@io_bazel_rules_dotnet//:dotnet_context_data"))
     },
     toolchains = ["@io_bazel_rules_dotnet//dotnet:toolchain_type_mono"],
 )

And then in the rule body, you need to get the toolchain itself and use it's action generators.

.. code:: python

  def _my_rule_impl(ctx):
    dotnet = dotnet_context(ctx)


API
---

dotnet_register_toolchains
~~~~~~~~~~~~~~~~~~~~~~~~~~

Installs the Dotnet toolchains. 

net_register_sdk
~~~~~~~~~~~~~~~~

Registers .NET Framework.

It searches for .NET Framework using well known location and provided version. On non-Windows
platform the function doesn't do anything.

+--------------------------------+-----------------------------+------------------------------------+
| **Name**                       | **Type**                    | **Default value**                  |
+--------------------------------+-----------------------------+------------------------------------+
| :param:`net_version`           | :type:`string`              | |mandatory|                        |
+--------------------------------+-----------------------------+------------------------------------+
| The `TFM <https://docs.microsoft.com/en-us/dotnet/standard/frameworks>`_ of the framework.        |
| The supported frameworks are listed in `list.bzl <platform/list.bzl>`_.                           |
+--------------------------------+-----------------------------+------------------------------------+
| :param:`net_roslyn_version`    | :type:`string`              | :value:`NET_ROSLYN_DEFAULT_VERSION`|
+--------------------------------+-----------------------------+------------------------------------+
| The .NET framework is used with independent compiler provided via nuget package                   |
| `Microsoft.Net.Compilers <https://www.nuget.org/packages/Microsoft.Net.Compilers/>`_              |
+--------------------------------+-----------------------------+------------------------------------+
| :param:`tools_version`         | :type:`string`              | :value:`net472`                    |
+--------------------------------+-----------------------------+------------------------------------+
| The version of the framework to use for resgen tools if different is expected.                    |
+--------------------------------+-----------------------------+------------------------------------+
| :param:`name`                  | :type:`string`              | :value:`None`                      |
+--------------------------------+-----------------------------+------------------------------------+
| The name under which the SDK will be registered. If not provided the default @net_sdk_<tfm>       |
| is used.                                                                                          |
+--------------------------------+-----------------------------+------------------------------------+

core_register_sdk
~~~~~~~~~~~~~~~~~

Registers .NET Core.

It downloads the sdk for given version. Uses core_download_sdk_.

+--------------------------------+-----------------------------+------------------------------------+
| **Name**                       | **Type**                    | **Default value**                  |
+--------------------------------+-----------------------------+------------------------------------+
| :param:`core_version`          | :type:`string`              | |mandatory|                        |
+--------------------------------+-----------------------------+------------------------------------+
| The exact version of the framework.                                                               |
| The supported frameworks are listed in `list.bzl <platform/list.bzl>`_.                           |
+--------------------------------+-----------------------------+------------------------------------+
| :param:`name`                  | :type:`string`              | :value:`None`                      |
+--------------------------------+-----------------------------+------------------------------------+
| The name under which the SDK will be registered. If not provided the default @core_sdk_<version>  |
| is used.                                                                                          |
+--------------------------------+-----------------------------+------------------------------------+

mono_register_sdk
~~~~~~~~~~~~~~~~~

Registers Mono SDK. Mono has to be installed before use. See dotnet_host_sdk_.

dotnet_host_sdk
~~~~~~~~~~~~~~~

This detects the host Mono for use in toolchains. It usually is not used directly. Use mono_register_sdk_
instead.

It searches the PATH. 

+--------------------------------+-----------------------------+-----------------------------------+
| **Name**                       | **Type**                    | **Default value**                 |
+--------------------------------+-----------------------------+-----------------------------------+
| :param:`name`                  | :type:`string`              | |mandatory|                       |
+--------------------------------+-----------------------------+-----------------------------------+
| A unique name for this sdk. This should almost always be :value:`dotnet_sdk` if you want the SDK |
| to be used by toolchains.                                                                        |
+--------------------------------+-----------------------------+-----------------------------------+

core_download_sdk
~~~~~~~~~~~~~~~~~

This downloads .NET Core SDK for given version. It usually is not used directly. Use core_register_sdk_
instead. 

+--------------------------------+-----------------------------+-----------------------------------+
| **Name**                       | **Type**                    | **Default value**                 |
+--------------------------------+-----------------------------+-----------------------------------+
| :param:`name`                  | :type:`string`              | |mandatory|                       |
+--------------------------------+-----------------------------+-----------------------------------+
| A unique name for this sdk. This should almost always be :value:`core_sdk_<tfm>` if you want the |
| SDK to be used by toolchains.                                                                    |
+--------------------------------+-----------------------------+-----------------------------------+
| :param:`version`               | :type:`string`              |                                   |
+--------------------------------+-----------------------------+-----------------------------------+
| The version for the framework                                                                    |
+--------------------------------+-----------------------------+-----------------------------------+


dotnet_context
~~~~~~~~~~~~~~

This collects the information needed to form and return a :type:`DotnetContext` from a rule ctx.
It uses the attrbutes and the toolchains.
It can only be used in the implementation of a rule that has the dotnet toolchain attached and
the dotnet context data as an attribute. 

.. code:: python

  my_rule_mono = rule(
      _my_rule_impl,
      attrs = {
          ...
        "dotnet_context_data": attr.label(default = Label("@io_bazel_rules_dotnet//:dotnet_context_data"))
      },
      toolchains = ["@io_bazel_rules_dotnet//dotnet:toolchain_type_mono"],
  )
  my_rule_core = rule(
      _my_rule_impl,
      attrs = {
          ...
        "dotnet_context_data": attr.label(default = Label("@io_bazel_rules_dotnet//:core_context_data"))
      },
      toolchains = ["@io_bazel_rules_dotnet//dotnet:toolchain_type_core"],
  )
  my_rule_net = rule(
      _my_rule_impl,
      attrs = {
          ...
        "dotnet_context_data": attr.label(default = Label("@io_bazel_rules_dotnet//:net_context_data"))
      },
      toolchains = ["@io_bazel_rules_dotnet//dotnet:toolchain_type_net"],
  )


+--------------------------------+-----------------------------+-----------------------------------+
| **Name**                       | **Type**                    | **Default value**                 |
+--------------------------------+-----------------------------+-----------------------------------+
| :param:`ctx`                   | :type:`ctx`                 | |mandatory|                       |
+--------------------------------+-----------------------------+-----------------------------------+
| The Bazel ctx object for the current rule.                                                       |
+--------------------------------+-----------------------------+-----------------------------------+

The context object
~~~~~~~~~~~~~~~~~~

DotnetContext is never returned by a rule, instead you build one using dotnet_context(ctx) in the 
top of any custom skylark rule that wants to interact with the dotnet rules (regardless of framework).
It provides all the information needed to create dotnet actions, and create or interact with the 
other dotnet providers.

When you get a DotnetContext from a context (see use_) it exposes a number of fields and methods.

All methods take the DotnetContext as the only positional argument, all other arguments even if
mandatory must be specified by name, to allow us to re-order and deprecate individual parameters
over time.


Methods
^^^^^^^

* Action generators

  * assembly_
  * resx_

* Helpers

  * declare_file_
  * new_library_
  * new_resource_


Fields
^^^^^^

+--------------------------------+-----------------------------------------------------------------+
| **Name**                       | **Type**                                                        |
+--------------------------------+-----------------------------------------------------------------+
| :param:`toolchain`             | :type:`DotnetToolchain`                                         |
+--------------------------------+-----------------------------------------------------------------+
| The underlying toolchain. This should be considered an opaque type subject to change.            |
+--------------------------------+-----------------------------------------------------------------+
| :param:`exe_extension`         | :type:`string`                                                  |
+--------------------------------+-----------------------------------------------------------------+
| The suffix to use for all executables in this build mode. Mostly used when generating the output |
| filenames of binary rules.                                                                       |
+--------------------------------+-----------------------------------------------------------------+
| :param:`runner`                | :type:`File`                                                    |
+--------------------------------+-----------------------------------------------------------------+
| The "mono" or "dotnet" binary used to run framework executables                                  |
+--------------------------------+-----------------------------------------------------------------+
| :param:`mcs`                   | :type:`File`                                                    |
+--------------------------------+-----------------------------------------------------------------+
| The main "mcs" (C# compiler) binary used.                                                        |
+--------------------------------+-----------------------------------------------------------------+
| :param:`resgen`                | :type:`File`                                                    |
+--------------------------------+-----------------------------------------------------------------+
| The resource compiler (dotnet executable).                                                       |
+--------------------------------+-----------------------------------------------------------------+
| :param:`stdlib`                | :type:`File`                                                    |
+--------------------------------+-----------------------------------------------------------------+
| The standard library (mscorlib.dll) to use in the build.                                         |
+--------------------------------+-----------------------------------------------------------------+
| :param:`libVersion`            | :type:`string`                                                  |
+--------------------------------+-----------------------------------------------------------------+
| The library version to used.                                                                     |
+--------------------------------+-----------------------------------------------------------------+
| :param:`actions`               | :type:`ctx.actions`                                             |
+--------------------------------+-----------------------------------------------------------------+
| The actions structure from the Bazel context, which has all the methods for building new         |
| bazel actions.                                                                                   |
+--------------------------------+-----------------------------------------------------------------+
| :param:`lib`                   | :type:`label`                                                   |
+--------------------------------+-----------------------------------------------------------------+
| The label for directory with the selected libraryVersion assemblies                              |
+--------------------------------+-----------------------------------------------------------------+


assembly
~~~~~~~~

The library function adds an action that compiles the set of sources into assembly.

It returns DotnetLibrary_ provider.

+--------------------------------+--------------------------------+-----------------------------------+
| **Name**                       | **Type**                       | **Default value**                 |
+--------------------------------+--------------------------------+-----------------------------------+
| :param:`name`                  | :type:`string`                 | |mandatory|                       |
+--------------------------------+--------------------------------+-----------------------------------+
| This must be the same DotnetContext object you got this function from.                              |
+--------------------------------+--------------------------------+-----------------------------------+
| :param:`srcs`                  | :type:`File iterable`          | |mandatory|                       |
+--------------------------------+--------------------------------+-----------------------------------+
| An iterable of source code artifacts.                                                               |
+--------------------------------+--------------------------------+-----------------------------------+
| :param:`deps`                  | :type:`DotnetLibrary iterable` | :value:`None`                     |
+--------------------------------+--------------------------------+-----------------------------------+
| An iterable of all directly imported libraries.                                                     |
+--------------------------------+--------------------------------+-----------------------------------+
| :param:`out`                   | :type:`string`                 | :value:`None`                     |
+--------------------------------+--------------------------------+-----------------------------------+
| An alternative name of the output file                                                              |
+--------------------------------+--------------------------------+-----------------------------------+
| :param:`resources`             | :type:`DotnetResource iterable`| :value:`None`                     |
+--------------------------------+--------------------------------+-----------------------------------+
| An iterable of all directly imported libraries.                                                     |
+--------------------------------+--------------------------------+-----------------------------------+
| :param:`exeutable`             | :type:`bool`                   | :value:`True`                     |
+--------------------------------+--------------------------------+-----------------------------------+
| Determines if an exeutable or ordinary assembly is produced                                         |
+--------------------------------+--------------------------------+-----------------------------------+
| :param:`defines`               | :type:`string iterable`        | :value:`None`                     |
+--------------------------------+--------------------------------+-----------------------------------+
| A list of defines to be passed to the compiler                                                      |
+--------------------------------+--------------------------------+-----------------------------------+
| :param:`unsafe`                | :type:`bool`                   | :value:`False`                    |
+--------------------------------+--------------------------------+-----------------------------------+
| Determines if /unsafe should be passed to the compiler                                              |
+--------------------------------+--------------------------------+-----------------------------------+
| :param:`data`                  | :type:`File iterable`          | :value:`None`                     |
+--------------------------------+--------------------------------+-----------------------------------+
| List of addtional files to use as runfiles.                                                         |
+--------------------------------+--------------------------------+-----------------------------------+
| :param:`keyfile`               | :type:`File`                   | :value:`None`                     |
+--------------------------------+--------------------------------+-----------------------------------+
| Keyfile to use for signing the assembly.                                                            |
+--------------------------------+--------------------------------+-----------------------------------+

resx
~~~~

The function adds an action that compiles a single .resx file into .resources file.

It returns DotnetResource_ provider.

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


declare_file
~~~~~~~~~~~~

This is the equivalent of ctx.actions.declare_file.

+--------------------------------+-----------------------------+-----------------------------------+
| **Name**                       | **Type**                    | **Default value**                 |
+--------------------------------+-----------------------------+-----------------------------------+
| :param:`dotnet`                | :type:`DotnetContext`       | |mandatory|                       |
+--------------------------------+-----------------------------+-----------------------------------+
| This must be the same DotnetContext object you got this function from.                           |
+--------------------------------+-----------------------------+-----------------------------------+
| :param:`path`                  | :type:`string`              | :value:`""`                       |
+--------------------------------+-----------------------------+-----------------------------------+
| A path for this file, including the basename of the file.                                        |
+--------------------------------+-----------------------------+-----------------------------------+

new_library
~~~~~~~~~~~

This creates a new DotnetLibrary_.
You can add extra fields to the go library by providing extra named parameters to this function,
they will be visible to the resolver when it is invoked.

+--------------------------------+--------------------------------+-----------------------------------+
| **Name**                       | **Type**                       | **Default value**                 |
+--------------------------------+--------------------------------+-----------------------------------+
| :param:`name`                  | :type:`string`                 | |mandatory|                       |
+--------------------------------+--------------------------------+-----------------------------------+
| A unique name for this library.                                                                     |
+--------------------------------+--------------------------------+-----------------------------------+
| :param:`dotnet`                | :type:`DotnetContext`          | |mandatory|                       |
+--------------------------------+--------------------------------+-----------------------------------+
| This must be the same DotnetContext object you got this function from.                              |
+--------------------------------+--------------------------------+-----------------------------------+
| :param:`deps`                  | :type:`list of DotnetLibrary`  |                                   |
+--------------------------------+--------------------------------+-----------------------------------+
| The direct dependencies of this library.                                                            |
+--------------------------------+--------------------------------+-----------------------------------+
| :param:`transitive`            | :type:`depset of DotnetLibrary`|                                   |
+--------------------------------+--------------------------------+-----------------------------------+
| The full set of transitive dependencies. This includes ``deps`` for this                            |
| library and all ``deps`` members transitively reachable through ``deps``.                           |
+--------------------------------+--------------------------------+-----------------------------------+
| :param:`result`                | :type:`File`                   |                                   |
+--------------------------------+--------------------------------+-----------------------------------+
| The result to include in DotnetLibrary (used when importing external assemblies)                    |
+--------------------------------+--------------------------------+-----------------------------------+
| :param:`pdb`                   | :type:`File`                   |                                   |
+--------------------------------+--------------------------------+-----------------------------------+
| If .pdb file for given library                                                                      |
+--------------------------------+--------------------------------+-----------------------------------+
| :param:`runfiles`              | :type:`depset of Files`        |                                   |
+--------------------------------+--------------------------------+-----------------------------------+
| Runfiles for DotnetLibrary                                                                          |
+--------------------------------+--------------------------------+-----------------------------------+

new_resource
~~~~~~~~~~~~

This creates a new DotnetResource_.
You can add extra fields to the dotnet resource by providing extra named parameters to this function,
they will be visible to the resolver when it is invoked.

+--------------------------------+-----------------------------+-----------------------------------+
| **Name**                       | **Type**                    | **Default value**                 |
+--------------------------------+-----------------------------+-----------------------------------+
| :param:`name`                  | :type:`string`              | |mandatory|                       |
+--------------------------------+-----------------------------+-----------------------------------+
| A unique name for this library.                                                                  |
+--------------------------------+-----------------------------+-----------------------------------+
| :param:`dotnet`                | :type:`DotnetContext`       | |mandatory|                       |
+--------------------------------+-----------------------------+-----------------------------------+
| This must be the same DotnetContext object you got this function from.                           |
+--------------------------------+-----------------------------+-----------------------------------+
| :param:`result`                | :type:`File`                | |mandatory|                       |
+--------------------------------+-----------------------------+-----------------------------------+
| The .resources file.                                                                             |
+--------------------------------+-----------------------------+-----------------------------------+
| :param:`identifier`            | :type:`string`              | :value:`None`                     |
+--------------------------------+-----------------------------+-----------------------------------+
| Identifier passed to -resource flag of mcs compiler. If empty the basename of the result         |
| is used.                                                                                         |
+--------------------------------+-----------------------------+-----------------------------------+

stdlib_byname
~~~~~~~~~~~~~

This creates a new DotnetLibrary_.
Looks for given library within imported framework.

+--------------------------------+-----------------------------+-----------------------------------+
| **Name**                       | **Type**                    | **Default value**                 |
+--------------------------------+-----------------------------+-----------------------------------+
| :param:`shared`                | :type:`target`              |                                   |
+--------------------------------+-----------------------------+-----------------------------------+
| A target with libraries.                                                                         |
+--------------------------------+-----------------------------+-----------------------------------+
| :param:`lib`                   | :type:`target`              |                                   |
+--------------------------------+-----------------------------+-----------------------------------+
| A target with libraries.                                                                         |
+--------------------------------+-----------------------------+-----------------------------------+
| :param:`libVersion`            | :type:`string`              |                                   |
+--------------------------------+-----------------------------+-----------------------------------+
| Version of the framework to look for.                                                            |
+--------------------------------+-----------------------------+-----------------------------------+
| :param:`name`                  | :type:`string`              | |mandatory|                       |
+--------------------------------+-----------------------------+-----------------------------------+
| Name of the library to look for.                                                                 |
+--------------------------------+-----------------------------+-----------------------------------+


