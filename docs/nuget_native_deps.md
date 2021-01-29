Native dependencies in nuget
============================

At the moment [nuget2bazel](nuget2bazel.md) is not able to handle non-usual folders like runtime. 

In such cases it is possible to define additional WORKSPACE rule for handling files in such folders:

  ```python

    dotnet_nuget_new(
        name = "grpc.core.runtime",
        package = "grpc.core",
        version = "2.28.1",
        sha256 = "b625817b7e8dfe66e0894b232001b4c2f0e80aa41dc4dccb59d5a452ca36a755",
        build_file_content = """exports_files(glob(["runtimes/**/*"]), visibility = ["//visibility:public"])""",
    )
  ```

Such files may be later referenced in the build rule:

  ```python

    data = select({
        "@bazel_tools//src/conditions:windows": ["@grpc.core.runtime//:runtimes/win/native/grpc_csharp_ext.x64.dll", "@grpc.core.runtime//:runtimes/win/native/grpc_csharp_ext.x86.dll"],
        "@bazel_tools//src/conditions:darwin": ["@grpc.core.runtime//:runtimes/osx/native/libgrpc_csharp_ext.x64.dylib", "@grpc.core.runtime//:runtimes/osx/native/libgrpc_csharp_ext.x86.dylib"],
        "//conditions:default": ["@grpc.core.runtime//:runtimes/linux/native/libgrpc_csharp_ext.x64.so", "@grpc.core.runtime//:runtimes/linux/native/libgrpc_csharp_ext.x86.so"],
    }),
  ```
