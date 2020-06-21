Multiversion
============
.. _net_register_sdk: ../dotnet/toolchains.rst#net_register_sdk
.. _core_register_sdk: ../dotnet/toolchains.rst#core_register_sdk

Particularly .NET Framework is often used with multiple versions of frameworks (net45, net472, etc.).

Rules_dotnet support multiple versions of framework for .NET Core and .NET Framework. The version of
the framework is specified by the "dotnet_context_data" attribute. 

For example:

.. code:: python

    net_library(
        name = "foo_bar",
        srcs = [
            "foo.cs",
            "bar.cs",
        ],
        dotnet_context_data = "@io_bazel_rules_dotnet//:net_context_data_net472",
    )

The available frameworks are defined when calling net_register_sdk_ and core_register_sdk_.

Two techniques are often used to build multiple versions:

* Using loops (see `example <../tests/examples/example_transitive_lib/BUILD>`_):

  .. code:: python

    load("@io_bazel_rules_dotnet//dotnet:defs.bzl", "net_register_sdk", "DOTNET_NET_FRAMEWORKS")
    ...
    [net_register_sdk(
        framework
    ) for framework in DOTNET_NET_FRAMEWORKS]
    ...

  .. code:: python

    load("@io_bazel_rules_dotnet//dotnet:defs.bzl", "DOTNET_NET_FRAMEWORKS", "net_library")
    ...
    [net_library(
        name = "TransitiveClass-net_{}".format(framework),
        srcs = [
            "TransitiveClass.cs",
        ],
        dotnet_context_data = "@io_bazel_rules_dotnet//:net_context_data_{}".format(framework),
        visibility = ["//visibility:public"],
        deps = [
        ],
    ) for framework in DOTNET_NET_FRAMEWORKS]
    ...

* Using macros (see `example 2 <../dotnet/stdlib.core/macro.bzl>`_):

  .. code:: python

    load("@io_bazel_rules_dotnet//dotnet/private:rules/stdlib.bzl", "core_stdlib")

    def all_core_stdlib(framework):
        if framework:
            context = "@io_bazel_rules_dotnet//:core_context_data_{}".format(framework)
        else:
            context = "@io_bazel_rules_dotnet//:core_context_data"

        core_stdlib(
            name = "microsoft.csharp.dll",
            deps = [
                ":netstandard.dll",
            ],
            dotnet_context_data = context,
        )
    ...

  .. code:: python

    load("@io_bazel_rules_dotnet//dotnet/stdlib.core:macro.bzl", "all_core_stdlib")
    load("@io_bazel_rules_dotnet//dotnet/private:rules/stdlib.bzl", "core_stdlib")

    framework = "v2.1.200"
    all_core_stdlib(framework)

Please take into consideration `runtime limitations <runtime.rst>`_.
