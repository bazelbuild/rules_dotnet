C# Rules for Bazel_
===================

.. All external links are here
.. _Bazel: https://bazel.build/
.. |badge| image:: https://badge.buildkite.com/703775290818dcb2af754f503ed54dc11bb124fce2a6bf1606.svg
   :target: https://buildkite.com/bazel/rules-dotnet-edge
.. |badgeAzure| image:: https://dev.azure.com/tomaszstrejczek/rules_dotnet/_apis/build/status/tomaszstrejczek.rules_dotnet?branchName=master
   :target: https://dev.azure.com/tomaszstrejczek/rules_dotnet/_build
.. |badgeTravis| image:: https://travis-ci.org/bazelbuild/rules_dotnet.svg?branch=master
    :target: https://travis-ci.org/bazelbuild/rules_dotnet   
.. |badgeAppveyor| image:: https://ci.appveyor.com/api/projects/status/obpncs8e7wab1yty/branch/master
    :target: https://ci.appveyor.com/project/tomek1909/rules-dotnet/branch/master
.. _Mono: http://www.mono-project.com/
.. _Net: https://en.wikipedia.org/wiki/.NET_Framework
.. _Core: https://en.wikipedia.org/wiki/.NET_Core
.. _sandboxing: https://bazel.io/blog/2015/09/11/sandboxing.html 
.. _dotnet_library: dotnet/core.rst#dotnet_library
.. _dotnet_binary: dotnet/core.rst#dotnet_binary
.. _dotnet_nunit_test: dotnet/core.rst#dotnet_nunit_test
.. _dotnet_resx: dotnet/core.rst#dotnet_resx
.. _dotnet_import_library: dotnet/core.rst#dotnet_import_library
.. _dotnet_repositories: dotnet/workspace.rst#dotnet_repositories
.. _dotnet_repositories_nugets: dotnet/workspace.rst#dotnet_repositories_nugets
.. _dotnet_register_toolchains: dotnet/toolchains.rst#dotnet_register_toolchains
.. _net_register_sdk: dotnet/toolchains.rst#net_register_sdk
.. _core_register_sdk: dotnet/toolchains.rst#core_register_sdk
.. _mono_register_sdk: dotnet/toolchains.rst#mono_register_sdk
.. _nuget_package: dotnet/workspace.rst#nuget_package
.. _dotnet_nuget_new: dotnet/workspace.rst#dotnet_nuget_new
.. ;;


* Build status:

  +-----------------+---------------+-----------------+
  | Azure pipelines | Travis CI     | Appveyor        |
  +=================+===============+=================+
  | |badgeAzure|    | |badgeTravis| | |badgeAppveyor| |
  +-----------------+---------------+-----------------+


.. contents:: 
  :depth: 2

Documentation
-------------

* `Examples <tests/examples/README.rst>`_

* `Runtime considerations <docs/runtime.rst>`_

* `Multiple framework versions <docs/multiversion.rst>`_

* `Nuget usage <tools/nuget2bazel/README.rst>`_

* `Core API <dotnet/core.rst>`_
  
  * `dotnet_library, core_library, net_library <dotnet/core.rst#dotnet-library-core-library-net-library>`_
  * `dotnet_binary, net_binary, core_binary <dotnet/core.rst#dotnet-binary-net-binary-core-binary>`_
  * `dotnet_resx, net_resx, core_resx <dotnet/core.rst#dotnet-resx-net-resx-core-resx>`_
  * `dotnet_nunit_test, net_nunit_test, net_nunit3_test, core_xunit_test, net_xunit_test, dotnet_xunit_test <dotnet/core.rst#dotnet-nunit-test-net-nunit-test-net-nunit3-test-core-xunit-test-net-xunit-test-dotnet-xunit-test>`_
  * `dotnet_resx, net_resx, core_resx <dotnet/core.rst#dotnet-resx-net-resx-core-resx>`_
  * `dotnet_import_library, core_import_library, net_import_library, dotnet_import_binary, core_import_binary, net_import_binary <dotnet/core.rst#dotnet-import-library-core-import-library-net-import-library-dotnet-import-binary-core-import-binary-net-import-binary>`_
  * `dotnet_stdlib, core_stdlib, net_stdlib <dotnet/core.rst#dotnet-stdlib-core-stdlib-net-stdlib>`_

* `Workspace rules <dotnet/workspace.rst>`_

* `Toolchains <dotnet/toolchains.rst>`_

* `Tests <tests/README.rst>`_


Overview
--------

This is a minimal viable set of C# bindings for building C# code with
Core_, Net_ and Mono_. It's still pretty rough but it works.

**Warning: on Windows requires minimum 1.1.0 version of bazel (due to improper symbolic link targets handling 
in previous versions).**

Caveats
-------

These rules are not compatible with sandboxing_. Particularly, running dotnet rules 
on Linux or OSX requires passing --spawn_strategy=standalone.

Bazel_ creates long paths. Therefore it is recommended to increase the length limit 
using newer version of Windows. Please see 
`here <https://docs.microsoft.com/en-us/windows/desktop/fileio/naming-a-file#maximum-path-length-limitation>`_.

However, some Windows programs do not handle long path names. Most notably - Microsoft 
C compiler (cl.exe). Therefore TMP env variable should be set to something 
short (like X:\\ or c:\\TEMP). 

Bazel_ and dotnet_rules rely on symbolic linking. On Windows it, typically, requires 
elevated permissions. However, newer versions of Windows have a `workaround <https://blogs.windows.com/buildingapps/2016/12/02/symlinks-windows-10/#IJuxPHWEkSSRqC7w.97>`_.

NUnit v2 runner used in some tests requires .NET Framework 3.5 installation.

If you intend to use Mono_ or .Net Framework then they have to be installed locally 
on the machine. The producers of these frameworks do not provide downloadable 
"run-in-place" (without installation) versions. The developer versions of these frameworks
have to be used.

Setup
-----

* Add the following to your `WORKSPACE` file to add the external repositories:

  .. code:: python

    # A newer version should be fine
    load("@bazel_tools//tools/build_defs/repo:git.bzl", "git_repository")
    git_repository(
        name = "io_bazel_rules_dotnet",
        remote = "https://github.com/bazelbuild/rules_dotnet",
        branch = "master",
    )

    load("@io_bazel_rules_dotnet//dotnet:deps.bzl", "dotnet_repositories")

    dotnet_repositories()

    load("@io_bazel_rules_dotnet//dotnet:defs.bzl", "core_register_sdk", "net_register_sdk", "mono_register_sdk",
        "dotnet_register_toolchains", "dotnet_repositories_nugets", "nuget_package")

    dotnet_register_toolchains()
    dotnet_repositories_nugets()
    # For .NET Core:
    core_register_sdk()
    # For .NET Framework:
    net_register_sdk()
    # For Mono:
    mono_register_sdk()

  The dotnet_repositories_ rule fetches external dependencies which have to be defined before loading
  any other file of rules_dotnet. dotnet_repositories_nugets_ loads nuget packages required by test rules.

  The dotnet_register_toolchains_ configures toolchains.

  The mono_register_sdk_, core_register_sdk_, net_register_sdk_ "glue" toolchains with 
  appropriate SDKs.

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
      name = "foo_bar.dll",
      srcs = [
          "foo.cs",
          "bar.cs",
      ],
      deps = [
          "//examples/example_lib:MyClass",
          "@npgsql//:npgsqllib",
      ],
    )

  Note: The defined library must have extension .dll. Otherwise launchers used by rules_dotnet are not able 
  to correctly locate necessary files. 

* dotnet_binary_

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

  Note: The defined library must have extension .exe. Otherwise launchers used by rules_dotnet are not able 
  to correctly locate necessary files. 

* dotnet_nunit_test_

  .. code:: python

    dotnet_nunit_test(
        name = "MyTest.dll",
        srcs = [
            "MyTest.cs",
        ],
        deps = [
            "//examples/example_lib:MyClass",
            "//dotnet/externals/nunit2:nunit.framework",
        ],
    )

  Note: The defined library must have extension .dll. Otherwise launchers used by rules_dotnet are not able 
  to correctly locate necessary files. 

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
        name = "foo_bar.exe",
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
