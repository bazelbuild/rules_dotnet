load("@rules_dotnet//dotnet:defs.bzl", "nuget_package")

def paket():
    "paket"
    nuget_package(
        name = "main.argu",
        package = "argu",
        version = "6.1.1",
        sha256 = "b40f67149996be848ea3ca0557ac14b9ab46e7b6b74125b48f100373c03329ed",
        build_file_content = """
load("@rules_dotnet//dotnet:defs.bzl", "import_library", "import_multiframework_library")
import_library(
    name = "net11",
    target_framework = "net11",
    deps = [
    ],
    data = [
    ],
)
import_library(
    name = "net20",
    target_framework = "net20",
    deps = [
    ],
    data = [
    ],
)
import_library(
    name = "net35",
    target_framework = "net35",
    deps = [
    ],
    data = [
    ],
)
import_library(
    name = "net40",
    target_framework = "net40",
    deps = [
    ],
    data = [
    ],
)
import_library(
    name = "net403",
    target_framework = "net403",
    deps = [
    ],
    data = [
    ],
)
import_library(
    name = "net45",
    target_framework = "net45",
    deps = [
    ],
    data = [
    ],
)
import_library(
    name = "net451",
    target_framework = "net451",
    deps = [
    ],
    data = [
    ],
)
import_library(
    name = "net452",
    target_framework = "net452",
    deps = [
    ],
    data = [
    ],
)
import_library(
    name = "net46",
    target_framework = "net46",
    deps = [
    ],
    data = [
    ],
)
import_library(
    name = "net461",
    target_framework = "net461",
    dll = "lib/netstandard2.0/Argu.dll",
    refdll = "lib/netstandard2.0/Argu.dll",
    pdb = "lib/netstandard2.0/Argu.pdb",
    deps = [
        "@main.fsharp.core//:lib",
        "@main.system.configuration.configurationmanager//:lib",
    ],
    data = [
        "lib/netstandard2.0/Argu.dll",
        "lib/netstandard2.0/Argu.xml",
    ],
)
import_library(
    name = "net462",
    target_framework = "net462",
    dll = "lib/netstandard2.0/Argu.dll",
    refdll = "lib/netstandard2.0/Argu.dll",
    pdb = "lib/netstandard2.0/Argu.pdb",
    deps = [
        "@main.fsharp.core//:lib",
        "@main.system.configuration.configurationmanager//:lib",
    ],
    data = [
        "lib/netstandard2.0/Argu.dll",
        "lib/netstandard2.0/Argu.xml",
    ],
)
import_library(
    name = "net47",
    target_framework = "net47",
    dll = "lib/netstandard2.0/Argu.dll",
    refdll = "lib/netstandard2.0/Argu.dll",
    pdb = "lib/netstandard2.0/Argu.pdb",
    deps = [
        "@main.fsharp.core//:lib",
        "@main.system.configuration.configurationmanager//:lib",
    ],
    data = [
        "lib/netstandard2.0/Argu.dll",
        "lib/netstandard2.0/Argu.xml",
    ],
)
import_library(
    name = "net471",
    target_framework = "net471",
    dll = "lib/netstandard2.0/Argu.dll",
    refdll = "lib/netstandard2.0/Argu.dll",
    pdb = "lib/netstandard2.0/Argu.pdb",
    deps = [
        "@main.fsharp.core//:lib",
        "@main.system.configuration.configurationmanager//:lib",
    ],
    data = [
        "lib/netstandard2.0/Argu.dll",
        "lib/netstandard2.0/Argu.xml",
    ],
)
import_library(
    name = "net472",
    target_framework = "net472",
    dll = "lib/netstandard2.0/Argu.dll",
    refdll = "lib/netstandard2.0/Argu.dll",
    pdb = "lib/netstandard2.0/Argu.pdb",
    deps = [
        "@main.fsharp.core//:lib",
        "@main.system.configuration.configurationmanager//:lib",
    ],
    data = [
        "lib/netstandard2.0/Argu.dll",
        "lib/netstandard2.0/Argu.xml",
    ],
)
import_library(
    name = "net48",
    target_framework = "net48",
    dll = "lib/netstandard2.0/Argu.dll",
    refdll = "lib/netstandard2.0/Argu.dll",
    pdb = "lib/netstandard2.0/Argu.pdb",
    deps = [
        "@main.fsharp.core//:lib",
        "@main.system.configuration.configurationmanager//:lib",
    ],
    data = [
        "lib/netstandard2.0/Argu.dll",
        "lib/netstandard2.0/Argu.xml",
    ],
)
import_library(
    name = "netstandard",
    target_framework = "netstandard",
    deps = [
    ],
    data = [
    ],
)
import_library(
    name = "netstandard1.0",
    target_framework = "netstandard1.0",
    deps = [
    ],
    data = [
    ],
)
import_library(
    name = "netstandard1.1",
    target_framework = "netstandard1.1",
    deps = [
    ],
    data = [
    ],
)
import_library(
    name = "netstandard1.2",
    target_framework = "netstandard1.2",
    deps = [
    ],
    data = [
    ],
)
import_library(
    name = "netstandard1.3",
    target_framework = "netstandard1.3",
    deps = [
    ],
    data = [
    ],
)
import_library(
    name = "netstandard1.4",
    target_framework = "netstandard1.4",
    deps = [
    ],
    data = [
    ],
)
import_library(
    name = "netstandard1.5",
    target_framework = "netstandard1.5",
    deps = [
    ],
    data = [
    ],
)
import_library(
    name = "netstandard1.6",
    target_framework = "netstandard1.6",
    deps = [
    ],
    data = [
    ],
)
import_library(
    name = "netstandard2.0",
    target_framework = "netstandard2.0",
    dll = "lib/netstandard2.0/Argu.dll",
    refdll = "lib/netstandard2.0/Argu.dll",
    pdb = "lib/netstandard2.0/Argu.pdb",
    deps = [
        "@main.fsharp.core//:lib",
        "@main.system.configuration.configurationmanager//:lib",
    ],
    data = [
        "lib/netstandard2.0/Argu.dll",
        "lib/netstandard2.0/Argu.xml",
    ],
)
import_library(
    name = "netstandard2.1",
    target_framework = "netstandard2.1",
    dll = "lib/netstandard2.0/Argu.dll",
    refdll = "lib/netstandard2.0/Argu.dll",
    pdb = "lib/netstandard2.0/Argu.pdb",
    deps = [
        "@main.fsharp.core//:lib",
        "@main.system.configuration.configurationmanager//:lib",
    ],
    data = [
        "lib/netstandard2.0/Argu.dll",
        "lib/netstandard2.0/Argu.xml",
    ],
)
import_library(
    name = "netcoreapp1.0",
    target_framework = "netcoreapp1.0",
    deps = [
    ],
    data = [
    ],
)
import_library(
    name = "netcoreapp1.1",
    target_framework = "netcoreapp1.1",
    deps = [
    ],
    data = [
    ],
)
import_library(
    name = "netcoreapp2.0",
    target_framework = "netcoreapp2.0",
    dll = "lib/netstandard2.0/Argu.dll",
    refdll = "lib/netstandard2.0/Argu.dll",
    pdb = "lib/netstandard2.0/Argu.pdb",
    deps = [
        "@main.fsharp.core//:lib",
        "@main.system.configuration.configurationmanager//:lib",
    ],
    data = [
        "lib/netstandard2.0/Argu.dll",
        "lib/netstandard2.0/Argu.xml",
    ],
)
import_library(
    name = "netcoreapp2.1",
    target_framework = "netcoreapp2.1",
    dll = "lib/netstandard2.0/Argu.dll",
    refdll = "lib/netstandard2.0/Argu.dll",
    pdb = "lib/netstandard2.0/Argu.pdb",
    deps = [
        "@main.fsharp.core//:lib",
        "@main.system.configuration.configurationmanager//:lib",
    ],
    data = [
        "lib/netstandard2.0/Argu.dll",
        "lib/netstandard2.0/Argu.xml",
    ],
)
import_library(
    name = "netcoreapp2.2",
    target_framework = "netcoreapp2.2",
    dll = "lib/netstandard2.0/Argu.dll",
    refdll = "lib/netstandard2.0/Argu.dll",
    pdb = "lib/netstandard2.0/Argu.pdb",
    deps = [
        "@main.fsharp.core//:lib",
        "@main.system.configuration.configurationmanager//:lib",
    ],
    data = [
        "lib/netstandard2.0/Argu.dll",
        "lib/netstandard2.0/Argu.xml",
    ],
)
import_library(
    name = "netcoreapp3.0",
    target_framework = "netcoreapp3.0",
    dll = "lib/netstandard2.0/Argu.dll",
    refdll = "lib/netstandard2.0/Argu.dll",
    pdb = "lib/netstandard2.0/Argu.pdb",
    deps = [
        "@main.fsharp.core//:lib",
        "@main.system.configuration.configurationmanager//:lib",
    ],
    data = [
        "lib/netstandard2.0/Argu.dll",
        "lib/netstandard2.0/Argu.xml",
    ],
)
import_library(
    name = "netcoreapp3.1",
    target_framework = "netcoreapp3.1",
    dll = "lib/netstandard2.0/Argu.dll",
    refdll = "lib/netstandard2.0/Argu.dll",
    pdb = "lib/netstandard2.0/Argu.pdb",
    deps = [
        "@main.fsharp.core//:lib",
        "@main.system.configuration.configurationmanager//:lib",
    ],
    data = [
        "lib/netstandard2.0/Argu.dll",
        "lib/netstandard2.0/Argu.xml",
    ],
)
import_library(
    name = "net5.0",
    target_framework = "net5.0",
    dll = "lib/netstandard2.0/Argu.dll",
    refdll = "lib/netstandard2.0/Argu.dll",
    pdb = "lib/netstandard2.0/Argu.pdb",
    deps = [
        "@main.fsharp.core//:lib",
        "@main.system.configuration.configurationmanager//:lib",
    ],
    data = [
        "lib/netstandard2.0/Argu.dll",
        "lib/netstandard2.0/Argu.xml",
    ],
)
import_library(
    name = "net6.0",
    target_framework = "net6.0",
    dll = "lib/netstandard2.0/Argu.dll",
    refdll = "lib/netstandard2.0/Argu.dll",
    pdb = "lib/netstandard2.0/Argu.pdb",
    deps = [
        "@main.fsharp.core//:lib",
        "@main.system.configuration.configurationmanager//:lib",
    ],
    data = [
        "lib/netstandard2.0/Argu.dll",
        "lib/netstandard2.0/Argu.xml",
    ],
)
import_multiframework_library(
    name = "lib",
    net11 = ":net11",
    net20 = ":net20",
    net35 = ":net35",
    net40 = ":net40",
    net403 = ":net403",
    net45 = ":net45",
    net451 = ":net451",
    net452 = ":net452",
    net46 = ":net46",
    net461 = ":net461",
    net462 = ":net462",
    net47 = ":net47",
    net471 = ":net471",
    net472 = ":net472",
    net48 = ":net48",
    netstandard = ":netstandard",
    netstandard1_0 = ":netstandard1.0",
    netstandard1_1 = ":netstandard1.1",
    netstandard1_2 = ":netstandard1.2",
    netstandard1_3 = ":netstandard1.3",
    netstandard1_4 = ":netstandard1.4",
    netstandard1_5 = ":netstandard1.5",
    netstandard1_6 = ":netstandard1.6",
    netstandard2_0 = ":netstandard2.0",
    netstandard2_1 = ":netstandard2.1",
    netcoreapp1_0 = ":netcoreapp1.0",
    netcoreapp1_1 = ":netcoreapp1.1",
    netcoreapp2_0 = ":netcoreapp2.0",
    netcoreapp2_1 = ":netcoreapp2.1",
    netcoreapp2_2 = ":netcoreapp2.2",
    netcoreapp3_0 = ":netcoreapp3.0",
    netcoreapp3_1 = ":netcoreapp3.1",
    net5_0 = ":net5.0",
    net6_0 = ":net6.0",
    visibility = ["//visibility:public"],
)
"""
    )
    nuget_package(
        name = "main.fsharp.core",
        package = "fsharp.core",
        version = "6.0.4",
        sha256 = "bb3de1443cda987da82862e66e0dc4835dc03859f16919c2116679487f98f045",
        build_file_content = """
load("@rules_dotnet//dotnet:defs.bzl", "import_library", "import_multiframework_library")
import_library(
    name = "net11",
    target_framework = "net11",
    deps = [
    ],
    data = [
    ],
)
import_library(
    name = "net20",
    target_framework = "net20",
    deps = [
    ],
    data = [
    ],
)
import_library(
    name = "net35",
    target_framework = "net35",
    deps = [
    ],
    data = [
    ],
)
import_library(
    name = "net40",
    target_framework = "net40",
    deps = [
    ],
    data = [
    ],
)
import_library(
    name = "net403",
    target_framework = "net403",
    deps = [
    ],
    data = [
    ],
)
import_library(
    name = "net45",
    target_framework = "net45",
    deps = [
    ],
    data = [
    ],
)
import_library(
    name = "net451",
    target_framework = "net451",
    deps = [
    ],
    data = [
    ],
)
import_library(
    name = "net452",
    target_framework = "net452",
    deps = [
    ],
    data = [
    ],
)
import_library(
    name = "net46",
    target_framework = "net46",
    deps = [
    ],
    data = [
    ],
)
import_library(
    name = "net461",
    target_framework = "net461",
    dll = "lib/netstandard2.0/FSharp.Core.dll",
    refdll = "lib/netstandard2.0/FSharp.Core.dll",
    deps = [
    ],
    data = [
        "lib/netstandard2.0/cs/FSharp.Core.resources.dll",
        "lib/netstandard2.0/de/FSharp.Core.resources.dll",
        "lib/netstandard2.0/es/FSharp.Core.resources.dll",
        "lib/netstandard2.0/fr/FSharp.Core.resources.dll",
        "lib/netstandard2.0/FSharp.Core.dll",
        "lib/netstandard2.0/FSharp.Core.xml",
        "lib/netstandard2.0/it/FSharp.Core.resources.dll",
        "lib/netstandard2.0/ja/FSharp.Core.resources.dll",
        "lib/netstandard2.0/ko/FSharp.Core.resources.dll",
        "lib/netstandard2.0/pl/FSharp.Core.resources.dll",
        "lib/netstandard2.0/pt-BR/FSharp.Core.resources.dll",
        "lib/netstandard2.0/ru/FSharp.Core.resources.dll",
        "lib/netstandard2.0/tr/FSharp.Core.resources.dll",
        "lib/netstandard2.0/zh-Hans/FSharp.Core.resources.dll",
        "lib/netstandard2.0/zh-Hant/FSharp.Core.resources.dll",
    ],
)
import_library(
    name = "net462",
    target_framework = "net462",
    dll = "lib/netstandard2.0/FSharp.Core.dll",
    refdll = "lib/netstandard2.0/FSharp.Core.dll",
    deps = [
    ],
    data = [
        "lib/netstandard2.0/cs/FSharp.Core.resources.dll",
        "lib/netstandard2.0/de/FSharp.Core.resources.dll",
        "lib/netstandard2.0/es/FSharp.Core.resources.dll",
        "lib/netstandard2.0/fr/FSharp.Core.resources.dll",
        "lib/netstandard2.0/FSharp.Core.dll",
        "lib/netstandard2.0/FSharp.Core.xml",
        "lib/netstandard2.0/it/FSharp.Core.resources.dll",
        "lib/netstandard2.0/ja/FSharp.Core.resources.dll",
        "lib/netstandard2.0/ko/FSharp.Core.resources.dll",
        "lib/netstandard2.0/pl/FSharp.Core.resources.dll",
        "lib/netstandard2.0/pt-BR/FSharp.Core.resources.dll",
        "lib/netstandard2.0/ru/FSharp.Core.resources.dll",
        "lib/netstandard2.0/tr/FSharp.Core.resources.dll",
        "lib/netstandard2.0/zh-Hans/FSharp.Core.resources.dll",
        "lib/netstandard2.0/zh-Hant/FSharp.Core.resources.dll",
    ],
)
import_library(
    name = "net47",
    target_framework = "net47",
    dll = "lib/netstandard2.0/FSharp.Core.dll",
    refdll = "lib/netstandard2.0/FSharp.Core.dll",
    deps = [
    ],
    data = [
        "lib/netstandard2.0/cs/FSharp.Core.resources.dll",
        "lib/netstandard2.0/de/FSharp.Core.resources.dll",
        "lib/netstandard2.0/es/FSharp.Core.resources.dll",
        "lib/netstandard2.0/fr/FSharp.Core.resources.dll",
        "lib/netstandard2.0/FSharp.Core.dll",
        "lib/netstandard2.0/FSharp.Core.xml",
        "lib/netstandard2.0/it/FSharp.Core.resources.dll",
        "lib/netstandard2.0/ja/FSharp.Core.resources.dll",
        "lib/netstandard2.0/ko/FSharp.Core.resources.dll",
        "lib/netstandard2.0/pl/FSharp.Core.resources.dll",
        "lib/netstandard2.0/pt-BR/FSharp.Core.resources.dll",
        "lib/netstandard2.0/ru/FSharp.Core.resources.dll",
        "lib/netstandard2.0/tr/FSharp.Core.resources.dll",
        "lib/netstandard2.0/zh-Hans/FSharp.Core.resources.dll",
        "lib/netstandard2.0/zh-Hant/FSharp.Core.resources.dll",
    ],
)
import_library(
    name = "net471",
    target_framework = "net471",
    dll = "lib/netstandard2.0/FSharp.Core.dll",
    refdll = "lib/netstandard2.0/FSharp.Core.dll",
    deps = [
    ],
    data = [
        "lib/netstandard2.0/cs/FSharp.Core.resources.dll",
        "lib/netstandard2.0/de/FSharp.Core.resources.dll",
        "lib/netstandard2.0/es/FSharp.Core.resources.dll",
        "lib/netstandard2.0/fr/FSharp.Core.resources.dll",
        "lib/netstandard2.0/FSharp.Core.dll",
        "lib/netstandard2.0/FSharp.Core.xml",
        "lib/netstandard2.0/it/FSharp.Core.resources.dll",
        "lib/netstandard2.0/ja/FSharp.Core.resources.dll",
        "lib/netstandard2.0/ko/FSharp.Core.resources.dll",
        "lib/netstandard2.0/pl/FSharp.Core.resources.dll",
        "lib/netstandard2.0/pt-BR/FSharp.Core.resources.dll",
        "lib/netstandard2.0/ru/FSharp.Core.resources.dll",
        "lib/netstandard2.0/tr/FSharp.Core.resources.dll",
        "lib/netstandard2.0/zh-Hans/FSharp.Core.resources.dll",
        "lib/netstandard2.0/zh-Hant/FSharp.Core.resources.dll",
    ],
)
import_library(
    name = "net472",
    target_framework = "net472",
    dll = "lib/netstandard2.0/FSharp.Core.dll",
    refdll = "lib/netstandard2.0/FSharp.Core.dll",
    deps = [
    ],
    data = [
        "lib/netstandard2.0/cs/FSharp.Core.resources.dll",
        "lib/netstandard2.0/de/FSharp.Core.resources.dll",
        "lib/netstandard2.0/es/FSharp.Core.resources.dll",
        "lib/netstandard2.0/fr/FSharp.Core.resources.dll",
        "lib/netstandard2.0/FSharp.Core.dll",
        "lib/netstandard2.0/FSharp.Core.xml",
        "lib/netstandard2.0/it/FSharp.Core.resources.dll",
        "lib/netstandard2.0/ja/FSharp.Core.resources.dll",
        "lib/netstandard2.0/ko/FSharp.Core.resources.dll",
        "lib/netstandard2.0/pl/FSharp.Core.resources.dll",
        "lib/netstandard2.0/pt-BR/FSharp.Core.resources.dll",
        "lib/netstandard2.0/ru/FSharp.Core.resources.dll",
        "lib/netstandard2.0/tr/FSharp.Core.resources.dll",
        "lib/netstandard2.0/zh-Hans/FSharp.Core.resources.dll",
        "lib/netstandard2.0/zh-Hant/FSharp.Core.resources.dll",
    ],
)
import_library(
    name = "net48",
    target_framework = "net48",
    dll = "lib/netstandard2.0/FSharp.Core.dll",
    refdll = "lib/netstandard2.0/FSharp.Core.dll",
    deps = [
    ],
    data = [
        "lib/netstandard2.0/cs/FSharp.Core.resources.dll",
        "lib/netstandard2.0/de/FSharp.Core.resources.dll",
        "lib/netstandard2.0/es/FSharp.Core.resources.dll",
        "lib/netstandard2.0/fr/FSharp.Core.resources.dll",
        "lib/netstandard2.0/FSharp.Core.dll",
        "lib/netstandard2.0/FSharp.Core.xml",
        "lib/netstandard2.0/it/FSharp.Core.resources.dll",
        "lib/netstandard2.0/ja/FSharp.Core.resources.dll",
        "lib/netstandard2.0/ko/FSharp.Core.resources.dll",
        "lib/netstandard2.0/pl/FSharp.Core.resources.dll",
        "lib/netstandard2.0/pt-BR/FSharp.Core.resources.dll",
        "lib/netstandard2.0/ru/FSharp.Core.resources.dll",
        "lib/netstandard2.0/tr/FSharp.Core.resources.dll",
        "lib/netstandard2.0/zh-Hans/FSharp.Core.resources.dll",
        "lib/netstandard2.0/zh-Hant/FSharp.Core.resources.dll",
    ],
)
import_library(
    name = "netstandard",
    target_framework = "netstandard",
    deps = [
    ],
    data = [
    ],
)
import_library(
    name = "netstandard1.0",
    target_framework = "netstandard1.0",
    deps = [
    ],
    data = [
    ],
)
import_library(
    name = "netstandard1.1",
    target_framework = "netstandard1.1",
    deps = [
    ],
    data = [
    ],
)
import_library(
    name = "netstandard1.2",
    target_framework = "netstandard1.2",
    deps = [
    ],
    data = [
    ],
)
import_library(
    name = "netstandard1.3",
    target_framework = "netstandard1.3",
    deps = [
    ],
    data = [
    ],
)
import_library(
    name = "netstandard1.4",
    target_framework = "netstandard1.4",
    deps = [
    ],
    data = [
    ],
)
import_library(
    name = "netstandard1.5",
    target_framework = "netstandard1.5",
    deps = [
    ],
    data = [
    ],
)
import_library(
    name = "netstandard1.6",
    target_framework = "netstandard1.6",
    deps = [
    ],
    data = [
    ],
)
import_library(
    name = "netstandard2.0",
    target_framework = "netstandard2.0",
    dll = "lib/netstandard2.0/FSharp.Core.dll",
    refdll = "lib/netstandard2.0/FSharp.Core.dll",
    deps = [
    ],
    data = [
        "lib/netstandard2.0/cs/FSharp.Core.resources.dll",
        "lib/netstandard2.0/de/FSharp.Core.resources.dll",
        "lib/netstandard2.0/es/FSharp.Core.resources.dll",
        "lib/netstandard2.0/fr/FSharp.Core.resources.dll",
        "lib/netstandard2.0/FSharp.Core.dll",
        "lib/netstandard2.0/FSharp.Core.xml",
        "lib/netstandard2.0/it/FSharp.Core.resources.dll",
        "lib/netstandard2.0/ja/FSharp.Core.resources.dll",
        "lib/netstandard2.0/ko/FSharp.Core.resources.dll",
        "lib/netstandard2.0/pl/FSharp.Core.resources.dll",
        "lib/netstandard2.0/pt-BR/FSharp.Core.resources.dll",
        "lib/netstandard2.0/ru/FSharp.Core.resources.dll",
        "lib/netstandard2.0/tr/FSharp.Core.resources.dll",
        "lib/netstandard2.0/zh-Hans/FSharp.Core.resources.dll",
        "lib/netstandard2.0/zh-Hant/FSharp.Core.resources.dll",
    ],
)
import_library(
    name = "netstandard2.1",
    target_framework = "netstandard2.1",
    dll = "lib/netstandard2.1/FSharp.Core.dll",
    refdll = "lib/netstandard2.1/FSharp.Core.dll",
    deps = [
    ],
    data = [
        "lib/netstandard2.1/cs/FSharp.Core.resources.dll",
        "lib/netstandard2.1/de/FSharp.Core.resources.dll",
        "lib/netstandard2.1/es/FSharp.Core.resources.dll",
        "lib/netstandard2.1/fr/FSharp.Core.resources.dll",
        "lib/netstandard2.1/FSharp.Core.dll",
        "lib/netstandard2.1/FSharp.Core.xml",
        "lib/netstandard2.1/it/FSharp.Core.resources.dll",
        "lib/netstandard2.1/ja/FSharp.Core.resources.dll",
        "lib/netstandard2.1/ko/FSharp.Core.resources.dll",
        "lib/netstandard2.1/pl/FSharp.Core.resources.dll",
        "lib/netstandard2.1/pt-BR/FSharp.Core.resources.dll",
        "lib/netstandard2.1/ru/FSharp.Core.resources.dll",
        "lib/netstandard2.1/tr/FSharp.Core.resources.dll",
        "lib/netstandard2.1/zh-Hans/FSharp.Core.resources.dll",
        "lib/netstandard2.1/zh-Hant/FSharp.Core.resources.dll",
    ],
)
import_library(
    name = "netcoreapp1.0",
    target_framework = "netcoreapp1.0",
    deps = [
    ],
    data = [
    ],
)
import_library(
    name = "netcoreapp1.1",
    target_framework = "netcoreapp1.1",
    deps = [
    ],
    data = [
    ],
)
import_library(
    name = "netcoreapp2.0",
    target_framework = "netcoreapp2.0",
    dll = "lib/netstandard2.0/FSharp.Core.dll",
    refdll = "lib/netstandard2.0/FSharp.Core.dll",
    deps = [
    ],
    data = [
        "lib/netstandard2.0/cs/FSharp.Core.resources.dll",
        "lib/netstandard2.0/de/FSharp.Core.resources.dll",
        "lib/netstandard2.0/es/FSharp.Core.resources.dll",
        "lib/netstandard2.0/fr/FSharp.Core.resources.dll",
        "lib/netstandard2.0/FSharp.Core.dll",
        "lib/netstandard2.0/FSharp.Core.xml",
        "lib/netstandard2.0/it/FSharp.Core.resources.dll",
        "lib/netstandard2.0/ja/FSharp.Core.resources.dll",
        "lib/netstandard2.0/ko/FSharp.Core.resources.dll",
        "lib/netstandard2.0/pl/FSharp.Core.resources.dll",
        "lib/netstandard2.0/pt-BR/FSharp.Core.resources.dll",
        "lib/netstandard2.0/ru/FSharp.Core.resources.dll",
        "lib/netstandard2.0/tr/FSharp.Core.resources.dll",
        "lib/netstandard2.0/zh-Hans/FSharp.Core.resources.dll",
        "lib/netstandard2.0/zh-Hant/FSharp.Core.resources.dll",
    ],
)
import_library(
    name = "netcoreapp2.1",
    target_framework = "netcoreapp2.1",
    dll = "lib/netstandard2.0/FSharp.Core.dll",
    refdll = "lib/netstandard2.0/FSharp.Core.dll",
    deps = [
    ],
    data = [
        "lib/netstandard2.0/cs/FSharp.Core.resources.dll",
        "lib/netstandard2.0/de/FSharp.Core.resources.dll",
        "lib/netstandard2.0/es/FSharp.Core.resources.dll",
        "lib/netstandard2.0/fr/FSharp.Core.resources.dll",
        "lib/netstandard2.0/FSharp.Core.dll",
        "lib/netstandard2.0/FSharp.Core.xml",
        "lib/netstandard2.0/it/FSharp.Core.resources.dll",
        "lib/netstandard2.0/ja/FSharp.Core.resources.dll",
        "lib/netstandard2.0/ko/FSharp.Core.resources.dll",
        "lib/netstandard2.0/pl/FSharp.Core.resources.dll",
        "lib/netstandard2.0/pt-BR/FSharp.Core.resources.dll",
        "lib/netstandard2.0/ru/FSharp.Core.resources.dll",
        "lib/netstandard2.0/tr/FSharp.Core.resources.dll",
        "lib/netstandard2.0/zh-Hans/FSharp.Core.resources.dll",
        "lib/netstandard2.0/zh-Hant/FSharp.Core.resources.dll",
    ],
)
import_library(
    name = "netcoreapp2.2",
    target_framework = "netcoreapp2.2",
    dll = "lib/netstandard2.0/FSharp.Core.dll",
    refdll = "lib/netstandard2.0/FSharp.Core.dll",
    deps = [
    ],
    data = [
        "lib/netstandard2.0/cs/FSharp.Core.resources.dll",
        "lib/netstandard2.0/de/FSharp.Core.resources.dll",
        "lib/netstandard2.0/es/FSharp.Core.resources.dll",
        "lib/netstandard2.0/fr/FSharp.Core.resources.dll",
        "lib/netstandard2.0/FSharp.Core.dll",
        "lib/netstandard2.0/FSharp.Core.xml",
        "lib/netstandard2.0/it/FSharp.Core.resources.dll",
        "lib/netstandard2.0/ja/FSharp.Core.resources.dll",
        "lib/netstandard2.0/ko/FSharp.Core.resources.dll",
        "lib/netstandard2.0/pl/FSharp.Core.resources.dll",
        "lib/netstandard2.0/pt-BR/FSharp.Core.resources.dll",
        "lib/netstandard2.0/ru/FSharp.Core.resources.dll",
        "lib/netstandard2.0/tr/FSharp.Core.resources.dll",
        "lib/netstandard2.0/zh-Hans/FSharp.Core.resources.dll",
        "lib/netstandard2.0/zh-Hant/FSharp.Core.resources.dll",
    ],
)
import_library(
    name = "netcoreapp3.0",
    target_framework = "netcoreapp3.0",
    dll = "lib/netstandard2.1/FSharp.Core.dll",
    refdll = "lib/netstandard2.1/FSharp.Core.dll",
    deps = [
    ],
    data = [
        "lib/netstandard2.1/cs/FSharp.Core.resources.dll",
        "lib/netstandard2.1/de/FSharp.Core.resources.dll",
        "lib/netstandard2.1/es/FSharp.Core.resources.dll",
        "lib/netstandard2.1/fr/FSharp.Core.resources.dll",
        "lib/netstandard2.1/FSharp.Core.dll",
        "lib/netstandard2.1/FSharp.Core.xml",
        "lib/netstandard2.1/it/FSharp.Core.resources.dll",
        "lib/netstandard2.1/ja/FSharp.Core.resources.dll",
        "lib/netstandard2.1/ko/FSharp.Core.resources.dll",
        "lib/netstandard2.1/pl/FSharp.Core.resources.dll",
        "lib/netstandard2.1/pt-BR/FSharp.Core.resources.dll",
        "lib/netstandard2.1/ru/FSharp.Core.resources.dll",
        "lib/netstandard2.1/tr/FSharp.Core.resources.dll",
        "lib/netstandard2.1/zh-Hans/FSharp.Core.resources.dll",
        "lib/netstandard2.1/zh-Hant/FSharp.Core.resources.dll",
    ],
)
import_library(
    name = "netcoreapp3.1",
    target_framework = "netcoreapp3.1",
    dll = "lib/netstandard2.1/FSharp.Core.dll",
    refdll = "lib/netstandard2.1/FSharp.Core.dll",
    deps = [
    ],
    data = [
        "lib/netstandard2.1/cs/FSharp.Core.resources.dll",
        "lib/netstandard2.1/de/FSharp.Core.resources.dll",
        "lib/netstandard2.1/es/FSharp.Core.resources.dll",
        "lib/netstandard2.1/fr/FSharp.Core.resources.dll",
        "lib/netstandard2.1/FSharp.Core.dll",
        "lib/netstandard2.1/FSharp.Core.xml",
        "lib/netstandard2.1/it/FSharp.Core.resources.dll",
        "lib/netstandard2.1/ja/FSharp.Core.resources.dll",
        "lib/netstandard2.1/ko/FSharp.Core.resources.dll",
        "lib/netstandard2.1/pl/FSharp.Core.resources.dll",
        "lib/netstandard2.1/pt-BR/FSharp.Core.resources.dll",
        "lib/netstandard2.1/ru/FSharp.Core.resources.dll",
        "lib/netstandard2.1/tr/FSharp.Core.resources.dll",
        "lib/netstandard2.1/zh-Hans/FSharp.Core.resources.dll",
        "lib/netstandard2.1/zh-Hant/FSharp.Core.resources.dll",
    ],
)
import_library(
    name = "net5.0",
    target_framework = "net5.0",
    dll = "lib/netstandard2.1/FSharp.Core.dll",
    refdll = "lib/netstandard2.1/FSharp.Core.dll",
    deps = [
    ],
    data = [
        "lib/netstandard2.1/cs/FSharp.Core.resources.dll",
        "lib/netstandard2.1/de/FSharp.Core.resources.dll",
        "lib/netstandard2.1/es/FSharp.Core.resources.dll",
        "lib/netstandard2.1/fr/FSharp.Core.resources.dll",
        "lib/netstandard2.1/FSharp.Core.dll",
        "lib/netstandard2.1/FSharp.Core.xml",
        "lib/netstandard2.1/it/FSharp.Core.resources.dll",
        "lib/netstandard2.1/ja/FSharp.Core.resources.dll",
        "lib/netstandard2.1/ko/FSharp.Core.resources.dll",
        "lib/netstandard2.1/pl/FSharp.Core.resources.dll",
        "lib/netstandard2.1/pt-BR/FSharp.Core.resources.dll",
        "lib/netstandard2.1/ru/FSharp.Core.resources.dll",
        "lib/netstandard2.1/tr/FSharp.Core.resources.dll",
        "lib/netstandard2.1/zh-Hans/FSharp.Core.resources.dll",
        "lib/netstandard2.1/zh-Hant/FSharp.Core.resources.dll",
    ],
)
import_library(
    name = "net6.0",
    target_framework = "net6.0",
    dll = "lib/netstandard2.1/FSharp.Core.dll",
    refdll = "lib/netstandard2.1/FSharp.Core.dll",
    deps = [
    ],
    data = [
        "lib/netstandard2.1/cs/FSharp.Core.resources.dll",
        "lib/netstandard2.1/de/FSharp.Core.resources.dll",
        "lib/netstandard2.1/es/FSharp.Core.resources.dll",
        "lib/netstandard2.1/fr/FSharp.Core.resources.dll",
        "lib/netstandard2.1/FSharp.Core.dll",
        "lib/netstandard2.1/FSharp.Core.xml",
        "lib/netstandard2.1/it/FSharp.Core.resources.dll",
        "lib/netstandard2.1/ja/FSharp.Core.resources.dll",
        "lib/netstandard2.1/ko/FSharp.Core.resources.dll",
        "lib/netstandard2.1/pl/FSharp.Core.resources.dll",
        "lib/netstandard2.1/pt-BR/FSharp.Core.resources.dll",
        "lib/netstandard2.1/ru/FSharp.Core.resources.dll",
        "lib/netstandard2.1/tr/FSharp.Core.resources.dll",
        "lib/netstandard2.1/zh-Hans/FSharp.Core.resources.dll",
        "lib/netstandard2.1/zh-Hant/FSharp.Core.resources.dll",
    ],
)
import_multiframework_library(
    name = "lib",
    net11 = ":net11",
    net20 = ":net20",
    net35 = ":net35",
    net40 = ":net40",
    net403 = ":net403",
    net45 = ":net45",
    net451 = ":net451",
    net452 = ":net452",
    net46 = ":net46",
    net461 = ":net461",
    net462 = ":net462",
    net47 = ":net47",
    net471 = ":net471",
    net472 = ":net472",
    net48 = ":net48",
    netstandard = ":netstandard",
    netstandard1_0 = ":netstandard1.0",
    netstandard1_1 = ":netstandard1.1",
    netstandard1_2 = ":netstandard1.2",
    netstandard1_3 = ":netstandard1.3",
    netstandard1_4 = ":netstandard1.4",
    netstandard1_5 = ":netstandard1.5",
    netstandard1_6 = ":netstandard1.6",
    netstandard2_0 = ":netstandard2.0",
    netstandard2_1 = ":netstandard2.1",
    netcoreapp1_0 = ":netcoreapp1.0",
    netcoreapp1_1 = ":netcoreapp1.1",
    netcoreapp2_0 = ":netcoreapp2.0",
    netcoreapp2_1 = ":netcoreapp2.1",
    netcoreapp2_2 = ":netcoreapp2.2",
    netcoreapp3_0 = ":netcoreapp3.0",
    netcoreapp3_1 = ":netcoreapp3.1",
    net5_0 = ":net5.0",
    net6_0 = ":net6.0",
    visibility = ["//visibility:public"],
)
"""
    )
    nuget_package(
        name = "main.microsoft.win32.systemevents",
        package = "microsoft.win32.systemevents",
        version = "6.0.1",
        sha256 = "c24f2857b8c765f4b1297e4f0dc5774bfa529ec685ab89abf1f6a4bc923857d5",
        build_file_content = """
load("@rules_dotnet//dotnet:defs.bzl", "import_library", "import_multiframework_library")
import_library(
    name = "net11",
    target_framework = "net11",
    deps = [
    ],
    data = [
    ],
)
import_library(
    name = "net20",
    target_framework = "net20",
    deps = [
    ],
    data = [
    ],
)
import_library(
    name = "net35",
    target_framework = "net35",
    deps = [
    ],
    data = [
    ],
)
import_library(
    name = "net40",
    target_framework = "net40",
    deps = [
    ],
    data = [
    ],
)
import_library(
    name = "net403",
    target_framework = "net403",
    deps = [
    ],
    data = [
    ],
)
import_library(
    name = "net45",
    target_framework = "net45",
    deps = [
    ],
    data = [
    ],
)
import_library(
    name = "net451",
    target_framework = "net451",
    deps = [
    ],
    data = [
    ],
)
import_library(
    name = "net452",
    target_framework = "net452",
    deps = [
    ],
    data = [
    ],
)
import_library(
    name = "net46",
    target_framework = "net46",
    deps = [
    ],
    data = [
    ],
)
import_library(
    name = "net461",
    target_framework = "net461",
    dll = "lib/net461/Microsoft.Win32.SystemEvents.dll",
    refdll = "lib/net461/Microsoft.Win32.SystemEvents.dll",
    deps = [
    ],
    data = [
        "lib/net461/Microsoft.Win32.SystemEvents.dll",
        "lib/net461/Microsoft.Win32.SystemEvents.xml",
    ],
)
import_library(
    name = "net462",
    target_framework = "net462",
    dll = "lib/net461/Microsoft.Win32.SystemEvents.dll",
    refdll = "lib/net461/Microsoft.Win32.SystemEvents.dll",
    deps = [
    ],
    data = [
        "lib/net461/Microsoft.Win32.SystemEvents.dll",
        "lib/net461/Microsoft.Win32.SystemEvents.xml",
    ],
)
import_library(
    name = "net47",
    target_framework = "net47",
    dll = "lib/net461/Microsoft.Win32.SystemEvents.dll",
    refdll = "lib/net461/Microsoft.Win32.SystemEvents.dll",
    deps = [
    ],
    data = [
        "lib/net461/Microsoft.Win32.SystemEvents.dll",
        "lib/net461/Microsoft.Win32.SystemEvents.xml",
    ],
)
import_library(
    name = "net471",
    target_framework = "net471",
    dll = "lib/net461/Microsoft.Win32.SystemEvents.dll",
    refdll = "lib/net461/Microsoft.Win32.SystemEvents.dll",
    deps = [
    ],
    data = [
        "lib/net461/Microsoft.Win32.SystemEvents.dll",
        "lib/net461/Microsoft.Win32.SystemEvents.xml",
    ],
)
import_library(
    name = "net472",
    target_framework = "net472",
    dll = "lib/net461/Microsoft.Win32.SystemEvents.dll",
    refdll = "lib/net461/Microsoft.Win32.SystemEvents.dll",
    deps = [
    ],
    data = [
        "lib/net461/Microsoft.Win32.SystemEvents.dll",
        "lib/net461/Microsoft.Win32.SystemEvents.xml",
    ],
)
import_library(
    name = "net48",
    target_framework = "net48",
    dll = "lib/net461/Microsoft.Win32.SystemEvents.dll",
    refdll = "lib/net461/Microsoft.Win32.SystemEvents.dll",
    deps = [
    ],
    data = [
        "lib/net461/Microsoft.Win32.SystemEvents.dll",
        "lib/net461/Microsoft.Win32.SystemEvents.xml",
    ],
)
import_library(
    name = "netstandard",
    target_framework = "netstandard",
    deps = [
    ],
    data = [
    ],
)
import_library(
    name = "netstandard1.0",
    target_framework = "netstandard1.0",
    deps = [
    ],
    data = [
    ],
)
import_library(
    name = "netstandard1.1",
    target_framework = "netstandard1.1",
    deps = [
    ],
    data = [
    ],
)
import_library(
    name = "netstandard1.2",
    target_framework = "netstandard1.2",
    deps = [
    ],
    data = [
    ],
)
import_library(
    name = "netstandard1.3",
    target_framework = "netstandard1.3",
    deps = [
    ],
    data = [
    ],
)
import_library(
    name = "netstandard1.4",
    target_framework = "netstandard1.4",
    deps = [
    ],
    data = [
    ],
)
import_library(
    name = "netstandard1.5",
    target_framework = "netstandard1.5",
    deps = [
    ],
    data = [
    ],
)
import_library(
    name = "netstandard1.6",
    target_framework = "netstandard1.6",
    deps = [
    ],
    data = [
    ],
)
import_library(
    name = "netstandard2.0",
    target_framework = "netstandard2.0",
    dll = "lib/netstandard2.0/Microsoft.Win32.SystemEvents.dll",
    refdll = "lib/netstandard2.0/Microsoft.Win32.SystemEvents.dll",
    deps = [
    ],
    data = [
        "lib/netstandard2.0/Microsoft.Win32.SystemEvents.dll",
        "lib/netstandard2.0/Microsoft.Win32.SystemEvents.xml",
    ],
)
import_library(
    name = "netstandard2.1",
    target_framework = "netstandard2.1",
    dll = "lib/netstandard2.0/Microsoft.Win32.SystemEvents.dll",
    refdll = "lib/netstandard2.0/Microsoft.Win32.SystemEvents.dll",
    deps = [
    ],
    data = [
        "lib/netstandard2.0/Microsoft.Win32.SystemEvents.dll",
        "lib/netstandard2.0/Microsoft.Win32.SystemEvents.xml",
    ],
)
import_library(
    name = "netcoreapp1.0",
    target_framework = "netcoreapp1.0",
    deps = [
    ],
    data = [
    ],
)
import_library(
    name = "netcoreapp1.1",
    target_framework = "netcoreapp1.1",
    deps = [
    ],
    data = [
    ],
)
import_library(
    name = "netcoreapp2.0",
    target_framework = "netcoreapp2.0",
    dll = "lib/netstandard2.0/Microsoft.Win32.SystemEvents.dll",
    refdll = "lib/netstandard2.0/Microsoft.Win32.SystemEvents.dll",
    deps = [
    ],
    data = [
        "lib/netstandard2.0/Microsoft.Win32.SystemEvents.dll",
        "lib/netstandard2.0/Microsoft.Win32.SystemEvents.xml",
    ],
)
import_library(
    name = "netcoreapp2.1",
    target_framework = "netcoreapp2.1",
    dll = "lib/netstandard2.0/Microsoft.Win32.SystemEvents.dll",
    refdll = "lib/netstandard2.0/Microsoft.Win32.SystemEvents.dll",
    deps = [
    ],
    data = [
        "lib/netstandard2.0/Microsoft.Win32.SystemEvents.dll",
        "lib/netstandard2.0/Microsoft.Win32.SystemEvents.xml",
    ],
)
import_library(
    name = "netcoreapp2.2",
    target_framework = "netcoreapp2.2",
    dll = "lib/netstandard2.0/Microsoft.Win32.SystemEvents.dll",
    refdll = "lib/netstandard2.0/Microsoft.Win32.SystemEvents.dll",
    deps = [
    ],
    data = [
        "lib/netstandard2.0/Microsoft.Win32.SystemEvents.dll",
        "lib/netstandard2.0/Microsoft.Win32.SystemEvents.xml",
    ],
)
import_library(
    name = "netcoreapp3.0",
    target_framework = "netcoreapp3.0",
    dll = "lib/netstandard2.0/Microsoft.Win32.SystemEvents.dll",
    refdll = "lib/netstandard2.0/Microsoft.Win32.SystemEvents.dll",
    deps = [
    ],
    data = [
        "lib/netstandard2.0/Microsoft.Win32.SystemEvents.dll",
        "lib/netstandard2.0/Microsoft.Win32.SystemEvents.xml",
    ],
)
import_library(
    name = "netcoreapp3.1",
    target_framework = "netcoreapp3.1",
    dll = "lib/netcoreapp3.1/Microsoft.Win32.SystemEvents.dll",
    refdll = "lib/netcoreapp3.1/Microsoft.Win32.SystemEvents.dll",
    deps = [
    ],
    data = [
        "lib/netcoreapp3.1/Microsoft.Win32.SystemEvents.dll",
        "lib/netcoreapp3.1/Microsoft.Win32.SystemEvents.xml",
    ],
)
import_library(
    name = "net5.0",
    target_framework = "net5.0",
    dll = "lib/netcoreapp3.1/Microsoft.Win32.SystemEvents.dll",
    refdll = "lib/netcoreapp3.1/Microsoft.Win32.SystemEvents.dll",
    deps = [
    ],
    data = [
        "lib/netcoreapp3.1/Microsoft.Win32.SystemEvents.dll",
        "lib/netcoreapp3.1/Microsoft.Win32.SystemEvents.xml",
    ],
)
import_library(
    name = "net6.0",
    target_framework = "net6.0",
    dll = "lib/net6.0/Microsoft.Win32.SystemEvents.dll",
    refdll = "lib/net6.0/Microsoft.Win32.SystemEvents.dll",
    deps = [
    ],
    data = [
        "lib/net6.0/Microsoft.Win32.SystemEvents.dll",
        "lib/net6.0/Microsoft.Win32.SystemEvents.xml",
    ],
)
import_multiframework_library(
    name = "lib",
    net11 = ":net11",
    net20 = ":net20",
    net35 = ":net35",
    net40 = ":net40",
    net403 = ":net403",
    net45 = ":net45",
    net451 = ":net451",
    net452 = ":net452",
    net46 = ":net46",
    net461 = ":net461",
    net462 = ":net462",
    net47 = ":net47",
    net471 = ":net471",
    net472 = ":net472",
    net48 = ":net48",
    netstandard = ":netstandard",
    netstandard1_0 = ":netstandard1.0",
    netstandard1_1 = ":netstandard1.1",
    netstandard1_2 = ":netstandard1.2",
    netstandard1_3 = ":netstandard1.3",
    netstandard1_4 = ":netstandard1.4",
    netstandard1_5 = ":netstandard1.5",
    netstandard1_6 = ":netstandard1.6",
    netstandard2_0 = ":netstandard2.0",
    netstandard2_1 = ":netstandard2.1",
    netcoreapp1_0 = ":netcoreapp1.0",
    netcoreapp1_1 = ":netcoreapp1.1",
    netcoreapp2_0 = ":netcoreapp2.0",
    netcoreapp2_1 = ":netcoreapp2.1",
    netcoreapp2_2 = ":netcoreapp2.2",
    netcoreapp3_0 = ":netcoreapp3.0",
    netcoreapp3_1 = ":netcoreapp3.1",
    net5_0 = ":net5.0",
    net6_0 = ":net6.0",
    visibility = ["//visibility:public"],
)
"""
    )
    nuget_package(
        name = "main.system.configuration.configurationmanager",
        package = "system.configuration.configurationmanager",
        version = "6.0.0",
        sha256 = "7cf57aebc09f8bef29356aef1806ab1787dec1d3d5103c25256bc9934cbe0a6b",
        build_file_content = """
load("@rules_dotnet//dotnet:defs.bzl", "import_library", "import_multiframework_library")
import_library(
    name = "net11",
    target_framework = "net11",
    deps = [
    ],
    data = [
    ],
)
import_library(
    name = "net20",
    target_framework = "net20",
    deps = [
    ],
    data = [
    ],
)
import_library(
    name = "net35",
    target_framework = "net35",
    deps = [
    ],
    data = [
    ],
)
import_library(
    name = "net40",
    target_framework = "net40",
    deps = [
    ],
    data = [
    ],
)
import_library(
    name = "net403",
    target_framework = "net403",
    deps = [
    ],
    data = [
    ],
)
import_library(
    name = "net45",
    target_framework = "net45",
    deps = [
    ],
    data = [
    ],
)
import_library(
    name = "net451",
    target_framework = "net451",
    deps = [
    ],
    data = [
    ],
)
import_library(
    name = "net452",
    target_framework = "net452",
    deps = [
    ],
    data = [
    ],
)
import_library(
    name = "net46",
    target_framework = "net46",
    deps = [
    ],
    data = [
    ],
)
import_library(
    name = "net461",
    target_framework = "net461",
    dll = "lib/net461/System.Configuration.ConfigurationManager.dll",
    refdll = "lib/net461/System.Configuration.ConfigurationManager.dll",
    deps = [
        "@main.system.security.permissions//:lib",
    ],
    data = [
        "lib/net461/System.Configuration.ConfigurationManager.dll",
        "lib/net461/System.Configuration.ConfigurationManager.xml",
    ],
)
import_library(
    name = "net462",
    target_framework = "net462",
    dll = "lib/net461/System.Configuration.ConfigurationManager.dll",
    refdll = "lib/net461/System.Configuration.ConfigurationManager.dll",
    deps = [
        "@main.system.security.permissions//:lib",
    ],
    data = [
        "lib/net461/System.Configuration.ConfigurationManager.dll",
        "lib/net461/System.Configuration.ConfigurationManager.xml",
    ],
)
import_library(
    name = "net47",
    target_framework = "net47",
    dll = "lib/net461/System.Configuration.ConfigurationManager.dll",
    refdll = "lib/net461/System.Configuration.ConfigurationManager.dll",
    deps = [
        "@main.system.security.permissions//:lib",
    ],
    data = [
        "lib/net461/System.Configuration.ConfigurationManager.dll",
        "lib/net461/System.Configuration.ConfigurationManager.xml",
    ],
)
import_library(
    name = "net471",
    target_framework = "net471",
    dll = "lib/net461/System.Configuration.ConfigurationManager.dll",
    refdll = "lib/net461/System.Configuration.ConfigurationManager.dll",
    deps = [
        "@main.system.security.permissions//:lib",
    ],
    data = [
        "lib/net461/System.Configuration.ConfigurationManager.dll",
        "lib/net461/System.Configuration.ConfigurationManager.xml",
    ],
)
import_library(
    name = "net472",
    target_framework = "net472",
    dll = "lib/net461/System.Configuration.ConfigurationManager.dll",
    refdll = "lib/net461/System.Configuration.ConfigurationManager.dll",
    deps = [
        "@main.system.security.permissions//:lib",
    ],
    data = [
        "lib/net461/System.Configuration.ConfigurationManager.dll",
        "lib/net461/System.Configuration.ConfigurationManager.xml",
    ],
)
import_library(
    name = "net48",
    target_framework = "net48",
    dll = "lib/net461/System.Configuration.ConfigurationManager.dll",
    refdll = "lib/net461/System.Configuration.ConfigurationManager.dll",
    deps = [
        "@main.system.security.permissions//:lib",
    ],
    data = [
        "lib/net461/System.Configuration.ConfigurationManager.dll",
        "lib/net461/System.Configuration.ConfigurationManager.xml",
    ],
)
import_library(
    name = "netstandard",
    target_framework = "netstandard",
    deps = [
    ],
    data = [
    ],
)
import_library(
    name = "netstandard1.0",
    target_framework = "netstandard1.0",
    deps = [
    ],
    data = [
    ],
)
import_library(
    name = "netstandard1.1",
    target_framework = "netstandard1.1",
    deps = [
    ],
    data = [
    ],
)
import_library(
    name = "netstandard1.2",
    target_framework = "netstandard1.2",
    deps = [
    ],
    data = [
    ],
)
import_library(
    name = "netstandard1.3",
    target_framework = "netstandard1.3",
    deps = [
    ],
    data = [
    ],
)
import_library(
    name = "netstandard1.4",
    target_framework = "netstandard1.4",
    deps = [
    ],
    data = [
    ],
)
import_library(
    name = "netstandard1.5",
    target_framework = "netstandard1.5",
    deps = [
    ],
    data = [
    ],
)
import_library(
    name = "netstandard1.6",
    target_framework = "netstandard1.6",
    deps = [
    ],
    data = [
    ],
)
import_library(
    name = "netstandard2.0",
    target_framework = "netstandard2.0",
    dll = "lib/netstandard2.0/System.Configuration.ConfigurationManager.dll",
    refdll = "lib/netstandard2.0/System.Configuration.ConfigurationManager.dll",
    deps = [
        "@main.system.security.cryptography.protecteddata//:lib",
        "@main.system.security.permissions//:lib",
    ],
    data = [
        "lib/netstandard2.0/System.Configuration.ConfigurationManager.dll",
        "lib/netstandard2.0/System.Configuration.ConfigurationManager.xml",
    ],
)
import_library(
    name = "netstandard2.1",
    target_framework = "netstandard2.1",
    dll = "lib/netstandard2.0/System.Configuration.ConfigurationManager.dll",
    refdll = "lib/netstandard2.0/System.Configuration.ConfigurationManager.dll",
    deps = [
        "@main.system.security.cryptography.protecteddata//:lib",
        "@main.system.security.permissions//:lib",
    ],
    data = [
        "lib/netstandard2.0/System.Configuration.ConfigurationManager.dll",
        "lib/netstandard2.0/System.Configuration.ConfigurationManager.xml",
    ],
)
import_library(
    name = "netcoreapp1.0",
    target_framework = "netcoreapp1.0",
    deps = [
    ],
    data = [
    ],
)
import_library(
    name = "netcoreapp1.1",
    target_framework = "netcoreapp1.1",
    deps = [
    ],
    data = [
    ],
)
import_library(
    name = "netcoreapp2.0",
    target_framework = "netcoreapp2.0",
    dll = "lib/netstandard2.0/System.Configuration.ConfigurationManager.dll",
    refdll = "lib/netstandard2.0/System.Configuration.ConfigurationManager.dll",
    deps = [
        "@main.system.security.cryptography.protecteddata//:lib",
        "@main.system.security.permissions//:lib",
    ],
    data = [
        "lib/netstandard2.0/System.Configuration.ConfigurationManager.dll",
        "lib/netstandard2.0/System.Configuration.ConfigurationManager.xml",
    ],
)
import_library(
    name = "netcoreapp2.1",
    target_framework = "netcoreapp2.1",
    dll = "lib/netstandard2.0/System.Configuration.ConfigurationManager.dll",
    refdll = "lib/netstandard2.0/System.Configuration.ConfigurationManager.dll",
    deps = [
        "@main.system.security.cryptography.protecteddata//:lib",
        "@main.system.security.permissions//:lib",
    ],
    data = [
        "lib/netstandard2.0/System.Configuration.ConfigurationManager.dll",
        "lib/netstandard2.0/System.Configuration.ConfigurationManager.xml",
    ],
)
import_library(
    name = "netcoreapp2.2",
    target_framework = "netcoreapp2.2",
    dll = "lib/netstandard2.0/System.Configuration.ConfigurationManager.dll",
    refdll = "lib/netstandard2.0/System.Configuration.ConfigurationManager.dll",
    deps = [
        "@main.system.security.cryptography.protecteddata//:lib",
        "@main.system.security.permissions//:lib",
    ],
    data = [
        "lib/netstandard2.0/System.Configuration.ConfigurationManager.dll",
        "lib/netstandard2.0/System.Configuration.ConfigurationManager.xml",
    ],
)
import_library(
    name = "netcoreapp3.0",
    target_framework = "netcoreapp3.0",
    dll = "lib/netstandard2.0/System.Configuration.ConfigurationManager.dll",
    refdll = "lib/netstandard2.0/System.Configuration.ConfigurationManager.dll",
    deps = [
        "@main.system.security.cryptography.protecteddata//:lib",
        "@main.system.security.permissions//:lib",
    ],
    data = [
        "lib/netstandard2.0/System.Configuration.ConfigurationManager.dll",
        "lib/netstandard2.0/System.Configuration.ConfigurationManager.xml",
    ],
)
import_library(
    name = "netcoreapp3.1",
    target_framework = "netcoreapp3.1",
    dll = "lib/netstandard2.0/System.Configuration.ConfigurationManager.dll",
    refdll = "lib/netstandard2.0/System.Configuration.ConfigurationManager.dll",
    deps = [
        "@main.system.security.cryptography.protecteddata//:lib",
        "@main.system.security.permissions//:lib",
    ],
    data = [
        "lib/netstandard2.0/System.Configuration.ConfigurationManager.dll",
        "lib/netstandard2.0/System.Configuration.ConfigurationManager.xml",
    ],
)
import_library(
    name = "net5.0",
    target_framework = "net5.0",
    dll = "lib/netstandard2.0/System.Configuration.ConfigurationManager.dll",
    refdll = "lib/netstandard2.0/System.Configuration.ConfigurationManager.dll",
    deps = [
        "@main.system.security.cryptography.protecteddata//:lib",
        "@main.system.security.permissions//:lib",
    ],
    data = [
        "lib/netstandard2.0/System.Configuration.ConfigurationManager.dll",
        "lib/netstandard2.0/System.Configuration.ConfigurationManager.xml",
    ],
)
import_library(
    name = "net6.0",
    target_framework = "net6.0",
    dll = "lib/net6.0/System.Configuration.ConfigurationManager.dll",
    refdll = "lib/net6.0/System.Configuration.ConfigurationManager.dll",
    deps = [
        "@main.system.security.cryptography.protecteddata//:lib",
        "@main.system.security.permissions//:lib",
    ],
    data = [
        "lib/net6.0/System.Configuration.ConfigurationManager.dll",
        "lib/net6.0/System.Configuration.ConfigurationManager.xml",
    ],
)
import_multiframework_library(
    name = "lib",
    net11 = ":net11",
    net20 = ":net20",
    net35 = ":net35",
    net40 = ":net40",
    net403 = ":net403",
    net45 = ":net45",
    net451 = ":net451",
    net452 = ":net452",
    net46 = ":net46",
    net461 = ":net461",
    net462 = ":net462",
    net47 = ":net47",
    net471 = ":net471",
    net472 = ":net472",
    net48 = ":net48",
    netstandard = ":netstandard",
    netstandard1_0 = ":netstandard1.0",
    netstandard1_1 = ":netstandard1.1",
    netstandard1_2 = ":netstandard1.2",
    netstandard1_3 = ":netstandard1.3",
    netstandard1_4 = ":netstandard1.4",
    netstandard1_5 = ":netstandard1.5",
    netstandard1_6 = ":netstandard1.6",
    netstandard2_0 = ":netstandard2.0",
    netstandard2_1 = ":netstandard2.1",
    netcoreapp1_0 = ":netcoreapp1.0",
    netcoreapp1_1 = ":netcoreapp1.1",
    netcoreapp2_0 = ":netcoreapp2.0",
    netcoreapp2_1 = ":netcoreapp2.1",
    netcoreapp2_2 = ":netcoreapp2.2",
    netcoreapp3_0 = ":netcoreapp3.0",
    netcoreapp3_1 = ":netcoreapp3.1",
    net5_0 = ":net5.0",
    net6_0 = ":net6.0",
    visibility = ["//visibility:public"],
)
"""
    )
    nuget_package(
        name = "main.system.drawing.common",
        package = "system.drawing.common",
        version = "6.0.0",
        sha256 = "ffd11a01b11e3a310b452319688992d4ef059947bc8f85ae154c3554eacfc80a",
        build_file_content = """
load("@rules_dotnet//dotnet:defs.bzl", "import_library", "import_multiframework_library")
import_library(
    name = "net11",
    target_framework = "net11",
    deps = [
    ],
    data = [
        "runtimes/unix/lib/net6.0/System.Drawing.Common.dll",
        "runtimes/unix/lib/net6.0/System.Drawing.Common.xml",
        "runtimes/unix/lib/netcoreapp3.1/System.Drawing.Common.dll",
        "runtimes/unix/lib/netcoreapp3.1/System.Drawing.Common.xml",
    ],
)
import_library(
    name = "net20",
    target_framework = "net20",
    deps = [
    ],
    data = [
        "runtimes/unix/lib/net6.0/System.Drawing.Common.dll",
        "runtimes/unix/lib/net6.0/System.Drawing.Common.xml",
        "runtimes/unix/lib/netcoreapp3.1/System.Drawing.Common.dll",
        "runtimes/unix/lib/netcoreapp3.1/System.Drawing.Common.xml",
    ],
)
import_library(
    name = "net35",
    target_framework = "net35",
    deps = [
    ],
    data = [
        "runtimes/unix/lib/net6.0/System.Drawing.Common.dll",
        "runtimes/unix/lib/net6.0/System.Drawing.Common.xml",
        "runtimes/unix/lib/netcoreapp3.1/System.Drawing.Common.dll",
        "runtimes/unix/lib/netcoreapp3.1/System.Drawing.Common.xml",
    ],
)
import_library(
    name = "net40",
    target_framework = "net40",
    deps = [
    ],
    data = [
        "runtimes/unix/lib/net6.0/System.Drawing.Common.dll",
        "runtimes/unix/lib/net6.0/System.Drawing.Common.xml",
        "runtimes/unix/lib/netcoreapp3.1/System.Drawing.Common.dll",
        "runtimes/unix/lib/netcoreapp3.1/System.Drawing.Common.xml",
    ],
)
import_library(
    name = "net403",
    target_framework = "net403",
    deps = [
    ],
    data = [
        "runtimes/unix/lib/net6.0/System.Drawing.Common.dll",
        "runtimes/unix/lib/net6.0/System.Drawing.Common.xml",
        "runtimes/unix/lib/netcoreapp3.1/System.Drawing.Common.dll",
        "runtimes/unix/lib/netcoreapp3.1/System.Drawing.Common.xml",
    ],
)
import_library(
    name = "net45",
    target_framework = "net45",
    deps = [
    ],
    data = [
        "runtimes/unix/lib/net6.0/System.Drawing.Common.dll",
        "runtimes/unix/lib/net6.0/System.Drawing.Common.xml",
        "runtimes/unix/lib/netcoreapp3.1/System.Drawing.Common.dll",
        "runtimes/unix/lib/netcoreapp3.1/System.Drawing.Common.xml",
    ],
)
import_library(
    name = "net451",
    target_framework = "net451",
    deps = [
    ],
    data = [
        "runtimes/unix/lib/net6.0/System.Drawing.Common.dll",
        "runtimes/unix/lib/net6.0/System.Drawing.Common.xml",
        "runtimes/unix/lib/netcoreapp3.1/System.Drawing.Common.dll",
        "runtimes/unix/lib/netcoreapp3.1/System.Drawing.Common.xml",
    ],
)
import_library(
    name = "net452",
    target_framework = "net452",
    deps = [
    ],
    data = [
        "runtimes/unix/lib/net6.0/System.Drawing.Common.dll",
        "runtimes/unix/lib/net6.0/System.Drawing.Common.xml",
        "runtimes/unix/lib/netcoreapp3.1/System.Drawing.Common.dll",
        "runtimes/unix/lib/netcoreapp3.1/System.Drawing.Common.xml",
    ],
)
import_library(
    name = "net46",
    target_framework = "net46",
    deps = [
    ],
    data = [
        "runtimes/unix/lib/net6.0/System.Drawing.Common.dll",
        "runtimes/unix/lib/net6.0/System.Drawing.Common.xml",
        "runtimes/unix/lib/netcoreapp3.1/System.Drawing.Common.dll",
        "runtimes/unix/lib/netcoreapp3.1/System.Drawing.Common.xml",
    ],
)
import_library(
    name = "net461",
    target_framework = "net461",
    dll = "lib/net461/System.Drawing.Common.dll",
    refdll = "lib/net461/System.Drawing.Common.dll",
    deps = [
    ],
    data = [
        "lib/net461/System.Drawing.Common.dll",
        "lib/net461/System.Drawing.Common.xml",
        "runtimes/unix/lib/net6.0/System.Drawing.Common.dll",
        "runtimes/unix/lib/net6.0/System.Drawing.Common.xml",
        "runtimes/unix/lib/netcoreapp3.1/System.Drawing.Common.dll",
        "runtimes/unix/lib/netcoreapp3.1/System.Drawing.Common.xml",
    ],
)
import_library(
    name = "net462",
    target_framework = "net462",
    dll = "lib/net461/System.Drawing.Common.dll",
    refdll = "lib/net461/System.Drawing.Common.dll",
    deps = [
    ],
    data = [
        "lib/net461/System.Drawing.Common.dll",
        "lib/net461/System.Drawing.Common.xml",
        "runtimes/unix/lib/net6.0/System.Drawing.Common.dll",
        "runtimes/unix/lib/net6.0/System.Drawing.Common.xml",
        "runtimes/unix/lib/netcoreapp3.1/System.Drawing.Common.dll",
        "runtimes/unix/lib/netcoreapp3.1/System.Drawing.Common.xml",
    ],
)
import_library(
    name = "net47",
    target_framework = "net47",
    dll = "lib/net461/System.Drawing.Common.dll",
    refdll = "lib/net461/System.Drawing.Common.dll",
    deps = [
    ],
    data = [
        "lib/net461/System.Drawing.Common.dll",
        "lib/net461/System.Drawing.Common.xml",
        "runtimes/unix/lib/net6.0/System.Drawing.Common.dll",
        "runtimes/unix/lib/net6.0/System.Drawing.Common.xml",
        "runtimes/unix/lib/netcoreapp3.1/System.Drawing.Common.dll",
        "runtimes/unix/lib/netcoreapp3.1/System.Drawing.Common.xml",
    ],
)
import_library(
    name = "net471",
    target_framework = "net471",
    dll = "lib/net461/System.Drawing.Common.dll",
    refdll = "lib/net461/System.Drawing.Common.dll",
    deps = [
    ],
    data = [
        "lib/net461/System.Drawing.Common.dll",
        "lib/net461/System.Drawing.Common.xml",
        "runtimes/unix/lib/net6.0/System.Drawing.Common.dll",
        "runtimes/unix/lib/net6.0/System.Drawing.Common.xml",
        "runtimes/unix/lib/netcoreapp3.1/System.Drawing.Common.dll",
        "runtimes/unix/lib/netcoreapp3.1/System.Drawing.Common.xml",
    ],
)
import_library(
    name = "net472",
    target_framework = "net472",
    dll = "lib/net461/System.Drawing.Common.dll",
    refdll = "lib/net461/System.Drawing.Common.dll",
    deps = [
    ],
    data = [
        "lib/net461/System.Drawing.Common.dll",
        "lib/net461/System.Drawing.Common.xml",
        "runtimes/unix/lib/net6.0/System.Drawing.Common.dll",
        "runtimes/unix/lib/net6.0/System.Drawing.Common.xml",
        "runtimes/unix/lib/netcoreapp3.1/System.Drawing.Common.dll",
        "runtimes/unix/lib/netcoreapp3.1/System.Drawing.Common.xml",
    ],
)
import_library(
    name = "net48",
    target_framework = "net48",
    dll = "lib/net461/System.Drawing.Common.dll",
    refdll = "lib/net461/System.Drawing.Common.dll",
    deps = [
    ],
    data = [
        "lib/net461/System.Drawing.Common.dll",
        "lib/net461/System.Drawing.Common.xml",
        "runtimes/unix/lib/net6.0/System.Drawing.Common.dll",
        "runtimes/unix/lib/net6.0/System.Drawing.Common.xml",
        "runtimes/unix/lib/netcoreapp3.1/System.Drawing.Common.dll",
        "runtimes/unix/lib/netcoreapp3.1/System.Drawing.Common.xml",
    ],
)
import_library(
    name = "netstandard",
    target_framework = "netstandard",
    deps = [
    ],
    data = [
        "runtimes/unix/lib/net6.0/System.Drawing.Common.dll",
        "runtimes/unix/lib/net6.0/System.Drawing.Common.xml",
        "runtimes/unix/lib/netcoreapp3.1/System.Drawing.Common.dll",
        "runtimes/unix/lib/netcoreapp3.1/System.Drawing.Common.xml",
    ],
)
import_library(
    name = "netstandard1.0",
    target_framework = "netstandard1.0",
    deps = [
    ],
    data = [
        "runtimes/unix/lib/net6.0/System.Drawing.Common.dll",
        "runtimes/unix/lib/net6.0/System.Drawing.Common.xml",
        "runtimes/unix/lib/netcoreapp3.1/System.Drawing.Common.dll",
        "runtimes/unix/lib/netcoreapp3.1/System.Drawing.Common.xml",
    ],
)
import_library(
    name = "netstandard1.1",
    target_framework = "netstandard1.1",
    deps = [
    ],
    data = [
        "runtimes/unix/lib/net6.0/System.Drawing.Common.dll",
        "runtimes/unix/lib/net6.0/System.Drawing.Common.xml",
        "runtimes/unix/lib/netcoreapp3.1/System.Drawing.Common.dll",
        "runtimes/unix/lib/netcoreapp3.1/System.Drawing.Common.xml",
    ],
)
import_library(
    name = "netstandard1.2",
    target_framework = "netstandard1.2",
    deps = [
    ],
    data = [
        "runtimes/unix/lib/net6.0/System.Drawing.Common.dll",
        "runtimes/unix/lib/net6.0/System.Drawing.Common.xml",
        "runtimes/unix/lib/netcoreapp3.1/System.Drawing.Common.dll",
        "runtimes/unix/lib/netcoreapp3.1/System.Drawing.Common.xml",
    ],
)
import_library(
    name = "netstandard1.3",
    target_framework = "netstandard1.3",
    deps = [
    ],
    data = [
        "runtimes/unix/lib/net6.0/System.Drawing.Common.dll",
        "runtimes/unix/lib/net6.0/System.Drawing.Common.xml",
        "runtimes/unix/lib/netcoreapp3.1/System.Drawing.Common.dll",
        "runtimes/unix/lib/netcoreapp3.1/System.Drawing.Common.xml",
    ],
)
import_library(
    name = "netstandard1.4",
    target_framework = "netstandard1.4",
    deps = [
    ],
    data = [
        "runtimes/unix/lib/net6.0/System.Drawing.Common.dll",
        "runtimes/unix/lib/net6.0/System.Drawing.Common.xml",
        "runtimes/unix/lib/netcoreapp3.1/System.Drawing.Common.dll",
        "runtimes/unix/lib/netcoreapp3.1/System.Drawing.Common.xml",
    ],
)
import_library(
    name = "netstandard1.5",
    target_framework = "netstandard1.5",
    deps = [
    ],
    data = [
        "runtimes/unix/lib/net6.0/System.Drawing.Common.dll",
        "runtimes/unix/lib/net6.0/System.Drawing.Common.xml",
        "runtimes/unix/lib/netcoreapp3.1/System.Drawing.Common.dll",
        "runtimes/unix/lib/netcoreapp3.1/System.Drawing.Common.xml",
    ],
)
import_library(
    name = "netstandard1.6",
    target_framework = "netstandard1.6",
    deps = [
    ],
    data = [
        "runtimes/unix/lib/net6.0/System.Drawing.Common.dll",
        "runtimes/unix/lib/net6.0/System.Drawing.Common.xml",
        "runtimes/unix/lib/netcoreapp3.1/System.Drawing.Common.dll",
        "runtimes/unix/lib/netcoreapp3.1/System.Drawing.Common.xml",
    ],
)
import_library(
    name = "netstandard2.0",
    target_framework = "netstandard2.0",
    dll = "lib/netstandard2.0/System.Drawing.Common.dll",
    refdll = "lib/netstandard2.0/System.Drawing.Common.dll",
    deps = [
    ],
    data = [
        "lib/netstandard2.0/System.Drawing.Common.dll",
        "lib/netstandard2.0/System.Drawing.Common.xml",
        "runtimes/unix/lib/net6.0/System.Drawing.Common.dll",
        "runtimes/unix/lib/net6.0/System.Drawing.Common.xml",
        "runtimes/unix/lib/netcoreapp3.1/System.Drawing.Common.dll",
        "runtimes/unix/lib/netcoreapp3.1/System.Drawing.Common.xml",
    ],
)
import_library(
    name = "netstandard2.1",
    target_framework = "netstandard2.1",
    dll = "lib/netstandard2.0/System.Drawing.Common.dll",
    refdll = "lib/netstandard2.0/System.Drawing.Common.dll",
    deps = [
    ],
    data = [
        "lib/netstandard2.0/System.Drawing.Common.dll",
        "lib/netstandard2.0/System.Drawing.Common.xml",
        "runtimes/unix/lib/net6.0/System.Drawing.Common.dll",
        "runtimes/unix/lib/net6.0/System.Drawing.Common.xml",
        "runtimes/unix/lib/netcoreapp3.1/System.Drawing.Common.dll",
        "runtimes/unix/lib/netcoreapp3.1/System.Drawing.Common.xml",
    ],
)
import_library(
    name = "netcoreapp1.0",
    target_framework = "netcoreapp1.0",
    deps = [
    ],
    data = [
        "runtimes/unix/lib/net6.0/System.Drawing.Common.dll",
        "runtimes/unix/lib/net6.0/System.Drawing.Common.xml",
        "runtimes/unix/lib/netcoreapp3.1/System.Drawing.Common.dll",
        "runtimes/unix/lib/netcoreapp3.1/System.Drawing.Common.xml",
    ],
)
import_library(
    name = "netcoreapp1.1",
    target_framework = "netcoreapp1.1",
    deps = [
    ],
    data = [
        "runtimes/unix/lib/net6.0/System.Drawing.Common.dll",
        "runtimes/unix/lib/net6.0/System.Drawing.Common.xml",
        "runtimes/unix/lib/netcoreapp3.1/System.Drawing.Common.dll",
        "runtimes/unix/lib/netcoreapp3.1/System.Drawing.Common.xml",
    ],
)
import_library(
    name = "netcoreapp2.0",
    target_framework = "netcoreapp2.0",
    dll = "lib/netstandard2.0/System.Drawing.Common.dll",
    refdll = "lib/netstandard2.0/System.Drawing.Common.dll",
    deps = [
    ],
    data = [
        "lib/netstandard2.0/System.Drawing.Common.dll",
        "lib/netstandard2.0/System.Drawing.Common.xml",
        "runtimes/unix/lib/net6.0/System.Drawing.Common.dll",
        "runtimes/unix/lib/net6.0/System.Drawing.Common.xml",
        "runtimes/unix/lib/netcoreapp3.1/System.Drawing.Common.dll",
        "runtimes/unix/lib/netcoreapp3.1/System.Drawing.Common.xml",
    ],
)
import_library(
    name = "netcoreapp2.1",
    target_framework = "netcoreapp2.1",
    dll = "lib/netstandard2.0/System.Drawing.Common.dll",
    refdll = "lib/netstandard2.0/System.Drawing.Common.dll",
    deps = [
    ],
    data = [
        "lib/netstandard2.0/System.Drawing.Common.dll",
        "lib/netstandard2.0/System.Drawing.Common.xml",
        "runtimes/unix/lib/net6.0/System.Drawing.Common.dll",
        "runtimes/unix/lib/net6.0/System.Drawing.Common.xml",
        "runtimes/unix/lib/netcoreapp3.1/System.Drawing.Common.dll",
        "runtimes/unix/lib/netcoreapp3.1/System.Drawing.Common.xml",
    ],
)
import_library(
    name = "netcoreapp2.2",
    target_framework = "netcoreapp2.2",
    dll = "lib/netstandard2.0/System.Drawing.Common.dll",
    refdll = "lib/netstandard2.0/System.Drawing.Common.dll",
    deps = [
    ],
    data = [
        "lib/netstandard2.0/System.Drawing.Common.dll",
        "lib/netstandard2.0/System.Drawing.Common.xml",
        "runtimes/unix/lib/net6.0/System.Drawing.Common.dll",
        "runtimes/unix/lib/net6.0/System.Drawing.Common.xml",
        "runtimes/unix/lib/netcoreapp3.1/System.Drawing.Common.dll",
        "runtimes/unix/lib/netcoreapp3.1/System.Drawing.Common.xml",
    ],
)
import_library(
    name = "netcoreapp3.0",
    target_framework = "netcoreapp3.0",
    dll = "lib/netstandard2.0/System.Drawing.Common.dll",
    refdll = "lib/netstandard2.0/System.Drawing.Common.dll",
    deps = [
    ],
    data = [
        "lib/netstandard2.0/System.Drawing.Common.dll",
        "lib/netstandard2.0/System.Drawing.Common.xml",
        "runtimes/unix/lib/net6.0/System.Drawing.Common.dll",
        "runtimes/unix/lib/net6.0/System.Drawing.Common.xml",
        "runtimes/unix/lib/netcoreapp3.1/System.Drawing.Common.dll",
        "runtimes/unix/lib/netcoreapp3.1/System.Drawing.Common.xml",
    ],
)
import_library(
    name = "netcoreapp3.1",
    target_framework = "netcoreapp3.1",
    dll = "lib/netcoreapp3.1/System.Drawing.Common.dll",
    refdll = "lib/netcoreapp3.1/System.Drawing.Common.dll",
    deps = [
        "@main.microsoft.win32.systemevents//:lib",
    ],
    data = [
        "lib/netcoreapp3.1/System.Drawing.Common.dll",
        "lib/netcoreapp3.1/System.Drawing.Common.xml",
        "runtimes/unix/lib/net6.0/System.Drawing.Common.dll",
        "runtimes/unix/lib/net6.0/System.Drawing.Common.xml",
        "runtimes/unix/lib/netcoreapp3.1/System.Drawing.Common.dll",
        "runtimes/unix/lib/netcoreapp3.1/System.Drawing.Common.xml",
    ],
)
import_library(
    name = "net5.0",
    target_framework = "net5.0",
    dll = "lib/netcoreapp3.1/System.Drawing.Common.dll",
    refdll = "lib/netcoreapp3.1/System.Drawing.Common.dll",
    deps = [
        "@main.microsoft.win32.systemevents//:lib",
    ],
    data = [
        "lib/netcoreapp3.1/System.Drawing.Common.dll",
        "lib/netcoreapp3.1/System.Drawing.Common.xml",
        "runtimes/unix/lib/net6.0/System.Drawing.Common.dll",
        "runtimes/unix/lib/net6.0/System.Drawing.Common.xml",
        "runtimes/unix/lib/netcoreapp3.1/System.Drawing.Common.dll",
        "runtimes/unix/lib/netcoreapp3.1/System.Drawing.Common.xml",
    ],
)
import_library(
    name = "net6.0",
    target_framework = "net6.0",
    dll = "lib/net6.0/System.Drawing.Common.dll",
    refdll = "lib/net6.0/System.Drawing.Common.dll",
    deps = [
        "@main.microsoft.win32.systemevents//:lib",
    ],
    data = [
        "lib/net6.0/System.Drawing.Common.dll",
        "lib/net6.0/System.Drawing.Common.xml",
        "runtimes/unix/lib/net6.0/System.Drawing.Common.dll",
        "runtimes/unix/lib/net6.0/System.Drawing.Common.xml",
        "runtimes/unix/lib/netcoreapp3.1/System.Drawing.Common.dll",
        "runtimes/unix/lib/netcoreapp3.1/System.Drawing.Common.xml",
    ],
)
import_multiframework_library(
    name = "lib",
    net11 = ":net11",
    net20 = ":net20",
    net35 = ":net35",
    net40 = ":net40",
    net403 = ":net403",
    net45 = ":net45",
    net451 = ":net451",
    net452 = ":net452",
    net46 = ":net46",
    net461 = ":net461",
    net462 = ":net462",
    net47 = ":net47",
    net471 = ":net471",
    net472 = ":net472",
    net48 = ":net48",
    netstandard = ":netstandard",
    netstandard1_0 = ":netstandard1.0",
    netstandard1_1 = ":netstandard1.1",
    netstandard1_2 = ":netstandard1.2",
    netstandard1_3 = ":netstandard1.3",
    netstandard1_4 = ":netstandard1.4",
    netstandard1_5 = ":netstandard1.5",
    netstandard1_6 = ":netstandard1.6",
    netstandard2_0 = ":netstandard2.0",
    netstandard2_1 = ":netstandard2.1",
    netcoreapp1_0 = ":netcoreapp1.0",
    netcoreapp1_1 = ":netcoreapp1.1",
    netcoreapp2_0 = ":netcoreapp2.0",
    netcoreapp2_1 = ":netcoreapp2.1",
    netcoreapp2_2 = ":netcoreapp2.2",
    netcoreapp3_0 = ":netcoreapp3.0",
    netcoreapp3_1 = ":netcoreapp3.1",
    net5_0 = ":net5.0",
    net6_0 = ":net6.0",
    visibility = ["//visibility:public"],
)
"""
    )
    nuget_package(
        name = "main.system.security.accesscontrol",
        package = "system.security.accesscontrol",
        version = "6.0.0",
        sha256 = "a8ec961016cdaf7123c92f9eb451bcff331bb8f8c0f8ef9d8bbd7b24ff42c728",
        build_file_content = """
load("@rules_dotnet//dotnet:defs.bzl", "import_library", "import_multiframework_library")
import_library(
    name = "net11",
    target_framework = "net11",
    deps = [
    ],
    data = [
    ],
)
import_library(
    name = "net20",
    target_framework = "net20",
    deps = [
    ],
    data = [
    ],
)
import_library(
    name = "net35",
    target_framework = "net35",
    deps = [
    ],
    data = [
    ],
)
import_library(
    name = "net40",
    target_framework = "net40",
    deps = [
    ],
    data = [
    ],
)
import_library(
    name = "net403",
    target_framework = "net403",
    deps = [
    ],
    data = [
    ],
)
import_library(
    name = "net45",
    target_framework = "net45",
    deps = [
    ],
    data = [
    ],
)
import_library(
    name = "net451",
    target_framework = "net451",
    deps = [
    ],
    data = [
    ],
)
import_library(
    name = "net452",
    target_framework = "net452",
    deps = [
    ],
    data = [
    ],
)
import_library(
    name = "net46",
    target_framework = "net46",
    deps = [
    ],
    data = [
    ],
)
import_library(
    name = "net461",
    target_framework = "net461",
    dll = "lib/net461/System.Security.AccessControl.dll",
    refdll = "lib/net461/System.Security.AccessControl.dll",
    deps = [
    ],
    data = [
        "lib/net461/System.Security.AccessControl.dll",
        "lib/net461/System.Security.AccessControl.xml",
    ],
)
import_library(
    name = "net462",
    target_framework = "net462",
    dll = "lib/net461/System.Security.AccessControl.dll",
    refdll = "lib/net461/System.Security.AccessControl.dll",
    deps = [
    ],
    data = [
        "lib/net461/System.Security.AccessControl.dll",
        "lib/net461/System.Security.AccessControl.xml",
    ],
)
import_library(
    name = "net47",
    target_framework = "net47",
    dll = "lib/net461/System.Security.AccessControl.dll",
    refdll = "lib/net461/System.Security.AccessControl.dll",
    deps = [
    ],
    data = [
        "lib/net461/System.Security.AccessControl.dll",
        "lib/net461/System.Security.AccessControl.xml",
    ],
)
import_library(
    name = "net471",
    target_framework = "net471",
    dll = "lib/net461/System.Security.AccessControl.dll",
    refdll = "lib/net461/System.Security.AccessControl.dll",
    deps = [
    ],
    data = [
        "lib/net461/System.Security.AccessControl.dll",
        "lib/net461/System.Security.AccessControl.xml",
    ],
)
import_library(
    name = "net472",
    target_framework = "net472",
    dll = "lib/net461/System.Security.AccessControl.dll",
    refdll = "lib/net461/System.Security.AccessControl.dll",
    deps = [
    ],
    data = [
        "lib/net461/System.Security.AccessControl.dll",
        "lib/net461/System.Security.AccessControl.xml",
    ],
)
import_library(
    name = "net48",
    target_framework = "net48",
    dll = "lib/net461/System.Security.AccessControl.dll",
    refdll = "lib/net461/System.Security.AccessControl.dll",
    deps = [
    ],
    data = [
        "lib/net461/System.Security.AccessControl.dll",
        "lib/net461/System.Security.AccessControl.xml",
    ],
)
import_library(
    name = "netstandard",
    target_framework = "netstandard",
    deps = [
    ],
    data = [
    ],
)
import_library(
    name = "netstandard1.0",
    target_framework = "netstandard1.0",
    deps = [
    ],
    data = [
    ],
)
import_library(
    name = "netstandard1.1",
    target_framework = "netstandard1.1",
    deps = [
    ],
    data = [
    ],
)
import_library(
    name = "netstandard1.2",
    target_framework = "netstandard1.2",
    deps = [
    ],
    data = [
    ],
)
import_library(
    name = "netstandard1.3",
    target_framework = "netstandard1.3",
    deps = [
    ],
    data = [
    ],
)
import_library(
    name = "netstandard1.4",
    target_framework = "netstandard1.4",
    deps = [
    ],
    data = [
    ],
)
import_library(
    name = "netstandard1.5",
    target_framework = "netstandard1.5",
    deps = [
    ],
    data = [
    ],
)
import_library(
    name = "netstandard1.6",
    target_framework = "netstandard1.6",
    deps = [
    ],
    data = [
    ],
)
import_library(
    name = "netstandard2.0",
    target_framework = "netstandard2.0",
    dll = "lib/netstandard2.0/System.Security.AccessControl.dll",
    refdll = "lib/netstandard2.0/System.Security.AccessControl.dll",
    deps = [
    ],
    data = [
        "lib/netstandard2.0/System.Security.AccessControl.dll",
        "lib/netstandard2.0/System.Security.AccessControl.xml",
    ],
)
import_library(
    name = "netstandard2.1",
    target_framework = "netstandard2.1",
    dll = "lib/netstandard2.0/System.Security.AccessControl.dll",
    refdll = "lib/netstandard2.0/System.Security.AccessControl.dll",
    deps = [
    ],
    data = [
        "lib/netstandard2.0/System.Security.AccessControl.dll",
        "lib/netstandard2.0/System.Security.AccessControl.xml",
    ],
)
import_library(
    name = "netcoreapp1.0",
    target_framework = "netcoreapp1.0",
    deps = [
    ],
    data = [
    ],
)
import_library(
    name = "netcoreapp1.1",
    target_framework = "netcoreapp1.1",
    deps = [
    ],
    data = [
    ],
)
import_library(
    name = "netcoreapp2.0",
    target_framework = "netcoreapp2.0",
    dll = "lib/netstandard2.0/System.Security.AccessControl.dll",
    refdll = "lib/netstandard2.0/System.Security.AccessControl.dll",
    deps = [
    ],
    data = [
        "lib/netstandard2.0/System.Security.AccessControl.dll",
        "lib/netstandard2.0/System.Security.AccessControl.xml",
    ],
)
import_library(
    name = "netcoreapp2.1",
    target_framework = "netcoreapp2.1",
    dll = "lib/netstandard2.0/System.Security.AccessControl.dll",
    refdll = "lib/netstandard2.0/System.Security.AccessControl.dll",
    deps = [
    ],
    data = [
        "lib/netstandard2.0/System.Security.AccessControl.dll",
        "lib/netstandard2.0/System.Security.AccessControl.xml",
    ],
)
import_library(
    name = "netcoreapp2.2",
    target_framework = "netcoreapp2.2",
    dll = "lib/netstandard2.0/System.Security.AccessControl.dll",
    refdll = "lib/netstandard2.0/System.Security.AccessControl.dll",
    deps = [
    ],
    data = [
        "lib/netstandard2.0/System.Security.AccessControl.dll",
        "lib/netstandard2.0/System.Security.AccessControl.xml",
    ],
)
import_library(
    name = "netcoreapp3.0",
    target_framework = "netcoreapp3.0",
    dll = "lib/netstandard2.0/System.Security.AccessControl.dll",
    refdll = "lib/netstandard2.0/System.Security.AccessControl.dll",
    deps = [
    ],
    data = [
        "lib/netstandard2.0/System.Security.AccessControl.dll",
        "lib/netstandard2.0/System.Security.AccessControl.xml",
    ],
)
import_library(
    name = "netcoreapp3.1",
    target_framework = "netcoreapp3.1",
    dll = "lib/netstandard2.0/System.Security.AccessControl.dll",
    refdll = "lib/netstandard2.0/System.Security.AccessControl.dll",
    deps = [
    ],
    data = [
        "lib/netstandard2.0/System.Security.AccessControl.dll",
        "lib/netstandard2.0/System.Security.AccessControl.xml",
    ],
)
import_library(
    name = "net5.0",
    target_framework = "net5.0",
    dll = "lib/netstandard2.0/System.Security.AccessControl.dll",
    refdll = "lib/netstandard2.0/System.Security.AccessControl.dll",
    deps = [
    ],
    data = [
        "lib/netstandard2.0/System.Security.AccessControl.dll",
        "lib/netstandard2.0/System.Security.AccessControl.xml",
    ],
)
import_library(
    name = "net6.0",
    target_framework = "net6.0",
    dll = "lib/net6.0/System.Security.AccessControl.dll",
    refdll = "lib/net6.0/System.Security.AccessControl.dll",
    deps = [
    ],
    data = [
        "lib/net6.0/System.Security.AccessControl.dll",
        "lib/net6.0/System.Security.AccessControl.xml",
    ],
)
import_multiframework_library(
    name = "lib",
    net11 = ":net11",
    net20 = ":net20",
    net35 = ":net35",
    net40 = ":net40",
    net403 = ":net403",
    net45 = ":net45",
    net451 = ":net451",
    net452 = ":net452",
    net46 = ":net46",
    net461 = ":net461",
    net462 = ":net462",
    net47 = ":net47",
    net471 = ":net471",
    net472 = ":net472",
    net48 = ":net48",
    netstandard = ":netstandard",
    netstandard1_0 = ":netstandard1.0",
    netstandard1_1 = ":netstandard1.1",
    netstandard1_2 = ":netstandard1.2",
    netstandard1_3 = ":netstandard1.3",
    netstandard1_4 = ":netstandard1.4",
    netstandard1_5 = ":netstandard1.5",
    netstandard1_6 = ":netstandard1.6",
    netstandard2_0 = ":netstandard2.0",
    netstandard2_1 = ":netstandard2.1",
    netcoreapp1_0 = ":netcoreapp1.0",
    netcoreapp1_1 = ":netcoreapp1.1",
    netcoreapp2_0 = ":netcoreapp2.0",
    netcoreapp2_1 = ":netcoreapp2.1",
    netcoreapp2_2 = ":netcoreapp2.2",
    netcoreapp3_0 = ":netcoreapp3.0",
    netcoreapp3_1 = ":netcoreapp3.1",
    net5_0 = ":net5.0",
    net6_0 = ":net6.0",
    visibility = ["//visibility:public"],
)
"""
    )
    nuget_package(
        name = "main.system.security.cryptography.protecteddata",
        package = "system.security.cryptography.protecteddata",
        version = "6.0.0",
        sha256 = "5a2f48f4d6d99694035e04bb2a5d3a44817163ff7aef84bb84a898c3911a6d16",
        build_file_content = """
load("@rules_dotnet//dotnet:defs.bzl", "import_library", "import_multiframework_library")
import_library(
    name = "net11",
    target_framework = "net11",
    deps = [
    ],
    data = [
    ],
)
import_library(
    name = "net20",
    target_framework = "net20",
    deps = [
    ],
    data = [
    ],
)
import_library(
    name = "net35",
    target_framework = "net35",
    deps = [
    ],
    data = [
    ],
)
import_library(
    name = "net40",
    target_framework = "net40",
    deps = [
    ],
    data = [
    ],
)
import_library(
    name = "net403",
    target_framework = "net403",
    deps = [
    ],
    data = [
    ],
)
import_library(
    name = "net45",
    target_framework = "net45",
    deps = [
    ],
    data = [
    ],
)
import_library(
    name = "net451",
    target_framework = "net451",
    deps = [
    ],
    data = [
    ],
)
import_library(
    name = "net452",
    target_framework = "net452",
    deps = [
    ],
    data = [
    ],
)
import_library(
    name = "net46",
    target_framework = "net46",
    deps = [
    ],
    data = [
    ],
)
import_library(
    name = "net461",
    target_framework = "net461",
    dll = "lib/net461/System.Security.Cryptography.ProtectedData.dll",
    refdll = "lib/net461/System.Security.Cryptography.ProtectedData.dll",
    deps = [
    ],
    data = [
        "lib/net461/System.Security.Cryptography.ProtectedData.dll",
        "lib/net461/System.Security.Cryptography.ProtectedData.xml",
    ],
)
import_library(
    name = "net462",
    target_framework = "net462",
    dll = "lib/net461/System.Security.Cryptography.ProtectedData.dll",
    refdll = "lib/net461/System.Security.Cryptography.ProtectedData.dll",
    deps = [
    ],
    data = [
        "lib/net461/System.Security.Cryptography.ProtectedData.dll",
        "lib/net461/System.Security.Cryptography.ProtectedData.xml",
    ],
)
import_library(
    name = "net47",
    target_framework = "net47",
    dll = "lib/net461/System.Security.Cryptography.ProtectedData.dll",
    refdll = "lib/net461/System.Security.Cryptography.ProtectedData.dll",
    deps = [
    ],
    data = [
        "lib/net461/System.Security.Cryptography.ProtectedData.dll",
        "lib/net461/System.Security.Cryptography.ProtectedData.xml",
    ],
)
import_library(
    name = "net471",
    target_framework = "net471",
    dll = "lib/net461/System.Security.Cryptography.ProtectedData.dll",
    refdll = "lib/net461/System.Security.Cryptography.ProtectedData.dll",
    deps = [
    ],
    data = [
        "lib/net461/System.Security.Cryptography.ProtectedData.dll",
        "lib/net461/System.Security.Cryptography.ProtectedData.xml",
    ],
)
import_library(
    name = "net472",
    target_framework = "net472",
    dll = "lib/net461/System.Security.Cryptography.ProtectedData.dll",
    refdll = "lib/net461/System.Security.Cryptography.ProtectedData.dll",
    deps = [
    ],
    data = [
        "lib/net461/System.Security.Cryptography.ProtectedData.dll",
        "lib/net461/System.Security.Cryptography.ProtectedData.xml",
    ],
)
import_library(
    name = "net48",
    target_framework = "net48",
    dll = "lib/net461/System.Security.Cryptography.ProtectedData.dll",
    refdll = "lib/net461/System.Security.Cryptography.ProtectedData.dll",
    deps = [
    ],
    data = [
        "lib/net461/System.Security.Cryptography.ProtectedData.dll",
        "lib/net461/System.Security.Cryptography.ProtectedData.xml",
    ],
)
import_library(
    name = "netstandard",
    target_framework = "netstandard",
    deps = [
    ],
    data = [
    ],
)
import_library(
    name = "netstandard1.0",
    target_framework = "netstandard1.0",
    deps = [
    ],
    data = [
    ],
)
import_library(
    name = "netstandard1.1",
    target_framework = "netstandard1.1",
    deps = [
    ],
    data = [
    ],
)
import_library(
    name = "netstandard1.2",
    target_framework = "netstandard1.2",
    deps = [
    ],
    data = [
    ],
)
import_library(
    name = "netstandard1.3",
    target_framework = "netstandard1.3",
    deps = [
    ],
    data = [
    ],
)
import_library(
    name = "netstandard1.4",
    target_framework = "netstandard1.4",
    deps = [
    ],
    data = [
    ],
)
import_library(
    name = "netstandard1.5",
    target_framework = "netstandard1.5",
    deps = [
    ],
    data = [
    ],
)
import_library(
    name = "netstandard1.6",
    target_framework = "netstandard1.6",
    deps = [
    ],
    data = [
    ],
)
import_library(
    name = "netstandard2.0",
    target_framework = "netstandard2.0",
    dll = "lib/netstandard2.0/System.Security.Cryptography.ProtectedData.dll",
    refdll = "lib/netstandard2.0/System.Security.Cryptography.ProtectedData.dll",
    deps = [
    ],
    data = [
        "lib/netstandard2.0/System.Security.Cryptography.ProtectedData.dll",
        "lib/netstandard2.0/System.Security.Cryptography.ProtectedData.xml",
    ],
)
import_library(
    name = "netstandard2.1",
    target_framework = "netstandard2.1",
    dll = "lib/netstandard2.0/System.Security.Cryptography.ProtectedData.dll",
    refdll = "lib/netstandard2.0/System.Security.Cryptography.ProtectedData.dll",
    deps = [
    ],
    data = [
        "lib/netstandard2.0/System.Security.Cryptography.ProtectedData.dll",
        "lib/netstandard2.0/System.Security.Cryptography.ProtectedData.xml",
    ],
)
import_library(
    name = "netcoreapp1.0",
    target_framework = "netcoreapp1.0",
    deps = [
    ],
    data = [
    ],
)
import_library(
    name = "netcoreapp1.1",
    target_framework = "netcoreapp1.1",
    deps = [
    ],
    data = [
    ],
)
import_library(
    name = "netcoreapp2.0",
    target_framework = "netcoreapp2.0",
    dll = "lib/netstandard2.0/System.Security.Cryptography.ProtectedData.dll",
    refdll = "lib/netstandard2.0/System.Security.Cryptography.ProtectedData.dll",
    deps = [
    ],
    data = [
        "lib/netstandard2.0/System.Security.Cryptography.ProtectedData.dll",
        "lib/netstandard2.0/System.Security.Cryptography.ProtectedData.xml",
    ],
)
import_library(
    name = "netcoreapp2.1",
    target_framework = "netcoreapp2.1",
    dll = "lib/netstandard2.0/System.Security.Cryptography.ProtectedData.dll",
    refdll = "lib/netstandard2.0/System.Security.Cryptography.ProtectedData.dll",
    deps = [
    ],
    data = [
        "lib/netstandard2.0/System.Security.Cryptography.ProtectedData.dll",
        "lib/netstandard2.0/System.Security.Cryptography.ProtectedData.xml",
    ],
)
import_library(
    name = "netcoreapp2.2",
    target_framework = "netcoreapp2.2",
    dll = "lib/netstandard2.0/System.Security.Cryptography.ProtectedData.dll",
    refdll = "lib/netstandard2.0/System.Security.Cryptography.ProtectedData.dll",
    deps = [
    ],
    data = [
        "lib/netstandard2.0/System.Security.Cryptography.ProtectedData.dll",
        "lib/netstandard2.0/System.Security.Cryptography.ProtectedData.xml",
    ],
)
import_library(
    name = "netcoreapp3.0",
    target_framework = "netcoreapp3.0",
    dll = "lib/netstandard2.0/System.Security.Cryptography.ProtectedData.dll",
    refdll = "lib/netstandard2.0/System.Security.Cryptography.ProtectedData.dll",
    deps = [
    ],
    data = [
        "lib/netstandard2.0/System.Security.Cryptography.ProtectedData.dll",
        "lib/netstandard2.0/System.Security.Cryptography.ProtectedData.xml",
    ],
)
import_library(
    name = "netcoreapp3.1",
    target_framework = "netcoreapp3.1",
    dll = "lib/netstandard2.0/System.Security.Cryptography.ProtectedData.dll",
    refdll = "lib/netstandard2.0/System.Security.Cryptography.ProtectedData.dll",
    deps = [
    ],
    data = [
        "lib/netstandard2.0/System.Security.Cryptography.ProtectedData.dll",
        "lib/netstandard2.0/System.Security.Cryptography.ProtectedData.xml",
    ],
)
import_library(
    name = "net5.0",
    target_framework = "net5.0",
    dll = "lib/netstandard2.0/System.Security.Cryptography.ProtectedData.dll",
    refdll = "lib/netstandard2.0/System.Security.Cryptography.ProtectedData.dll",
    deps = [
    ],
    data = [
        "lib/netstandard2.0/System.Security.Cryptography.ProtectedData.dll",
        "lib/netstandard2.0/System.Security.Cryptography.ProtectedData.xml",
    ],
)
import_library(
    name = "net6.0",
    target_framework = "net6.0",
    dll = "lib/net6.0/System.Security.Cryptography.ProtectedData.dll",
    refdll = "lib/net6.0/System.Security.Cryptography.ProtectedData.dll",
    deps = [
    ],
    data = [
        "lib/net6.0/System.Security.Cryptography.ProtectedData.dll",
        "lib/net6.0/System.Security.Cryptography.ProtectedData.xml",
    ],
)
import_multiframework_library(
    name = "lib",
    net11 = ":net11",
    net20 = ":net20",
    net35 = ":net35",
    net40 = ":net40",
    net403 = ":net403",
    net45 = ":net45",
    net451 = ":net451",
    net452 = ":net452",
    net46 = ":net46",
    net461 = ":net461",
    net462 = ":net462",
    net47 = ":net47",
    net471 = ":net471",
    net472 = ":net472",
    net48 = ":net48",
    netstandard = ":netstandard",
    netstandard1_0 = ":netstandard1.0",
    netstandard1_1 = ":netstandard1.1",
    netstandard1_2 = ":netstandard1.2",
    netstandard1_3 = ":netstandard1.3",
    netstandard1_4 = ":netstandard1.4",
    netstandard1_5 = ":netstandard1.5",
    netstandard1_6 = ":netstandard1.6",
    netstandard2_0 = ":netstandard2.0",
    netstandard2_1 = ":netstandard2.1",
    netcoreapp1_0 = ":netcoreapp1.0",
    netcoreapp1_1 = ":netcoreapp1.1",
    netcoreapp2_0 = ":netcoreapp2.0",
    netcoreapp2_1 = ":netcoreapp2.1",
    netcoreapp2_2 = ":netcoreapp2.2",
    netcoreapp3_0 = ":netcoreapp3.0",
    netcoreapp3_1 = ":netcoreapp3.1",
    net5_0 = ":net5.0",
    net6_0 = ":net6.0",
    visibility = ["//visibility:public"],
)
"""
    )
    nuget_package(
        name = "main.system.security.permissions",
        package = "system.security.permissions",
        version = "6.0.0",
        sha256 = "fcc32fb4558637fbce41f8d774e85eb7582c9cc821ea58790c21e2995b27544b",
        build_file_content = """
load("@rules_dotnet//dotnet:defs.bzl", "import_library", "import_multiframework_library")
import_library(
    name = "net11",
    target_framework = "net11",
    deps = [
    ],
    data = [
    ],
)
import_library(
    name = "net20",
    target_framework = "net20",
    deps = [
    ],
    data = [
    ],
)
import_library(
    name = "net35",
    target_framework = "net35",
    deps = [
    ],
    data = [
    ],
)
import_library(
    name = "net40",
    target_framework = "net40",
    deps = [
    ],
    data = [
    ],
)
import_library(
    name = "net403",
    target_framework = "net403",
    deps = [
    ],
    data = [
    ],
)
import_library(
    name = "net45",
    target_framework = "net45",
    deps = [
    ],
    data = [
    ],
)
import_library(
    name = "net451",
    target_framework = "net451",
    deps = [
    ],
    data = [
    ],
)
import_library(
    name = "net452",
    target_framework = "net452",
    deps = [
    ],
    data = [
    ],
)
import_library(
    name = "net46",
    target_framework = "net46",
    deps = [
    ],
    data = [
    ],
)
import_library(
    name = "net461",
    target_framework = "net461",
    dll = "lib/net461/System.Security.Permissions.dll",
    refdll = "lib/net461/System.Security.Permissions.dll",
    deps = [
        "@main.system.security.accesscontrol//:lib",
    ],
    data = [
        "lib/net461/System.Security.Permissions.dll",
        "lib/net461/System.Security.Permissions.xml",
    ],
)
import_library(
    name = "net462",
    target_framework = "net462",
    dll = "lib/net461/System.Security.Permissions.dll",
    refdll = "lib/net461/System.Security.Permissions.dll",
    deps = [
        "@main.system.security.accesscontrol//:lib",
    ],
    data = [
        "lib/net461/System.Security.Permissions.dll",
        "lib/net461/System.Security.Permissions.xml",
    ],
)
import_library(
    name = "net47",
    target_framework = "net47",
    dll = "lib/net461/System.Security.Permissions.dll",
    refdll = "lib/net461/System.Security.Permissions.dll",
    deps = [
        "@main.system.security.accesscontrol//:lib",
    ],
    data = [
        "lib/net461/System.Security.Permissions.dll",
        "lib/net461/System.Security.Permissions.xml",
    ],
)
import_library(
    name = "net471",
    target_framework = "net471",
    dll = "lib/net461/System.Security.Permissions.dll",
    refdll = "lib/net461/System.Security.Permissions.dll",
    deps = [
        "@main.system.security.accesscontrol//:lib",
    ],
    data = [
        "lib/net461/System.Security.Permissions.dll",
        "lib/net461/System.Security.Permissions.xml",
    ],
)
import_library(
    name = "net472",
    target_framework = "net472",
    dll = "lib/net461/System.Security.Permissions.dll",
    refdll = "lib/net461/System.Security.Permissions.dll",
    deps = [
        "@main.system.security.accesscontrol//:lib",
    ],
    data = [
        "lib/net461/System.Security.Permissions.dll",
        "lib/net461/System.Security.Permissions.xml",
    ],
)
import_library(
    name = "net48",
    target_framework = "net48",
    dll = "lib/net461/System.Security.Permissions.dll",
    refdll = "lib/net461/System.Security.Permissions.dll",
    deps = [
        "@main.system.security.accesscontrol//:lib",
    ],
    data = [
        "lib/net461/System.Security.Permissions.dll",
        "lib/net461/System.Security.Permissions.xml",
    ],
)
import_library(
    name = "netstandard",
    target_framework = "netstandard",
    deps = [
    ],
    data = [
    ],
)
import_library(
    name = "netstandard1.0",
    target_framework = "netstandard1.0",
    deps = [
    ],
    data = [
    ],
)
import_library(
    name = "netstandard1.1",
    target_framework = "netstandard1.1",
    deps = [
    ],
    data = [
    ],
)
import_library(
    name = "netstandard1.2",
    target_framework = "netstandard1.2",
    deps = [
    ],
    data = [
    ],
)
import_library(
    name = "netstandard1.3",
    target_framework = "netstandard1.3",
    deps = [
    ],
    data = [
    ],
)
import_library(
    name = "netstandard1.4",
    target_framework = "netstandard1.4",
    deps = [
    ],
    data = [
    ],
)
import_library(
    name = "netstandard1.5",
    target_framework = "netstandard1.5",
    deps = [
    ],
    data = [
    ],
)
import_library(
    name = "netstandard1.6",
    target_framework = "netstandard1.6",
    deps = [
    ],
    data = [
    ],
)
import_library(
    name = "netstandard2.0",
    target_framework = "netstandard2.0",
    dll = "lib/netstandard2.0/System.Security.Permissions.dll",
    refdll = "lib/netstandard2.0/System.Security.Permissions.dll",
    deps = [
        "@main.system.security.accesscontrol//:lib",
    ],
    data = [
        "lib/netstandard2.0/System.Security.Permissions.dll",
        "lib/netstandard2.0/System.Security.Permissions.xml",
    ],
)
import_library(
    name = "netstandard2.1",
    target_framework = "netstandard2.1",
    dll = "lib/netstandard2.0/System.Security.Permissions.dll",
    refdll = "lib/netstandard2.0/System.Security.Permissions.dll",
    deps = [
        "@main.system.security.accesscontrol//:lib",
    ],
    data = [
        "lib/netstandard2.0/System.Security.Permissions.dll",
        "lib/netstandard2.0/System.Security.Permissions.xml",
    ],
)
import_library(
    name = "netcoreapp1.0",
    target_framework = "netcoreapp1.0",
    deps = [
    ],
    data = [
    ],
)
import_library(
    name = "netcoreapp1.1",
    target_framework = "netcoreapp1.1",
    deps = [
    ],
    data = [
    ],
)
import_library(
    name = "netcoreapp2.0",
    target_framework = "netcoreapp2.0",
    dll = "lib/netstandard2.0/System.Security.Permissions.dll",
    refdll = "lib/netstandard2.0/System.Security.Permissions.dll",
    deps = [
        "@main.system.security.accesscontrol//:lib",
    ],
    data = [
        "lib/netstandard2.0/System.Security.Permissions.dll",
        "lib/netstandard2.0/System.Security.Permissions.xml",
    ],
)
import_library(
    name = "netcoreapp2.1",
    target_framework = "netcoreapp2.1",
    dll = "lib/netstandard2.0/System.Security.Permissions.dll",
    refdll = "lib/netstandard2.0/System.Security.Permissions.dll",
    deps = [
        "@main.system.security.accesscontrol//:lib",
    ],
    data = [
        "lib/netstandard2.0/System.Security.Permissions.dll",
        "lib/netstandard2.0/System.Security.Permissions.xml",
    ],
)
import_library(
    name = "netcoreapp2.2",
    target_framework = "netcoreapp2.2",
    dll = "lib/netstandard2.0/System.Security.Permissions.dll",
    refdll = "lib/netstandard2.0/System.Security.Permissions.dll",
    deps = [
        "@main.system.security.accesscontrol//:lib",
    ],
    data = [
        "lib/netstandard2.0/System.Security.Permissions.dll",
        "lib/netstandard2.0/System.Security.Permissions.xml",
    ],
)
import_library(
    name = "netcoreapp3.0",
    target_framework = "netcoreapp3.0",
    dll = "lib/netstandard2.0/System.Security.Permissions.dll",
    refdll = "lib/netstandard2.0/System.Security.Permissions.dll",
    deps = [
        "@main.system.security.accesscontrol//:lib",
    ],
    data = [
        "lib/netstandard2.0/System.Security.Permissions.dll",
        "lib/netstandard2.0/System.Security.Permissions.xml",
    ],
)
import_library(
    name = "netcoreapp3.1",
    target_framework = "netcoreapp3.1",
    dll = "lib/netcoreapp3.1/System.Security.Permissions.dll",
    refdll = "lib/netcoreapp3.1/System.Security.Permissions.dll",
    deps = [
        "@main.system.security.accesscontrol//:lib",
        "@main.system.windows.extensions//:lib",
    ],
    data = [
        "lib/netcoreapp3.1/System.Security.Permissions.dll",
        "lib/netcoreapp3.1/System.Security.Permissions.xml",
    ],
)
import_library(
    name = "net5.0",
    target_framework = "net5.0",
    dll = "lib/net5.0/System.Security.Permissions.dll",
    refdll = "lib/net5.0/System.Security.Permissions.dll",
    deps = [
        "@main.system.security.accesscontrol//:lib",
        "@main.system.windows.extensions//:lib",
    ],
    data = [
        "lib/net5.0/System.Security.Permissions.dll",
        "lib/net5.0/System.Security.Permissions.xml",
    ],
)
import_library(
    name = "net6.0",
    target_framework = "net6.0",
    dll = "lib/net6.0/System.Security.Permissions.dll",
    refdll = "lib/net6.0/System.Security.Permissions.dll",
    deps = [
        "@main.system.security.accesscontrol//:lib",
        "@main.system.windows.extensions//:lib",
    ],
    data = [
        "lib/net6.0/System.Security.Permissions.dll",
        "lib/net6.0/System.Security.Permissions.xml",
    ],
)
import_multiframework_library(
    name = "lib",
    net11 = ":net11",
    net20 = ":net20",
    net35 = ":net35",
    net40 = ":net40",
    net403 = ":net403",
    net45 = ":net45",
    net451 = ":net451",
    net452 = ":net452",
    net46 = ":net46",
    net461 = ":net461",
    net462 = ":net462",
    net47 = ":net47",
    net471 = ":net471",
    net472 = ":net472",
    net48 = ":net48",
    netstandard = ":netstandard",
    netstandard1_0 = ":netstandard1.0",
    netstandard1_1 = ":netstandard1.1",
    netstandard1_2 = ":netstandard1.2",
    netstandard1_3 = ":netstandard1.3",
    netstandard1_4 = ":netstandard1.4",
    netstandard1_5 = ":netstandard1.5",
    netstandard1_6 = ":netstandard1.6",
    netstandard2_0 = ":netstandard2.0",
    netstandard2_1 = ":netstandard2.1",
    netcoreapp1_0 = ":netcoreapp1.0",
    netcoreapp1_1 = ":netcoreapp1.1",
    netcoreapp2_0 = ":netcoreapp2.0",
    netcoreapp2_1 = ":netcoreapp2.1",
    netcoreapp2_2 = ":netcoreapp2.2",
    netcoreapp3_0 = ":netcoreapp3.0",
    netcoreapp3_1 = ":netcoreapp3.1",
    net5_0 = ":net5.0",
    net6_0 = ":net6.0",
    visibility = ["//visibility:public"],
)
"""
    )
    nuget_package(
        name = "main.system.windows.extensions",
        package = "system.windows.extensions",
        version = "6.0.0",
        sha256 = "37eaa0d44e850c9f40f4be74c2656ddf13d057c671946d71797805bb13bec9f3",
        build_file_content = """
load("@rules_dotnet//dotnet:defs.bzl", "import_library", "import_multiframework_library")
import_library(
    name = "net11",
    target_framework = "net11",
    deps = [
    ],
    data = [
    ],
)
import_library(
    name = "net20",
    target_framework = "net20",
    deps = [
    ],
    data = [
    ],
)
import_library(
    name = "net35",
    target_framework = "net35",
    deps = [
    ],
    data = [
    ],
)
import_library(
    name = "net40",
    target_framework = "net40",
    deps = [
    ],
    data = [
    ],
)
import_library(
    name = "net403",
    target_framework = "net403",
    deps = [
    ],
    data = [
    ],
)
import_library(
    name = "net45",
    target_framework = "net45",
    deps = [
    ],
    data = [
    ],
)
import_library(
    name = "net451",
    target_framework = "net451",
    deps = [
    ],
    data = [
    ],
)
import_library(
    name = "net452",
    target_framework = "net452",
    deps = [
    ],
    data = [
    ],
)
import_library(
    name = "net46",
    target_framework = "net46",
    deps = [
    ],
    data = [
    ],
)
import_library(
    name = "net461",
    target_framework = "net461",
    deps = [
    ],
    data = [
    ],
)
import_library(
    name = "net462",
    target_framework = "net462",
    deps = [
    ],
    data = [
    ],
)
import_library(
    name = "net47",
    target_framework = "net47",
    deps = [
    ],
    data = [
    ],
)
import_library(
    name = "net471",
    target_framework = "net471",
    deps = [
    ],
    data = [
    ],
)
import_library(
    name = "net472",
    target_framework = "net472",
    deps = [
    ],
    data = [
    ],
)
import_library(
    name = "net48",
    target_framework = "net48",
    deps = [
    ],
    data = [
    ],
)
import_library(
    name = "netstandard",
    target_framework = "netstandard",
    deps = [
    ],
    data = [
    ],
)
import_library(
    name = "netstandard1.0",
    target_framework = "netstandard1.0",
    deps = [
    ],
    data = [
    ],
)
import_library(
    name = "netstandard1.1",
    target_framework = "netstandard1.1",
    deps = [
    ],
    data = [
    ],
)
import_library(
    name = "netstandard1.2",
    target_framework = "netstandard1.2",
    deps = [
    ],
    data = [
    ],
)
import_library(
    name = "netstandard1.3",
    target_framework = "netstandard1.3",
    deps = [
    ],
    data = [
    ],
)
import_library(
    name = "netstandard1.4",
    target_framework = "netstandard1.4",
    deps = [
    ],
    data = [
    ],
)
import_library(
    name = "netstandard1.5",
    target_framework = "netstandard1.5",
    deps = [
    ],
    data = [
    ],
)
import_library(
    name = "netstandard1.6",
    target_framework = "netstandard1.6",
    deps = [
    ],
    data = [
    ],
)
import_library(
    name = "netstandard2.0",
    target_framework = "netstandard2.0",
    deps = [
    ],
    data = [
    ],
)
import_library(
    name = "netstandard2.1",
    target_framework = "netstandard2.1",
    deps = [
    ],
    data = [
    ],
)
import_library(
    name = "netcoreapp1.0",
    target_framework = "netcoreapp1.0",
    deps = [
    ],
    data = [
    ],
)
import_library(
    name = "netcoreapp1.1",
    target_framework = "netcoreapp1.1",
    deps = [
    ],
    data = [
    ],
)
import_library(
    name = "netcoreapp2.0",
    target_framework = "netcoreapp2.0",
    deps = [
    ],
    data = [
    ],
)
import_library(
    name = "netcoreapp2.1",
    target_framework = "netcoreapp2.1",
    deps = [
    ],
    data = [
    ],
)
import_library(
    name = "netcoreapp2.2",
    target_framework = "netcoreapp2.2",
    deps = [
    ],
    data = [
    ],
)
import_library(
    name = "netcoreapp3.0",
    target_framework = "netcoreapp3.0",
    deps = [
    ],
    data = [
    ],
)
import_library(
    name = "netcoreapp3.1",
    target_framework = "netcoreapp3.1",
    dll = "lib/netcoreapp3.1/System.Windows.Extensions.dll",
    refdll = "lib/netcoreapp3.1/System.Windows.Extensions.dll",
    deps = [
        "@main.system.drawing.common//:lib",
    ],
    data = [
        "lib/netcoreapp3.1/System.Windows.Extensions.dll",
        "lib/netcoreapp3.1/System.Windows.Extensions.xml",
    ],
)
import_library(
    name = "net5.0",
    target_framework = "net5.0",
    dll = "lib/netcoreapp3.1/System.Windows.Extensions.dll",
    refdll = "lib/netcoreapp3.1/System.Windows.Extensions.dll",
    deps = [
        "@main.system.drawing.common//:lib",
    ],
    data = [
        "lib/netcoreapp3.1/System.Windows.Extensions.dll",
        "lib/netcoreapp3.1/System.Windows.Extensions.xml",
    ],
)
import_library(
    name = "net6.0",
    target_framework = "net6.0",
    dll = "lib/net6.0/System.Windows.Extensions.dll",
    refdll = "lib/net6.0/System.Windows.Extensions.dll",
    deps = [
        "@main.system.drawing.common//:lib",
    ],
    data = [
        "lib/net6.0/System.Windows.Extensions.dll",
        "lib/net6.0/System.Windows.Extensions.xml",
    ],
)
import_multiframework_library(
    name = "lib",
    net11 = ":net11",
    net20 = ":net20",
    net35 = ":net35",
    net40 = ":net40",
    net403 = ":net403",
    net45 = ":net45",
    net451 = ":net451",
    net452 = ":net452",
    net46 = ":net46",
    net461 = ":net461",
    net462 = ":net462",
    net47 = ":net47",
    net471 = ":net471",
    net472 = ":net472",
    net48 = ":net48",
    netstandard = ":netstandard",
    netstandard1_0 = ":netstandard1.0",
    netstandard1_1 = ":netstandard1.1",
    netstandard1_2 = ":netstandard1.2",
    netstandard1_3 = ":netstandard1.3",
    netstandard1_4 = ":netstandard1.4",
    netstandard1_5 = ":netstandard1.5",
    netstandard1_6 = ":netstandard1.6",
    netstandard2_0 = ":netstandard2.0",
    netstandard2_1 = ":netstandard2.1",
    netcoreapp1_0 = ":netcoreapp1.0",
    netcoreapp1_1 = ":netcoreapp1.1",
    netcoreapp2_0 = ":netcoreapp2.0",
    netcoreapp2_1 = ":netcoreapp2.1",
    netcoreapp2_2 = ":netcoreapp2.2",
    netcoreapp3_0 = ":netcoreapp3.0",
    netcoreapp3_1 = ":netcoreapp3.1",
    net5_0 = ":net5.0",
    net6_0 = ":net6.0",
    visibility = ["//visibility:public"],
)
"""
    )
    nuget_package(
        name = "othergroup.argu",
        package = "argu",
        version = "6.1.1",
        sha256 = "b40f67149996be848ea3ca0557ac14b9ab46e7b6b74125b48f100373c03329ed",
        build_file_content = """
load("@rules_dotnet//dotnet:defs.bzl", "import_library", "import_multiframework_library")
import_library(
    name = "net11",
    target_framework = "net11",
    deps = [
    ],
    data = [
    ],
)
import_library(
    name = "net20",
    target_framework = "net20",
    deps = [
    ],
    data = [
    ],
)
import_library(
    name = "net35",
    target_framework = "net35",
    deps = [
    ],
    data = [
    ],
)
import_library(
    name = "net40",
    target_framework = "net40",
    deps = [
    ],
    data = [
    ],
)
import_library(
    name = "net403",
    target_framework = "net403",
    deps = [
    ],
    data = [
    ],
)
import_library(
    name = "net45",
    target_framework = "net45",
    deps = [
    ],
    data = [
    ],
)
import_library(
    name = "net451",
    target_framework = "net451",
    deps = [
    ],
    data = [
    ],
)
import_library(
    name = "net452",
    target_framework = "net452",
    deps = [
    ],
    data = [
    ],
)
import_library(
    name = "net46",
    target_framework = "net46",
    deps = [
    ],
    data = [
    ],
)
import_library(
    name = "net461",
    target_framework = "net461",
    dll = "lib/netstandard2.0/Argu.dll",
    refdll = "lib/netstandard2.0/Argu.dll",
    pdb = "lib/netstandard2.0/Argu.pdb",
    deps = [
        "@othergroup.fsharp.core//:lib",
        "@othergroup.system.configuration.configurationmanager//:lib",
    ],
    data = [
        "lib/netstandard2.0/Argu.dll",
        "lib/netstandard2.0/Argu.xml",
    ],
)
import_library(
    name = "net462",
    target_framework = "net462",
    dll = "lib/netstandard2.0/Argu.dll",
    refdll = "lib/netstandard2.0/Argu.dll",
    pdb = "lib/netstandard2.0/Argu.pdb",
    deps = [
        "@othergroup.fsharp.core//:lib",
        "@othergroup.system.configuration.configurationmanager//:lib",
    ],
    data = [
        "lib/netstandard2.0/Argu.dll",
        "lib/netstandard2.0/Argu.xml",
    ],
)
import_library(
    name = "net47",
    target_framework = "net47",
    dll = "lib/netstandard2.0/Argu.dll",
    refdll = "lib/netstandard2.0/Argu.dll",
    pdb = "lib/netstandard2.0/Argu.pdb",
    deps = [
        "@othergroup.fsharp.core//:lib",
        "@othergroup.system.configuration.configurationmanager//:lib",
    ],
    data = [
        "lib/netstandard2.0/Argu.dll",
        "lib/netstandard2.0/Argu.xml",
    ],
)
import_library(
    name = "net471",
    target_framework = "net471",
    dll = "lib/netstandard2.0/Argu.dll",
    refdll = "lib/netstandard2.0/Argu.dll",
    pdb = "lib/netstandard2.0/Argu.pdb",
    deps = [
        "@othergroup.fsharp.core//:lib",
        "@othergroup.system.configuration.configurationmanager//:lib",
    ],
    data = [
        "lib/netstandard2.0/Argu.dll",
        "lib/netstandard2.0/Argu.xml",
    ],
)
import_library(
    name = "net472",
    target_framework = "net472",
    dll = "lib/netstandard2.0/Argu.dll",
    refdll = "lib/netstandard2.0/Argu.dll",
    pdb = "lib/netstandard2.0/Argu.pdb",
    deps = [
        "@othergroup.fsharp.core//:lib",
        "@othergroup.system.configuration.configurationmanager//:lib",
    ],
    data = [
        "lib/netstandard2.0/Argu.dll",
        "lib/netstandard2.0/Argu.xml",
    ],
)
import_library(
    name = "net48",
    target_framework = "net48",
    dll = "lib/netstandard2.0/Argu.dll",
    refdll = "lib/netstandard2.0/Argu.dll",
    pdb = "lib/netstandard2.0/Argu.pdb",
    deps = [
        "@othergroup.fsharp.core//:lib",
        "@othergroup.system.configuration.configurationmanager//:lib",
    ],
    data = [
        "lib/netstandard2.0/Argu.dll",
        "lib/netstandard2.0/Argu.xml",
    ],
)
import_library(
    name = "netstandard",
    target_framework = "netstandard",
    deps = [
    ],
    data = [
    ],
)
import_library(
    name = "netstandard1.0",
    target_framework = "netstandard1.0",
    deps = [
    ],
    data = [
    ],
)
import_library(
    name = "netstandard1.1",
    target_framework = "netstandard1.1",
    deps = [
    ],
    data = [
    ],
)
import_library(
    name = "netstandard1.2",
    target_framework = "netstandard1.2",
    deps = [
    ],
    data = [
    ],
)
import_library(
    name = "netstandard1.3",
    target_framework = "netstandard1.3",
    deps = [
    ],
    data = [
    ],
)
import_library(
    name = "netstandard1.4",
    target_framework = "netstandard1.4",
    deps = [
    ],
    data = [
    ],
)
import_library(
    name = "netstandard1.5",
    target_framework = "netstandard1.5",
    deps = [
    ],
    data = [
    ],
)
import_library(
    name = "netstandard1.6",
    target_framework = "netstandard1.6",
    deps = [
    ],
    data = [
    ],
)
import_library(
    name = "netstandard2.0",
    target_framework = "netstandard2.0",
    dll = "lib/netstandard2.0/Argu.dll",
    refdll = "lib/netstandard2.0/Argu.dll",
    pdb = "lib/netstandard2.0/Argu.pdb",
    deps = [
        "@othergroup.fsharp.core//:lib",
        "@othergroup.system.configuration.configurationmanager//:lib",
    ],
    data = [
        "lib/netstandard2.0/Argu.dll",
        "lib/netstandard2.0/Argu.xml",
    ],
)
import_library(
    name = "netstandard2.1",
    target_framework = "netstandard2.1",
    dll = "lib/netstandard2.0/Argu.dll",
    refdll = "lib/netstandard2.0/Argu.dll",
    pdb = "lib/netstandard2.0/Argu.pdb",
    deps = [
        "@othergroup.fsharp.core//:lib",
        "@othergroup.system.configuration.configurationmanager//:lib",
    ],
    data = [
        "lib/netstandard2.0/Argu.dll",
        "lib/netstandard2.0/Argu.xml",
    ],
)
import_library(
    name = "netcoreapp1.0",
    target_framework = "netcoreapp1.0",
    deps = [
    ],
    data = [
    ],
)
import_library(
    name = "netcoreapp1.1",
    target_framework = "netcoreapp1.1",
    deps = [
    ],
    data = [
    ],
)
import_library(
    name = "netcoreapp2.0",
    target_framework = "netcoreapp2.0",
    dll = "lib/netstandard2.0/Argu.dll",
    refdll = "lib/netstandard2.0/Argu.dll",
    pdb = "lib/netstandard2.0/Argu.pdb",
    deps = [
        "@othergroup.fsharp.core//:lib",
        "@othergroup.system.configuration.configurationmanager//:lib",
    ],
    data = [
        "lib/netstandard2.0/Argu.dll",
        "lib/netstandard2.0/Argu.xml",
    ],
)
import_library(
    name = "netcoreapp2.1",
    target_framework = "netcoreapp2.1",
    dll = "lib/netstandard2.0/Argu.dll",
    refdll = "lib/netstandard2.0/Argu.dll",
    pdb = "lib/netstandard2.0/Argu.pdb",
    deps = [
        "@othergroup.fsharp.core//:lib",
        "@othergroup.system.configuration.configurationmanager//:lib",
    ],
    data = [
        "lib/netstandard2.0/Argu.dll",
        "lib/netstandard2.0/Argu.xml",
    ],
)
import_library(
    name = "netcoreapp2.2",
    target_framework = "netcoreapp2.2",
    dll = "lib/netstandard2.0/Argu.dll",
    refdll = "lib/netstandard2.0/Argu.dll",
    pdb = "lib/netstandard2.0/Argu.pdb",
    deps = [
        "@othergroup.fsharp.core//:lib",
        "@othergroup.system.configuration.configurationmanager//:lib",
    ],
    data = [
        "lib/netstandard2.0/Argu.dll",
        "lib/netstandard2.0/Argu.xml",
    ],
)
import_library(
    name = "netcoreapp3.0",
    target_framework = "netcoreapp3.0",
    dll = "lib/netstandard2.0/Argu.dll",
    refdll = "lib/netstandard2.0/Argu.dll",
    pdb = "lib/netstandard2.0/Argu.pdb",
    deps = [
        "@othergroup.fsharp.core//:lib",
        "@othergroup.system.configuration.configurationmanager//:lib",
    ],
    data = [
        "lib/netstandard2.0/Argu.dll",
        "lib/netstandard2.0/Argu.xml",
    ],
)
import_library(
    name = "netcoreapp3.1",
    target_framework = "netcoreapp3.1",
    dll = "lib/netstandard2.0/Argu.dll",
    refdll = "lib/netstandard2.0/Argu.dll",
    pdb = "lib/netstandard2.0/Argu.pdb",
    deps = [
        "@othergroup.fsharp.core//:lib",
        "@othergroup.system.configuration.configurationmanager//:lib",
    ],
    data = [
        "lib/netstandard2.0/Argu.dll",
        "lib/netstandard2.0/Argu.xml",
    ],
)
import_library(
    name = "net5.0",
    target_framework = "net5.0",
    dll = "lib/netstandard2.0/Argu.dll",
    refdll = "lib/netstandard2.0/Argu.dll",
    pdb = "lib/netstandard2.0/Argu.pdb",
    deps = [
        "@othergroup.fsharp.core//:lib",
        "@othergroup.system.configuration.configurationmanager//:lib",
    ],
    data = [
        "lib/netstandard2.0/Argu.dll",
        "lib/netstandard2.0/Argu.xml",
    ],
)
import_library(
    name = "net6.0",
    target_framework = "net6.0",
    dll = "lib/netstandard2.0/Argu.dll",
    refdll = "lib/netstandard2.0/Argu.dll",
    pdb = "lib/netstandard2.0/Argu.pdb",
    deps = [
        "@othergroup.fsharp.core//:lib",
        "@othergroup.system.configuration.configurationmanager//:lib",
    ],
    data = [
        "lib/netstandard2.0/Argu.dll",
        "lib/netstandard2.0/Argu.xml",
    ],
)
import_multiframework_library(
    name = "lib",
    net11 = ":net11",
    net20 = ":net20",
    net35 = ":net35",
    net40 = ":net40",
    net403 = ":net403",
    net45 = ":net45",
    net451 = ":net451",
    net452 = ":net452",
    net46 = ":net46",
    net461 = ":net461",
    net462 = ":net462",
    net47 = ":net47",
    net471 = ":net471",
    net472 = ":net472",
    net48 = ":net48",
    netstandard = ":netstandard",
    netstandard1_0 = ":netstandard1.0",
    netstandard1_1 = ":netstandard1.1",
    netstandard1_2 = ":netstandard1.2",
    netstandard1_3 = ":netstandard1.3",
    netstandard1_4 = ":netstandard1.4",
    netstandard1_5 = ":netstandard1.5",
    netstandard1_6 = ":netstandard1.6",
    netstandard2_0 = ":netstandard2.0",
    netstandard2_1 = ":netstandard2.1",
    netcoreapp1_0 = ":netcoreapp1.0",
    netcoreapp1_1 = ":netcoreapp1.1",
    netcoreapp2_0 = ":netcoreapp2.0",
    netcoreapp2_1 = ":netcoreapp2.1",
    netcoreapp2_2 = ":netcoreapp2.2",
    netcoreapp3_0 = ":netcoreapp3.0",
    netcoreapp3_1 = ":netcoreapp3.1",
    net5_0 = ":net5.0",
    net6_0 = ":net6.0",
    visibility = ["//visibility:public"],
)
"""
    )
    nuget_package(
        name = "othergroup.fsharp.core",
        package = "fsharp.core",
        version = "6.0.4",
        sha256 = "bb3de1443cda987da82862e66e0dc4835dc03859f16919c2116679487f98f045",
        build_file_content = """
load("@rules_dotnet//dotnet:defs.bzl", "import_library", "import_multiframework_library")
import_library(
    name = "net11",
    target_framework = "net11",
    deps = [
    ],
    data = [
    ],
)
import_library(
    name = "net20",
    target_framework = "net20",
    deps = [
    ],
    data = [
    ],
)
import_library(
    name = "net35",
    target_framework = "net35",
    deps = [
    ],
    data = [
    ],
)
import_library(
    name = "net40",
    target_framework = "net40",
    deps = [
    ],
    data = [
    ],
)
import_library(
    name = "net403",
    target_framework = "net403",
    deps = [
    ],
    data = [
    ],
)
import_library(
    name = "net45",
    target_framework = "net45",
    deps = [
    ],
    data = [
    ],
)
import_library(
    name = "net451",
    target_framework = "net451",
    deps = [
    ],
    data = [
    ],
)
import_library(
    name = "net452",
    target_framework = "net452",
    deps = [
    ],
    data = [
    ],
)
import_library(
    name = "net46",
    target_framework = "net46",
    deps = [
    ],
    data = [
    ],
)
import_library(
    name = "net461",
    target_framework = "net461",
    dll = "lib/netstandard2.0/FSharp.Core.dll",
    refdll = "lib/netstandard2.0/FSharp.Core.dll",
    deps = [
    ],
    data = [
        "lib/netstandard2.0/cs/FSharp.Core.resources.dll",
        "lib/netstandard2.0/de/FSharp.Core.resources.dll",
        "lib/netstandard2.0/es/FSharp.Core.resources.dll",
        "lib/netstandard2.0/fr/FSharp.Core.resources.dll",
        "lib/netstandard2.0/FSharp.Core.dll",
        "lib/netstandard2.0/FSharp.Core.xml",
        "lib/netstandard2.0/it/FSharp.Core.resources.dll",
        "lib/netstandard2.0/ja/FSharp.Core.resources.dll",
        "lib/netstandard2.0/ko/FSharp.Core.resources.dll",
        "lib/netstandard2.0/pl/FSharp.Core.resources.dll",
        "lib/netstandard2.0/pt-BR/FSharp.Core.resources.dll",
        "lib/netstandard2.0/ru/FSharp.Core.resources.dll",
        "lib/netstandard2.0/tr/FSharp.Core.resources.dll",
        "lib/netstandard2.0/zh-Hans/FSharp.Core.resources.dll",
        "lib/netstandard2.0/zh-Hant/FSharp.Core.resources.dll",
    ],
)
import_library(
    name = "net462",
    target_framework = "net462",
    dll = "lib/netstandard2.0/FSharp.Core.dll",
    refdll = "lib/netstandard2.0/FSharp.Core.dll",
    deps = [
    ],
    data = [
        "lib/netstandard2.0/cs/FSharp.Core.resources.dll",
        "lib/netstandard2.0/de/FSharp.Core.resources.dll",
        "lib/netstandard2.0/es/FSharp.Core.resources.dll",
        "lib/netstandard2.0/fr/FSharp.Core.resources.dll",
        "lib/netstandard2.0/FSharp.Core.dll",
        "lib/netstandard2.0/FSharp.Core.xml",
        "lib/netstandard2.0/it/FSharp.Core.resources.dll",
        "lib/netstandard2.0/ja/FSharp.Core.resources.dll",
        "lib/netstandard2.0/ko/FSharp.Core.resources.dll",
        "lib/netstandard2.0/pl/FSharp.Core.resources.dll",
        "lib/netstandard2.0/pt-BR/FSharp.Core.resources.dll",
        "lib/netstandard2.0/ru/FSharp.Core.resources.dll",
        "lib/netstandard2.0/tr/FSharp.Core.resources.dll",
        "lib/netstandard2.0/zh-Hans/FSharp.Core.resources.dll",
        "lib/netstandard2.0/zh-Hant/FSharp.Core.resources.dll",
    ],
)
import_library(
    name = "net47",
    target_framework = "net47",
    dll = "lib/netstandard2.0/FSharp.Core.dll",
    refdll = "lib/netstandard2.0/FSharp.Core.dll",
    deps = [
    ],
    data = [
        "lib/netstandard2.0/cs/FSharp.Core.resources.dll",
        "lib/netstandard2.0/de/FSharp.Core.resources.dll",
        "lib/netstandard2.0/es/FSharp.Core.resources.dll",
        "lib/netstandard2.0/fr/FSharp.Core.resources.dll",
        "lib/netstandard2.0/FSharp.Core.dll",
        "lib/netstandard2.0/FSharp.Core.xml",
        "lib/netstandard2.0/it/FSharp.Core.resources.dll",
        "lib/netstandard2.0/ja/FSharp.Core.resources.dll",
        "lib/netstandard2.0/ko/FSharp.Core.resources.dll",
        "lib/netstandard2.0/pl/FSharp.Core.resources.dll",
        "lib/netstandard2.0/pt-BR/FSharp.Core.resources.dll",
        "lib/netstandard2.0/ru/FSharp.Core.resources.dll",
        "lib/netstandard2.0/tr/FSharp.Core.resources.dll",
        "lib/netstandard2.0/zh-Hans/FSharp.Core.resources.dll",
        "lib/netstandard2.0/zh-Hant/FSharp.Core.resources.dll",
    ],
)
import_library(
    name = "net471",
    target_framework = "net471",
    dll = "lib/netstandard2.0/FSharp.Core.dll",
    refdll = "lib/netstandard2.0/FSharp.Core.dll",
    deps = [
    ],
    data = [
        "lib/netstandard2.0/cs/FSharp.Core.resources.dll",
        "lib/netstandard2.0/de/FSharp.Core.resources.dll",
        "lib/netstandard2.0/es/FSharp.Core.resources.dll",
        "lib/netstandard2.0/fr/FSharp.Core.resources.dll",
        "lib/netstandard2.0/FSharp.Core.dll",
        "lib/netstandard2.0/FSharp.Core.xml",
        "lib/netstandard2.0/it/FSharp.Core.resources.dll",
        "lib/netstandard2.0/ja/FSharp.Core.resources.dll",
        "lib/netstandard2.0/ko/FSharp.Core.resources.dll",
        "lib/netstandard2.0/pl/FSharp.Core.resources.dll",
        "lib/netstandard2.0/pt-BR/FSharp.Core.resources.dll",
        "lib/netstandard2.0/ru/FSharp.Core.resources.dll",
        "lib/netstandard2.0/tr/FSharp.Core.resources.dll",
        "lib/netstandard2.0/zh-Hans/FSharp.Core.resources.dll",
        "lib/netstandard2.0/zh-Hant/FSharp.Core.resources.dll",
    ],
)
import_library(
    name = "net472",
    target_framework = "net472",
    dll = "lib/netstandard2.0/FSharp.Core.dll",
    refdll = "lib/netstandard2.0/FSharp.Core.dll",
    deps = [
    ],
    data = [
        "lib/netstandard2.0/cs/FSharp.Core.resources.dll",
        "lib/netstandard2.0/de/FSharp.Core.resources.dll",
        "lib/netstandard2.0/es/FSharp.Core.resources.dll",
        "lib/netstandard2.0/fr/FSharp.Core.resources.dll",
        "lib/netstandard2.0/FSharp.Core.dll",
        "lib/netstandard2.0/FSharp.Core.xml",
        "lib/netstandard2.0/it/FSharp.Core.resources.dll",
        "lib/netstandard2.0/ja/FSharp.Core.resources.dll",
        "lib/netstandard2.0/ko/FSharp.Core.resources.dll",
        "lib/netstandard2.0/pl/FSharp.Core.resources.dll",
        "lib/netstandard2.0/pt-BR/FSharp.Core.resources.dll",
        "lib/netstandard2.0/ru/FSharp.Core.resources.dll",
        "lib/netstandard2.0/tr/FSharp.Core.resources.dll",
        "lib/netstandard2.0/zh-Hans/FSharp.Core.resources.dll",
        "lib/netstandard2.0/zh-Hant/FSharp.Core.resources.dll",
    ],
)
import_library(
    name = "net48",
    target_framework = "net48",
    dll = "lib/netstandard2.0/FSharp.Core.dll",
    refdll = "lib/netstandard2.0/FSharp.Core.dll",
    deps = [
    ],
    data = [
        "lib/netstandard2.0/cs/FSharp.Core.resources.dll",
        "lib/netstandard2.0/de/FSharp.Core.resources.dll",
        "lib/netstandard2.0/es/FSharp.Core.resources.dll",
        "lib/netstandard2.0/fr/FSharp.Core.resources.dll",
        "lib/netstandard2.0/FSharp.Core.dll",
        "lib/netstandard2.0/FSharp.Core.xml",
        "lib/netstandard2.0/it/FSharp.Core.resources.dll",
        "lib/netstandard2.0/ja/FSharp.Core.resources.dll",
        "lib/netstandard2.0/ko/FSharp.Core.resources.dll",
        "lib/netstandard2.0/pl/FSharp.Core.resources.dll",
        "lib/netstandard2.0/pt-BR/FSharp.Core.resources.dll",
        "lib/netstandard2.0/ru/FSharp.Core.resources.dll",
        "lib/netstandard2.0/tr/FSharp.Core.resources.dll",
        "lib/netstandard2.0/zh-Hans/FSharp.Core.resources.dll",
        "lib/netstandard2.0/zh-Hant/FSharp.Core.resources.dll",
    ],
)
import_library(
    name = "netstandard",
    target_framework = "netstandard",
    deps = [
    ],
    data = [
    ],
)
import_library(
    name = "netstandard1.0",
    target_framework = "netstandard1.0",
    deps = [
    ],
    data = [
    ],
)
import_library(
    name = "netstandard1.1",
    target_framework = "netstandard1.1",
    deps = [
    ],
    data = [
    ],
)
import_library(
    name = "netstandard1.2",
    target_framework = "netstandard1.2",
    deps = [
    ],
    data = [
    ],
)
import_library(
    name = "netstandard1.3",
    target_framework = "netstandard1.3",
    deps = [
    ],
    data = [
    ],
)
import_library(
    name = "netstandard1.4",
    target_framework = "netstandard1.4",
    deps = [
    ],
    data = [
    ],
)
import_library(
    name = "netstandard1.5",
    target_framework = "netstandard1.5",
    deps = [
    ],
    data = [
    ],
)
import_library(
    name = "netstandard1.6",
    target_framework = "netstandard1.6",
    deps = [
    ],
    data = [
    ],
)
import_library(
    name = "netstandard2.0",
    target_framework = "netstandard2.0",
    dll = "lib/netstandard2.0/FSharp.Core.dll",
    refdll = "lib/netstandard2.0/FSharp.Core.dll",
    deps = [
    ],
    data = [
        "lib/netstandard2.0/cs/FSharp.Core.resources.dll",
        "lib/netstandard2.0/de/FSharp.Core.resources.dll",
        "lib/netstandard2.0/es/FSharp.Core.resources.dll",
        "lib/netstandard2.0/fr/FSharp.Core.resources.dll",
        "lib/netstandard2.0/FSharp.Core.dll",
        "lib/netstandard2.0/FSharp.Core.xml",
        "lib/netstandard2.0/it/FSharp.Core.resources.dll",
        "lib/netstandard2.0/ja/FSharp.Core.resources.dll",
        "lib/netstandard2.0/ko/FSharp.Core.resources.dll",
        "lib/netstandard2.0/pl/FSharp.Core.resources.dll",
        "lib/netstandard2.0/pt-BR/FSharp.Core.resources.dll",
        "lib/netstandard2.0/ru/FSharp.Core.resources.dll",
        "lib/netstandard2.0/tr/FSharp.Core.resources.dll",
        "lib/netstandard2.0/zh-Hans/FSharp.Core.resources.dll",
        "lib/netstandard2.0/zh-Hant/FSharp.Core.resources.dll",
    ],
)
import_library(
    name = "netstandard2.1",
    target_framework = "netstandard2.1",
    dll = "lib/netstandard2.1/FSharp.Core.dll",
    refdll = "lib/netstandard2.1/FSharp.Core.dll",
    deps = [
    ],
    data = [
        "lib/netstandard2.1/cs/FSharp.Core.resources.dll",
        "lib/netstandard2.1/de/FSharp.Core.resources.dll",
        "lib/netstandard2.1/es/FSharp.Core.resources.dll",
        "lib/netstandard2.1/fr/FSharp.Core.resources.dll",
        "lib/netstandard2.1/FSharp.Core.dll",
        "lib/netstandard2.1/FSharp.Core.xml",
        "lib/netstandard2.1/it/FSharp.Core.resources.dll",
        "lib/netstandard2.1/ja/FSharp.Core.resources.dll",
        "lib/netstandard2.1/ko/FSharp.Core.resources.dll",
        "lib/netstandard2.1/pl/FSharp.Core.resources.dll",
        "lib/netstandard2.1/pt-BR/FSharp.Core.resources.dll",
        "lib/netstandard2.1/ru/FSharp.Core.resources.dll",
        "lib/netstandard2.1/tr/FSharp.Core.resources.dll",
        "lib/netstandard2.1/zh-Hans/FSharp.Core.resources.dll",
        "lib/netstandard2.1/zh-Hant/FSharp.Core.resources.dll",
    ],
)
import_library(
    name = "netcoreapp1.0",
    target_framework = "netcoreapp1.0",
    deps = [
    ],
    data = [
    ],
)
import_library(
    name = "netcoreapp1.1",
    target_framework = "netcoreapp1.1",
    deps = [
    ],
    data = [
    ],
)
import_library(
    name = "netcoreapp2.0",
    target_framework = "netcoreapp2.0",
    dll = "lib/netstandard2.0/FSharp.Core.dll",
    refdll = "lib/netstandard2.0/FSharp.Core.dll",
    deps = [
    ],
    data = [
        "lib/netstandard2.0/cs/FSharp.Core.resources.dll",
        "lib/netstandard2.0/de/FSharp.Core.resources.dll",
        "lib/netstandard2.0/es/FSharp.Core.resources.dll",
        "lib/netstandard2.0/fr/FSharp.Core.resources.dll",
        "lib/netstandard2.0/FSharp.Core.dll",
        "lib/netstandard2.0/FSharp.Core.xml",
        "lib/netstandard2.0/it/FSharp.Core.resources.dll",
        "lib/netstandard2.0/ja/FSharp.Core.resources.dll",
        "lib/netstandard2.0/ko/FSharp.Core.resources.dll",
        "lib/netstandard2.0/pl/FSharp.Core.resources.dll",
        "lib/netstandard2.0/pt-BR/FSharp.Core.resources.dll",
        "lib/netstandard2.0/ru/FSharp.Core.resources.dll",
        "lib/netstandard2.0/tr/FSharp.Core.resources.dll",
        "lib/netstandard2.0/zh-Hans/FSharp.Core.resources.dll",
        "lib/netstandard2.0/zh-Hant/FSharp.Core.resources.dll",
    ],
)
import_library(
    name = "netcoreapp2.1",
    target_framework = "netcoreapp2.1",
    dll = "lib/netstandard2.0/FSharp.Core.dll",
    refdll = "lib/netstandard2.0/FSharp.Core.dll",
    deps = [
    ],
    data = [
        "lib/netstandard2.0/cs/FSharp.Core.resources.dll",
        "lib/netstandard2.0/de/FSharp.Core.resources.dll",
        "lib/netstandard2.0/es/FSharp.Core.resources.dll",
        "lib/netstandard2.0/fr/FSharp.Core.resources.dll",
        "lib/netstandard2.0/FSharp.Core.dll",
        "lib/netstandard2.0/FSharp.Core.xml",
        "lib/netstandard2.0/it/FSharp.Core.resources.dll",
        "lib/netstandard2.0/ja/FSharp.Core.resources.dll",
        "lib/netstandard2.0/ko/FSharp.Core.resources.dll",
        "lib/netstandard2.0/pl/FSharp.Core.resources.dll",
        "lib/netstandard2.0/pt-BR/FSharp.Core.resources.dll",
        "lib/netstandard2.0/ru/FSharp.Core.resources.dll",
        "lib/netstandard2.0/tr/FSharp.Core.resources.dll",
        "lib/netstandard2.0/zh-Hans/FSharp.Core.resources.dll",
        "lib/netstandard2.0/zh-Hant/FSharp.Core.resources.dll",
    ],
)
import_library(
    name = "netcoreapp2.2",
    target_framework = "netcoreapp2.2",
    dll = "lib/netstandard2.0/FSharp.Core.dll",
    refdll = "lib/netstandard2.0/FSharp.Core.dll",
    deps = [
    ],
    data = [
        "lib/netstandard2.0/cs/FSharp.Core.resources.dll",
        "lib/netstandard2.0/de/FSharp.Core.resources.dll",
        "lib/netstandard2.0/es/FSharp.Core.resources.dll",
        "lib/netstandard2.0/fr/FSharp.Core.resources.dll",
        "lib/netstandard2.0/FSharp.Core.dll",
        "lib/netstandard2.0/FSharp.Core.xml",
        "lib/netstandard2.0/it/FSharp.Core.resources.dll",
        "lib/netstandard2.0/ja/FSharp.Core.resources.dll",
        "lib/netstandard2.0/ko/FSharp.Core.resources.dll",
        "lib/netstandard2.0/pl/FSharp.Core.resources.dll",
        "lib/netstandard2.0/pt-BR/FSharp.Core.resources.dll",
        "lib/netstandard2.0/ru/FSharp.Core.resources.dll",
        "lib/netstandard2.0/tr/FSharp.Core.resources.dll",
        "lib/netstandard2.0/zh-Hans/FSharp.Core.resources.dll",
        "lib/netstandard2.0/zh-Hant/FSharp.Core.resources.dll",
    ],
)
import_library(
    name = "netcoreapp3.0",
    target_framework = "netcoreapp3.0",
    dll = "lib/netstandard2.1/FSharp.Core.dll",
    refdll = "lib/netstandard2.1/FSharp.Core.dll",
    deps = [
    ],
    data = [
        "lib/netstandard2.1/cs/FSharp.Core.resources.dll",
        "lib/netstandard2.1/de/FSharp.Core.resources.dll",
        "lib/netstandard2.1/es/FSharp.Core.resources.dll",
        "lib/netstandard2.1/fr/FSharp.Core.resources.dll",
        "lib/netstandard2.1/FSharp.Core.dll",
        "lib/netstandard2.1/FSharp.Core.xml",
        "lib/netstandard2.1/it/FSharp.Core.resources.dll",
        "lib/netstandard2.1/ja/FSharp.Core.resources.dll",
        "lib/netstandard2.1/ko/FSharp.Core.resources.dll",
        "lib/netstandard2.1/pl/FSharp.Core.resources.dll",
        "lib/netstandard2.1/pt-BR/FSharp.Core.resources.dll",
        "lib/netstandard2.1/ru/FSharp.Core.resources.dll",
        "lib/netstandard2.1/tr/FSharp.Core.resources.dll",
        "lib/netstandard2.1/zh-Hans/FSharp.Core.resources.dll",
        "lib/netstandard2.1/zh-Hant/FSharp.Core.resources.dll",
    ],
)
import_library(
    name = "netcoreapp3.1",
    target_framework = "netcoreapp3.1",
    dll = "lib/netstandard2.1/FSharp.Core.dll",
    refdll = "lib/netstandard2.1/FSharp.Core.dll",
    deps = [
    ],
    data = [
        "lib/netstandard2.1/cs/FSharp.Core.resources.dll",
        "lib/netstandard2.1/de/FSharp.Core.resources.dll",
        "lib/netstandard2.1/es/FSharp.Core.resources.dll",
        "lib/netstandard2.1/fr/FSharp.Core.resources.dll",
        "lib/netstandard2.1/FSharp.Core.dll",
        "lib/netstandard2.1/FSharp.Core.xml",
        "lib/netstandard2.1/it/FSharp.Core.resources.dll",
        "lib/netstandard2.1/ja/FSharp.Core.resources.dll",
        "lib/netstandard2.1/ko/FSharp.Core.resources.dll",
        "lib/netstandard2.1/pl/FSharp.Core.resources.dll",
        "lib/netstandard2.1/pt-BR/FSharp.Core.resources.dll",
        "lib/netstandard2.1/ru/FSharp.Core.resources.dll",
        "lib/netstandard2.1/tr/FSharp.Core.resources.dll",
        "lib/netstandard2.1/zh-Hans/FSharp.Core.resources.dll",
        "lib/netstandard2.1/zh-Hant/FSharp.Core.resources.dll",
    ],
)
import_library(
    name = "net5.0",
    target_framework = "net5.0",
    dll = "lib/netstandard2.1/FSharp.Core.dll",
    refdll = "lib/netstandard2.1/FSharp.Core.dll",
    deps = [
    ],
    data = [
        "lib/netstandard2.1/cs/FSharp.Core.resources.dll",
        "lib/netstandard2.1/de/FSharp.Core.resources.dll",
        "lib/netstandard2.1/es/FSharp.Core.resources.dll",
        "lib/netstandard2.1/fr/FSharp.Core.resources.dll",
        "lib/netstandard2.1/FSharp.Core.dll",
        "lib/netstandard2.1/FSharp.Core.xml",
        "lib/netstandard2.1/it/FSharp.Core.resources.dll",
        "lib/netstandard2.1/ja/FSharp.Core.resources.dll",
        "lib/netstandard2.1/ko/FSharp.Core.resources.dll",
        "lib/netstandard2.1/pl/FSharp.Core.resources.dll",
        "lib/netstandard2.1/pt-BR/FSharp.Core.resources.dll",
        "lib/netstandard2.1/ru/FSharp.Core.resources.dll",
        "lib/netstandard2.1/tr/FSharp.Core.resources.dll",
        "lib/netstandard2.1/zh-Hans/FSharp.Core.resources.dll",
        "lib/netstandard2.1/zh-Hant/FSharp.Core.resources.dll",
    ],
)
import_library(
    name = "net6.0",
    target_framework = "net6.0",
    dll = "lib/netstandard2.1/FSharp.Core.dll",
    refdll = "lib/netstandard2.1/FSharp.Core.dll",
    deps = [
    ],
    data = [
        "lib/netstandard2.1/cs/FSharp.Core.resources.dll",
        "lib/netstandard2.1/de/FSharp.Core.resources.dll",
        "lib/netstandard2.1/es/FSharp.Core.resources.dll",
        "lib/netstandard2.1/fr/FSharp.Core.resources.dll",
        "lib/netstandard2.1/FSharp.Core.dll",
        "lib/netstandard2.1/FSharp.Core.xml",
        "lib/netstandard2.1/it/FSharp.Core.resources.dll",
        "lib/netstandard2.1/ja/FSharp.Core.resources.dll",
        "lib/netstandard2.1/ko/FSharp.Core.resources.dll",
        "lib/netstandard2.1/pl/FSharp.Core.resources.dll",
        "lib/netstandard2.1/pt-BR/FSharp.Core.resources.dll",
        "lib/netstandard2.1/ru/FSharp.Core.resources.dll",
        "lib/netstandard2.1/tr/FSharp.Core.resources.dll",
        "lib/netstandard2.1/zh-Hans/FSharp.Core.resources.dll",
        "lib/netstandard2.1/zh-Hant/FSharp.Core.resources.dll",
    ],
)
import_multiframework_library(
    name = "lib",
    net11 = ":net11",
    net20 = ":net20",
    net35 = ":net35",
    net40 = ":net40",
    net403 = ":net403",
    net45 = ":net45",
    net451 = ":net451",
    net452 = ":net452",
    net46 = ":net46",
    net461 = ":net461",
    net462 = ":net462",
    net47 = ":net47",
    net471 = ":net471",
    net472 = ":net472",
    net48 = ":net48",
    netstandard = ":netstandard",
    netstandard1_0 = ":netstandard1.0",
    netstandard1_1 = ":netstandard1.1",
    netstandard1_2 = ":netstandard1.2",
    netstandard1_3 = ":netstandard1.3",
    netstandard1_4 = ":netstandard1.4",
    netstandard1_5 = ":netstandard1.5",
    netstandard1_6 = ":netstandard1.6",
    netstandard2_0 = ":netstandard2.0",
    netstandard2_1 = ":netstandard2.1",
    netcoreapp1_0 = ":netcoreapp1.0",
    netcoreapp1_1 = ":netcoreapp1.1",
    netcoreapp2_0 = ":netcoreapp2.0",
    netcoreapp2_1 = ":netcoreapp2.1",
    netcoreapp2_2 = ":netcoreapp2.2",
    netcoreapp3_0 = ":netcoreapp3.0",
    netcoreapp3_1 = ":netcoreapp3.1",
    net5_0 = ":net5.0",
    net6_0 = ":net6.0",
    visibility = ["//visibility:public"],
)
"""
    )
    nuget_package(
        name = "othergroup.microsoft.win32.systemevents",
        package = "microsoft.win32.systemevents",
        version = "6.0.1",
        sha256 = "c24f2857b8c765f4b1297e4f0dc5774bfa529ec685ab89abf1f6a4bc923857d5",
        build_file_content = """
load("@rules_dotnet//dotnet:defs.bzl", "import_library", "import_multiframework_library")
import_library(
    name = "net11",
    target_framework = "net11",
    deps = [
    ],
    data = [
    ],
)
import_library(
    name = "net20",
    target_framework = "net20",
    deps = [
    ],
    data = [
    ],
)
import_library(
    name = "net35",
    target_framework = "net35",
    deps = [
    ],
    data = [
    ],
)
import_library(
    name = "net40",
    target_framework = "net40",
    deps = [
    ],
    data = [
    ],
)
import_library(
    name = "net403",
    target_framework = "net403",
    deps = [
    ],
    data = [
    ],
)
import_library(
    name = "net45",
    target_framework = "net45",
    deps = [
    ],
    data = [
    ],
)
import_library(
    name = "net451",
    target_framework = "net451",
    deps = [
    ],
    data = [
    ],
)
import_library(
    name = "net452",
    target_framework = "net452",
    deps = [
    ],
    data = [
    ],
)
import_library(
    name = "net46",
    target_framework = "net46",
    deps = [
    ],
    data = [
    ],
)
import_library(
    name = "net461",
    target_framework = "net461",
    dll = "lib/net461/Microsoft.Win32.SystemEvents.dll",
    refdll = "lib/net461/Microsoft.Win32.SystemEvents.dll",
    deps = [
    ],
    data = [
        "lib/net461/Microsoft.Win32.SystemEvents.dll",
        "lib/net461/Microsoft.Win32.SystemEvents.xml",
    ],
)
import_library(
    name = "net462",
    target_framework = "net462",
    dll = "lib/net461/Microsoft.Win32.SystemEvents.dll",
    refdll = "lib/net461/Microsoft.Win32.SystemEvents.dll",
    deps = [
    ],
    data = [
        "lib/net461/Microsoft.Win32.SystemEvents.dll",
        "lib/net461/Microsoft.Win32.SystemEvents.xml",
    ],
)
import_library(
    name = "net47",
    target_framework = "net47",
    dll = "lib/net461/Microsoft.Win32.SystemEvents.dll",
    refdll = "lib/net461/Microsoft.Win32.SystemEvents.dll",
    deps = [
    ],
    data = [
        "lib/net461/Microsoft.Win32.SystemEvents.dll",
        "lib/net461/Microsoft.Win32.SystemEvents.xml",
    ],
)
import_library(
    name = "net471",
    target_framework = "net471",
    dll = "lib/net461/Microsoft.Win32.SystemEvents.dll",
    refdll = "lib/net461/Microsoft.Win32.SystemEvents.dll",
    deps = [
    ],
    data = [
        "lib/net461/Microsoft.Win32.SystemEvents.dll",
        "lib/net461/Microsoft.Win32.SystemEvents.xml",
    ],
)
import_library(
    name = "net472",
    target_framework = "net472",
    dll = "lib/net461/Microsoft.Win32.SystemEvents.dll",
    refdll = "lib/net461/Microsoft.Win32.SystemEvents.dll",
    deps = [
    ],
    data = [
        "lib/net461/Microsoft.Win32.SystemEvents.dll",
        "lib/net461/Microsoft.Win32.SystemEvents.xml",
    ],
)
import_library(
    name = "net48",
    target_framework = "net48",
    dll = "lib/net461/Microsoft.Win32.SystemEvents.dll",
    refdll = "lib/net461/Microsoft.Win32.SystemEvents.dll",
    deps = [
    ],
    data = [
        "lib/net461/Microsoft.Win32.SystemEvents.dll",
        "lib/net461/Microsoft.Win32.SystemEvents.xml",
    ],
)
import_library(
    name = "netstandard",
    target_framework = "netstandard",
    deps = [
    ],
    data = [
    ],
)
import_library(
    name = "netstandard1.0",
    target_framework = "netstandard1.0",
    deps = [
    ],
    data = [
    ],
)
import_library(
    name = "netstandard1.1",
    target_framework = "netstandard1.1",
    deps = [
    ],
    data = [
    ],
)
import_library(
    name = "netstandard1.2",
    target_framework = "netstandard1.2",
    deps = [
    ],
    data = [
    ],
)
import_library(
    name = "netstandard1.3",
    target_framework = "netstandard1.3",
    deps = [
    ],
    data = [
    ],
)
import_library(
    name = "netstandard1.4",
    target_framework = "netstandard1.4",
    deps = [
    ],
    data = [
    ],
)
import_library(
    name = "netstandard1.5",
    target_framework = "netstandard1.5",
    deps = [
    ],
    data = [
    ],
)
import_library(
    name = "netstandard1.6",
    target_framework = "netstandard1.6",
    deps = [
    ],
    data = [
    ],
)
import_library(
    name = "netstandard2.0",
    target_framework = "netstandard2.0",
    dll = "lib/netstandard2.0/Microsoft.Win32.SystemEvents.dll",
    refdll = "lib/netstandard2.0/Microsoft.Win32.SystemEvents.dll",
    deps = [
    ],
    data = [
        "lib/netstandard2.0/Microsoft.Win32.SystemEvents.dll",
        "lib/netstandard2.0/Microsoft.Win32.SystemEvents.xml",
    ],
)
import_library(
    name = "netstandard2.1",
    target_framework = "netstandard2.1",
    dll = "lib/netstandard2.0/Microsoft.Win32.SystemEvents.dll",
    refdll = "lib/netstandard2.0/Microsoft.Win32.SystemEvents.dll",
    deps = [
    ],
    data = [
        "lib/netstandard2.0/Microsoft.Win32.SystemEvents.dll",
        "lib/netstandard2.0/Microsoft.Win32.SystemEvents.xml",
    ],
)
import_library(
    name = "netcoreapp1.0",
    target_framework = "netcoreapp1.0",
    deps = [
    ],
    data = [
    ],
)
import_library(
    name = "netcoreapp1.1",
    target_framework = "netcoreapp1.1",
    deps = [
    ],
    data = [
    ],
)
import_library(
    name = "netcoreapp2.0",
    target_framework = "netcoreapp2.0",
    dll = "lib/netstandard2.0/Microsoft.Win32.SystemEvents.dll",
    refdll = "lib/netstandard2.0/Microsoft.Win32.SystemEvents.dll",
    deps = [
    ],
    data = [
        "lib/netstandard2.0/Microsoft.Win32.SystemEvents.dll",
        "lib/netstandard2.0/Microsoft.Win32.SystemEvents.xml",
    ],
)
import_library(
    name = "netcoreapp2.1",
    target_framework = "netcoreapp2.1",
    dll = "lib/netstandard2.0/Microsoft.Win32.SystemEvents.dll",
    refdll = "lib/netstandard2.0/Microsoft.Win32.SystemEvents.dll",
    deps = [
    ],
    data = [
        "lib/netstandard2.0/Microsoft.Win32.SystemEvents.dll",
        "lib/netstandard2.0/Microsoft.Win32.SystemEvents.xml",
    ],
)
import_library(
    name = "netcoreapp2.2",
    target_framework = "netcoreapp2.2",
    dll = "lib/netstandard2.0/Microsoft.Win32.SystemEvents.dll",
    refdll = "lib/netstandard2.0/Microsoft.Win32.SystemEvents.dll",
    deps = [
    ],
    data = [
        "lib/netstandard2.0/Microsoft.Win32.SystemEvents.dll",
        "lib/netstandard2.0/Microsoft.Win32.SystemEvents.xml",
    ],
)
import_library(
    name = "netcoreapp3.0",
    target_framework = "netcoreapp3.0",
    dll = "lib/netstandard2.0/Microsoft.Win32.SystemEvents.dll",
    refdll = "lib/netstandard2.0/Microsoft.Win32.SystemEvents.dll",
    deps = [
    ],
    data = [
        "lib/netstandard2.0/Microsoft.Win32.SystemEvents.dll",
        "lib/netstandard2.0/Microsoft.Win32.SystemEvents.xml",
    ],
)
import_library(
    name = "netcoreapp3.1",
    target_framework = "netcoreapp3.1",
    dll = "lib/netcoreapp3.1/Microsoft.Win32.SystemEvents.dll",
    refdll = "lib/netcoreapp3.1/Microsoft.Win32.SystemEvents.dll",
    deps = [
    ],
    data = [
        "lib/netcoreapp3.1/Microsoft.Win32.SystemEvents.dll",
        "lib/netcoreapp3.1/Microsoft.Win32.SystemEvents.xml",
    ],
)
import_library(
    name = "net5.0",
    target_framework = "net5.0",
    dll = "lib/netcoreapp3.1/Microsoft.Win32.SystemEvents.dll",
    refdll = "lib/netcoreapp3.1/Microsoft.Win32.SystemEvents.dll",
    deps = [
    ],
    data = [
        "lib/netcoreapp3.1/Microsoft.Win32.SystemEvents.dll",
        "lib/netcoreapp3.1/Microsoft.Win32.SystemEvents.xml",
    ],
)
import_library(
    name = "net6.0",
    target_framework = "net6.0",
    dll = "lib/net6.0/Microsoft.Win32.SystemEvents.dll",
    refdll = "lib/net6.0/Microsoft.Win32.SystemEvents.dll",
    deps = [
    ],
    data = [
        "lib/net6.0/Microsoft.Win32.SystemEvents.dll",
        "lib/net6.0/Microsoft.Win32.SystemEvents.xml",
    ],
)
import_multiframework_library(
    name = "lib",
    net11 = ":net11",
    net20 = ":net20",
    net35 = ":net35",
    net40 = ":net40",
    net403 = ":net403",
    net45 = ":net45",
    net451 = ":net451",
    net452 = ":net452",
    net46 = ":net46",
    net461 = ":net461",
    net462 = ":net462",
    net47 = ":net47",
    net471 = ":net471",
    net472 = ":net472",
    net48 = ":net48",
    netstandard = ":netstandard",
    netstandard1_0 = ":netstandard1.0",
    netstandard1_1 = ":netstandard1.1",
    netstandard1_2 = ":netstandard1.2",
    netstandard1_3 = ":netstandard1.3",
    netstandard1_4 = ":netstandard1.4",
    netstandard1_5 = ":netstandard1.5",
    netstandard1_6 = ":netstandard1.6",
    netstandard2_0 = ":netstandard2.0",
    netstandard2_1 = ":netstandard2.1",
    netcoreapp1_0 = ":netcoreapp1.0",
    netcoreapp1_1 = ":netcoreapp1.1",
    netcoreapp2_0 = ":netcoreapp2.0",
    netcoreapp2_1 = ":netcoreapp2.1",
    netcoreapp2_2 = ":netcoreapp2.2",
    netcoreapp3_0 = ":netcoreapp3.0",
    netcoreapp3_1 = ":netcoreapp3.1",
    net5_0 = ":net5.0",
    net6_0 = ":net6.0",
    visibility = ["//visibility:public"],
)
"""
    )
    nuget_package(
        name = "othergroup.system.configuration.configurationmanager",
        package = "system.configuration.configurationmanager",
        version = "6.0.0",
        sha256 = "7cf57aebc09f8bef29356aef1806ab1787dec1d3d5103c25256bc9934cbe0a6b",
        build_file_content = """
load("@rules_dotnet//dotnet:defs.bzl", "import_library", "import_multiframework_library")
import_library(
    name = "net11",
    target_framework = "net11",
    deps = [
    ],
    data = [
    ],
)
import_library(
    name = "net20",
    target_framework = "net20",
    deps = [
    ],
    data = [
    ],
)
import_library(
    name = "net35",
    target_framework = "net35",
    deps = [
    ],
    data = [
    ],
)
import_library(
    name = "net40",
    target_framework = "net40",
    deps = [
    ],
    data = [
    ],
)
import_library(
    name = "net403",
    target_framework = "net403",
    deps = [
    ],
    data = [
    ],
)
import_library(
    name = "net45",
    target_framework = "net45",
    deps = [
    ],
    data = [
    ],
)
import_library(
    name = "net451",
    target_framework = "net451",
    deps = [
    ],
    data = [
    ],
)
import_library(
    name = "net452",
    target_framework = "net452",
    deps = [
    ],
    data = [
    ],
)
import_library(
    name = "net46",
    target_framework = "net46",
    deps = [
    ],
    data = [
    ],
)
import_library(
    name = "net461",
    target_framework = "net461",
    dll = "lib/net461/System.Configuration.ConfigurationManager.dll",
    refdll = "lib/net461/System.Configuration.ConfigurationManager.dll",
    deps = [
        "@othergroup.system.security.permissions//:lib",
    ],
    data = [
        "lib/net461/System.Configuration.ConfigurationManager.dll",
        "lib/net461/System.Configuration.ConfigurationManager.xml",
    ],
)
import_library(
    name = "net462",
    target_framework = "net462",
    dll = "lib/net461/System.Configuration.ConfigurationManager.dll",
    refdll = "lib/net461/System.Configuration.ConfigurationManager.dll",
    deps = [
        "@othergroup.system.security.permissions//:lib",
    ],
    data = [
        "lib/net461/System.Configuration.ConfigurationManager.dll",
        "lib/net461/System.Configuration.ConfigurationManager.xml",
    ],
)
import_library(
    name = "net47",
    target_framework = "net47",
    dll = "lib/net461/System.Configuration.ConfigurationManager.dll",
    refdll = "lib/net461/System.Configuration.ConfigurationManager.dll",
    deps = [
        "@othergroup.system.security.permissions//:lib",
    ],
    data = [
        "lib/net461/System.Configuration.ConfigurationManager.dll",
        "lib/net461/System.Configuration.ConfigurationManager.xml",
    ],
)
import_library(
    name = "net471",
    target_framework = "net471",
    dll = "lib/net461/System.Configuration.ConfigurationManager.dll",
    refdll = "lib/net461/System.Configuration.ConfigurationManager.dll",
    deps = [
        "@othergroup.system.security.permissions//:lib",
    ],
    data = [
        "lib/net461/System.Configuration.ConfigurationManager.dll",
        "lib/net461/System.Configuration.ConfigurationManager.xml",
    ],
)
import_library(
    name = "net472",
    target_framework = "net472",
    dll = "lib/net461/System.Configuration.ConfigurationManager.dll",
    refdll = "lib/net461/System.Configuration.ConfigurationManager.dll",
    deps = [
        "@othergroup.system.security.permissions//:lib",
    ],
    data = [
        "lib/net461/System.Configuration.ConfigurationManager.dll",
        "lib/net461/System.Configuration.ConfigurationManager.xml",
    ],
)
import_library(
    name = "net48",
    target_framework = "net48",
    dll = "lib/net461/System.Configuration.ConfigurationManager.dll",
    refdll = "lib/net461/System.Configuration.ConfigurationManager.dll",
    deps = [
        "@othergroup.system.security.permissions//:lib",
    ],
    data = [
        "lib/net461/System.Configuration.ConfigurationManager.dll",
        "lib/net461/System.Configuration.ConfigurationManager.xml",
    ],
)
import_library(
    name = "netstandard",
    target_framework = "netstandard",
    deps = [
    ],
    data = [
    ],
)
import_library(
    name = "netstandard1.0",
    target_framework = "netstandard1.0",
    deps = [
    ],
    data = [
    ],
)
import_library(
    name = "netstandard1.1",
    target_framework = "netstandard1.1",
    deps = [
    ],
    data = [
    ],
)
import_library(
    name = "netstandard1.2",
    target_framework = "netstandard1.2",
    deps = [
    ],
    data = [
    ],
)
import_library(
    name = "netstandard1.3",
    target_framework = "netstandard1.3",
    deps = [
    ],
    data = [
    ],
)
import_library(
    name = "netstandard1.4",
    target_framework = "netstandard1.4",
    deps = [
    ],
    data = [
    ],
)
import_library(
    name = "netstandard1.5",
    target_framework = "netstandard1.5",
    deps = [
    ],
    data = [
    ],
)
import_library(
    name = "netstandard1.6",
    target_framework = "netstandard1.6",
    deps = [
    ],
    data = [
    ],
)
import_library(
    name = "netstandard2.0",
    target_framework = "netstandard2.0",
    dll = "lib/netstandard2.0/System.Configuration.ConfigurationManager.dll",
    refdll = "lib/netstandard2.0/System.Configuration.ConfigurationManager.dll",
    deps = [
        "@othergroup.system.security.cryptography.protecteddata//:lib",
        "@othergroup.system.security.permissions//:lib",
    ],
    data = [
        "lib/netstandard2.0/System.Configuration.ConfigurationManager.dll",
        "lib/netstandard2.0/System.Configuration.ConfigurationManager.xml",
    ],
)
import_library(
    name = "netstandard2.1",
    target_framework = "netstandard2.1",
    dll = "lib/netstandard2.0/System.Configuration.ConfigurationManager.dll",
    refdll = "lib/netstandard2.0/System.Configuration.ConfigurationManager.dll",
    deps = [
        "@othergroup.system.security.cryptography.protecteddata//:lib",
        "@othergroup.system.security.permissions//:lib",
    ],
    data = [
        "lib/netstandard2.0/System.Configuration.ConfigurationManager.dll",
        "lib/netstandard2.0/System.Configuration.ConfigurationManager.xml",
    ],
)
import_library(
    name = "netcoreapp1.0",
    target_framework = "netcoreapp1.0",
    deps = [
    ],
    data = [
    ],
)
import_library(
    name = "netcoreapp1.1",
    target_framework = "netcoreapp1.1",
    deps = [
    ],
    data = [
    ],
)
import_library(
    name = "netcoreapp2.0",
    target_framework = "netcoreapp2.0",
    dll = "lib/netstandard2.0/System.Configuration.ConfigurationManager.dll",
    refdll = "lib/netstandard2.0/System.Configuration.ConfigurationManager.dll",
    deps = [
        "@othergroup.system.security.cryptography.protecteddata//:lib",
        "@othergroup.system.security.permissions//:lib",
    ],
    data = [
        "lib/netstandard2.0/System.Configuration.ConfigurationManager.dll",
        "lib/netstandard2.0/System.Configuration.ConfigurationManager.xml",
    ],
)
import_library(
    name = "netcoreapp2.1",
    target_framework = "netcoreapp2.1",
    dll = "lib/netstandard2.0/System.Configuration.ConfigurationManager.dll",
    refdll = "lib/netstandard2.0/System.Configuration.ConfigurationManager.dll",
    deps = [
        "@othergroup.system.security.cryptography.protecteddata//:lib",
        "@othergroup.system.security.permissions//:lib",
    ],
    data = [
        "lib/netstandard2.0/System.Configuration.ConfigurationManager.dll",
        "lib/netstandard2.0/System.Configuration.ConfigurationManager.xml",
    ],
)
import_library(
    name = "netcoreapp2.2",
    target_framework = "netcoreapp2.2",
    dll = "lib/netstandard2.0/System.Configuration.ConfigurationManager.dll",
    refdll = "lib/netstandard2.0/System.Configuration.ConfigurationManager.dll",
    deps = [
        "@othergroup.system.security.cryptography.protecteddata//:lib",
        "@othergroup.system.security.permissions//:lib",
    ],
    data = [
        "lib/netstandard2.0/System.Configuration.ConfigurationManager.dll",
        "lib/netstandard2.0/System.Configuration.ConfigurationManager.xml",
    ],
)
import_library(
    name = "netcoreapp3.0",
    target_framework = "netcoreapp3.0",
    dll = "lib/netstandard2.0/System.Configuration.ConfigurationManager.dll",
    refdll = "lib/netstandard2.0/System.Configuration.ConfigurationManager.dll",
    deps = [
        "@othergroup.system.security.cryptography.protecteddata//:lib",
        "@othergroup.system.security.permissions//:lib",
    ],
    data = [
        "lib/netstandard2.0/System.Configuration.ConfigurationManager.dll",
        "lib/netstandard2.0/System.Configuration.ConfigurationManager.xml",
    ],
)
import_library(
    name = "netcoreapp3.1",
    target_framework = "netcoreapp3.1",
    dll = "lib/netstandard2.0/System.Configuration.ConfigurationManager.dll",
    refdll = "lib/netstandard2.0/System.Configuration.ConfigurationManager.dll",
    deps = [
        "@othergroup.system.security.cryptography.protecteddata//:lib",
        "@othergroup.system.security.permissions//:lib",
    ],
    data = [
        "lib/netstandard2.0/System.Configuration.ConfigurationManager.dll",
        "lib/netstandard2.0/System.Configuration.ConfigurationManager.xml",
    ],
)
import_library(
    name = "net5.0",
    target_framework = "net5.0",
    dll = "lib/netstandard2.0/System.Configuration.ConfigurationManager.dll",
    refdll = "lib/netstandard2.0/System.Configuration.ConfigurationManager.dll",
    deps = [
        "@othergroup.system.security.cryptography.protecteddata//:lib",
        "@othergroup.system.security.permissions//:lib",
    ],
    data = [
        "lib/netstandard2.0/System.Configuration.ConfigurationManager.dll",
        "lib/netstandard2.0/System.Configuration.ConfigurationManager.xml",
    ],
)
import_library(
    name = "net6.0",
    target_framework = "net6.0",
    dll = "lib/net6.0/System.Configuration.ConfigurationManager.dll",
    refdll = "lib/net6.0/System.Configuration.ConfigurationManager.dll",
    deps = [
        "@othergroup.system.security.cryptography.protecteddata//:lib",
        "@othergroup.system.security.permissions//:lib",
    ],
    data = [
        "lib/net6.0/System.Configuration.ConfigurationManager.dll",
        "lib/net6.0/System.Configuration.ConfigurationManager.xml",
    ],
)
import_multiframework_library(
    name = "lib",
    net11 = ":net11",
    net20 = ":net20",
    net35 = ":net35",
    net40 = ":net40",
    net403 = ":net403",
    net45 = ":net45",
    net451 = ":net451",
    net452 = ":net452",
    net46 = ":net46",
    net461 = ":net461",
    net462 = ":net462",
    net47 = ":net47",
    net471 = ":net471",
    net472 = ":net472",
    net48 = ":net48",
    netstandard = ":netstandard",
    netstandard1_0 = ":netstandard1.0",
    netstandard1_1 = ":netstandard1.1",
    netstandard1_2 = ":netstandard1.2",
    netstandard1_3 = ":netstandard1.3",
    netstandard1_4 = ":netstandard1.4",
    netstandard1_5 = ":netstandard1.5",
    netstandard1_6 = ":netstandard1.6",
    netstandard2_0 = ":netstandard2.0",
    netstandard2_1 = ":netstandard2.1",
    netcoreapp1_0 = ":netcoreapp1.0",
    netcoreapp1_1 = ":netcoreapp1.1",
    netcoreapp2_0 = ":netcoreapp2.0",
    netcoreapp2_1 = ":netcoreapp2.1",
    netcoreapp2_2 = ":netcoreapp2.2",
    netcoreapp3_0 = ":netcoreapp3.0",
    netcoreapp3_1 = ":netcoreapp3.1",
    net5_0 = ":net5.0",
    net6_0 = ":net6.0",
    visibility = ["//visibility:public"],
)
"""
    )
    nuget_package(
        name = "othergroup.system.drawing.common",
        package = "system.drawing.common",
        version = "6.0.0",
        sha256 = "ffd11a01b11e3a310b452319688992d4ef059947bc8f85ae154c3554eacfc80a",
        build_file_content = """
load("@rules_dotnet//dotnet:defs.bzl", "import_library", "import_multiframework_library")
import_library(
    name = "net11",
    target_framework = "net11",
    deps = [
    ],
    data = [
        "runtimes/unix/lib/net6.0/System.Drawing.Common.dll",
        "runtimes/unix/lib/net6.0/System.Drawing.Common.xml",
        "runtimes/unix/lib/netcoreapp3.1/System.Drawing.Common.dll",
        "runtimes/unix/lib/netcoreapp3.1/System.Drawing.Common.xml",
    ],
)
import_library(
    name = "net20",
    target_framework = "net20",
    deps = [
    ],
    data = [
        "runtimes/unix/lib/net6.0/System.Drawing.Common.dll",
        "runtimes/unix/lib/net6.0/System.Drawing.Common.xml",
        "runtimes/unix/lib/netcoreapp3.1/System.Drawing.Common.dll",
        "runtimes/unix/lib/netcoreapp3.1/System.Drawing.Common.xml",
    ],
)
import_library(
    name = "net35",
    target_framework = "net35",
    deps = [
    ],
    data = [
        "runtimes/unix/lib/net6.0/System.Drawing.Common.dll",
        "runtimes/unix/lib/net6.0/System.Drawing.Common.xml",
        "runtimes/unix/lib/netcoreapp3.1/System.Drawing.Common.dll",
        "runtimes/unix/lib/netcoreapp3.1/System.Drawing.Common.xml",
    ],
)
import_library(
    name = "net40",
    target_framework = "net40",
    deps = [
    ],
    data = [
        "runtimes/unix/lib/net6.0/System.Drawing.Common.dll",
        "runtimes/unix/lib/net6.0/System.Drawing.Common.xml",
        "runtimes/unix/lib/netcoreapp3.1/System.Drawing.Common.dll",
        "runtimes/unix/lib/netcoreapp3.1/System.Drawing.Common.xml",
    ],
)
import_library(
    name = "net403",
    target_framework = "net403",
    deps = [
    ],
    data = [
        "runtimes/unix/lib/net6.0/System.Drawing.Common.dll",
        "runtimes/unix/lib/net6.0/System.Drawing.Common.xml",
        "runtimes/unix/lib/netcoreapp3.1/System.Drawing.Common.dll",
        "runtimes/unix/lib/netcoreapp3.1/System.Drawing.Common.xml",
    ],
)
import_library(
    name = "net45",
    target_framework = "net45",
    deps = [
    ],
    data = [
        "runtimes/unix/lib/net6.0/System.Drawing.Common.dll",
        "runtimes/unix/lib/net6.0/System.Drawing.Common.xml",
        "runtimes/unix/lib/netcoreapp3.1/System.Drawing.Common.dll",
        "runtimes/unix/lib/netcoreapp3.1/System.Drawing.Common.xml",
    ],
)
import_library(
    name = "net451",
    target_framework = "net451",
    deps = [
    ],
    data = [
        "runtimes/unix/lib/net6.0/System.Drawing.Common.dll",
        "runtimes/unix/lib/net6.0/System.Drawing.Common.xml",
        "runtimes/unix/lib/netcoreapp3.1/System.Drawing.Common.dll",
        "runtimes/unix/lib/netcoreapp3.1/System.Drawing.Common.xml",
    ],
)
import_library(
    name = "net452",
    target_framework = "net452",
    deps = [
    ],
    data = [
        "runtimes/unix/lib/net6.0/System.Drawing.Common.dll",
        "runtimes/unix/lib/net6.0/System.Drawing.Common.xml",
        "runtimes/unix/lib/netcoreapp3.1/System.Drawing.Common.dll",
        "runtimes/unix/lib/netcoreapp3.1/System.Drawing.Common.xml",
    ],
)
import_library(
    name = "net46",
    target_framework = "net46",
    deps = [
    ],
    data = [
        "runtimes/unix/lib/net6.0/System.Drawing.Common.dll",
        "runtimes/unix/lib/net6.0/System.Drawing.Common.xml",
        "runtimes/unix/lib/netcoreapp3.1/System.Drawing.Common.dll",
        "runtimes/unix/lib/netcoreapp3.1/System.Drawing.Common.xml",
    ],
)
import_library(
    name = "net461",
    target_framework = "net461",
    dll = "lib/net461/System.Drawing.Common.dll",
    refdll = "lib/net461/System.Drawing.Common.dll",
    deps = [
    ],
    data = [
        "lib/net461/System.Drawing.Common.dll",
        "lib/net461/System.Drawing.Common.xml",
        "runtimes/unix/lib/net6.0/System.Drawing.Common.dll",
        "runtimes/unix/lib/net6.0/System.Drawing.Common.xml",
        "runtimes/unix/lib/netcoreapp3.1/System.Drawing.Common.dll",
        "runtimes/unix/lib/netcoreapp3.1/System.Drawing.Common.xml",
    ],
)
import_library(
    name = "net462",
    target_framework = "net462",
    dll = "lib/net461/System.Drawing.Common.dll",
    refdll = "lib/net461/System.Drawing.Common.dll",
    deps = [
    ],
    data = [
        "lib/net461/System.Drawing.Common.dll",
        "lib/net461/System.Drawing.Common.xml",
        "runtimes/unix/lib/net6.0/System.Drawing.Common.dll",
        "runtimes/unix/lib/net6.0/System.Drawing.Common.xml",
        "runtimes/unix/lib/netcoreapp3.1/System.Drawing.Common.dll",
        "runtimes/unix/lib/netcoreapp3.1/System.Drawing.Common.xml",
    ],
)
import_library(
    name = "net47",
    target_framework = "net47",
    dll = "lib/net461/System.Drawing.Common.dll",
    refdll = "lib/net461/System.Drawing.Common.dll",
    deps = [
    ],
    data = [
        "lib/net461/System.Drawing.Common.dll",
        "lib/net461/System.Drawing.Common.xml",
        "runtimes/unix/lib/net6.0/System.Drawing.Common.dll",
        "runtimes/unix/lib/net6.0/System.Drawing.Common.xml",
        "runtimes/unix/lib/netcoreapp3.1/System.Drawing.Common.dll",
        "runtimes/unix/lib/netcoreapp3.1/System.Drawing.Common.xml",
    ],
)
import_library(
    name = "net471",
    target_framework = "net471",
    dll = "lib/net461/System.Drawing.Common.dll",
    refdll = "lib/net461/System.Drawing.Common.dll",
    deps = [
    ],
    data = [
        "lib/net461/System.Drawing.Common.dll",
        "lib/net461/System.Drawing.Common.xml",
        "runtimes/unix/lib/net6.0/System.Drawing.Common.dll",
        "runtimes/unix/lib/net6.0/System.Drawing.Common.xml",
        "runtimes/unix/lib/netcoreapp3.1/System.Drawing.Common.dll",
        "runtimes/unix/lib/netcoreapp3.1/System.Drawing.Common.xml",
    ],
)
import_library(
    name = "net472",
    target_framework = "net472",
    dll = "lib/net461/System.Drawing.Common.dll",
    refdll = "lib/net461/System.Drawing.Common.dll",
    deps = [
    ],
    data = [
        "lib/net461/System.Drawing.Common.dll",
        "lib/net461/System.Drawing.Common.xml",
        "runtimes/unix/lib/net6.0/System.Drawing.Common.dll",
        "runtimes/unix/lib/net6.0/System.Drawing.Common.xml",
        "runtimes/unix/lib/netcoreapp3.1/System.Drawing.Common.dll",
        "runtimes/unix/lib/netcoreapp3.1/System.Drawing.Common.xml",
    ],
)
import_library(
    name = "net48",
    target_framework = "net48",
    dll = "lib/net461/System.Drawing.Common.dll",
    refdll = "lib/net461/System.Drawing.Common.dll",
    deps = [
    ],
    data = [
        "lib/net461/System.Drawing.Common.dll",
        "lib/net461/System.Drawing.Common.xml",
        "runtimes/unix/lib/net6.0/System.Drawing.Common.dll",
        "runtimes/unix/lib/net6.0/System.Drawing.Common.xml",
        "runtimes/unix/lib/netcoreapp3.1/System.Drawing.Common.dll",
        "runtimes/unix/lib/netcoreapp3.1/System.Drawing.Common.xml",
    ],
)
import_library(
    name = "netstandard",
    target_framework = "netstandard",
    deps = [
    ],
    data = [
        "runtimes/unix/lib/net6.0/System.Drawing.Common.dll",
        "runtimes/unix/lib/net6.0/System.Drawing.Common.xml",
        "runtimes/unix/lib/netcoreapp3.1/System.Drawing.Common.dll",
        "runtimes/unix/lib/netcoreapp3.1/System.Drawing.Common.xml",
    ],
)
import_library(
    name = "netstandard1.0",
    target_framework = "netstandard1.0",
    deps = [
    ],
    data = [
        "runtimes/unix/lib/net6.0/System.Drawing.Common.dll",
        "runtimes/unix/lib/net6.0/System.Drawing.Common.xml",
        "runtimes/unix/lib/netcoreapp3.1/System.Drawing.Common.dll",
        "runtimes/unix/lib/netcoreapp3.1/System.Drawing.Common.xml",
    ],
)
import_library(
    name = "netstandard1.1",
    target_framework = "netstandard1.1",
    deps = [
    ],
    data = [
        "runtimes/unix/lib/net6.0/System.Drawing.Common.dll",
        "runtimes/unix/lib/net6.0/System.Drawing.Common.xml",
        "runtimes/unix/lib/netcoreapp3.1/System.Drawing.Common.dll",
        "runtimes/unix/lib/netcoreapp3.1/System.Drawing.Common.xml",
    ],
)
import_library(
    name = "netstandard1.2",
    target_framework = "netstandard1.2",
    deps = [
    ],
    data = [
        "runtimes/unix/lib/net6.0/System.Drawing.Common.dll",
        "runtimes/unix/lib/net6.0/System.Drawing.Common.xml",
        "runtimes/unix/lib/netcoreapp3.1/System.Drawing.Common.dll",
        "runtimes/unix/lib/netcoreapp3.1/System.Drawing.Common.xml",
    ],
)
import_library(
    name = "netstandard1.3",
    target_framework = "netstandard1.3",
    deps = [
    ],
    data = [
        "runtimes/unix/lib/net6.0/System.Drawing.Common.dll",
        "runtimes/unix/lib/net6.0/System.Drawing.Common.xml",
        "runtimes/unix/lib/netcoreapp3.1/System.Drawing.Common.dll",
        "runtimes/unix/lib/netcoreapp3.1/System.Drawing.Common.xml",
    ],
)
import_library(
    name = "netstandard1.4",
    target_framework = "netstandard1.4",
    deps = [
    ],
    data = [
        "runtimes/unix/lib/net6.0/System.Drawing.Common.dll",
        "runtimes/unix/lib/net6.0/System.Drawing.Common.xml",
        "runtimes/unix/lib/netcoreapp3.1/System.Drawing.Common.dll",
        "runtimes/unix/lib/netcoreapp3.1/System.Drawing.Common.xml",
    ],
)
import_library(
    name = "netstandard1.5",
    target_framework = "netstandard1.5",
    deps = [
    ],
    data = [
        "runtimes/unix/lib/net6.0/System.Drawing.Common.dll",
        "runtimes/unix/lib/net6.0/System.Drawing.Common.xml",
        "runtimes/unix/lib/netcoreapp3.1/System.Drawing.Common.dll",
        "runtimes/unix/lib/netcoreapp3.1/System.Drawing.Common.xml",
    ],
)
import_library(
    name = "netstandard1.6",
    target_framework = "netstandard1.6",
    deps = [
    ],
    data = [
        "runtimes/unix/lib/net6.0/System.Drawing.Common.dll",
        "runtimes/unix/lib/net6.0/System.Drawing.Common.xml",
        "runtimes/unix/lib/netcoreapp3.1/System.Drawing.Common.dll",
        "runtimes/unix/lib/netcoreapp3.1/System.Drawing.Common.xml",
    ],
)
import_library(
    name = "netstandard2.0",
    target_framework = "netstandard2.0",
    dll = "lib/netstandard2.0/System.Drawing.Common.dll",
    refdll = "lib/netstandard2.0/System.Drawing.Common.dll",
    deps = [
    ],
    data = [
        "lib/netstandard2.0/System.Drawing.Common.dll",
        "lib/netstandard2.0/System.Drawing.Common.xml",
        "runtimes/unix/lib/net6.0/System.Drawing.Common.dll",
        "runtimes/unix/lib/net6.0/System.Drawing.Common.xml",
        "runtimes/unix/lib/netcoreapp3.1/System.Drawing.Common.dll",
        "runtimes/unix/lib/netcoreapp3.1/System.Drawing.Common.xml",
    ],
)
import_library(
    name = "netstandard2.1",
    target_framework = "netstandard2.1",
    dll = "lib/netstandard2.0/System.Drawing.Common.dll",
    refdll = "lib/netstandard2.0/System.Drawing.Common.dll",
    deps = [
    ],
    data = [
        "lib/netstandard2.0/System.Drawing.Common.dll",
        "lib/netstandard2.0/System.Drawing.Common.xml",
        "runtimes/unix/lib/net6.0/System.Drawing.Common.dll",
        "runtimes/unix/lib/net6.0/System.Drawing.Common.xml",
        "runtimes/unix/lib/netcoreapp3.1/System.Drawing.Common.dll",
        "runtimes/unix/lib/netcoreapp3.1/System.Drawing.Common.xml",
    ],
)
import_library(
    name = "netcoreapp1.0",
    target_framework = "netcoreapp1.0",
    deps = [
    ],
    data = [
        "runtimes/unix/lib/net6.0/System.Drawing.Common.dll",
        "runtimes/unix/lib/net6.0/System.Drawing.Common.xml",
        "runtimes/unix/lib/netcoreapp3.1/System.Drawing.Common.dll",
        "runtimes/unix/lib/netcoreapp3.1/System.Drawing.Common.xml",
    ],
)
import_library(
    name = "netcoreapp1.1",
    target_framework = "netcoreapp1.1",
    deps = [
    ],
    data = [
        "runtimes/unix/lib/net6.0/System.Drawing.Common.dll",
        "runtimes/unix/lib/net6.0/System.Drawing.Common.xml",
        "runtimes/unix/lib/netcoreapp3.1/System.Drawing.Common.dll",
        "runtimes/unix/lib/netcoreapp3.1/System.Drawing.Common.xml",
    ],
)
import_library(
    name = "netcoreapp2.0",
    target_framework = "netcoreapp2.0",
    dll = "lib/netstandard2.0/System.Drawing.Common.dll",
    refdll = "lib/netstandard2.0/System.Drawing.Common.dll",
    deps = [
    ],
    data = [
        "lib/netstandard2.0/System.Drawing.Common.dll",
        "lib/netstandard2.0/System.Drawing.Common.xml",
        "runtimes/unix/lib/net6.0/System.Drawing.Common.dll",
        "runtimes/unix/lib/net6.0/System.Drawing.Common.xml",
        "runtimes/unix/lib/netcoreapp3.1/System.Drawing.Common.dll",
        "runtimes/unix/lib/netcoreapp3.1/System.Drawing.Common.xml",
    ],
)
import_library(
    name = "netcoreapp2.1",
    target_framework = "netcoreapp2.1",
    dll = "lib/netstandard2.0/System.Drawing.Common.dll",
    refdll = "lib/netstandard2.0/System.Drawing.Common.dll",
    deps = [
    ],
    data = [
        "lib/netstandard2.0/System.Drawing.Common.dll",
        "lib/netstandard2.0/System.Drawing.Common.xml",
        "runtimes/unix/lib/net6.0/System.Drawing.Common.dll",
        "runtimes/unix/lib/net6.0/System.Drawing.Common.xml",
        "runtimes/unix/lib/netcoreapp3.1/System.Drawing.Common.dll",
        "runtimes/unix/lib/netcoreapp3.1/System.Drawing.Common.xml",
    ],
)
import_library(
    name = "netcoreapp2.2",
    target_framework = "netcoreapp2.2",
    dll = "lib/netstandard2.0/System.Drawing.Common.dll",
    refdll = "lib/netstandard2.0/System.Drawing.Common.dll",
    deps = [
    ],
    data = [
        "lib/netstandard2.0/System.Drawing.Common.dll",
        "lib/netstandard2.0/System.Drawing.Common.xml",
        "runtimes/unix/lib/net6.0/System.Drawing.Common.dll",
        "runtimes/unix/lib/net6.0/System.Drawing.Common.xml",
        "runtimes/unix/lib/netcoreapp3.1/System.Drawing.Common.dll",
        "runtimes/unix/lib/netcoreapp3.1/System.Drawing.Common.xml",
    ],
)
import_library(
    name = "netcoreapp3.0",
    target_framework = "netcoreapp3.0",
    dll = "lib/netstandard2.0/System.Drawing.Common.dll",
    refdll = "lib/netstandard2.0/System.Drawing.Common.dll",
    deps = [
    ],
    data = [
        "lib/netstandard2.0/System.Drawing.Common.dll",
        "lib/netstandard2.0/System.Drawing.Common.xml",
        "runtimes/unix/lib/net6.0/System.Drawing.Common.dll",
        "runtimes/unix/lib/net6.0/System.Drawing.Common.xml",
        "runtimes/unix/lib/netcoreapp3.1/System.Drawing.Common.dll",
        "runtimes/unix/lib/netcoreapp3.1/System.Drawing.Common.xml",
    ],
)
import_library(
    name = "netcoreapp3.1",
    target_framework = "netcoreapp3.1",
    dll = "lib/netcoreapp3.1/System.Drawing.Common.dll",
    refdll = "lib/netcoreapp3.1/System.Drawing.Common.dll",
    deps = [
        "@othergroup.microsoft.win32.systemevents//:lib",
    ],
    data = [
        "lib/netcoreapp3.1/System.Drawing.Common.dll",
        "lib/netcoreapp3.1/System.Drawing.Common.xml",
        "runtimes/unix/lib/net6.0/System.Drawing.Common.dll",
        "runtimes/unix/lib/net6.0/System.Drawing.Common.xml",
        "runtimes/unix/lib/netcoreapp3.1/System.Drawing.Common.dll",
        "runtimes/unix/lib/netcoreapp3.1/System.Drawing.Common.xml",
    ],
)
import_library(
    name = "net5.0",
    target_framework = "net5.0",
    dll = "lib/netcoreapp3.1/System.Drawing.Common.dll",
    refdll = "lib/netcoreapp3.1/System.Drawing.Common.dll",
    deps = [
        "@othergroup.microsoft.win32.systemevents//:lib",
    ],
    data = [
        "lib/netcoreapp3.1/System.Drawing.Common.dll",
        "lib/netcoreapp3.1/System.Drawing.Common.xml",
        "runtimes/unix/lib/net6.0/System.Drawing.Common.dll",
        "runtimes/unix/lib/net6.0/System.Drawing.Common.xml",
        "runtimes/unix/lib/netcoreapp3.1/System.Drawing.Common.dll",
        "runtimes/unix/lib/netcoreapp3.1/System.Drawing.Common.xml",
    ],
)
import_library(
    name = "net6.0",
    target_framework = "net6.0",
    dll = "lib/net6.0/System.Drawing.Common.dll",
    refdll = "lib/net6.0/System.Drawing.Common.dll",
    deps = [
        "@othergroup.microsoft.win32.systemevents//:lib",
    ],
    data = [
        "lib/net6.0/System.Drawing.Common.dll",
        "lib/net6.0/System.Drawing.Common.xml",
        "runtimes/unix/lib/net6.0/System.Drawing.Common.dll",
        "runtimes/unix/lib/net6.0/System.Drawing.Common.xml",
        "runtimes/unix/lib/netcoreapp3.1/System.Drawing.Common.dll",
        "runtimes/unix/lib/netcoreapp3.1/System.Drawing.Common.xml",
    ],
)
import_multiframework_library(
    name = "lib",
    net11 = ":net11",
    net20 = ":net20",
    net35 = ":net35",
    net40 = ":net40",
    net403 = ":net403",
    net45 = ":net45",
    net451 = ":net451",
    net452 = ":net452",
    net46 = ":net46",
    net461 = ":net461",
    net462 = ":net462",
    net47 = ":net47",
    net471 = ":net471",
    net472 = ":net472",
    net48 = ":net48",
    netstandard = ":netstandard",
    netstandard1_0 = ":netstandard1.0",
    netstandard1_1 = ":netstandard1.1",
    netstandard1_2 = ":netstandard1.2",
    netstandard1_3 = ":netstandard1.3",
    netstandard1_4 = ":netstandard1.4",
    netstandard1_5 = ":netstandard1.5",
    netstandard1_6 = ":netstandard1.6",
    netstandard2_0 = ":netstandard2.0",
    netstandard2_1 = ":netstandard2.1",
    netcoreapp1_0 = ":netcoreapp1.0",
    netcoreapp1_1 = ":netcoreapp1.1",
    netcoreapp2_0 = ":netcoreapp2.0",
    netcoreapp2_1 = ":netcoreapp2.1",
    netcoreapp2_2 = ":netcoreapp2.2",
    netcoreapp3_0 = ":netcoreapp3.0",
    netcoreapp3_1 = ":netcoreapp3.1",
    net5_0 = ":net5.0",
    net6_0 = ":net6.0",
    visibility = ["//visibility:public"],
)
"""
    )
    nuget_package(
        name = "othergroup.system.security.accesscontrol",
        package = "system.security.accesscontrol",
        version = "6.0.0",
        sha256 = "a8ec961016cdaf7123c92f9eb451bcff331bb8f8c0f8ef9d8bbd7b24ff42c728",
        build_file_content = """
load("@rules_dotnet//dotnet:defs.bzl", "import_library", "import_multiframework_library")
import_library(
    name = "net11",
    target_framework = "net11",
    deps = [
    ],
    data = [
    ],
)
import_library(
    name = "net20",
    target_framework = "net20",
    deps = [
    ],
    data = [
    ],
)
import_library(
    name = "net35",
    target_framework = "net35",
    deps = [
    ],
    data = [
    ],
)
import_library(
    name = "net40",
    target_framework = "net40",
    deps = [
    ],
    data = [
    ],
)
import_library(
    name = "net403",
    target_framework = "net403",
    deps = [
    ],
    data = [
    ],
)
import_library(
    name = "net45",
    target_framework = "net45",
    deps = [
    ],
    data = [
    ],
)
import_library(
    name = "net451",
    target_framework = "net451",
    deps = [
    ],
    data = [
    ],
)
import_library(
    name = "net452",
    target_framework = "net452",
    deps = [
    ],
    data = [
    ],
)
import_library(
    name = "net46",
    target_framework = "net46",
    deps = [
    ],
    data = [
    ],
)
import_library(
    name = "net461",
    target_framework = "net461",
    dll = "lib/net461/System.Security.AccessControl.dll",
    refdll = "lib/net461/System.Security.AccessControl.dll",
    deps = [
    ],
    data = [
        "lib/net461/System.Security.AccessControl.dll",
        "lib/net461/System.Security.AccessControl.xml",
    ],
)
import_library(
    name = "net462",
    target_framework = "net462",
    dll = "lib/net461/System.Security.AccessControl.dll",
    refdll = "lib/net461/System.Security.AccessControl.dll",
    deps = [
    ],
    data = [
        "lib/net461/System.Security.AccessControl.dll",
        "lib/net461/System.Security.AccessControl.xml",
    ],
)
import_library(
    name = "net47",
    target_framework = "net47",
    dll = "lib/net461/System.Security.AccessControl.dll",
    refdll = "lib/net461/System.Security.AccessControl.dll",
    deps = [
    ],
    data = [
        "lib/net461/System.Security.AccessControl.dll",
        "lib/net461/System.Security.AccessControl.xml",
    ],
)
import_library(
    name = "net471",
    target_framework = "net471",
    dll = "lib/net461/System.Security.AccessControl.dll",
    refdll = "lib/net461/System.Security.AccessControl.dll",
    deps = [
    ],
    data = [
        "lib/net461/System.Security.AccessControl.dll",
        "lib/net461/System.Security.AccessControl.xml",
    ],
)
import_library(
    name = "net472",
    target_framework = "net472",
    dll = "lib/net461/System.Security.AccessControl.dll",
    refdll = "lib/net461/System.Security.AccessControl.dll",
    deps = [
    ],
    data = [
        "lib/net461/System.Security.AccessControl.dll",
        "lib/net461/System.Security.AccessControl.xml",
    ],
)
import_library(
    name = "net48",
    target_framework = "net48",
    dll = "lib/net461/System.Security.AccessControl.dll",
    refdll = "lib/net461/System.Security.AccessControl.dll",
    deps = [
    ],
    data = [
        "lib/net461/System.Security.AccessControl.dll",
        "lib/net461/System.Security.AccessControl.xml",
    ],
)
import_library(
    name = "netstandard",
    target_framework = "netstandard",
    deps = [
    ],
    data = [
    ],
)
import_library(
    name = "netstandard1.0",
    target_framework = "netstandard1.0",
    deps = [
    ],
    data = [
    ],
)
import_library(
    name = "netstandard1.1",
    target_framework = "netstandard1.1",
    deps = [
    ],
    data = [
    ],
)
import_library(
    name = "netstandard1.2",
    target_framework = "netstandard1.2",
    deps = [
    ],
    data = [
    ],
)
import_library(
    name = "netstandard1.3",
    target_framework = "netstandard1.3",
    deps = [
    ],
    data = [
    ],
)
import_library(
    name = "netstandard1.4",
    target_framework = "netstandard1.4",
    deps = [
    ],
    data = [
    ],
)
import_library(
    name = "netstandard1.5",
    target_framework = "netstandard1.5",
    deps = [
    ],
    data = [
    ],
)
import_library(
    name = "netstandard1.6",
    target_framework = "netstandard1.6",
    deps = [
    ],
    data = [
    ],
)
import_library(
    name = "netstandard2.0",
    target_framework = "netstandard2.0",
    dll = "lib/netstandard2.0/System.Security.AccessControl.dll",
    refdll = "lib/netstandard2.0/System.Security.AccessControl.dll",
    deps = [
    ],
    data = [
        "lib/netstandard2.0/System.Security.AccessControl.dll",
        "lib/netstandard2.0/System.Security.AccessControl.xml",
    ],
)
import_library(
    name = "netstandard2.1",
    target_framework = "netstandard2.1",
    dll = "lib/netstandard2.0/System.Security.AccessControl.dll",
    refdll = "lib/netstandard2.0/System.Security.AccessControl.dll",
    deps = [
    ],
    data = [
        "lib/netstandard2.0/System.Security.AccessControl.dll",
        "lib/netstandard2.0/System.Security.AccessControl.xml",
    ],
)
import_library(
    name = "netcoreapp1.0",
    target_framework = "netcoreapp1.0",
    deps = [
    ],
    data = [
    ],
)
import_library(
    name = "netcoreapp1.1",
    target_framework = "netcoreapp1.1",
    deps = [
    ],
    data = [
    ],
)
import_library(
    name = "netcoreapp2.0",
    target_framework = "netcoreapp2.0",
    dll = "lib/netstandard2.0/System.Security.AccessControl.dll",
    refdll = "lib/netstandard2.0/System.Security.AccessControl.dll",
    deps = [
    ],
    data = [
        "lib/netstandard2.0/System.Security.AccessControl.dll",
        "lib/netstandard2.0/System.Security.AccessControl.xml",
    ],
)
import_library(
    name = "netcoreapp2.1",
    target_framework = "netcoreapp2.1",
    dll = "lib/netstandard2.0/System.Security.AccessControl.dll",
    refdll = "lib/netstandard2.0/System.Security.AccessControl.dll",
    deps = [
    ],
    data = [
        "lib/netstandard2.0/System.Security.AccessControl.dll",
        "lib/netstandard2.0/System.Security.AccessControl.xml",
    ],
)
import_library(
    name = "netcoreapp2.2",
    target_framework = "netcoreapp2.2",
    dll = "lib/netstandard2.0/System.Security.AccessControl.dll",
    refdll = "lib/netstandard2.0/System.Security.AccessControl.dll",
    deps = [
    ],
    data = [
        "lib/netstandard2.0/System.Security.AccessControl.dll",
        "lib/netstandard2.0/System.Security.AccessControl.xml",
    ],
)
import_library(
    name = "netcoreapp3.0",
    target_framework = "netcoreapp3.0",
    dll = "lib/netstandard2.0/System.Security.AccessControl.dll",
    refdll = "lib/netstandard2.0/System.Security.AccessControl.dll",
    deps = [
    ],
    data = [
        "lib/netstandard2.0/System.Security.AccessControl.dll",
        "lib/netstandard2.0/System.Security.AccessControl.xml",
    ],
)
import_library(
    name = "netcoreapp3.1",
    target_framework = "netcoreapp3.1",
    dll = "lib/netstandard2.0/System.Security.AccessControl.dll",
    refdll = "lib/netstandard2.0/System.Security.AccessControl.dll",
    deps = [
    ],
    data = [
        "lib/netstandard2.0/System.Security.AccessControl.dll",
        "lib/netstandard2.0/System.Security.AccessControl.xml",
    ],
)
import_library(
    name = "net5.0",
    target_framework = "net5.0",
    dll = "lib/netstandard2.0/System.Security.AccessControl.dll",
    refdll = "lib/netstandard2.0/System.Security.AccessControl.dll",
    deps = [
    ],
    data = [
        "lib/netstandard2.0/System.Security.AccessControl.dll",
        "lib/netstandard2.0/System.Security.AccessControl.xml",
    ],
)
import_library(
    name = "net6.0",
    target_framework = "net6.0",
    dll = "lib/net6.0/System.Security.AccessControl.dll",
    refdll = "lib/net6.0/System.Security.AccessControl.dll",
    deps = [
    ],
    data = [
        "lib/net6.0/System.Security.AccessControl.dll",
        "lib/net6.0/System.Security.AccessControl.xml",
    ],
)
import_multiframework_library(
    name = "lib",
    net11 = ":net11",
    net20 = ":net20",
    net35 = ":net35",
    net40 = ":net40",
    net403 = ":net403",
    net45 = ":net45",
    net451 = ":net451",
    net452 = ":net452",
    net46 = ":net46",
    net461 = ":net461",
    net462 = ":net462",
    net47 = ":net47",
    net471 = ":net471",
    net472 = ":net472",
    net48 = ":net48",
    netstandard = ":netstandard",
    netstandard1_0 = ":netstandard1.0",
    netstandard1_1 = ":netstandard1.1",
    netstandard1_2 = ":netstandard1.2",
    netstandard1_3 = ":netstandard1.3",
    netstandard1_4 = ":netstandard1.4",
    netstandard1_5 = ":netstandard1.5",
    netstandard1_6 = ":netstandard1.6",
    netstandard2_0 = ":netstandard2.0",
    netstandard2_1 = ":netstandard2.1",
    netcoreapp1_0 = ":netcoreapp1.0",
    netcoreapp1_1 = ":netcoreapp1.1",
    netcoreapp2_0 = ":netcoreapp2.0",
    netcoreapp2_1 = ":netcoreapp2.1",
    netcoreapp2_2 = ":netcoreapp2.2",
    netcoreapp3_0 = ":netcoreapp3.0",
    netcoreapp3_1 = ":netcoreapp3.1",
    net5_0 = ":net5.0",
    net6_0 = ":net6.0",
    visibility = ["//visibility:public"],
)
"""
    )
    nuget_package(
        name = "othergroup.system.security.cryptography.protecteddata",
        package = "system.security.cryptography.protecteddata",
        version = "6.0.0",
        sha256 = "5a2f48f4d6d99694035e04bb2a5d3a44817163ff7aef84bb84a898c3911a6d16",
        build_file_content = """
load("@rules_dotnet//dotnet:defs.bzl", "import_library", "import_multiframework_library")
import_library(
    name = "net11",
    target_framework = "net11",
    deps = [
    ],
    data = [
    ],
)
import_library(
    name = "net20",
    target_framework = "net20",
    deps = [
    ],
    data = [
    ],
)
import_library(
    name = "net35",
    target_framework = "net35",
    deps = [
    ],
    data = [
    ],
)
import_library(
    name = "net40",
    target_framework = "net40",
    deps = [
    ],
    data = [
    ],
)
import_library(
    name = "net403",
    target_framework = "net403",
    deps = [
    ],
    data = [
    ],
)
import_library(
    name = "net45",
    target_framework = "net45",
    deps = [
    ],
    data = [
    ],
)
import_library(
    name = "net451",
    target_framework = "net451",
    deps = [
    ],
    data = [
    ],
)
import_library(
    name = "net452",
    target_framework = "net452",
    deps = [
    ],
    data = [
    ],
)
import_library(
    name = "net46",
    target_framework = "net46",
    deps = [
    ],
    data = [
    ],
)
import_library(
    name = "net461",
    target_framework = "net461",
    dll = "lib/net461/System.Security.Cryptography.ProtectedData.dll",
    refdll = "lib/net461/System.Security.Cryptography.ProtectedData.dll",
    deps = [
    ],
    data = [
        "lib/net461/System.Security.Cryptography.ProtectedData.dll",
        "lib/net461/System.Security.Cryptography.ProtectedData.xml",
    ],
)
import_library(
    name = "net462",
    target_framework = "net462",
    dll = "lib/net461/System.Security.Cryptography.ProtectedData.dll",
    refdll = "lib/net461/System.Security.Cryptography.ProtectedData.dll",
    deps = [
    ],
    data = [
        "lib/net461/System.Security.Cryptography.ProtectedData.dll",
        "lib/net461/System.Security.Cryptography.ProtectedData.xml",
    ],
)
import_library(
    name = "net47",
    target_framework = "net47",
    dll = "lib/net461/System.Security.Cryptography.ProtectedData.dll",
    refdll = "lib/net461/System.Security.Cryptography.ProtectedData.dll",
    deps = [
    ],
    data = [
        "lib/net461/System.Security.Cryptography.ProtectedData.dll",
        "lib/net461/System.Security.Cryptography.ProtectedData.xml",
    ],
)
import_library(
    name = "net471",
    target_framework = "net471",
    dll = "lib/net461/System.Security.Cryptography.ProtectedData.dll",
    refdll = "lib/net461/System.Security.Cryptography.ProtectedData.dll",
    deps = [
    ],
    data = [
        "lib/net461/System.Security.Cryptography.ProtectedData.dll",
        "lib/net461/System.Security.Cryptography.ProtectedData.xml",
    ],
)
import_library(
    name = "net472",
    target_framework = "net472",
    dll = "lib/net461/System.Security.Cryptography.ProtectedData.dll",
    refdll = "lib/net461/System.Security.Cryptography.ProtectedData.dll",
    deps = [
    ],
    data = [
        "lib/net461/System.Security.Cryptography.ProtectedData.dll",
        "lib/net461/System.Security.Cryptography.ProtectedData.xml",
    ],
)
import_library(
    name = "net48",
    target_framework = "net48",
    dll = "lib/net461/System.Security.Cryptography.ProtectedData.dll",
    refdll = "lib/net461/System.Security.Cryptography.ProtectedData.dll",
    deps = [
    ],
    data = [
        "lib/net461/System.Security.Cryptography.ProtectedData.dll",
        "lib/net461/System.Security.Cryptography.ProtectedData.xml",
    ],
)
import_library(
    name = "netstandard",
    target_framework = "netstandard",
    deps = [
    ],
    data = [
    ],
)
import_library(
    name = "netstandard1.0",
    target_framework = "netstandard1.0",
    deps = [
    ],
    data = [
    ],
)
import_library(
    name = "netstandard1.1",
    target_framework = "netstandard1.1",
    deps = [
    ],
    data = [
    ],
)
import_library(
    name = "netstandard1.2",
    target_framework = "netstandard1.2",
    deps = [
    ],
    data = [
    ],
)
import_library(
    name = "netstandard1.3",
    target_framework = "netstandard1.3",
    deps = [
    ],
    data = [
    ],
)
import_library(
    name = "netstandard1.4",
    target_framework = "netstandard1.4",
    deps = [
    ],
    data = [
    ],
)
import_library(
    name = "netstandard1.5",
    target_framework = "netstandard1.5",
    deps = [
    ],
    data = [
    ],
)
import_library(
    name = "netstandard1.6",
    target_framework = "netstandard1.6",
    deps = [
    ],
    data = [
    ],
)
import_library(
    name = "netstandard2.0",
    target_framework = "netstandard2.0",
    dll = "lib/netstandard2.0/System.Security.Cryptography.ProtectedData.dll",
    refdll = "lib/netstandard2.0/System.Security.Cryptography.ProtectedData.dll",
    deps = [
    ],
    data = [
        "lib/netstandard2.0/System.Security.Cryptography.ProtectedData.dll",
        "lib/netstandard2.0/System.Security.Cryptography.ProtectedData.xml",
    ],
)
import_library(
    name = "netstandard2.1",
    target_framework = "netstandard2.1",
    dll = "lib/netstandard2.0/System.Security.Cryptography.ProtectedData.dll",
    refdll = "lib/netstandard2.0/System.Security.Cryptography.ProtectedData.dll",
    deps = [
    ],
    data = [
        "lib/netstandard2.0/System.Security.Cryptography.ProtectedData.dll",
        "lib/netstandard2.0/System.Security.Cryptography.ProtectedData.xml",
    ],
)
import_library(
    name = "netcoreapp1.0",
    target_framework = "netcoreapp1.0",
    deps = [
    ],
    data = [
    ],
)
import_library(
    name = "netcoreapp1.1",
    target_framework = "netcoreapp1.1",
    deps = [
    ],
    data = [
    ],
)
import_library(
    name = "netcoreapp2.0",
    target_framework = "netcoreapp2.0",
    dll = "lib/netstandard2.0/System.Security.Cryptography.ProtectedData.dll",
    refdll = "lib/netstandard2.0/System.Security.Cryptography.ProtectedData.dll",
    deps = [
    ],
    data = [
        "lib/netstandard2.0/System.Security.Cryptography.ProtectedData.dll",
        "lib/netstandard2.0/System.Security.Cryptography.ProtectedData.xml",
    ],
)
import_library(
    name = "netcoreapp2.1",
    target_framework = "netcoreapp2.1",
    dll = "lib/netstandard2.0/System.Security.Cryptography.ProtectedData.dll",
    refdll = "lib/netstandard2.0/System.Security.Cryptography.ProtectedData.dll",
    deps = [
    ],
    data = [
        "lib/netstandard2.0/System.Security.Cryptography.ProtectedData.dll",
        "lib/netstandard2.0/System.Security.Cryptography.ProtectedData.xml",
    ],
)
import_library(
    name = "netcoreapp2.2",
    target_framework = "netcoreapp2.2",
    dll = "lib/netstandard2.0/System.Security.Cryptography.ProtectedData.dll",
    refdll = "lib/netstandard2.0/System.Security.Cryptography.ProtectedData.dll",
    deps = [
    ],
    data = [
        "lib/netstandard2.0/System.Security.Cryptography.ProtectedData.dll",
        "lib/netstandard2.0/System.Security.Cryptography.ProtectedData.xml",
    ],
)
import_library(
    name = "netcoreapp3.0",
    target_framework = "netcoreapp3.0",
    dll = "lib/netstandard2.0/System.Security.Cryptography.ProtectedData.dll",
    refdll = "lib/netstandard2.0/System.Security.Cryptography.ProtectedData.dll",
    deps = [
    ],
    data = [
        "lib/netstandard2.0/System.Security.Cryptography.ProtectedData.dll",
        "lib/netstandard2.0/System.Security.Cryptography.ProtectedData.xml",
    ],
)
import_library(
    name = "netcoreapp3.1",
    target_framework = "netcoreapp3.1",
    dll = "lib/netstandard2.0/System.Security.Cryptography.ProtectedData.dll",
    refdll = "lib/netstandard2.0/System.Security.Cryptography.ProtectedData.dll",
    deps = [
    ],
    data = [
        "lib/netstandard2.0/System.Security.Cryptography.ProtectedData.dll",
        "lib/netstandard2.0/System.Security.Cryptography.ProtectedData.xml",
    ],
)
import_library(
    name = "net5.0",
    target_framework = "net5.0",
    dll = "lib/netstandard2.0/System.Security.Cryptography.ProtectedData.dll",
    refdll = "lib/netstandard2.0/System.Security.Cryptography.ProtectedData.dll",
    deps = [
    ],
    data = [
        "lib/netstandard2.0/System.Security.Cryptography.ProtectedData.dll",
        "lib/netstandard2.0/System.Security.Cryptography.ProtectedData.xml",
    ],
)
import_library(
    name = "net6.0",
    target_framework = "net6.0",
    dll = "lib/net6.0/System.Security.Cryptography.ProtectedData.dll",
    refdll = "lib/net6.0/System.Security.Cryptography.ProtectedData.dll",
    deps = [
    ],
    data = [
        "lib/net6.0/System.Security.Cryptography.ProtectedData.dll",
        "lib/net6.0/System.Security.Cryptography.ProtectedData.xml",
    ],
)
import_multiframework_library(
    name = "lib",
    net11 = ":net11",
    net20 = ":net20",
    net35 = ":net35",
    net40 = ":net40",
    net403 = ":net403",
    net45 = ":net45",
    net451 = ":net451",
    net452 = ":net452",
    net46 = ":net46",
    net461 = ":net461",
    net462 = ":net462",
    net47 = ":net47",
    net471 = ":net471",
    net472 = ":net472",
    net48 = ":net48",
    netstandard = ":netstandard",
    netstandard1_0 = ":netstandard1.0",
    netstandard1_1 = ":netstandard1.1",
    netstandard1_2 = ":netstandard1.2",
    netstandard1_3 = ":netstandard1.3",
    netstandard1_4 = ":netstandard1.4",
    netstandard1_5 = ":netstandard1.5",
    netstandard1_6 = ":netstandard1.6",
    netstandard2_0 = ":netstandard2.0",
    netstandard2_1 = ":netstandard2.1",
    netcoreapp1_0 = ":netcoreapp1.0",
    netcoreapp1_1 = ":netcoreapp1.1",
    netcoreapp2_0 = ":netcoreapp2.0",
    netcoreapp2_1 = ":netcoreapp2.1",
    netcoreapp2_2 = ":netcoreapp2.2",
    netcoreapp3_0 = ":netcoreapp3.0",
    netcoreapp3_1 = ":netcoreapp3.1",
    net5_0 = ":net5.0",
    net6_0 = ":net6.0",
    visibility = ["//visibility:public"],
)
"""
    )
    nuget_package(
        name = "othergroup.system.security.permissions",
        package = "system.security.permissions",
        version = "6.0.0",
        sha256 = "fcc32fb4558637fbce41f8d774e85eb7582c9cc821ea58790c21e2995b27544b",
        build_file_content = """
load("@rules_dotnet//dotnet:defs.bzl", "import_library", "import_multiframework_library")
import_library(
    name = "net11",
    target_framework = "net11",
    deps = [
    ],
    data = [
    ],
)
import_library(
    name = "net20",
    target_framework = "net20",
    deps = [
    ],
    data = [
    ],
)
import_library(
    name = "net35",
    target_framework = "net35",
    deps = [
    ],
    data = [
    ],
)
import_library(
    name = "net40",
    target_framework = "net40",
    deps = [
    ],
    data = [
    ],
)
import_library(
    name = "net403",
    target_framework = "net403",
    deps = [
    ],
    data = [
    ],
)
import_library(
    name = "net45",
    target_framework = "net45",
    deps = [
    ],
    data = [
    ],
)
import_library(
    name = "net451",
    target_framework = "net451",
    deps = [
    ],
    data = [
    ],
)
import_library(
    name = "net452",
    target_framework = "net452",
    deps = [
    ],
    data = [
    ],
)
import_library(
    name = "net46",
    target_framework = "net46",
    deps = [
    ],
    data = [
    ],
)
import_library(
    name = "net461",
    target_framework = "net461",
    dll = "lib/net461/System.Security.Permissions.dll",
    refdll = "lib/net461/System.Security.Permissions.dll",
    deps = [
        "@othergroup.system.security.accesscontrol//:lib",
    ],
    data = [
        "lib/net461/System.Security.Permissions.dll",
        "lib/net461/System.Security.Permissions.xml",
    ],
)
import_library(
    name = "net462",
    target_framework = "net462",
    dll = "lib/net461/System.Security.Permissions.dll",
    refdll = "lib/net461/System.Security.Permissions.dll",
    deps = [
        "@othergroup.system.security.accesscontrol//:lib",
    ],
    data = [
        "lib/net461/System.Security.Permissions.dll",
        "lib/net461/System.Security.Permissions.xml",
    ],
)
import_library(
    name = "net47",
    target_framework = "net47",
    dll = "lib/net461/System.Security.Permissions.dll",
    refdll = "lib/net461/System.Security.Permissions.dll",
    deps = [
        "@othergroup.system.security.accesscontrol//:lib",
    ],
    data = [
        "lib/net461/System.Security.Permissions.dll",
        "lib/net461/System.Security.Permissions.xml",
    ],
)
import_library(
    name = "net471",
    target_framework = "net471",
    dll = "lib/net461/System.Security.Permissions.dll",
    refdll = "lib/net461/System.Security.Permissions.dll",
    deps = [
        "@othergroup.system.security.accesscontrol//:lib",
    ],
    data = [
        "lib/net461/System.Security.Permissions.dll",
        "lib/net461/System.Security.Permissions.xml",
    ],
)
import_library(
    name = "net472",
    target_framework = "net472",
    dll = "lib/net461/System.Security.Permissions.dll",
    refdll = "lib/net461/System.Security.Permissions.dll",
    deps = [
        "@othergroup.system.security.accesscontrol//:lib",
    ],
    data = [
        "lib/net461/System.Security.Permissions.dll",
        "lib/net461/System.Security.Permissions.xml",
    ],
)
import_library(
    name = "net48",
    target_framework = "net48",
    dll = "lib/net461/System.Security.Permissions.dll",
    refdll = "lib/net461/System.Security.Permissions.dll",
    deps = [
        "@othergroup.system.security.accesscontrol//:lib",
    ],
    data = [
        "lib/net461/System.Security.Permissions.dll",
        "lib/net461/System.Security.Permissions.xml",
    ],
)
import_library(
    name = "netstandard",
    target_framework = "netstandard",
    deps = [
    ],
    data = [
    ],
)
import_library(
    name = "netstandard1.0",
    target_framework = "netstandard1.0",
    deps = [
    ],
    data = [
    ],
)
import_library(
    name = "netstandard1.1",
    target_framework = "netstandard1.1",
    deps = [
    ],
    data = [
    ],
)
import_library(
    name = "netstandard1.2",
    target_framework = "netstandard1.2",
    deps = [
    ],
    data = [
    ],
)
import_library(
    name = "netstandard1.3",
    target_framework = "netstandard1.3",
    deps = [
    ],
    data = [
    ],
)
import_library(
    name = "netstandard1.4",
    target_framework = "netstandard1.4",
    deps = [
    ],
    data = [
    ],
)
import_library(
    name = "netstandard1.5",
    target_framework = "netstandard1.5",
    deps = [
    ],
    data = [
    ],
)
import_library(
    name = "netstandard1.6",
    target_framework = "netstandard1.6",
    deps = [
    ],
    data = [
    ],
)
import_library(
    name = "netstandard2.0",
    target_framework = "netstandard2.0",
    dll = "lib/netstandard2.0/System.Security.Permissions.dll",
    refdll = "lib/netstandard2.0/System.Security.Permissions.dll",
    deps = [
        "@othergroup.system.security.accesscontrol//:lib",
    ],
    data = [
        "lib/netstandard2.0/System.Security.Permissions.dll",
        "lib/netstandard2.0/System.Security.Permissions.xml",
    ],
)
import_library(
    name = "netstandard2.1",
    target_framework = "netstandard2.1",
    dll = "lib/netstandard2.0/System.Security.Permissions.dll",
    refdll = "lib/netstandard2.0/System.Security.Permissions.dll",
    deps = [
        "@othergroup.system.security.accesscontrol//:lib",
    ],
    data = [
        "lib/netstandard2.0/System.Security.Permissions.dll",
        "lib/netstandard2.0/System.Security.Permissions.xml",
    ],
)
import_library(
    name = "netcoreapp1.0",
    target_framework = "netcoreapp1.0",
    deps = [
    ],
    data = [
    ],
)
import_library(
    name = "netcoreapp1.1",
    target_framework = "netcoreapp1.1",
    deps = [
    ],
    data = [
    ],
)
import_library(
    name = "netcoreapp2.0",
    target_framework = "netcoreapp2.0",
    dll = "lib/netstandard2.0/System.Security.Permissions.dll",
    refdll = "lib/netstandard2.0/System.Security.Permissions.dll",
    deps = [
        "@othergroup.system.security.accesscontrol//:lib",
    ],
    data = [
        "lib/netstandard2.0/System.Security.Permissions.dll",
        "lib/netstandard2.0/System.Security.Permissions.xml",
    ],
)
import_library(
    name = "netcoreapp2.1",
    target_framework = "netcoreapp2.1",
    dll = "lib/netstandard2.0/System.Security.Permissions.dll",
    refdll = "lib/netstandard2.0/System.Security.Permissions.dll",
    deps = [
        "@othergroup.system.security.accesscontrol//:lib",
    ],
    data = [
        "lib/netstandard2.0/System.Security.Permissions.dll",
        "lib/netstandard2.0/System.Security.Permissions.xml",
    ],
)
import_library(
    name = "netcoreapp2.2",
    target_framework = "netcoreapp2.2",
    dll = "lib/netstandard2.0/System.Security.Permissions.dll",
    refdll = "lib/netstandard2.0/System.Security.Permissions.dll",
    deps = [
        "@othergroup.system.security.accesscontrol//:lib",
    ],
    data = [
        "lib/netstandard2.0/System.Security.Permissions.dll",
        "lib/netstandard2.0/System.Security.Permissions.xml",
    ],
)
import_library(
    name = "netcoreapp3.0",
    target_framework = "netcoreapp3.0",
    dll = "lib/netstandard2.0/System.Security.Permissions.dll",
    refdll = "lib/netstandard2.0/System.Security.Permissions.dll",
    deps = [
        "@othergroup.system.security.accesscontrol//:lib",
    ],
    data = [
        "lib/netstandard2.0/System.Security.Permissions.dll",
        "lib/netstandard2.0/System.Security.Permissions.xml",
    ],
)
import_library(
    name = "netcoreapp3.1",
    target_framework = "netcoreapp3.1",
    dll = "lib/netcoreapp3.1/System.Security.Permissions.dll",
    refdll = "lib/netcoreapp3.1/System.Security.Permissions.dll",
    deps = [
        "@othergroup.system.security.accesscontrol//:lib",
        "@othergroup.system.windows.extensions//:lib",
    ],
    data = [
        "lib/netcoreapp3.1/System.Security.Permissions.dll",
        "lib/netcoreapp3.1/System.Security.Permissions.xml",
    ],
)
import_library(
    name = "net5.0",
    target_framework = "net5.0",
    dll = "lib/net5.0/System.Security.Permissions.dll",
    refdll = "lib/net5.0/System.Security.Permissions.dll",
    deps = [
        "@othergroup.system.security.accesscontrol//:lib",
        "@othergroup.system.windows.extensions//:lib",
    ],
    data = [
        "lib/net5.0/System.Security.Permissions.dll",
        "lib/net5.0/System.Security.Permissions.xml",
    ],
)
import_library(
    name = "net6.0",
    target_framework = "net6.0",
    dll = "lib/net6.0/System.Security.Permissions.dll",
    refdll = "lib/net6.0/System.Security.Permissions.dll",
    deps = [
        "@othergroup.system.security.accesscontrol//:lib",
        "@othergroup.system.windows.extensions//:lib",
    ],
    data = [
        "lib/net6.0/System.Security.Permissions.dll",
        "lib/net6.0/System.Security.Permissions.xml",
    ],
)
import_multiframework_library(
    name = "lib",
    net11 = ":net11",
    net20 = ":net20",
    net35 = ":net35",
    net40 = ":net40",
    net403 = ":net403",
    net45 = ":net45",
    net451 = ":net451",
    net452 = ":net452",
    net46 = ":net46",
    net461 = ":net461",
    net462 = ":net462",
    net47 = ":net47",
    net471 = ":net471",
    net472 = ":net472",
    net48 = ":net48",
    netstandard = ":netstandard",
    netstandard1_0 = ":netstandard1.0",
    netstandard1_1 = ":netstandard1.1",
    netstandard1_2 = ":netstandard1.2",
    netstandard1_3 = ":netstandard1.3",
    netstandard1_4 = ":netstandard1.4",
    netstandard1_5 = ":netstandard1.5",
    netstandard1_6 = ":netstandard1.6",
    netstandard2_0 = ":netstandard2.0",
    netstandard2_1 = ":netstandard2.1",
    netcoreapp1_0 = ":netcoreapp1.0",
    netcoreapp1_1 = ":netcoreapp1.1",
    netcoreapp2_0 = ":netcoreapp2.0",
    netcoreapp2_1 = ":netcoreapp2.1",
    netcoreapp2_2 = ":netcoreapp2.2",
    netcoreapp3_0 = ":netcoreapp3.0",
    netcoreapp3_1 = ":netcoreapp3.1",
    net5_0 = ":net5.0",
    net6_0 = ":net6.0",
    visibility = ["//visibility:public"],
)
"""
    )
    nuget_package(
        name = "othergroup.system.windows.extensions",
        package = "system.windows.extensions",
        version = "6.0.0",
        sha256 = "37eaa0d44e850c9f40f4be74c2656ddf13d057c671946d71797805bb13bec9f3",
        build_file_content = """
load("@rules_dotnet//dotnet:defs.bzl", "import_library", "import_multiframework_library")
import_library(
    name = "net11",
    target_framework = "net11",
    deps = [
    ],
    data = [
    ],
)
import_library(
    name = "net20",
    target_framework = "net20",
    deps = [
    ],
    data = [
    ],
)
import_library(
    name = "net35",
    target_framework = "net35",
    deps = [
    ],
    data = [
    ],
)
import_library(
    name = "net40",
    target_framework = "net40",
    deps = [
    ],
    data = [
    ],
)
import_library(
    name = "net403",
    target_framework = "net403",
    deps = [
    ],
    data = [
    ],
)
import_library(
    name = "net45",
    target_framework = "net45",
    deps = [
    ],
    data = [
    ],
)
import_library(
    name = "net451",
    target_framework = "net451",
    deps = [
    ],
    data = [
    ],
)
import_library(
    name = "net452",
    target_framework = "net452",
    deps = [
    ],
    data = [
    ],
)
import_library(
    name = "net46",
    target_framework = "net46",
    deps = [
    ],
    data = [
    ],
)
import_library(
    name = "net461",
    target_framework = "net461",
    deps = [
    ],
    data = [
    ],
)
import_library(
    name = "net462",
    target_framework = "net462",
    deps = [
    ],
    data = [
    ],
)
import_library(
    name = "net47",
    target_framework = "net47",
    deps = [
    ],
    data = [
    ],
)
import_library(
    name = "net471",
    target_framework = "net471",
    deps = [
    ],
    data = [
    ],
)
import_library(
    name = "net472",
    target_framework = "net472",
    deps = [
    ],
    data = [
    ],
)
import_library(
    name = "net48",
    target_framework = "net48",
    deps = [
    ],
    data = [
    ],
)
import_library(
    name = "netstandard",
    target_framework = "netstandard",
    deps = [
    ],
    data = [
    ],
)
import_library(
    name = "netstandard1.0",
    target_framework = "netstandard1.0",
    deps = [
    ],
    data = [
    ],
)
import_library(
    name = "netstandard1.1",
    target_framework = "netstandard1.1",
    deps = [
    ],
    data = [
    ],
)
import_library(
    name = "netstandard1.2",
    target_framework = "netstandard1.2",
    deps = [
    ],
    data = [
    ],
)
import_library(
    name = "netstandard1.3",
    target_framework = "netstandard1.3",
    deps = [
    ],
    data = [
    ],
)
import_library(
    name = "netstandard1.4",
    target_framework = "netstandard1.4",
    deps = [
    ],
    data = [
    ],
)
import_library(
    name = "netstandard1.5",
    target_framework = "netstandard1.5",
    deps = [
    ],
    data = [
    ],
)
import_library(
    name = "netstandard1.6",
    target_framework = "netstandard1.6",
    deps = [
    ],
    data = [
    ],
)
import_library(
    name = "netstandard2.0",
    target_framework = "netstandard2.0",
    deps = [
    ],
    data = [
    ],
)
import_library(
    name = "netstandard2.1",
    target_framework = "netstandard2.1",
    deps = [
    ],
    data = [
    ],
)
import_library(
    name = "netcoreapp1.0",
    target_framework = "netcoreapp1.0",
    deps = [
    ],
    data = [
    ],
)
import_library(
    name = "netcoreapp1.1",
    target_framework = "netcoreapp1.1",
    deps = [
    ],
    data = [
    ],
)
import_library(
    name = "netcoreapp2.0",
    target_framework = "netcoreapp2.0",
    deps = [
    ],
    data = [
    ],
)
import_library(
    name = "netcoreapp2.1",
    target_framework = "netcoreapp2.1",
    deps = [
    ],
    data = [
    ],
)
import_library(
    name = "netcoreapp2.2",
    target_framework = "netcoreapp2.2",
    deps = [
    ],
    data = [
    ],
)
import_library(
    name = "netcoreapp3.0",
    target_framework = "netcoreapp3.0",
    deps = [
    ],
    data = [
    ],
)
import_library(
    name = "netcoreapp3.1",
    target_framework = "netcoreapp3.1",
    dll = "lib/netcoreapp3.1/System.Windows.Extensions.dll",
    refdll = "lib/netcoreapp3.1/System.Windows.Extensions.dll",
    deps = [
        "@othergroup.system.drawing.common//:lib",
    ],
    data = [
        "lib/netcoreapp3.1/System.Windows.Extensions.dll",
        "lib/netcoreapp3.1/System.Windows.Extensions.xml",
    ],
)
import_library(
    name = "net5.0",
    target_framework = "net5.0",
    dll = "lib/netcoreapp3.1/System.Windows.Extensions.dll",
    refdll = "lib/netcoreapp3.1/System.Windows.Extensions.dll",
    deps = [
        "@othergroup.system.drawing.common//:lib",
    ],
    data = [
        "lib/netcoreapp3.1/System.Windows.Extensions.dll",
        "lib/netcoreapp3.1/System.Windows.Extensions.xml",
    ],
)
import_library(
    name = "net6.0",
    target_framework = "net6.0",
    dll = "lib/net6.0/System.Windows.Extensions.dll",
    refdll = "lib/net6.0/System.Windows.Extensions.dll",
    deps = [
        "@othergroup.system.drawing.common//:lib",
    ],
    data = [
        "lib/net6.0/System.Windows.Extensions.dll",
        "lib/net6.0/System.Windows.Extensions.xml",
    ],
)
import_multiframework_library(
    name = "lib",
    net11 = ":net11",
    net20 = ":net20",
    net35 = ":net35",
    net40 = ":net40",
    net403 = ":net403",
    net45 = ":net45",
    net451 = ":net451",
    net452 = ":net452",
    net46 = ":net46",
    net461 = ":net461",
    net462 = ":net462",
    net47 = ":net47",
    net471 = ":net471",
    net472 = ":net472",
    net48 = ":net48",
    netstandard = ":netstandard",
    netstandard1_0 = ":netstandard1.0",
    netstandard1_1 = ":netstandard1.1",
    netstandard1_2 = ":netstandard1.2",
    netstandard1_3 = ":netstandard1.3",
    netstandard1_4 = ":netstandard1.4",
    netstandard1_5 = ":netstandard1.5",
    netstandard1_6 = ":netstandard1.6",
    netstandard2_0 = ":netstandard2.0",
    netstandard2_1 = ":netstandard2.1",
    netcoreapp1_0 = ":netcoreapp1.0",
    netcoreapp1_1 = ":netcoreapp1.1",
    netcoreapp2_0 = ":netcoreapp2.0",
    netcoreapp2_1 = ":netcoreapp2.1",
    netcoreapp2_2 = ":netcoreapp2.2",
    netcoreapp3_0 = ":netcoreapp3.0",
    netcoreapp3_1 = ":netcoreapp3.1",
    net5_0 = ":net5.0",
    net6_0 = ":net6.0",
    visibility = ["//visibility:public"],
)
"""
    )
