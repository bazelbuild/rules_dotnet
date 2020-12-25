C\# Rules for Bazel\_
=====================

-   Build status:

    <table>
    <col width="25%" />
    <col width="22%" />
    <col width="25%" />
    <thead>
    <tr class="header">
    <th align="left">Azure pipelines</th>
    <th align="left">Travis CI</th>
    <th align="left">Appveyor</th>
    </tr>
    </thead>
    <tbody>
    <tr class="odd">
    <td align="left">|badgeAzure|</td>
    <td align="left">|badgeTravis|</td>
    <td align="left">|badgeAppveyor|</td>
    </tr>
    </tbody>
    </table>

> depth  
> 2
>
Documentation
-------------

-   [Examples](tests/examples/README.rst)
-   [Runtime considerations](docs/runtime.rst)
-   [Multiple framework versions](docs/multiversion.rst)
-   [Nuget usage](tools/nuget2bazel/README.rst)
-   [Core API](dotnet/core.rst)
    -   [dotnet\_library, core\_library, net\_library](dotnet/core.rst#dotnet-library-core-library-net-library)
    -   [dotnet\_binary, net\_binary, core\_binary](dotnet/core.rst#dotnet-binary-net-binary-core-binary)
    -   [dotnet\_resx, net\_resx, core\_resx](dotnet/core.rst#dotnet-resx-net-resx-core-resx)
    -   [dotnet\_nunit\_test, net\_nunit\_test, net\_nunit3\_test, core\_xunit\_test, net\_xunit\_test, dotnet\_xunit\_test](dotnet/core.rst#dotnet-nunit-test-net-nunit-test-net-nunit3-test-core-xunit-test-net-xunit-test-dotnet-xunit-test)
    -   [dotnet\_resx, net\_resx, core\_resx](dotnet/core.rst#dotnet-resx-net-resx-core-resx)
    -   [dotnet\_import\_library, core\_import\_library, net\_import\_library, dotnet\_import\_binary, core\_import\_binary, net\_import\_binary](dotnet/core.rst#dotnet-import-library-core-import-library-net-import-library-dotnet-import-binary-core-import-binary-net-import-binary)
    -   [dotnet\_stdlib, core\_stdlib, net\_stdlib](dotnet/core.rst#dotnet-stdlib-core-stdlib-net-stdlib)
-   [Workspace rules](dotnet/workspace.rst)
-   [Toolchains](dotnet/toolchains.rst)
-   [Tests](tests/README.rst)

Overview
--------

This is a minimal viable set of C\# bindings for building C\# code with Core\_

Caveats
-------

These rules are not compatible with sandboxing\_. Particularly, running dotnet rules on Linux or OSX requires passing --spawn\_strategy=standalone.

Bazel\_ creates long paths. Therefore it is recommended to increase the length limit using newer version of Windows. Please see [here](https://docs.microsoft.com/en-us/windows/desktop/fileio/naming-a-file#maximum-path-length-limitation).

However, some Windows programs do not handle long path names. Most notably - Microsoft C compiler (cl.exe). Therefore TMP env variable should be set to something short (like X:\\ or c:\\TEMP).

Bazel\_ and dotnet\_rules rely on symbolic linking. On Windows it, typically, requires elevated permissions. However, newer versions of Windows have a [workaround](https://blogs.windows.com/buildingapps/2016/12/02/symlinks-windows-10/#IJuxPHWEkSSRqC7w.97).

NUnit v2 runner used in some tests requires .NET Framework 3.5 installation.

If you intend to use Mono\_ or .Net Framework then they have to be installed locally on the machine. The producers of these frameworks do not provide downloadable "run-in-place" (without installation) versions. The developer versions of these frameworks have to be used.

Setup
-----

-   Add the following to your WORKSPACE file to add the external repositories:

    ``` {.sourceCode .python}
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
    ```

    The dotnet\_repositories\_ rule fetches external dependencies which have to be defined before loading any other file of rules\_dotnet. dotnet\_repositories\_nugets\_ loads nuget packages required by test rules.

    The dotnet\_register\_toolchains\_ configures toolchains.

    The mono\_register\_sdk\_, core\_register\_sdk\_, net\_register\_sdk\_ "glue" toolchains with appropriate SDKs.

-   Add a file named `BUILD.bazel` in the root directory of your project. In general, you need one of these files in every directory with dotnet code. At the top of the file used rules should be imported:

    ``` {.sourceCode .python}
    load("@io_bazel_rules_dotnet//dotnet:defs.bzl", "dotnet_library", "dotnet_binary")
    ```

-   If you intend to use CoreCLR make sure to install libunwind-devel if it is not present on your system (applies to Linux).

Examples
--------

-   dotnet\_library\_

    ``` {.sourceCode .python}
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
    ```

    Note: The defined library must have extension .dll. Otherwise launchers used by rules\_dotnet are not able to correctly locate necessary files.

-   dotnet\_binary\_

    ``` {.sourceCode .python}
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
    ```

    Note: The defined library must have extension .exe. Otherwise launchers used by rules\_dotnet are not able to correctly locate necessary files.

-   dotnet\_nunit\_test\_

    ``` {.sourceCode .python}
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
    ```

    Note: The defined library must have extension .dll. Otherwise launchers used by rules\_dotnet are not able to correctly locate necessary files.

-   dotnet\_resx\_

    ``` {.sourceCode .python}
    dotnet_resx(
        name = "Transform",
        src = "//dotnet/externals/nunit2/nunitv2:src/ClientUtilities/util/Transform.resx",
    )
    ```

-   nuget\_package\_

    In the WORKSPACE file for your project record a nuget dependency like so. This is a repository rule so it will not work unless it is in a workspace file.

    ``` {.sourceCode .python}
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
    ```

    Now, in a BUILD file, you can add the package to your deps

    ``` {.sourceCode .python}
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
    ```

-   dotnet\_nuget\_new\_

    In the WORKSPACE file for your project record a nuget dependency like so. This is a repository rule so it will not work unless it is in a workspace file.

    ``` {.sourceCode .python}
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
    ```

    Now, in a BUILD file, you can add the package to your \`deps\`:

    ``` {.sourceCode .python}
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
    ```


