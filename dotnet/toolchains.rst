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

At the bottom is the Mono MDK.

This is always bound to ``@dotnet_sdk`` and can be referred to directly if needed, but in general
you should always access it through the toolchain.

The dotnet_download_sdk_ and dotnet_host_sdk_ family of rules are responsible for downloading
these, and adding just enough of a build file to expose the contents to Bazel.

If you don't do anything special, the dotnet rules will download the most recent official SDK for
your host (if available).
If you need a forked version of dotnet/mono, want to control the version or just use the
installed sdk then it is easy to do, you just need to make sure you have bound the dotnet_sdk
repository before you call dotnet_register_toolchains_.

The toolchain
~~~~~~~~~~~~~

This a wrapper over the sdk that provides enough extras to match, target and work on a specific
platforms. It should be considered an opaqute type, you only ever use it through `the context`_.

Declaration
^^^^^^^^^^^

Toolchains are declared using the dotnet_toolchain macro.

Toolchains are pre-declared for all the known combinations of host and target, and the names
are a predictable
"<**host**>"
So for instance if the rules_dotnet repository is loaded with
it's default name, the following toolchain labels (along with many others) will be available

.. code::

  @io_bazel_rules_dotnet//dotnet/toolchain:linux_amd64
  
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
example of this in `limiting the available toolchains`_.


The context
~~~~~~~~~~~

This is the type you use if you are writing custom rules that need dotnet toochain.

Use
^^^

If you are writing a new rule that wants to use the Dotnet toolchain, you need to do a couple of things.
First, you have to declare that you want to consume the toolchain on the rule declaration.
The easiest way to do this is to use the dotnet_rule wrapper, which adds in the toolchain and some
hidden attributes that it consumes.

.. code:: python

  load("@io_bazel_rules_dotnet//dotnet:def.bzl", "dotnet_context")

  my_rule = rule(
      _my_rule_impl,
      attrs = {
          ...
         "dotnet_context_data": attr.label(default = Label("@io_bazel_rules_dotnet//:dotnet_context_data"))
     },
     toolchains = ["@io_bazel_rules_dotnet//dotnet:toolchain"],
 )

And then in the rule body, you need to get the toolchain itself and use it's action generators.

.. code:: python

  def _my_rule_impl(ctx):
    dotnet = dotnet_context(ctx)


Customizing
-----------

Normal usage
~~~~~~~~~~~~

This is an example of normal usage for the other examples to be compared against.

WORKSPACE
^^^^^^^^^

.. code:: python

    load("@io_bazel_rules_dotnet//dotnet:def.bzl", "dotnet_rules_dependencies", "dotnet_register_toolchains")

    dotnet_rules_dependencies()
    dotnet_register_toolchains()


Forcing the Dotnet version
~~~~~~~~~~~~~~~~~~~~~~~~~~

You can select the version of the Mono to use by specifying it when you call
dotnet_register_toolchains_ but you must use a value that matches a known toolchain.

WORKSPACE
^^^^^^^^^

.. code:: python

    load("@io_bazel_rules_dotnet//dotnet:def.bzl", "dotnet_rules_dependencies", "dotnet_register_toolchains")

    dotnet_rules_dependencies()
    dotnet_register_toolchains(dotnet_version="4.2.3")


Using the installed Mono 
~~~~~~~~~~~~~~~~~~~~~~~~

The "host" version is a special toolchain that breaks the hermetic seal to use the host installed
toolchain.

WORKSPACE
^^^^^^^^^

.. code:: python

    load("@io_bazel_rules_dotnet//dotnet:def.bzl", "dotnet_rules_dependencies", "dotnet_register_toolchains")

    dotnet_rules_dependencies()
    dotnet_register_toolchains(go_version="host")



Registering a custom Mono
~~~~~~~~~~~~~~~~~~~~~~~~~

If you want to register your own toolchain that takes precedence over the pre-declared ones you can
just add it and register it before the normal ones.

WORKSPACE
^^^^^^^^^

.. code:: python

    load("@io_bazel_rules_dotnet//dotnet:def.bzl", "dotnet_rules_dependencies", "dotnet_register_toolchains", "dotnet_download_sdk")

    dotnet_download_sdk(name="my_macos_sdk", url="http://bazel-mirror.storage.googleapis.com/download.mono-project.com/archive/4.2.3/macos-10-x86/MonoFramework-MDK-4.2.3.4.macos10.xamarin.x86.tar.gz")
    register_toolchains(
        "@//:my_macos_toolchain",
    )

    dotnet_rules_dependencies()
    dotnet_register_toolchains()


BUILD.bazel
^^^^^^^^^^^

.. code:: python

    dotnet_toolchain(name="my_macos_toolchain", sdk="my_macos_sdk")


Limiting the available toolchains
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

If you wanted to only allow your project to be compiled on mac at Mono version 4.2.3,
instead of calling dotnet_register_toolchains_ you can put

WORKSPACE
^^^^^^^^^

.. code:: python

    load("@io_bazel_rules_dotnet//dotnet:def.bzl", "dotnet_rules_dependencies")

    dotnet_rules_dependencies()
    register_toolchains(
        "@io_bazel_rules_dotnet//dotnet/toolchain:4.2.3_darwin_amd64",
    )


API
---

dotnet_register_toolchains
~~~~~~~~~~~~~~~~~~~~~~~~~~

Installs the Dotnet toolchains. If :param:`dotnet_version` is specified, it sets the
Mono version to use (for example, :value:`"4.2.3"`). By default, the latest
Mono will be used.

+--------------------------------+-----------------------------+-----------------------------------+
| **Name**                       | **Type**                    | **Default value**                 |
+--------------------------------+-----------------------------+-----------------------------------+
| :param:`dotnet_version`        | :type:`string`              | :value:`"4.2.3"`                  |
+--------------------------------+-----------------------------+-----------------------------------+
| This specifies the Mono version to select.                                                       |
| It will match the version specification of the toochain which for normal sdk toolchains is       |
| also the string part of the binary distribution you want to use.                                 |
| You can also use it to select the "host" sdk toolchain, or a custom toolchain with a             |
| specialized version string.                                                                      |
+--------------------------------+-----------------------------+-----------------------------------+

dotnet_download_sdk
~~~~~~~~~~~~~~~~~~~

This downloads Mono for use in toolchains.

+--------------------------------+-----------------------------+-----------------------------------+
| **Name**                       | **Type**                    | **Default value**                 |
+--------------------------------+-----------------------------+-----------------------------------+
| :param:`name`                  | :type:`string`              | |mandatory|                       |
+--------------------------------+-----------------------------+-----------------------------------+
| A unique name for this sdk. This should almost always be :value:`dotnet_sdk` if you want the SDK |
| to be used by toolchains.                                                                        |
+--------------------------------+-----------------------------+-----------------------------------+
| :param:`urls`                  | :type:`string_list`         | :value:`official distributions`   |
+--------------------------------+-----------------------------+-----------------------------------+
| A list of mirror urls to the binary distribution of Mono. These must contain the `{}`            |
| used to substitute the sdk filename being fetched (using `.format`.                              |
+--------------------------------+-----------------------------+-----------------------------------+
| :param:`strip_prefix`          | :type:`string`              | :value:`""`                       |
+--------------------------------+-----------------------------+-----------------------------------+
| A directory prefix to strip from the extracted files.                                            |
+--------------------------------+-----------------------------+-----------------------------------+
| :param:`sdks`                  | :type:`string_list_dict`    | |mandatory|                       |
+--------------------------------+-----------------------------+-----------------------------------+
| This consists of a set of mappings from the host platform tuple to a list of filename and        |
| sha256 for that file. The filename is combined the :param:`urls` to produce the final download   |
| urls to use.                                                                                     |
|                                                                                                  |
| As an example:                                                                                   |
|                                                                                                  |
| .. code:: python                                                                                 |
|                                                                                                  |
|     dotnet_download_sdk(                                                                         |
|         name = "dotnet_sdk",                                                                     |
|         sdks = {                                                                                 |
|             "mono_darwin_amd64":      ("MonoFramework-MDK-4.2.3.4.macos10.xamarin.x86.tar.gz",   |
|                 "25b026fe2f4de7c80b227f69588b06b93787f5b5f134fbf2d652926c08c04bcd"),             |
|         },                                                                                       |
|     )                                                                                            |
|                                                                                                  |
+--------------------------------+-----------------------------+-----------------------------------+


dotnet_host_sdk
~~~~~~~~~~~~~~~

This detects the host Mono for use in toolchains.

It searches the PATH. You can achive the same result by setting
the version to "host" when registering toolchains to select the installed sdk so it should
never be neccesary to use this feature directly.

+--------------------------------+-----------------------------+-----------------------------------+
| **Name**                       | **Type**                    | **Default value**                 |
+--------------------------------+-----------------------------+-----------------------------------+
| :param:`name`                  | :type:`string`              | |mandatory|                       |
+--------------------------------+-----------------------------+-----------------------------------+
| A unique name for this sdk. This should almost always be :value:`dotnet_sdk` if you want the SDK |
| to be used by toolchains.                                                                        |
+--------------------------------+-----------------------------+-----------------------------------+


dotnet_context
~~~~~~~~~~~~~~

This collects the information needed to form and return a :type:`DotnetContext` from a rule ctx.
It uses the attrbutes and the toolchains.
It can only be used in the implementation of a rule that has the dotnet toolchain attached and
the dotnet context data as an attribute. 

.. code:: python

  my_rule = rule(
      _my_rule_impl,
      attrs = {
          ...
        "dotnet_context_data": attr.label(default = Label("@io_bazel_rules_dotnet//:dotnet_context_data"))
      },
      toolchains = ["@io_bazel_rules_dotnet//dotnet:toolchain"],
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
top of any custom skylark rule that wants to interact with the go rules.
It provides all the information needed to create dotnet actions, and create or interact with the 
other dotnet providers.

When you get a DotnetContext from a context (see use_) it exposes a number of fields and methods.

All methods take the DotnetContext as the only positional argument, all other arguments even if
mandatory must be specified by name, to allow us to re-order and deprecate individual parameters
over time.


Methods
^^^^^^^

* Action generators

  * library_
  * binary_
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
| The "mono" binary used to run dotnet executables                                                 |
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
| The mono library version to used. The default is 4.7-api                                         |
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

new_resource
~~~~~~~~~~~~

This creates a new DotnetResource_.
You can add extra fields to the go library by providing extra named parameters to this function,
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


