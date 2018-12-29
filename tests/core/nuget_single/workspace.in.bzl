load("@io_bazel_rules_dotnet//dotnet:defs.bzl", "dotnet_repositories", "dotnet_register_toolchains", "mono_register_sdk", "net_register_sdk")
dotnet_repositories()
dotnet_register_toolchains()
mono_register_sdk()

load("@io_bazel_rules_dotnet//dotnet:defs.bzl", "dotnet_nuget_new", "nuget_package")

dotnet_nuget_new(
    name = "npgsql",
    package = "Npgsql",
    version = "3.2.7",
    build_file_content = """
package(default_visibility = [ "//visibility:public" ])
load("@io_bazel_rules_dotnet//dotnet:defs.bzl", "dotnet_import_library")

dotnet_import_library(
    name = "lib",
    src = "lib/net451/Npgsql.dll"
)
""",
)

dotnet_nuget_new(
    name = "commandlineparser",
    package = "commandlineparser",
    version = "2.3.0",
    build_file_content = """
package(default_visibility = [ "//visibility:public" ])
load("@io_bazel_rules_dotnet//dotnet:defs.bzl", "dotnet_import_library")

dotnet_import_library(
    name = "lib",
    src = "lib/net45/CommandLine.dll"
)
""",
)

nuget_package(
    name = "nuget.frameworks",
    package = "nuget.frameworks",
    version = "4.8.0",
    core_lib = {
        "netcoreapp2.0": "lib/netstandard1.6/NuGet.Frameworks.dll",
        "netcoreapp2.1": "lib/netstandard1.6/NuGet.Frameworks.dll",
    },
    net_lib = {
        "net45": "lib/net40/NuGet.Frameworks.dll",
        "net451": "lib/net40/NuGet.Frameworks.dll",
        "net452": "lib/net40/NuGet.Frameworks.dll",
        "net46": "lib/net46/NuGet.Frameworks.dll",
        "net461": "lib/net46/NuGet.Frameworks.dll",
        "net462": "lib/net46/NuGet.Frameworks.dll",
        "net47": "lib/net46/NuGet.Frameworks.dll",
        "net471": "lib/net46/NuGet.Frameworks.dll",
        "net472": "lib/net46/NuGet.Frameworks.dll",
        "netstandard1.6": "lib/netstandard1.6/NuGet.Frameworks.dll",
        "netstandard2.0": "lib/netstandard1.6/NuGet.Frameworks.dll",
    },
    mono_lib = "lib/net46/NuGet.Frameworks.dll",
    core_files = {
        "netcoreapp2.0": [
           "lib/netstandard1.6/NuGet.Frameworks.dll",
           "lib/netstandard1.6/NuGet.Frameworks.xml",
        ],
        "netcoreapp2.1": [
           "lib/netstandard1.6/NuGet.Frameworks.dll",
           "lib/netstandard1.6/NuGet.Frameworks.xml",
        ],
    },
    net_files = {
        "net45": [
           "lib/net40/NuGet.Frameworks.dll",
           "lib/net40/NuGet.Frameworks.xml",
        ],
        "net451": [
           "lib/net40/NuGet.Frameworks.dll",
           "lib/net40/NuGet.Frameworks.xml",
        ],
        "net452": [
           "lib/net40/NuGet.Frameworks.dll",
           "lib/net40/NuGet.Frameworks.xml",
        ],
        "net46": [
           "lib/net46/NuGet.Frameworks.dll",
           "lib/net46/NuGet.Frameworks.xml",
        ],
        "net461": [
           "lib/net46/NuGet.Frameworks.dll",
           "lib/net46/NuGet.Frameworks.xml",
        ],
        "net462": [
           "lib/net46/NuGet.Frameworks.dll",
           "lib/net46/NuGet.Frameworks.xml",
        ],
        "net47": [
           "lib/net46/NuGet.Frameworks.dll",
           "lib/net46/NuGet.Frameworks.xml",
        ],
        "net471": [
           "lib/net46/NuGet.Frameworks.dll",
           "lib/net46/NuGet.Frameworks.xml",
        ],
        "net472": [
           "lib/net46/NuGet.Frameworks.dll",
           "lib/net46/NuGet.Frameworks.xml",
        ],
        "netstandard1.6": [
           "lib/netstandard1.6/NuGet.Frameworks.dll",
           "lib/netstandard1.6/NuGet.Frameworks.xml",
        ],
        "netstandard2.0": [
           "lib/netstandard1.6/NuGet.Frameworks.dll",
           "lib/netstandard1.6/NuGet.Frameworks.xml",
        ],
    },
    mono_files = [
        "lib/net46/NuGet.Frameworks.dll",
        "lib/net46/NuGet.Frameworks.xml",
    ],
)
nuget_package(
    name = "nuget.common",
    package = "nuget.common",
    version = "4.8.0",
    core_lib = {
        "netcoreapp2.0": "lib/netstandard1.6/NuGet.Common.dll",
        "netcoreapp2.1": "lib/netstandard1.6/NuGet.Common.dll",
    },
    net_lib = {
        "net46": "lib/net46/NuGet.Common.dll",
        "net461": "lib/net46/NuGet.Common.dll",
        "net462": "lib/net46/NuGet.Common.dll",
        "net47": "lib/net46/NuGet.Common.dll",
        "net471": "lib/net46/NuGet.Common.dll",
        "net472": "lib/net46/NuGet.Common.dll",
        "netstandard1.6": "lib/netstandard1.6/NuGet.Common.dll",
        "netstandard2.0": "lib/netstandard1.6/NuGet.Common.dll",
    },
    mono_lib = "lib/net46/NuGet.Common.dll",
    core_deps = {
        "net46": [
           "@nuget.frameworks//:net46_net",
        ],
        "net461": [
           "@nuget.frameworks//:net461_net",
        ],
        "net462": [
           "@nuget.frameworks//:net462_net",
        ],
        "net47": [
           "@nuget.frameworks//:net47_net",
        ],
        "net471": [
           "@nuget.frameworks//:net471_net",
        ],
        "net472": [
           "@nuget.frameworks//:net472_net",
        ],
        "netstandard1.6": [
           "@nuget.frameworks//:netstandard1.6_net",
        ],
        "netstandard2.0": [
           "@nuget.frameworks//:netstandard2.0_net",
        ],
    },
    net_deps = {
        "net46": [
           "@nuget.frameworks//:net46_net",
        ],
        "net461": [
           "@nuget.frameworks//:net461_net",
        ],
        "net462": [
           "@nuget.frameworks//:net462_net",
        ],
        "net47": [
           "@nuget.frameworks//:net47_net",
        ],
        "net471": [
           "@nuget.frameworks//:net471_net",
        ],
        "net472": [
           "@nuget.frameworks//:net472_net",
        ],
        "netstandard1.6": [
           "@nuget.frameworks//:netstandard1.6_net",
        ],
        "netstandard2.0": [
           "@nuget.frameworks//:netstandard2.0_net",
        ],
    },
    mono_deps = [
        "@nuget.frameworks//:mono",
    ],
    core_files = {
        "netcoreapp2.0": [
           "lib/netstandard1.6/NuGet.Common.dll",
           "lib/netstandard1.6/NuGet.Common.xml",
        ],
        "netcoreapp2.1": [
           "lib/netstandard1.6/NuGet.Common.dll",
           "lib/netstandard1.6/NuGet.Common.xml",
        ],
    },
    net_files = {
        "net46": [
           "lib/net46/NuGet.Common.dll",
           "lib/net46/NuGet.Common.xml",
        ],
        "net461": [
           "lib/net46/NuGet.Common.dll",
           "lib/net46/NuGet.Common.xml",
        ],
        "net462": [
           "lib/net46/NuGet.Common.dll",
           "lib/net46/NuGet.Common.xml",
        ],
        "net47": [
           "lib/net46/NuGet.Common.dll",
           "lib/net46/NuGet.Common.xml",
        ],
        "net471": [
           "lib/net46/NuGet.Common.dll",
           "lib/net46/NuGet.Common.xml",
        ],
        "net472": [
           "lib/net46/NuGet.Common.dll",
           "lib/net46/NuGet.Common.xml",
        ],
        "netstandard1.6": [
           "lib/netstandard1.6/NuGet.Common.dll",
           "lib/netstandard1.6/NuGet.Common.xml",
        ],
        "netstandard2.0": [
           "lib/netstandard1.6/NuGet.Common.dll",
           "lib/netstandard1.6/NuGet.Common.xml",
        ],
    },
    mono_files = [
        "lib/net46/NuGet.Common.dll",
        "lib/net46/NuGet.Common.xml",
    ],
)

#