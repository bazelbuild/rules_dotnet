# Multiversion

.NET Core is often used with multiple versions of frameworks (particularly in monorepo scenarios).

Rules_dotnet support multiple versions of .NET Core. The version of
the framework is specified by the "dotnet_context_data" attribute. 

For example:

    ```python

    core_library(
        name = "foo_bar",
        srcs = [
            "foo.cs",
            "bar.cs",
        ],
        dotnet_context_data = "@io_bazel_rules_dotnet//:core_context_data_v3.1.100",
    )
    ```

The available frameworks are defined when calling [core_register_sdk](api.md#core_register_sdk).

Two techniques are often used to build multiple versions:

* Using loops:

  ```python

    load("@io_bazel_rules_dotnet//dotnet:defs.bzl", "core_register_sdk", "DOTNET_CORE_FRAMEWORKS")
    [core_register_sdk(
        framework,
        name = "core_sdk_{}".format(framework),
    ) for framework in DOTNET_CORE_FRAMEWORKS]
  ```

  ```python

    load("@io_bazel_rules_dotnet//dotnet:defs.bzl", "DOTNET_CORE_FRAMEWORKS", "core_library")
    ...
    [core_library(
        name = "TransitiveClass-net_{}".format(framework),
        srcs = [
            "TransitiveClass.cs",
        ],
        dotnet_context_data = "@io_bazel_rules_dotnet//:core_context_data_{}".format(framework),
        visibility = ["//visibility:public"],
        deps = [
        ],
    ) for framework in DOTNET_CORE_FRAMEWORKS]
    ...
  ```

* Using macros:

  ```python

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
  ```

  ```python

    load("@io_bazel_rules_dotnet//dotnet/stdlib.core:macro.bzl", "all_core_stdlib")
    load("@io_bazel_rules_dotnet//dotnet/private:rules/stdlib.bzl", "core_stdlib")

    framework = "v2.1.200"
    all_core_stdlib(framework)
  ```

Please take into consideration [runtime limitations](runtime.md).
