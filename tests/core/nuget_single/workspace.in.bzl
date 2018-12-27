dotnet_register_toolchains(dotnet_version="host")

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
    core_lib = "lib/netstandard1.6/NuGet.Frameworks.dll",
    net_lib = "lib/net46/NuGet.Frameworks.dll",
    mono_lib = "lib/net46/NuGet.Frameworks.dll",
    core_deps = [
        "@io_bazel_rules_dotnet//dotnet/stdlib.core:netstandard.library.dll",
    ],
    net_deps = [
    ],
    mono_deps = [
    ],
    core_files = [
        "lib/netstandard1.6/NuGet.Frameworks.dll",
        "lib/netstandard1.6/NuGet.Frameworks.xml",
    ],
    net_files = [
        "lib/net46/NuGet.Frameworks.dll",
        "lib/net46/NuGet.Frameworks.xml",
    ],
    mono_files = [
        "lib/net46/NuGet.Frameworks.dll",
        "lib/net46/NuGet.Frameworks.xml",
    ],
)
nuget_package(
    name = "nuget.common",
    package = "nuget.common",
    version = "4.8.0",
    core_lib = "lib/netstandard1.6/NuGet.Common.dll",
    net_lib = "lib/net46/NuGet.Common.dll",
    mono_lib = "lib/net46/NuGet.Common.dll",
    core_deps = [
        "@nuget.frameworks//:core",
        "@io_bazel_rules_dotnet//dotnet/stdlib.core:netstandard.library.dll",
        "@io_bazel_rules_dotnet//dotnet/stdlib.core:system.diagnostics.process.dll",
        "@io_bazel_rules_dotnet//dotnet/stdlib.core:system.threading.thread.dll",
    ],
    net_deps = [
        "@nuget.frameworks//:net",
    ],
    mono_deps = [
        "@nuget.frameworks//:mono",
    ],
    core_files = [
        "lib/netstandard1.6/NuGet.Common.dll",
        "lib/netstandard1.6/NuGet.Common.xml",
    ],
    net_files = [
        "lib/net46/NuGet.Common.dll",
        "lib/net46/NuGet.Common.xml",
    ],
    mono_files = [
        "lib/net46/NuGet.Common.dll",
        "lib/net46/NuGet.Common.xml",
    ],
)

#