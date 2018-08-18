C# Rules for Bazel_
===================

.. All external links are here
.. _Bazel: https://bazel.build/
.. |travis| image:: https://travis-ci.org/tomaszstrejczek/rules_dotnet.svg?branch=toolchain
   :target: https://travis-ci.org/tomaszstrejczek/rules_dotnet
.. |appvey| image:: https://ci.appveyor.com/api/projects/status/4wlsdo9kgwvt8b97/branch/toolchain?svg=true      
   :target: https://ci.appveyor.com/project/tomaszstrejczek/rules-dotnet/branch/toolchain
.. _Mono: http://www.mono-project.com/
.. _sandboxing: https://bazel.io/blog/2015/09/11/sandboxing.html 
.. _dotnet_library: dotnet/core.rst#dotnet_library
.. _dotnet_binary: dotnet/core.rst#dotnet_binary
.. _dotnet_nunit_test: dotnet/core.rst#dotnet_nunit_test
.. _dotnet_resx: dotnet/core.rst#dotnet_resx
.. _dotnet_import_library: dotnet/core.rst#dotnet_import_library
.. _dotnet_repositories: dotnet/workspace.rst#dotnet_repositories
.. _dotnet_register_toolchains: dotnet/toolchains.rst#dotnet_register_toolchains
.. _dotnet_nuget_new: dotnet/workspace.rst#dotnet_nuget_new
.. ;;

======== ========
Travis   Appveyor
======== ========
|travis| |appvey|
======== ========

.. contents:: 
  :depth: 2


Documentation
~~~~~~~~~~~~~

* `Core API <dotnet/core.rst>`_
  
  * `dotnet_library`_
  * `dotnet_binary`_
  * `dotnet_nunit_test`_
  * `dotnet_resx`_
  * `dotnet_import_library`_

* `Workspace rules <dotnet/workspace.rst>`_

* `Toolchains <dotnet/toolchains.rst>`_


Overview
~~~~~~~~

This is a minimal viable set of C# bindings for building C# code with
Mono_. It's still pretty rough but it works as a proof of concept that 
could grow into something more.

Caveats
~~~~~~~

These rules are not compatible with sandboxing_.

These rules do not currently support the .NET Framework.

These rules do not currently support .NET Core/Standard built with
the official compiler on any platform.

Downloading Mono currently does not work.

Due to Windows short path limit (260) of cl compiler TMP env variable should be
set to something short (like X:\ or c:\TEMP).

Setup
~~~~~

* Add the following to your `WORKSPACE` file to add the external repositories:

  .. code:: python

    # A newer version should be fine
    git_repository(
        name = "io_bazel_rules_dotnet",
        remote = "https://github.com/tomek1909/rules_dotnet",
        tag = "0.0.1",
    )

    load("@io_bazel_rules_dotnet//dotnet:defs.bzl", "dotnet_register_toolchains", "dotnet_repositories")

    dotnet_register_toolchains("host")

    dotnet_repositories()

  The dotnet_repositories_ rule fetches external dependencies, namely the nuget binary.
  The dotnet_register_toolchains_ tries to locate mono binaries and configure toolchains to use it.
  Support for downloading mono is coming soon.

* Add a file named ``BUILD.bazel`` in the root directory of your
  project. In general, you need one of these files in every directory
  with dotnet code.
  At the top of the file used rules should be imported:

  .. code:: python

    load("@io_bazel_rules_dotnet//dotnet:defs.bzl", "dotnet_library", "dotnet_binary")


Examples
~~~~~~~~

* dotnet_library_

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

* dotnet_binary_

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

* dotnet_nunit_test_

  .. code:: python

    dotnet_nunit_test(
        name = "MyTest",
        srcs = [
            "MyTest.cs",
        ],
        deps = [
            "//examples/example_lib:MyClass",
            "//dotnet/externals/nunit2:nunit.framework",
        ],
    )

* dotnet_resx_

  .. code:: python

    dotnet_resx(
        name = "Transform",
        src = "//dotnet/externals/nunit2/nunitv2:src/ClientUtilities/util/Transform.resx",
    )


* dotnet_nuget_new_

  In the `WORKSPACE` file for your project record a nuget dependency like so.
  This is a repository rule so it will not work unless it is in a workspace
  file.

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

  Now, in a `BUILD` file, you can add the package to your `deps`:

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


