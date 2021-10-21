# Multiversion

.NET Core is often used with multiple versions of frameworks (particularly in monorepo scenarios).

Rules_dotnet assume that the whole repository is built using the same version of the framework.
The framework is derived from the platform. For example //dotnet/toolchain:linux_amd64_2.2.402
specifies version 2.2.402 of the SDK.

If you need to build your source code with more than one version of the SDK, you have to run
bazel build separately for each version providing different --platforms and --host-platform
parameter.

Incompatible targets should be handled using target_compatible_with attribute.

For example:

    ```python

    csharp_library(
        name = "foo_bar",
        srcs = [
            "foo.cs",
            "bar.cs",
        ],
        target_compatible_with = ["@io_bazel_rules_dotnet//dotnet/toolchain:3.1.100"],
    )
    ```

For more complex cases you may use [select function](https://docs.bazel.build/versions/master/be/functions.html#select).

For example:

    ```python

    csharp_library(
        name = "foo_bar",
        srcs = [
            "foo.cs",
            "bar.cs",
        ],
      target_compatible_with = select({
          "@io_bazel_rules_dotnet//dotnet/toolchain:3.1.100": [],
          "@io_bazel_rules_dotnet//dotnet/toolchain:5.0.201": [],
          "//conditions:default": ["@platforms//:incompatible"],
      }),
    )
    ```

Please take into consideration [runtime limitations](runtime.md).
