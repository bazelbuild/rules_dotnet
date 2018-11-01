C# Rules for Bazel_
===================

.. All external links are here
.. _Bazel: https://bazel.build/
.. |badge| image:: https://badge.buildkite.com/703775290818dcb2af754f503ed54dc11bb124fce2a6bf1606.svg
   :target: https://buildkite.com/bazel/rules-dotnet-edge
.. |badgeAzure| image:: https://dev.azure.com/tomaszstrejczek/rules_dotnet/_apis/build/status/tomaszstrejczek.rules_dotnet?branchName=master
   :target: https://dev.azure.com/tomaszstrejczek/rules_dotnet/_build
.. _Mono: http://www.mono-project.com/
.. _sandboxing: https://bazel.io/blog/2015/09/11/sandboxing.html 
.. _dotnet_library: dotnet/core.rst#dotnet_library
.. _dotnet_binary: dotnet/core.rst#dotnet_binary
.. _dotnet_nunit_test: dotnet/core.rst#dotnet_nunit_test
.. _dotnet_resx: dotnet/core.rst#dotnet_resx
.. _dotnet_import_library: dotnet/core.rst#dotnet_import_library
.. _dotnet_repositories: dotnet/workspace.rst#dotnet_repositories
.. _dotnet_register_toolchains: dotnet/toolchains.rst#dotnet_register_toolchains
.. _nuget_package: dotnet/workspace.rst#nuget_package
.. _dotnet_nuget_new: dotnet/workspace.rst#dotnet_nuget_new
.. ;;


* Buildkite:

  |badge|

* Azure pipelines

  |badgeAzure| 

.. contents:: 
  :depth: 2

Documentation
-------------

* `Core API <dotnet/core.rst>`_
  
  * `dotnet_library`_
  * `dotnet_binary`_
  * `dotnet_nunit_test`_
  * `dotnet_resx`_
  * `dotnet_import_library`_

* `Workspace rules <dotnet/workspace.rst>`_

* `Toolchains <dotnet/toolchains.rst>`_

* `Tests <tests/README.rst>`_


Overview
--------

This is a minimal viable set of C# bindings for building C# code with
Mono_. It's still pretty rough but it works as a proof of concept that 
could grow into something more.

Caveats
-------

These rules are not compatible with sandboxing_. Particularly, running dotnet rules on linux o macos
requires passing --spawn_strategy=standalone.

Bazel_ creates long paths. Therefore it is recommended to increase the length limit using newer version of Windows.
Please see `here <https://docs.microsoft.com/en-us/windows/desktop/fileio/naming-a-file#maximum-path-length-limitation>`_.

However, some Windows programs do not handle long path names. Most notably - Microsoft cl compiler. Therefore TMP env variable should be
set to something short (like X:\\ or c:\\TEMP). 

Bazel_ and dotnet rules rely on symbolic linking. On Windows it, typically, requires elevated permissions. However, newer versions of Windows
hava a `workaround <https://blogs.windows.com/buildingapps/2016/12/02/symlinks-windows-10/#IJuxPHWEkSSRqC7w.97>`_.

NUnit v2 runner used in some tests requires .NET Framework 3.5 installation.

Setup
-----

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

* If you intend to use CoreCLR make sure to install libunwind-devel if it is not present on your system
  (applies to Linux).

Examples
--------

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


* nuget_package_

  In the `WORKSPACE` file for your project record a nuget dependency like so.
  This is a repository rule so it will not work unless it is in a workspace
  file.

  .. code:: python

    nuget_package(
        name = "newtonsoft.json",
        package = "newtonsoft.json",
        version = "11.0.2",
        sha256 = "679e438d5eb7d7e5599aa71b65fd23ee50dabf57579607873b87d34aec11ca1e",
        core_lib = "lib/netstandard2.0/Newtonsoft.Json.dll",
        net_lib = "lib/net45/Newtonsoft.Json.dll",
        mono_lib = "lib/net45/Newtonsoft.Json.dll",
        core_deps = [
        ],
        net_deps = [
        ],
        mono_deps = [
        ],
        core_files = [
            "lib/netstandard2.0/Newtonsoft.Json.dll",
            "lib/netstandard2.0/Newtonsoft.Json.xml",
        ],
        net_files = [
            "lib/net45/Newtonsoft.Json.dll",
            "lib/net45/Newtonsoft.Json.xml",
        ],
        mono_files = [
            "lib/net45/Newtonsoft.Json.dll",
            "lib/net45/Newtonsoft.Json.xml",
        ],
    )

  Now, in a `BUILD` file, you can add the package to your `deps`

  .. code:: python

    dotnet_binary(
        name = "foo_bar",
        srcs = [
            "foo.cs",
            "bar.cs",
        ],
        deps = [
            "//examples/example_lib:MyClass",
            "@newtonsoft.json//:dotnet",
        ],
        visibility = ["//visibility:public"],
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
