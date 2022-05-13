load("@io_bazel_rules_dotnet//dotnet:defs.bzl", "dotnet_nuget_new", "nuget_package")

def paket():
    "paket"
    nuget_package(
        name = "paket2bazel.argu",
        package = "argu",
        version = "6.1.1",
        sha256 = "b40f67149996be848ea3ca0557ac14b9ab46e7b6b74125b48f100373c03329ed",
        core_lib = {
            "netcoreapp2.0": "lib/netstandard2.0/Argu.dll",
            "netcoreapp2.1": "lib/netstandard2.0/Argu.dll",
            "netcoreapp2.2": "lib/netstandard2.0/Argu.dll",
            "netcoreapp3.0": "lib/netstandard2.0/Argu.dll",
            "netcoreapp3.1": "lib/netstandard2.0/Argu.dll",
            "net5.0": "lib/netstandard2.0/Argu.dll",
        },
        core_ref = {
            "netcoreapp2.0": "lib/netstandard2.0/Argu.dll",
            "netcoreapp2.1": "lib/netstandard2.0/Argu.dll",
            "netcoreapp2.2": "lib/netstandard2.0/Argu.dll",
            "netcoreapp3.0": "lib/netstandard2.0/Argu.dll",
            "netcoreapp3.1": "lib/netstandard2.0/Argu.dll",
            "net5.0": "lib/netstandard2.0/Argu.dll",
        },
        core_deps = {
            "netcoreapp2.0": [
                "@paket2bazel.fsharp.core//:lib",
                "@paket2bazel.system.configuration.configurationmanager//:lib",
            ],
            "netcoreapp2.1": [
                "@paket2bazel.fsharp.core//:lib",
                "@paket2bazel.system.configuration.configurationmanager//:lib",
            ],
            "netcoreapp2.2": [
                "@paket2bazel.fsharp.core//:lib",
                "@paket2bazel.system.configuration.configurationmanager//:lib",
            ],
            "netcoreapp3.0": [
                "@paket2bazel.fsharp.core//:lib",
                "@paket2bazel.system.configuration.configurationmanager//:lib",
            ],
            "netcoreapp3.1": [
                "@paket2bazel.fsharp.core//:lib",
                "@paket2bazel.system.configuration.configurationmanager//:lib",
            ],
            "net5.0": [
                "@paket2bazel.fsharp.core//:lib",
                "@paket2bazel.system.configuration.configurationmanager//:lib",
            ],
        },
        core_files = {
            "netcoreapp2.0": [
                "lib/netstandard2.0/Argu.dll",
                "lib/netstandard2.0/Argu.pdb",
                "lib/netstandard2.0/Argu.xml",
            ],
            "netcoreapp2.1": [
                "lib/netstandard2.0/Argu.dll",
                "lib/netstandard2.0/Argu.pdb",
                "lib/netstandard2.0/Argu.xml",
            ],
            "netcoreapp2.2": [
                "lib/netstandard2.0/Argu.dll",
                "lib/netstandard2.0/Argu.pdb",
                "lib/netstandard2.0/Argu.xml",
            ],
            "netcoreapp3.0": [
                "lib/netstandard2.0/Argu.dll",
                "lib/netstandard2.0/Argu.pdb",
                "lib/netstandard2.0/Argu.xml",
            ],
            "netcoreapp3.1": [
                "lib/netstandard2.0/Argu.dll",
                "lib/netstandard2.0/Argu.pdb",
                "lib/netstandard2.0/Argu.xml",
            ],
            "net5.0": [
                "lib/netstandard2.0/Argu.dll",
                "lib/netstandard2.0/Argu.pdb",
                "lib/netstandard2.0/Argu.xml",
            ],
        },
    )
    nuget_package(
        name = "paket2bazel.chessie",
        package = "chessie",
        version = "0.6.0",
        sha256 = "73eb462efeabc4080421f3eed5e8d6970cb486be69cf2eb77e1cd357b9f5e7e3",
        core_lib = {
            "netcoreapp2.0": "lib/netstandard1.6/Chessie.dll",
            "netcoreapp2.1": "lib/netstandard1.6/Chessie.dll",
            "netcoreapp2.2": "lib/netstandard1.6/Chessie.dll",
            "netcoreapp3.0": "lib/netstandard1.6/Chessie.dll",
            "netcoreapp3.1": "lib/netstandard1.6/Chessie.dll",
            "net5.0": "lib/netstandard1.6/Chessie.dll",
        },
        core_ref = {
            "netcoreapp2.0": "lib/netstandard1.6/Chessie.dll",
            "netcoreapp2.1": "lib/netstandard1.6/Chessie.dll",
            "netcoreapp2.2": "lib/netstandard1.6/Chessie.dll",
            "netcoreapp3.0": "lib/netstandard1.6/Chessie.dll",
            "netcoreapp3.1": "lib/netstandard1.6/Chessie.dll",
            "net5.0": "lib/netstandard1.6/Chessie.dll",
        },
        core_deps = {
            "netcoreapp2.0": [
                "@paket2bazel.netstandard.library//:lib",
                "@paket2bazel.fsharp.core//:lib",
            ],
            "netcoreapp2.1": [
                "@paket2bazel.netstandard.library//:lib",
                "@paket2bazel.fsharp.core//:lib",
            ],
            "netcoreapp2.2": [
                "@paket2bazel.netstandard.library//:lib",
                "@paket2bazel.fsharp.core//:lib",
            ],
            "netcoreapp3.0": [
                "@paket2bazel.netstandard.library//:lib",
                "@paket2bazel.fsharp.core//:lib",
            ],
            "netcoreapp3.1": [
                "@paket2bazel.netstandard.library//:lib",
                "@paket2bazel.fsharp.core//:lib",
            ],
            "net5.0": [
                "@paket2bazel.netstandard.library//:lib",
                "@paket2bazel.fsharp.core//:lib",
            ],
        },
        core_files = {
            "netcoreapp2.0": [
                "lib/netstandard1.6/Chessie.dll",
                "lib/netstandard1.6/Chessie.xml",
            ],
            "netcoreapp2.1": [
                "lib/netstandard1.6/Chessie.dll",
                "lib/netstandard1.6/Chessie.xml",
            ],
            "netcoreapp2.2": [
                "lib/netstandard1.6/Chessie.dll",
                "lib/netstandard1.6/Chessie.xml",
            ],
            "netcoreapp3.0": [
                "lib/netstandard1.6/Chessie.dll",
                "lib/netstandard1.6/Chessie.xml",
            ],
            "netcoreapp3.1": [
                "lib/netstandard1.6/Chessie.dll",
                "lib/netstandard1.6/Chessie.xml",
            ],
            "net5.0": [
                "lib/netstandard1.6/Chessie.dll",
                "lib/netstandard1.6/Chessie.xml",
            ],
        },
    )
    nuget_package(
        name = "paket2bazel.fsharp.control.asyncseq",
        package = "fsharp.control.asyncseq",
        version = "3.2.1",
        sha256 = "7b3499ac632a4d064ab74a230912945ae0c6c75255532359ce499466356a8809",
        core_lib = {
            "netcoreapp2.0": "lib/netstandard2.0/FSharp.Control.AsyncSeq.dll",
            "netcoreapp2.1": "lib/netstandard2.0/FSharp.Control.AsyncSeq.dll",
            "netcoreapp2.2": "lib/netstandard2.0/FSharp.Control.AsyncSeq.dll",
            "netcoreapp3.0": "lib/netstandard2.1/FSharp.Control.AsyncSeq.dll",
            "netcoreapp3.1": "lib/netstandard2.1/FSharp.Control.AsyncSeq.dll",
            "net5.0": "lib/netstandard2.1/FSharp.Control.AsyncSeq.dll",
        },
        core_ref = {
            "netcoreapp2.0": "lib/netstandard2.0/FSharp.Control.AsyncSeq.dll",
            "netcoreapp2.1": "lib/netstandard2.0/FSharp.Control.AsyncSeq.dll",
            "netcoreapp2.2": "lib/netstandard2.0/FSharp.Control.AsyncSeq.dll",
            "netcoreapp3.0": "lib/netstandard2.1/FSharp.Control.AsyncSeq.dll",
            "netcoreapp3.1": "lib/netstandard2.1/FSharp.Control.AsyncSeq.dll",
            "net5.0": "lib/netstandard2.1/FSharp.Control.AsyncSeq.dll",
        },
        core_deps = {
            "netcoreapp2.0": [
                "@paket2bazel.fsharp.core//:lib",
                "@paket2bazel.microsoft.bcl.asyncinterfaces//:lib",
            ],
            "netcoreapp2.1": [
                "@paket2bazel.fsharp.core//:lib",
                "@paket2bazel.microsoft.bcl.asyncinterfaces//:lib",
            ],
            "netcoreapp2.2": [
                "@paket2bazel.fsharp.core//:lib",
                "@paket2bazel.microsoft.bcl.asyncinterfaces//:lib",
            ],
            "netcoreapp3.0": [
                "@paket2bazel.fsharp.core//:lib",
                "@paket2bazel.microsoft.bcl.asyncinterfaces//:lib",
            ],
            "netcoreapp3.1": [
                "@paket2bazel.fsharp.core//:lib",
                "@paket2bazel.microsoft.bcl.asyncinterfaces//:lib",
            ],
            "net5.0": [
                "@paket2bazel.fsharp.core//:lib",
                "@paket2bazel.microsoft.bcl.asyncinterfaces//:lib",
            ],
        },
        core_files = {
            "netcoreapp2.0": [
                "lib/netstandard2.0/FSharp.Control.AsyncSeq.dll",
                "lib/netstandard2.0/FSharp.Control.AsyncSeq.xml",
            ],
            "netcoreapp2.1": [
                "lib/netstandard2.0/FSharp.Control.AsyncSeq.dll",
                "lib/netstandard2.0/FSharp.Control.AsyncSeq.xml",
            ],
            "netcoreapp2.2": [
                "lib/netstandard2.0/FSharp.Control.AsyncSeq.dll",
                "lib/netstandard2.0/FSharp.Control.AsyncSeq.xml",
            ],
            "netcoreapp3.0": [
                "lib/netstandard2.1/FSharp.Control.AsyncSeq.dll",
                "lib/netstandard2.1/FSharp.Control.AsyncSeq.xml",
            ],
            "netcoreapp3.1": [
                "lib/netstandard2.1/FSharp.Control.AsyncSeq.dll",
                "lib/netstandard2.1/FSharp.Control.AsyncSeq.xml",
            ],
            "net5.0": [
                "lib/netstandard2.1/FSharp.Control.AsyncSeq.dll",
                "lib/netstandard2.1/FSharp.Control.AsyncSeq.xml",
            ],
        },
    )
    nuget_package(
        name = "paket2bazel.fsharp.core",
        package = "fsharp.core",
        version = "6.0.3",
        sha256 = "a9701c0a654ccee9fb4691a3672364b7a700d3ee919542ae2595da1f81e34a64",
        core_lib = {
            "netcoreapp2.0": "lib/netstandard2.0/FSharp.Core.dll",
            "netcoreapp2.1": "lib/netstandard2.0/FSharp.Core.dll",
            "netcoreapp2.2": "lib/netstandard2.0/FSharp.Core.dll",
            "netcoreapp3.0": "lib/netstandard2.1/FSharp.Core.dll",
            "netcoreapp3.1": "lib/netstandard2.1/FSharp.Core.dll",
            "net5.0": "lib/netstandard2.1/FSharp.Core.dll",
        },
        core_ref = {
            "netcoreapp2.0": "lib/netstandard2.0/FSharp.Core.dll",
            "netcoreapp2.1": "lib/netstandard2.0/FSharp.Core.dll",
            "netcoreapp2.2": "lib/netstandard2.0/FSharp.Core.dll",
            "netcoreapp3.0": "lib/netstandard2.1/FSharp.Core.dll",
            "netcoreapp3.1": "lib/netstandard2.1/FSharp.Core.dll",
            "net5.0": "lib/netstandard2.1/FSharp.Core.dll",
        },
        core_files = {
            "netcoreapp2.0": [
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
            "netcoreapp2.1": [
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
            "netcoreapp2.2": [
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
            "netcoreapp3.0": [
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
            "netcoreapp3.1": [
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
            "net5.0": [
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
        },
    )
    nuget_package(
        name = "paket2bazel.fsharp.systemtextjson",
        package = "fsharp.systemtextjson",
        version = "0.16.6",
        sha256 = "48e51a42e04f1e54180e2da0694d8f75f4ee36de8f4ef3ac27283d1e2cff9c65",
        core_lib = {
            "netcoreapp2.0": "lib/netstandard2.0/FSharp.SystemTextJson.dll",
            "netcoreapp2.1": "lib/netstandard2.0/FSharp.SystemTextJson.dll",
            "netcoreapp2.2": "lib/netstandard2.0/FSharp.SystemTextJson.dll",
            "netcoreapp3.0": "lib/netstandard2.0/FSharp.SystemTextJson.dll",
            "netcoreapp3.1": "lib/netstandard2.0/FSharp.SystemTextJson.dll",
            "net5.0": "lib/netstandard2.0/FSharp.SystemTextJson.dll",
        },
        core_ref = {
            "netcoreapp2.0": "lib/netstandard2.0/FSharp.SystemTextJson.dll",
            "netcoreapp2.1": "lib/netstandard2.0/FSharp.SystemTextJson.dll",
            "netcoreapp2.2": "lib/netstandard2.0/FSharp.SystemTextJson.dll",
            "netcoreapp3.0": "lib/netstandard2.0/FSharp.SystemTextJson.dll",
            "netcoreapp3.1": "lib/netstandard2.0/FSharp.SystemTextJson.dll",
            "net5.0": "lib/netstandard2.0/FSharp.SystemTextJson.dll",
        },
        core_deps = {
            "netcoreapp2.0": [
                "@paket2bazel.fsharp.core//:lib",
                "@paket2bazel.system.text.json//:lib",
            ],
            "netcoreapp2.1": [
                "@paket2bazel.fsharp.core//:lib",
                "@paket2bazel.system.text.json//:lib",
            ],
            "netcoreapp2.2": [
                "@paket2bazel.fsharp.core//:lib",
                "@paket2bazel.system.text.json//:lib",
            ],
            "netcoreapp3.0": [
                "@paket2bazel.fsharp.core//:lib",
                "@paket2bazel.system.text.json//:lib",
            ],
            "netcoreapp3.1": [
                "@paket2bazel.fsharp.core//:lib",
                "@paket2bazel.system.text.json//:lib",
            ],
            "net5.0": [
                "@paket2bazel.fsharp.core//:lib",
                "@paket2bazel.system.text.json//:lib",
            ],
        },
        core_files = {
            "netcoreapp2.0": [
                "lib/netstandard2.0/FSharp.SystemTextJson.dll",
                "lib/netstandard2.0/FSharp.SystemTextJson.pdb",
            ],
            "netcoreapp2.1": [
                "lib/netstandard2.0/FSharp.SystemTextJson.dll",
                "lib/netstandard2.0/FSharp.SystemTextJson.pdb",
            ],
            "netcoreapp2.2": [
                "lib/netstandard2.0/FSharp.SystemTextJson.dll",
                "lib/netstandard2.0/FSharp.SystemTextJson.pdb",
            ],
            "netcoreapp3.0": [
                "lib/netstandard2.0/FSharp.SystemTextJson.dll",
                "lib/netstandard2.0/FSharp.SystemTextJson.pdb",
            ],
            "netcoreapp3.1": [
                "lib/netstandard2.0/FSharp.SystemTextJson.dll",
                "lib/netstandard2.0/FSharp.SystemTextJson.pdb",
            ],
            "net5.0": [
                "lib/netstandard2.0/FSharp.SystemTextJson.dll",
                "lib/netstandard2.0/FSharp.SystemTextJson.pdb",
            ],
        },
    )
    nuget_package(
        name = "paket2bazel.fsharpx.async",
        package = "fsharpx.async",
        version = "1.14.1",
        sha256 = "6c365bfe9a46f0dd4bf3c7a746a732eb022107e3bee6f58f8fa7368df6250ed4",
        core_lib = {
            "netcoreapp2.0": "lib/netstandard2.0/FSharpx.Async.dll",
            "netcoreapp2.1": "lib/netstandard2.0/FSharpx.Async.dll",
            "netcoreapp2.2": "lib/netstandard2.0/FSharpx.Async.dll",
            "netcoreapp3.0": "lib/netstandard2.0/FSharpx.Async.dll",
            "netcoreapp3.1": "lib/netstandard2.0/FSharpx.Async.dll",
            "net5.0": "lib/netstandard2.0/FSharpx.Async.dll",
        },
        core_ref = {
            "netcoreapp2.0": "lib/netstandard2.0/FSharpx.Async.dll",
            "netcoreapp2.1": "lib/netstandard2.0/FSharpx.Async.dll",
            "netcoreapp2.2": "lib/netstandard2.0/FSharpx.Async.dll",
            "netcoreapp3.0": "lib/netstandard2.0/FSharpx.Async.dll",
            "netcoreapp3.1": "lib/netstandard2.0/FSharpx.Async.dll",
            "net5.0": "lib/netstandard2.0/FSharpx.Async.dll",
        },
        core_deps = {
            "netcoreapp2.0": [
                "@paket2bazel.fsharp.control.asyncseq//:lib",
                "@paket2bazel.fsharp.core//:lib",
            ],
            "netcoreapp2.1": [
                "@paket2bazel.fsharp.control.asyncseq//:lib",
                "@paket2bazel.fsharp.core//:lib",
            ],
            "netcoreapp2.2": [
                "@paket2bazel.fsharp.control.asyncseq//:lib",
                "@paket2bazel.fsharp.core//:lib",
            ],
            "netcoreapp3.0": [
                "@paket2bazel.fsharp.control.asyncseq//:lib",
                "@paket2bazel.fsharp.core//:lib",
            ],
            "netcoreapp3.1": [
                "@paket2bazel.fsharp.control.asyncseq//:lib",
                "@paket2bazel.fsharp.core//:lib",
            ],
            "net5.0": [
                "@paket2bazel.fsharp.control.asyncseq//:lib",
                "@paket2bazel.fsharp.core//:lib",
            ],
        },
        core_files = {
            "netcoreapp2.0": [
                "lib/netstandard2.0/FSharpx.Async.dll",
                "lib/netstandard2.0/FSharpx.Async.xml",
            ],
            "netcoreapp2.1": [
                "lib/netstandard2.0/FSharpx.Async.dll",
                "lib/netstandard2.0/FSharpx.Async.xml",
            ],
            "netcoreapp2.2": [
                "lib/netstandard2.0/FSharpx.Async.dll",
                "lib/netstandard2.0/FSharpx.Async.xml",
            ],
            "netcoreapp3.0": [
                "lib/netstandard2.0/FSharpx.Async.dll",
                "lib/netstandard2.0/FSharpx.Async.xml",
            ],
            "netcoreapp3.1": [
                "lib/netstandard2.0/FSharpx.Async.dll",
                "lib/netstandard2.0/FSharpx.Async.xml",
            ],
            "net5.0": [
                "lib/netstandard2.0/FSharpx.Async.dll",
                "lib/netstandard2.0/FSharpx.Async.xml",
            ],
        },
    )
    nuget_package(
        name = "paket2bazel.fsharpx.collections",
        package = "fsharpx.collections",
        version = "2.1.3",
        sha256 = "ba5ca74245b6d770bc39e9f6a81c400ad3c0adafee29d261fbc22d5635e4fad9",
        core_lib = {
            "netcoreapp2.0": "lib/netstandard2.0/FSharpx.Collections.dll",
            "netcoreapp2.1": "lib/netstandard2.0/FSharpx.Collections.dll",
            "netcoreapp2.2": "lib/netstandard2.0/FSharpx.Collections.dll",
            "netcoreapp3.0": "lib/netstandard2.0/FSharpx.Collections.dll",
            "netcoreapp3.1": "lib/netstandard2.0/FSharpx.Collections.dll",
            "net5.0": "lib/netstandard2.0/FSharpx.Collections.dll",
        },
        core_ref = {
            "netcoreapp2.0": "lib/netstandard2.0/FSharpx.Collections.dll",
            "netcoreapp2.1": "lib/netstandard2.0/FSharpx.Collections.dll",
            "netcoreapp2.2": "lib/netstandard2.0/FSharpx.Collections.dll",
            "netcoreapp3.0": "lib/netstandard2.0/FSharpx.Collections.dll",
            "netcoreapp3.1": "lib/netstandard2.0/FSharpx.Collections.dll",
            "net5.0": "lib/netstandard2.0/FSharpx.Collections.dll",
        },
        core_deps = {
            "netcoreapp2.0": [
                "@paket2bazel.fsharp.core//:lib",
            ],
            "netcoreapp2.1": [
                "@paket2bazel.fsharp.core//:lib",
            ],
            "netcoreapp2.2": [
                "@paket2bazel.fsharp.core//:lib",
            ],
            "netcoreapp3.0": [
                "@paket2bazel.fsharp.core//:lib",
            ],
            "netcoreapp3.1": [
                "@paket2bazel.fsharp.core//:lib",
            ],
            "net5.0": [
                "@paket2bazel.fsharp.core//:lib",
            ],
        },
        core_files = {
            "netcoreapp2.0": [
                "lib/netstandard2.0/FSharpx.Collections.dll",
                "lib/netstandard2.0/FSharpx.Collections.pdb",
                "lib/netstandard2.0/FSharpx.Collections.xml",
            ],
            "netcoreapp2.1": [
                "lib/netstandard2.0/FSharpx.Collections.dll",
                "lib/netstandard2.0/FSharpx.Collections.pdb",
                "lib/netstandard2.0/FSharpx.Collections.xml",
            ],
            "netcoreapp2.2": [
                "lib/netstandard2.0/FSharpx.Collections.dll",
                "lib/netstandard2.0/FSharpx.Collections.pdb",
                "lib/netstandard2.0/FSharpx.Collections.xml",
            ],
            "netcoreapp3.0": [
                "lib/netstandard2.0/FSharpx.Collections.dll",
                "lib/netstandard2.0/FSharpx.Collections.pdb",
                "lib/netstandard2.0/FSharpx.Collections.xml",
            ],
            "netcoreapp3.1": [
                "lib/netstandard2.0/FSharpx.Collections.dll",
                "lib/netstandard2.0/FSharpx.Collections.pdb",
                "lib/netstandard2.0/FSharpx.Collections.xml",
            ],
            "net5.0": [
                "lib/netstandard2.0/FSharpx.Collections.dll",
                "lib/netstandard2.0/FSharpx.Collections.pdb",
                "lib/netstandard2.0/FSharpx.Collections.xml",
            ],
        },
    )
    nuget_package(
        name = "paket2bazel.fsharpx.extras",
        package = "fsharpx.extras",
        version = "3.0.0",
        sha256 = "3f8d89561bd1a4259c9ff0710cd2a71e3d47c94c439479e7f0aaf2c593a54480",
        core_lib = {
            "netcoreapp2.0": "lib/netstandard2.0/FSharpx.Extras.dll",
            "netcoreapp2.1": "lib/netstandard2.0/FSharpx.Extras.dll",
            "netcoreapp2.2": "lib/netstandard2.0/FSharpx.Extras.dll",
            "netcoreapp3.0": "lib/netstandard2.0/FSharpx.Extras.dll",
            "netcoreapp3.1": "lib/netstandard2.0/FSharpx.Extras.dll",
            "net5.0": "lib/netstandard2.0/FSharpx.Extras.dll",
        },
        core_ref = {
            "netcoreapp2.0": "lib/netstandard2.0/FSharpx.Extras.dll",
            "netcoreapp2.1": "lib/netstandard2.0/FSharpx.Extras.dll",
            "netcoreapp2.2": "lib/netstandard2.0/FSharpx.Extras.dll",
            "netcoreapp3.0": "lib/netstandard2.0/FSharpx.Extras.dll",
            "netcoreapp3.1": "lib/netstandard2.0/FSharpx.Extras.dll",
            "net5.0": "lib/netstandard2.0/FSharpx.Extras.dll",
        },
        core_deps = {
            "netcoreapp2.0": [
                "@paket2bazel.fsharp.core//:lib",
                "@paket2bazel.fsharpx.async//:lib",
                "@paket2bazel.fsharpx.collections//:lib",
                "@paket2bazel.system.reflection.emit.lightweight//:lib",
            ],
            "netcoreapp2.1": [
                "@paket2bazel.fsharp.core//:lib",
                "@paket2bazel.fsharpx.async//:lib",
                "@paket2bazel.fsharpx.collections//:lib",
                "@paket2bazel.system.reflection.emit.lightweight//:lib",
            ],
            "netcoreapp2.2": [
                "@paket2bazel.fsharp.core//:lib",
                "@paket2bazel.fsharpx.async//:lib",
                "@paket2bazel.fsharpx.collections//:lib",
                "@paket2bazel.system.reflection.emit.lightweight//:lib",
            ],
            "netcoreapp3.0": [
                "@paket2bazel.fsharp.core//:lib",
                "@paket2bazel.fsharpx.async//:lib",
                "@paket2bazel.fsharpx.collections//:lib",
                "@paket2bazel.system.reflection.emit.lightweight//:lib",
            ],
            "netcoreapp3.1": [
                "@paket2bazel.fsharp.core//:lib",
                "@paket2bazel.fsharpx.async//:lib",
                "@paket2bazel.fsharpx.collections//:lib",
                "@paket2bazel.system.reflection.emit.lightweight//:lib",
            ],
            "net5.0": [
                "@paket2bazel.fsharp.core//:lib",
                "@paket2bazel.fsharpx.async//:lib",
                "@paket2bazel.fsharpx.collections//:lib",
                "@paket2bazel.system.reflection.emit.lightweight//:lib",
            ],
        },
        core_files = {
            "netcoreapp2.0": [
                "lib/netstandard2.0/FSharpx.Extras.dll",
                "lib/netstandard2.0/FSharpx.Extras.xml",
            ],
            "netcoreapp2.1": [
                "lib/netstandard2.0/FSharpx.Extras.dll",
                "lib/netstandard2.0/FSharpx.Extras.xml",
            ],
            "netcoreapp2.2": [
                "lib/netstandard2.0/FSharpx.Extras.dll",
                "lib/netstandard2.0/FSharpx.Extras.xml",
            ],
            "netcoreapp3.0": [
                "lib/netstandard2.0/FSharpx.Extras.dll",
                "lib/netstandard2.0/FSharpx.Extras.xml",
            ],
            "netcoreapp3.1": [
                "lib/netstandard2.0/FSharpx.Extras.dll",
                "lib/netstandard2.0/FSharpx.Extras.xml",
            ],
            "net5.0": [
                "lib/netstandard2.0/FSharpx.Extras.dll",
                "lib/netstandard2.0/FSharpx.Extras.xml",
            ],
        },
    )
    nuget_package(
        name = "paket2bazel.microsoft.bcl.asyncinterfaces",
        package = "microsoft.bcl.asyncinterfaces",
        version = "6.0.0",
        sha256 = "e3df87fe2170a7e01f0880af59caa8f6eb380b3c40a4f282dfb43912aaf0f895",
        core_lib = {
            "netcoreapp2.0": "lib/netstandard2.0/Microsoft.Bcl.AsyncInterfaces.dll",
            "netcoreapp2.1": "lib/netstandard2.0/Microsoft.Bcl.AsyncInterfaces.dll",
            "netcoreapp2.2": "lib/netstandard2.0/Microsoft.Bcl.AsyncInterfaces.dll",
            "netcoreapp3.0": "lib/netstandard2.1/Microsoft.Bcl.AsyncInterfaces.dll",
            "netcoreapp3.1": "lib/netstandard2.1/Microsoft.Bcl.AsyncInterfaces.dll",
            "net5.0": "lib/netstandard2.1/Microsoft.Bcl.AsyncInterfaces.dll",
        },
        core_ref = {
            "netcoreapp2.0": "lib/netstandard2.0/Microsoft.Bcl.AsyncInterfaces.dll",
            "netcoreapp2.1": "lib/netstandard2.0/Microsoft.Bcl.AsyncInterfaces.dll",
            "netcoreapp2.2": "lib/netstandard2.0/Microsoft.Bcl.AsyncInterfaces.dll",
            "netcoreapp3.0": "lib/netstandard2.1/Microsoft.Bcl.AsyncInterfaces.dll",
            "netcoreapp3.1": "lib/netstandard2.1/Microsoft.Bcl.AsyncInterfaces.dll",
            "net5.0": "lib/netstandard2.1/Microsoft.Bcl.AsyncInterfaces.dll",
        },
        core_deps = {
            "netcoreapp2.0": [
                "@paket2bazel.system.threading.tasks.extensions//:lib",
            ],
            "netcoreapp2.1": [
                "@paket2bazel.system.threading.tasks.extensions//:lib",
            ],
            "netcoreapp2.2": [
                "@paket2bazel.system.threading.tasks.extensions//:lib",
            ],
        },
        core_files = {
            "netcoreapp2.0": [
                "lib/netstandard2.0/Microsoft.Bcl.AsyncInterfaces.dll",
                "lib/netstandard2.0/Microsoft.Bcl.AsyncInterfaces.xml",
            ],
            "netcoreapp2.1": [
                "lib/netstandard2.0/Microsoft.Bcl.AsyncInterfaces.dll",
                "lib/netstandard2.0/Microsoft.Bcl.AsyncInterfaces.xml",
            ],
            "netcoreapp2.2": [
                "lib/netstandard2.0/Microsoft.Bcl.AsyncInterfaces.dll",
                "lib/netstandard2.0/Microsoft.Bcl.AsyncInterfaces.xml",
            ],
            "netcoreapp3.0": [
                "lib/netstandard2.1/Microsoft.Bcl.AsyncInterfaces.dll",
                "lib/netstandard2.1/Microsoft.Bcl.AsyncInterfaces.xml",
            ],
            "netcoreapp3.1": [
                "lib/netstandard2.1/Microsoft.Bcl.AsyncInterfaces.dll",
                "lib/netstandard2.1/Microsoft.Bcl.AsyncInterfaces.xml",
            ],
            "net5.0": [
                "lib/netstandard2.1/Microsoft.Bcl.AsyncInterfaces.dll",
                "lib/netstandard2.1/Microsoft.Bcl.AsyncInterfaces.xml",
            ],
        },
    )
    nuget_package(
        name = "paket2bazel.microsoft.csharp",
        package = "microsoft.csharp",
        version = "4.7.0",
        sha256 = "127927bf646c145ebc9443ddadfe4cf81a55d641e82d3551029294c2e93fa63d",
    )
    nuget_package(
        name = "paket2bazel.microsoft.netcore.platforms",
        package = "microsoft.netcore.platforms",
        version = "6.0.3",
        sha256 = "07cb50afab4638e9f3c216691893a6f64fccd26fc74fda5f26a00568dd5015e3",
    )
    nuget_package(
        name = "paket2bazel.microsoft.netcore.targets",
        package = "microsoft.netcore.targets",
        version = "5.0.0",
        sha256 = "e6b14127c164c3bfb5d62086f6731584ea8f0a9c9522b6d4ceb15085cff6787c",
    )
    nuget_package(
        name = "paket2bazel.microsoft.web.xdt",
        package = "microsoft.web.xdt",
        version = "3.1.0",
        sha256 = "38ece8d6523710f474391b03c824b66f5192c2a667940dbaa3f895b464c37e72",
        core_lib = {
            "netcoreapp2.0": "lib/netstandard2.0/Microsoft.Web.XmlTransform.dll",
            "netcoreapp2.1": "lib/netstandard2.0/Microsoft.Web.XmlTransform.dll",
            "netcoreapp2.2": "lib/netstandard2.0/Microsoft.Web.XmlTransform.dll",
            "netcoreapp3.0": "lib/netstandard2.0/Microsoft.Web.XmlTransform.dll",
            "netcoreapp3.1": "lib/netstandard2.0/Microsoft.Web.XmlTransform.dll",
            "net5.0": "lib/netstandard2.0/Microsoft.Web.XmlTransform.dll",
        },
        core_ref = {
            "netcoreapp2.0": "lib/netstandard2.0/Microsoft.Web.XmlTransform.dll",
            "netcoreapp2.1": "lib/netstandard2.0/Microsoft.Web.XmlTransform.dll",
            "netcoreapp2.2": "lib/netstandard2.0/Microsoft.Web.XmlTransform.dll",
            "netcoreapp3.0": "lib/netstandard2.0/Microsoft.Web.XmlTransform.dll",
            "netcoreapp3.1": "lib/netstandard2.0/Microsoft.Web.XmlTransform.dll",
            "net5.0": "lib/netstandard2.0/Microsoft.Web.XmlTransform.dll",
        },
        core_files = {
            "netcoreapp2.0": [
                "lib/netstandard2.0/Microsoft.Web.XmlTransform.dll",
                "lib/netstandard2.0/Microsoft.Web.XmlTransform.pdb",
            ],
            "netcoreapp2.1": [
                "lib/netstandard2.0/Microsoft.Web.XmlTransform.dll",
                "lib/netstandard2.0/Microsoft.Web.XmlTransform.pdb",
            ],
            "netcoreapp2.2": [
                "lib/netstandard2.0/Microsoft.Web.XmlTransform.dll",
                "lib/netstandard2.0/Microsoft.Web.XmlTransform.pdb",
            ],
            "netcoreapp3.0": [
                "lib/netstandard2.0/Microsoft.Web.XmlTransform.dll",
                "lib/netstandard2.0/Microsoft.Web.XmlTransform.pdb",
            ],
            "netcoreapp3.1": [
                "lib/netstandard2.0/Microsoft.Web.XmlTransform.dll",
                "lib/netstandard2.0/Microsoft.Web.XmlTransform.pdb",
            ],
            "net5.0": [
                "lib/netstandard2.0/Microsoft.Web.XmlTransform.dll",
                "lib/netstandard2.0/Microsoft.Web.XmlTransform.pdb",
            ],
        },
    )
    nuget_package(
        name = "paket2bazel.microsoft.win32.systemevents",
        package = "microsoft.win32.systemevents",
        version = "6.0.1",
        sha256 = "c24f2857b8c765f4b1297e4f0dc5774bfa529ec685ab89abf1f6a4bc923857d5",
        core_lib = {
            "netcoreapp2.0": "lib/netstandard2.0/Microsoft.Win32.SystemEvents.dll",
            "netcoreapp2.1": "lib/netstandard2.0/Microsoft.Win32.SystemEvents.dll",
            "netcoreapp2.2": "lib/netstandard2.0/Microsoft.Win32.SystemEvents.dll",
            "netcoreapp3.0": "lib/netstandard2.0/Microsoft.Win32.SystemEvents.dll",
            "netcoreapp3.1": "lib/netcoreapp3.1/Microsoft.Win32.SystemEvents.dll",
            "net5.0": "lib/netcoreapp3.1/Microsoft.Win32.SystemEvents.dll",
        },
        core_ref = {
            "netcoreapp2.0": "lib/netstandard2.0/Microsoft.Win32.SystemEvents.dll",
            "netcoreapp2.1": "lib/netstandard2.0/Microsoft.Win32.SystemEvents.dll",
            "netcoreapp2.2": "lib/netstandard2.0/Microsoft.Win32.SystemEvents.dll",
            "netcoreapp3.0": "lib/netstandard2.0/Microsoft.Win32.SystemEvents.dll",
            "netcoreapp3.1": "lib/netcoreapp3.1/Microsoft.Win32.SystemEvents.dll",
            "net5.0": "lib/netcoreapp3.1/Microsoft.Win32.SystemEvents.dll",
        },
        core_files = {
            "netcoreapp2.0": [
                "lib/netstandard2.0/Microsoft.Win32.SystemEvents.dll",
                "lib/netstandard2.0/Microsoft.Win32.SystemEvents.xml",
            ],
            "netcoreapp2.1": [
                "lib/netstandard2.0/Microsoft.Win32.SystemEvents.dll",
                "lib/netstandard2.0/Microsoft.Win32.SystemEvents.xml",
            ],
            "netcoreapp2.2": [
                "lib/netstandard2.0/Microsoft.Win32.SystemEvents.dll",
                "lib/netstandard2.0/Microsoft.Win32.SystemEvents.xml",
            ],
            "netcoreapp3.0": [
                "lib/netstandard2.0/Microsoft.Win32.SystemEvents.dll",
                "lib/netstandard2.0/Microsoft.Win32.SystemEvents.xml",
            ],
            "netcoreapp3.1": [
                "lib/netcoreapp3.1/Microsoft.Win32.SystemEvents.dll",
                "lib/netcoreapp3.1/Microsoft.Win32.SystemEvents.xml",
            ],
            "net5.0": [
                "lib/netcoreapp3.1/Microsoft.Win32.SystemEvents.dll",
                "lib/netcoreapp3.1/Microsoft.Win32.SystemEvents.xml",
            ],
        },
    )
    nuget_package(
        name = "paket2bazel.mono.cecil",
        package = "mono.cecil",
        version = "0.11.4",
        sha256 = "1eb9d1805b0ecdfa805b0d1f5318bfbe4cd977c74c9f9cee79478b41603daafb",
        core_lib = {
            "netcoreapp2.0": "lib/netstandard2.0/Mono.Cecil.dll",
            "netcoreapp2.1": "lib/netstandard2.0/Mono.Cecil.dll",
            "netcoreapp2.2": "lib/netstandard2.0/Mono.Cecil.dll",
            "netcoreapp3.0": "lib/netstandard2.0/Mono.Cecil.dll",
            "netcoreapp3.1": "lib/netstandard2.0/Mono.Cecil.dll",
            "net5.0": "lib/netstandard2.0/Mono.Cecil.dll",
        },
        core_ref = {
            "netcoreapp2.0": "lib/netstandard2.0/Mono.Cecil.dll",
            "netcoreapp2.1": "lib/netstandard2.0/Mono.Cecil.dll",
            "netcoreapp2.2": "lib/netstandard2.0/Mono.Cecil.dll",
            "netcoreapp3.0": "lib/netstandard2.0/Mono.Cecil.dll",
            "netcoreapp3.1": "lib/netstandard2.0/Mono.Cecil.dll",
            "net5.0": "lib/netstandard2.0/Mono.Cecil.dll",
        },
        core_files = {
            "netcoreapp2.0": [
                "lib/netstandard2.0/Mono.Cecil.dll",
                "lib/netstandard2.0/Mono.Cecil.Mdb.dll",
                "lib/netstandard2.0/Mono.Cecil.Mdb.pdb",
                "lib/netstandard2.0/Mono.Cecil.pdb",
                "lib/netstandard2.0/Mono.Cecil.Pdb.dll",
                "lib/netstandard2.0/Mono.Cecil.Pdb.pdb",
                "lib/netstandard2.0/Mono.Cecil.Rocks.dll",
                "lib/netstandard2.0/Mono.Cecil.Rocks.pdb",
            ],
            "netcoreapp2.1": [
                "lib/netstandard2.0/Mono.Cecil.dll",
                "lib/netstandard2.0/Mono.Cecil.Mdb.dll",
                "lib/netstandard2.0/Mono.Cecil.Mdb.pdb",
                "lib/netstandard2.0/Mono.Cecil.pdb",
                "lib/netstandard2.0/Mono.Cecil.Pdb.dll",
                "lib/netstandard2.0/Mono.Cecil.Pdb.pdb",
                "lib/netstandard2.0/Mono.Cecil.Rocks.dll",
                "lib/netstandard2.0/Mono.Cecil.Rocks.pdb",
            ],
            "netcoreapp2.2": [
                "lib/netstandard2.0/Mono.Cecil.dll",
                "lib/netstandard2.0/Mono.Cecil.Mdb.dll",
                "lib/netstandard2.0/Mono.Cecil.Mdb.pdb",
                "lib/netstandard2.0/Mono.Cecil.pdb",
                "lib/netstandard2.0/Mono.Cecil.Pdb.dll",
                "lib/netstandard2.0/Mono.Cecil.Pdb.pdb",
                "lib/netstandard2.0/Mono.Cecil.Rocks.dll",
                "lib/netstandard2.0/Mono.Cecil.Rocks.pdb",
            ],
            "netcoreapp3.0": [
                "lib/netstandard2.0/Mono.Cecil.dll",
                "lib/netstandard2.0/Mono.Cecil.Mdb.dll",
                "lib/netstandard2.0/Mono.Cecil.Mdb.pdb",
                "lib/netstandard2.0/Mono.Cecil.pdb",
                "lib/netstandard2.0/Mono.Cecil.Pdb.dll",
                "lib/netstandard2.0/Mono.Cecil.Pdb.pdb",
                "lib/netstandard2.0/Mono.Cecil.Rocks.dll",
                "lib/netstandard2.0/Mono.Cecil.Rocks.pdb",
            ],
            "netcoreapp3.1": [
                "lib/netstandard2.0/Mono.Cecil.dll",
                "lib/netstandard2.0/Mono.Cecil.Mdb.dll",
                "lib/netstandard2.0/Mono.Cecil.Mdb.pdb",
                "lib/netstandard2.0/Mono.Cecil.pdb",
                "lib/netstandard2.0/Mono.Cecil.Pdb.dll",
                "lib/netstandard2.0/Mono.Cecil.Pdb.pdb",
                "lib/netstandard2.0/Mono.Cecil.Rocks.dll",
                "lib/netstandard2.0/Mono.Cecil.Rocks.pdb",
            ],
            "net5.0": [
                "lib/netstandard2.0/Mono.Cecil.dll",
                "lib/netstandard2.0/Mono.Cecil.Mdb.dll",
                "lib/netstandard2.0/Mono.Cecil.Mdb.pdb",
                "lib/netstandard2.0/Mono.Cecil.pdb",
                "lib/netstandard2.0/Mono.Cecil.Pdb.dll",
                "lib/netstandard2.0/Mono.Cecil.Pdb.pdb",
                "lib/netstandard2.0/Mono.Cecil.Rocks.dll",
                "lib/netstandard2.0/Mono.Cecil.Rocks.pdb",
            ],
        },
    )
    nuget_package(
        name = "paket2bazel.netstandard.library",
        package = "netstandard.library",
        version = "2.0.3",
        sha256 = "3eb87644f79bcffb3c0331dbdac3c7837265f2cdf58a7bfd93e431776f77c9ba",
        core_deps = {
            "netcoreapp2.0": [
                "@paket2bazel.microsoft.netcore.platforms//:lib",
            ],
            "netcoreapp2.1": [
                "@paket2bazel.microsoft.netcore.platforms//:lib",
            ],
            "netcoreapp2.2": [
                "@paket2bazel.microsoft.netcore.platforms//:lib",
            ],
            "netcoreapp3.0": [
                "@paket2bazel.microsoft.netcore.platforms//:lib",
            ],
            "netcoreapp3.1": [
                "@paket2bazel.microsoft.netcore.platforms//:lib",
            ],
            "net5.0": [
                "@paket2bazel.microsoft.netcore.platforms//:lib",
            ],
        },
    )
    nuget_package(
        name = "paket2bazel.newtonsoft.json",
        package = "newtonsoft.json",
        version = "13.0.1",
        sha256 = "2b6b52556e27e1b7913f33eedeb95568110c746bd64afff74357f1683878323a",
        core_lib = {
            "netcoreapp2.0": "lib/netstandard2.0/Newtonsoft.Json.dll",
            "netcoreapp2.1": "lib/netstandard2.0/Newtonsoft.Json.dll",
            "netcoreapp2.2": "lib/netstandard2.0/Newtonsoft.Json.dll",
            "netcoreapp3.0": "lib/netstandard2.0/Newtonsoft.Json.dll",
            "netcoreapp3.1": "lib/netstandard2.0/Newtonsoft.Json.dll",
            "net5.0": "lib/netstandard2.0/Newtonsoft.Json.dll",
        },
        core_ref = {
            "netcoreapp2.0": "lib/netstandard2.0/Newtonsoft.Json.dll",
            "netcoreapp2.1": "lib/netstandard2.0/Newtonsoft.Json.dll",
            "netcoreapp2.2": "lib/netstandard2.0/Newtonsoft.Json.dll",
            "netcoreapp3.0": "lib/netstandard2.0/Newtonsoft.Json.dll",
            "netcoreapp3.1": "lib/netstandard2.0/Newtonsoft.Json.dll",
            "net5.0": "lib/netstandard2.0/Newtonsoft.Json.dll",
        },
        core_files = {
            "netcoreapp2.0": [
                "lib/netstandard2.0/Newtonsoft.Json.dll",
                "lib/netstandard2.0/Newtonsoft.Json.xml",
            ],
            "netcoreapp2.1": [
                "lib/netstandard2.0/Newtonsoft.Json.dll",
                "lib/netstandard2.0/Newtonsoft.Json.xml",
            ],
            "netcoreapp2.2": [
                "lib/netstandard2.0/Newtonsoft.Json.dll",
                "lib/netstandard2.0/Newtonsoft.Json.xml",
            ],
            "netcoreapp3.0": [
                "lib/netstandard2.0/Newtonsoft.Json.dll",
                "lib/netstandard2.0/Newtonsoft.Json.xml",
            ],
            "netcoreapp3.1": [
                "lib/netstandard2.0/Newtonsoft.Json.dll",
                "lib/netstandard2.0/Newtonsoft.Json.xml",
            ],
            "net5.0": [
                "lib/netstandard2.0/Newtonsoft.Json.dll",
                "lib/netstandard2.0/Newtonsoft.Json.xml",
            ],
        },
    )
    nuget_package(
        name = "paket2bazel.nuget.commands",
        package = "nuget.commands",
        version = "6.2.0",
        sha256 = "51aa6b6ecb18708c1cf4e99d21e6d50d4fcfa2b1c3fac4a2d5a50c8576f53927",
        core_lib = {
            "netcoreapp2.0": "lib/netstandard2.0/NuGet.Commands.dll",
            "netcoreapp2.1": "lib/netstandard2.0/NuGet.Commands.dll",
            "netcoreapp2.2": "lib/netstandard2.0/NuGet.Commands.dll",
            "netcoreapp3.0": "lib/netstandard2.0/NuGet.Commands.dll",
            "netcoreapp3.1": "lib/netstandard2.0/NuGet.Commands.dll",
            "net5.0": "lib/net5.0/NuGet.Commands.dll",
        },
        core_ref = {
            "netcoreapp2.0": "lib/netstandard2.0/NuGet.Commands.dll",
            "netcoreapp2.1": "lib/netstandard2.0/NuGet.Commands.dll",
            "netcoreapp2.2": "lib/netstandard2.0/NuGet.Commands.dll",
            "netcoreapp3.0": "lib/netstandard2.0/NuGet.Commands.dll",
            "netcoreapp3.1": "lib/netstandard2.0/NuGet.Commands.dll",
            "net5.0": "lib/net5.0/NuGet.Commands.dll",
        },
        core_deps = {
            "netcoreapp2.0": [
                "@paket2bazel.nuget.credentials//:lib",
                "@paket2bazel.nuget.projectmodel//:lib",
            ],
            "netcoreapp2.1": [
                "@paket2bazel.nuget.credentials//:lib",
                "@paket2bazel.nuget.projectmodel//:lib",
            ],
            "netcoreapp2.2": [
                "@paket2bazel.nuget.credentials//:lib",
                "@paket2bazel.nuget.projectmodel//:lib",
            ],
            "netcoreapp3.0": [
                "@paket2bazel.nuget.credentials//:lib",
                "@paket2bazel.nuget.projectmodel//:lib",
            ],
            "netcoreapp3.1": [
                "@paket2bazel.nuget.credentials//:lib",
                "@paket2bazel.nuget.projectmodel//:lib",
            ],
            "net5.0": [
                "@paket2bazel.nuget.credentials//:lib",
                "@paket2bazel.nuget.projectmodel//:lib",
            ],
        },
        core_files = {
            "netcoreapp2.0": [
                "lib/netstandard2.0/NuGet.Commands.dll",
                "lib/netstandard2.0/NuGet.Commands.xml",
            ],
            "netcoreapp2.1": [
                "lib/netstandard2.0/NuGet.Commands.dll",
                "lib/netstandard2.0/NuGet.Commands.xml",
            ],
            "netcoreapp2.2": [
                "lib/netstandard2.0/NuGet.Commands.dll",
                "lib/netstandard2.0/NuGet.Commands.xml",
            ],
            "netcoreapp3.0": [
                "lib/netstandard2.0/NuGet.Commands.dll",
                "lib/netstandard2.0/NuGet.Commands.xml",
            ],
            "netcoreapp3.1": [
                "lib/netstandard2.0/NuGet.Commands.dll",
                "lib/netstandard2.0/NuGet.Commands.xml",
            ],
            "net5.0": [
                "lib/net5.0/NuGet.Commands.dll",
                "lib/net5.0/NuGet.Commands.xml",
            ],
        },
    )
    nuget_package(
        name = "paket2bazel.nuget.common",
        package = "nuget.common",
        version = "6.2.0",
        sha256 = "16b6599d516719a259d466ac3ae9598e23d787dd8846b6b411fa8d8e3ca572f7",
        core_lib = {
            "netcoreapp2.0": "lib/netstandard2.0/NuGet.Common.dll",
            "netcoreapp2.1": "lib/netstandard2.0/NuGet.Common.dll",
            "netcoreapp2.2": "lib/netstandard2.0/NuGet.Common.dll",
            "netcoreapp3.0": "lib/netstandard2.0/NuGet.Common.dll",
            "netcoreapp3.1": "lib/netstandard2.0/NuGet.Common.dll",
            "net5.0": "lib/netstandard2.0/NuGet.Common.dll",
        },
        core_ref = {
            "netcoreapp2.0": "lib/netstandard2.0/NuGet.Common.dll",
            "netcoreapp2.1": "lib/netstandard2.0/NuGet.Common.dll",
            "netcoreapp2.2": "lib/netstandard2.0/NuGet.Common.dll",
            "netcoreapp3.0": "lib/netstandard2.0/NuGet.Common.dll",
            "netcoreapp3.1": "lib/netstandard2.0/NuGet.Common.dll",
            "net5.0": "lib/netstandard2.0/NuGet.Common.dll",
        },
        core_deps = {
            "netcoreapp2.0": [
                "@paket2bazel.nuget.frameworks//:lib",
            ],
            "netcoreapp2.1": [
                "@paket2bazel.nuget.frameworks//:lib",
            ],
            "netcoreapp2.2": [
                "@paket2bazel.nuget.frameworks//:lib",
            ],
            "netcoreapp3.0": [
                "@paket2bazel.nuget.frameworks//:lib",
            ],
            "netcoreapp3.1": [
                "@paket2bazel.nuget.frameworks//:lib",
            ],
            "net5.0": [
                "@paket2bazel.nuget.frameworks//:lib",
            ],
        },
        core_files = {
            "netcoreapp2.0": [
                "lib/netstandard2.0/NuGet.Common.dll",
                "lib/netstandard2.0/NuGet.Common.xml",
            ],
            "netcoreapp2.1": [
                "lib/netstandard2.0/NuGet.Common.dll",
                "lib/netstandard2.0/NuGet.Common.xml",
            ],
            "netcoreapp2.2": [
                "lib/netstandard2.0/NuGet.Common.dll",
                "lib/netstandard2.0/NuGet.Common.xml",
            ],
            "netcoreapp3.0": [
                "lib/netstandard2.0/NuGet.Common.dll",
                "lib/netstandard2.0/NuGet.Common.xml",
            ],
            "netcoreapp3.1": [
                "lib/netstandard2.0/NuGet.Common.dll",
                "lib/netstandard2.0/NuGet.Common.xml",
            ],
            "net5.0": [
                "lib/netstandard2.0/NuGet.Common.dll",
                "lib/netstandard2.0/NuGet.Common.xml",
            ],
        },
    )
    nuget_package(
        name = "paket2bazel.nuget.configuration",
        package = "nuget.configuration",
        version = "6.2.0",
        sha256 = "a8d255212c8c6baa4ea0112566e93a0ce976419df19d5385ba78e1b243b5151e",
        core_lib = {
            "netcoreapp2.0": "lib/netstandard2.0/NuGet.Configuration.dll",
            "netcoreapp2.1": "lib/netstandard2.0/NuGet.Configuration.dll",
            "netcoreapp2.2": "lib/netstandard2.0/NuGet.Configuration.dll",
            "netcoreapp3.0": "lib/netstandard2.0/NuGet.Configuration.dll",
            "netcoreapp3.1": "lib/netstandard2.0/NuGet.Configuration.dll",
            "net5.0": "lib/netstandard2.0/NuGet.Configuration.dll",
        },
        core_ref = {
            "netcoreapp2.0": "lib/netstandard2.0/NuGet.Configuration.dll",
            "netcoreapp2.1": "lib/netstandard2.0/NuGet.Configuration.dll",
            "netcoreapp2.2": "lib/netstandard2.0/NuGet.Configuration.dll",
            "netcoreapp3.0": "lib/netstandard2.0/NuGet.Configuration.dll",
            "netcoreapp3.1": "lib/netstandard2.0/NuGet.Configuration.dll",
            "net5.0": "lib/netstandard2.0/NuGet.Configuration.dll",
        },
        core_deps = {
            "netcoreapp2.0": [
                "@paket2bazel.nuget.common//:lib",
                "@paket2bazel.system.security.cryptography.protecteddata//:lib",
            ],
            "netcoreapp2.1": [
                "@paket2bazel.nuget.common//:lib",
                "@paket2bazel.system.security.cryptography.protecteddata//:lib",
            ],
            "netcoreapp2.2": [
                "@paket2bazel.nuget.common//:lib",
                "@paket2bazel.system.security.cryptography.protecteddata//:lib",
            ],
            "netcoreapp3.0": [
                "@paket2bazel.nuget.common//:lib",
                "@paket2bazel.system.security.cryptography.protecteddata//:lib",
            ],
            "netcoreapp3.1": [
                "@paket2bazel.nuget.common//:lib",
                "@paket2bazel.system.security.cryptography.protecteddata//:lib",
            ],
            "net5.0": [
                "@paket2bazel.nuget.common//:lib",
                "@paket2bazel.system.security.cryptography.protecteddata//:lib",
            ],
        },
        core_files = {
            "netcoreapp2.0": [
                "lib/netstandard2.0/NuGet.Configuration.dll",
                "lib/netstandard2.0/NuGet.Configuration.xml",
            ],
            "netcoreapp2.1": [
                "lib/netstandard2.0/NuGet.Configuration.dll",
                "lib/netstandard2.0/NuGet.Configuration.xml",
            ],
            "netcoreapp2.2": [
                "lib/netstandard2.0/NuGet.Configuration.dll",
                "lib/netstandard2.0/NuGet.Configuration.xml",
            ],
            "netcoreapp3.0": [
                "lib/netstandard2.0/NuGet.Configuration.dll",
                "lib/netstandard2.0/NuGet.Configuration.xml",
            ],
            "netcoreapp3.1": [
                "lib/netstandard2.0/NuGet.Configuration.dll",
                "lib/netstandard2.0/NuGet.Configuration.xml",
            ],
            "net5.0": [
                "lib/netstandard2.0/NuGet.Configuration.dll",
                "lib/netstandard2.0/NuGet.Configuration.xml",
            ],
        },
    )
    nuget_package(
        name = "paket2bazel.nuget.credentials",
        package = "nuget.credentials",
        version = "6.2.0",
        sha256 = "cc30c5bf26b4bbe5539382717ac790df16ad8d42cd3605d678b907b0f632ca95",
        core_lib = {
            "netcoreapp2.0": "lib/netstandard2.0/NuGet.Credentials.dll",
            "netcoreapp2.1": "lib/netstandard2.0/NuGet.Credentials.dll",
            "netcoreapp2.2": "lib/netstandard2.0/NuGet.Credentials.dll",
            "netcoreapp3.0": "lib/netstandard2.0/NuGet.Credentials.dll",
            "netcoreapp3.1": "lib/netstandard2.0/NuGet.Credentials.dll",
            "net5.0": "lib/net5.0/NuGet.Credentials.dll",
        },
        core_ref = {
            "netcoreapp2.0": "lib/netstandard2.0/NuGet.Credentials.dll",
            "netcoreapp2.1": "lib/netstandard2.0/NuGet.Credentials.dll",
            "netcoreapp2.2": "lib/netstandard2.0/NuGet.Credentials.dll",
            "netcoreapp3.0": "lib/netstandard2.0/NuGet.Credentials.dll",
            "netcoreapp3.1": "lib/netstandard2.0/NuGet.Credentials.dll",
            "net5.0": "lib/net5.0/NuGet.Credentials.dll",
        },
        core_deps = {
            "netcoreapp2.0": [
                "@paket2bazel.nuget.protocol//:lib",
            ],
            "netcoreapp2.1": [
                "@paket2bazel.nuget.protocol//:lib",
            ],
            "netcoreapp2.2": [
                "@paket2bazel.nuget.protocol//:lib",
            ],
            "netcoreapp3.0": [
                "@paket2bazel.nuget.protocol//:lib",
            ],
            "netcoreapp3.1": [
                "@paket2bazel.nuget.protocol//:lib",
            ],
            "net5.0": [
                "@paket2bazel.nuget.protocol//:lib",
            ],
        },
        core_files = {
            "netcoreapp2.0": [
                "lib/netstandard2.0/NuGet.Credentials.dll",
            ],
            "netcoreapp2.1": [
                "lib/netstandard2.0/NuGet.Credentials.dll",
            ],
            "netcoreapp2.2": [
                "lib/netstandard2.0/NuGet.Credentials.dll",
            ],
            "netcoreapp3.0": [
                "lib/netstandard2.0/NuGet.Credentials.dll",
            ],
            "netcoreapp3.1": [
                "lib/netstandard2.0/NuGet.Credentials.dll",
            ],
            "net5.0": [
                "lib/net5.0/NuGet.Credentials.dll",
            ],
        },
    )
    nuget_package(
        name = "paket2bazel.nuget.dependencyresolver.core",
        package = "nuget.dependencyresolver.core",
        version = "6.2.0",
        sha256 = "f80e068e3a67aab3bde14ea8c421a54984a0a2386be09853b61888eec501002c",
        core_lib = {
            "netcoreapp2.0": "lib/netstandard2.0/NuGet.DependencyResolver.Core.dll",
            "netcoreapp2.1": "lib/netstandard2.0/NuGet.DependencyResolver.Core.dll",
            "netcoreapp2.2": "lib/netstandard2.0/NuGet.DependencyResolver.Core.dll",
            "netcoreapp3.0": "lib/netstandard2.0/NuGet.DependencyResolver.Core.dll",
            "netcoreapp3.1": "lib/netstandard2.0/NuGet.DependencyResolver.Core.dll",
            "net5.0": "lib/net5.0/NuGet.DependencyResolver.Core.dll",
        },
        core_ref = {
            "netcoreapp2.0": "lib/netstandard2.0/NuGet.DependencyResolver.Core.dll",
            "netcoreapp2.1": "lib/netstandard2.0/NuGet.DependencyResolver.Core.dll",
            "netcoreapp2.2": "lib/netstandard2.0/NuGet.DependencyResolver.Core.dll",
            "netcoreapp3.0": "lib/netstandard2.0/NuGet.DependencyResolver.Core.dll",
            "netcoreapp3.1": "lib/netstandard2.0/NuGet.DependencyResolver.Core.dll",
            "net5.0": "lib/net5.0/NuGet.DependencyResolver.Core.dll",
        },
        core_deps = {
            "netcoreapp2.0": [
                "@paket2bazel.nuget.configuration//:lib",
                "@paket2bazel.nuget.librarymodel//:lib",
                "@paket2bazel.nuget.protocol//:lib",
            ],
            "netcoreapp2.1": [
                "@paket2bazel.nuget.configuration//:lib",
                "@paket2bazel.nuget.librarymodel//:lib",
                "@paket2bazel.nuget.protocol//:lib",
            ],
            "netcoreapp2.2": [
                "@paket2bazel.nuget.configuration//:lib",
                "@paket2bazel.nuget.librarymodel//:lib",
                "@paket2bazel.nuget.protocol//:lib",
            ],
            "netcoreapp3.0": [
                "@paket2bazel.nuget.configuration//:lib",
                "@paket2bazel.nuget.librarymodel//:lib",
                "@paket2bazel.nuget.protocol//:lib",
            ],
            "netcoreapp3.1": [
                "@paket2bazel.nuget.configuration//:lib",
                "@paket2bazel.nuget.librarymodel//:lib",
                "@paket2bazel.nuget.protocol//:lib",
            ],
            "net5.0": [
                "@paket2bazel.nuget.configuration//:lib",
                "@paket2bazel.nuget.librarymodel//:lib",
                "@paket2bazel.nuget.protocol//:lib",
            ],
        },
        core_files = {
            "netcoreapp2.0": [
                "lib/netstandard2.0/NuGet.DependencyResolver.Core.dll",
                "lib/netstandard2.0/NuGet.DependencyResolver.Core.xml",
            ],
            "netcoreapp2.1": [
                "lib/netstandard2.0/NuGet.DependencyResolver.Core.dll",
                "lib/netstandard2.0/NuGet.DependencyResolver.Core.xml",
            ],
            "netcoreapp2.2": [
                "lib/netstandard2.0/NuGet.DependencyResolver.Core.dll",
                "lib/netstandard2.0/NuGet.DependencyResolver.Core.xml",
            ],
            "netcoreapp3.0": [
                "lib/netstandard2.0/NuGet.DependencyResolver.Core.dll",
                "lib/netstandard2.0/NuGet.DependencyResolver.Core.xml",
            ],
            "netcoreapp3.1": [
                "lib/netstandard2.0/NuGet.DependencyResolver.Core.dll",
                "lib/netstandard2.0/NuGet.DependencyResolver.Core.xml",
            ],
            "net5.0": [
                "lib/net5.0/NuGet.DependencyResolver.Core.dll",
                "lib/net5.0/NuGet.DependencyResolver.Core.xml",
            ],
        },
    )
    nuget_package(
        name = "paket2bazel.nuget.frameworks",
        package = "nuget.frameworks",
        version = "6.2.0",
        sha256 = "826427f3baa88b0fc032d3961fe87f30bfe3ca365acf92edb5d2b4bc7feb8b6b",
        core_lib = {
            "netcoreapp2.0": "lib/netstandard2.0/NuGet.Frameworks.dll",
            "netcoreapp2.1": "lib/netstandard2.0/NuGet.Frameworks.dll",
            "netcoreapp2.2": "lib/netstandard2.0/NuGet.Frameworks.dll",
            "netcoreapp3.0": "lib/netstandard2.0/NuGet.Frameworks.dll",
            "netcoreapp3.1": "lib/netstandard2.0/NuGet.Frameworks.dll",
            "net5.0": "lib/netstandard2.0/NuGet.Frameworks.dll",
        },
        core_ref = {
            "netcoreapp2.0": "lib/netstandard2.0/NuGet.Frameworks.dll",
            "netcoreapp2.1": "lib/netstandard2.0/NuGet.Frameworks.dll",
            "netcoreapp2.2": "lib/netstandard2.0/NuGet.Frameworks.dll",
            "netcoreapp3.0": "lib/netstandard2.0/NuGet.Frameworks.dll",
            "netcoreapp3.1": "lib/netstandard2.0/NuGet.Frameworks.dll",
            "net5.0": "lib/netstandard2.0/NuGet.Frameworks.dll",
        },
        core_files = {
            "netcoreapp2.0": [
                "lib/netstandard2.0/NuGet.Frameworks.dll",
                "lib/netstandard2.0/NuGet.Frameworks.xml",
            ],
            "netcoreapp2.1": [
                "lib/netstandard2.0/NuGet.Frameworks.dll",
                "lib/netstandard2.0/NuGet.Frameworks.xml",
            ],
            "netcoreapp2.2": [
                "lib/netstandard2.0/NuGet.Frameworks.dll",
                "lib/netstandard2.0/NuGet.Frameworks.xml",
            ],
            "netcoreapp3.0": [
                "lib/netstandard2.0/NuGet.Frameworks.dll",
                "lib/netstandard2.0/NuGet.Frameworks.xml",
            ],
            "netcoreapp3.1": [
                "lib/netstandard2.0/NuGet.Frameworks.dll",
                "lib/netstandard2.0/NuGet.Frameworks.xml",
            ],
            "net5.0": [
                "lib/netstandard2.0/NuGet.Frameworks.dll",
                "lib/netstandard2.0/NuGet.Frameworks.xml",
            ],
        },
    )
    nuget_package(
        name = "paket2bazel.nuget.librarymodel",
        package = "nuget.librarymodel",
        version = "6.2.0",
        sha256 = "22218a1c2f17196d904cc3621e6a7505edf68a99ffa1685734e81a76271c810a",
        core_lib = {
            "netcoreapp2.0": "lib/netstandard2.0/NuGet.LibraryModel.dll",
            "netcoreapp2.1": "lib/netstandard2.0/NuGet.LibraryModel.dll",
            "netcoreapp2.2": "lib/netstandard2.0/NuGet.LibraryModel.dll",
            "netcoreapp3.0": "lib/netstandard2.0/NuGet.LibraryModel.dll",
            "netcoreapp3.1": "lib/netstandard2.0/NuGet.LibraryModel.dll",
            "net5.0": "lib/netstandard2.0/NuGet.LibraryModel.dll",
        },
        core_ref = {
            "netcoreapp2.0": "lib/netstandard2.0/NuGet.LibraryModel.dll",
            "netcoreapp2.1": "lib/netstandard2.0/NuGet.LibraryModel.dll",
            "netcoreapp2.2": "lib/netstandard2.0/NuGet.LibraryModel.dll",
            "netcoreapp3.0": "lib/netstandard2.0/NuGet.LibraryModel.dll",
            "netcoreapp3.1": "lib/netstandard2.0/NuGet.LibraryModel.dll",
            "net5.0": "lib/netstandard2.0/NuGet.LibraryModel.dll",
        },
        core_deps = {
            "netcoreapp2.0": [
                "@paket2bazel.nuget.common//:lib",
                "@paket2bazel.nuget.versioning//:lib",
            ],
            "netcoreapp2.1": [
                "@paket2bazel.nuget.common//:lib",
                "@paket2bazel.nuget.versioning//:lib",
            ],
            "netcoreapp2.2": [
                "@paket2bazel.nuget.common//:lib",
                "@paket2bazel.nuget.versioning//:lib",
            ],
            "netcoreapp3.0": [
                "@paket2bazel.nuget.common//:lib",
                "@paket2bazel.nuget.versioning//:lib",
            ],
            "netcoreapp3.1": [
                "@paket2bazel.nuget.common//:lib",
                "@paket2bazel.nuget.versioning//:lib",
            ],
            "net5.0": [
                "@paket2bazel.nuget.common//:lib",
                "@paket2bazel.nuget.versioning//:lib",
            ],
        },
        core_files = {
            "netcoreapp2.0": [
                "lib/netstandard2.0/NuGet.LibraryModel.dll",
                "lib/netstandard2.0/NuGet.LibraryModel.xml",
            ],
            "netcoreapp2.1": [
                "lib/netstandard2.0/NuGet.LibraryModel.dll",
                "lib/netstandard2.0/NuGet.LibraryModel.xml",
            ],
            "netcoreapp2.2": [
                "lib/netstandard2.0/NuGet.LibraryModel.dll",
                "lib/netstandard2.0/NuGet.LibraryModel.xml",
            ],
            "netcoreapp3.0": [
                "lib/netstandard2.0/NuGet.LibraryModel.dll",
                "lib/netstandard2.0/NuGet.LibraryModel.xml",
            ],
            "netcoreapp3.1": [
                "lib/netstandard2.0/NuGet.LibraryModel.dll",
                "lib/netstandard2.0/NuGet.LibraryModel.xml",
            ],
            "net5.0": [
                "lib/netstandard2.0/NuGet.LibraryModel.dll",
                "lib/netstandard2.0/NuGet.LibraryModel.xml",
            ],
        },
    )
    nuget_package(
        name = "paket2bazel.nuget.packagemanagement",
        package = "nuget.packagemanagement",
        version = "6.2.0",
        sha256 = "30e2851ac1b2c656b7a201c06d93096ce8e0643fda8ae7e252574ca479ac5b09",
        core_lib = {
            "netcoreapp2.0": "lib/netstandard2.0/NuGet.PackageManagement.dll",
            "netcoreapp2.1": "lib/netstandard2.0/NuGet.PackageManagement.dll",
            "netcoreapp2.2": "lib/netstandard2.0/NuGet.PackageManagement.dll",
            "netcoreapp3.0": "lib/netstandard2.0/NuGet.PackageManagement.dll",
            "netcoreapp3.1": "lib/netstandard2.0/NuGet.PackageManagement.dll",
            "net5.0": "lib/netstandard2.0/NuGet.PackageManagement.dll",
        },
        core_ref = {
            "netcoreapp2.0": "lib/netstandard2.0/NuGet.PackageManagement.dll",
            "netcoreapp2.1": "lib/netstandard2.0/NuGet.PackageManagement.dll",
            "netcoreapp2.2": "lib/netstandard2.0/NuGet.PackageManagement.dll",
            "netcoreapp3.0": "lib/netstandard2.0/NuGet.PackageManagement.dll",
            "netcoreapp3.1": "lib/netstandard2.0/NuGet.PackageManagement.dll",
            "net5.0": "lib/netstandard2.0/NuGet.PackageManagement.dll",
        },
        core_deps = {
            "netcoreapp2.0": [
                "@paket2bazel.nuget.commands//:lib",
                "@paket2bazel.nuget.resolver//:lib",
                "@paket2bazel.microsoft.csharp//:lib",
                "@paket2bazel.microsoft.web.xdt//:lib",
                "@paket2bazel.system.componentmodel.composition//:lib",
            ],
            "netcoreapp2.1": [
                "@paket2bazel.nuget.commands//:lib",
                "@paket2bazel.nuget.resolver//:lib",
                "@paket2bazel.microsoft.csharp//:lib",
                "@paket2bazel.microsoft.web.xdt//:lib",
                "@paket2bazel.system.componentmodel.composition//:lib",
            ],
            "netcoreapp2.2": [
                "@paket2bazel.nuget.commands//:lib",
                "@paket2bazel.nuget.resolver//:lib",
                "@paket2bazel.microsoft.csharp//:lib",
                "@paket2bazel.microsoft.web.xdt//:lib",
                "@paket2bazel.system.componentmodel.composition//:lib",
            ],
            "netcoreapp3.0": [
                "@paket2bazel.nuget.commands//:lib",
                "@paket2bazel.nuget.resolver//:lib",
                "@paket2bazel.microsoft.csharp//:lib",
                "@paket2bazel.microsoft.web.xdt//:lib",
                "@paket2bazel.system.componentmodel.composition//:lib",
            ],
            "netcoreapp3.1": [
                "@paket2bazel.nuget.commands//:lib",
                "@paket2bazel.nuget.resolver//:lib",
                "@paket2bazel.microsoft.csharp//:lib",
                "@paket2bazel.microsoft.web.xdt//:lib",
                "@paket2bazel.system.componentmodel.composition//:lib",
            ],
            "net5.0": [
                "@paket2bazel.nuget.commands//:lib",
                "@paket2bazel.nuget.resolver//:lib",
                "@paket2bazel.microsoft.csharp//:lib",
                "@paket2bazel.microsoft.web.xdt//:lib",
                "@paket2bazel.system.componentmodel.composition//:lib",
            ],
        },
        core_files = {
            "netcoreapp2.0": [
                "lib/netstandard2.0/NuGet.PackageManagement.dll",
                "lib/netstandard2.0/NuGet.PackageManagement.xml",
            ],
            "netcoreapp2.1": [
                "lib/netstandard2.0/NuGet.PackageManagement.dll",
                "lib/netstandard2.0/NuGet.PackageManagement.xml",
            ],
            "netcoreapp2.2": [
                "lib/netstandard2.0/NuGet.PackageManagement.dll",
                "lib/netstandard2.0/NuGet.PackageManagement.xml",
            ],
            "netcoreapp3.0": [
                "lib/netstandard2.0/NuGet.PackageManagement.dll",
                "lib/netstandard2.0/NuGet.PackageManagement.xml",
            ],
            "netcoreapp3.1": [
                "lib/netstandard2.0/NuGet.PackageManagement.dll",
                "lib/netstandard2.0/NuGet.PackageManagement.xml",
            ],
            "net5.0": [
                "lib/netstandard2.0/NuGet.PackageManagement.dll",
                "lib/netstandard2.0/NuGet.PackageManagement.xml",
            ],
        },
    )
    nuget_package(
        name = "paket2bazel.nuget.packaging",
        package = "nuget.packaging",
        version = "6.2.0",
        sha256 = "7481a118093f38967cafa47b8a66d68702ff8178f6c814eddd014fb68c5ab317",
        core_lib = {
            "netcoreapp2.0": "lib/netstandard2.0/NuGet.Packaging.dll",
            "netcoreapp2.1": "lib/netstandard2.0/NuGet.Packaging.dll",
            "netcoreapp2.2": "lib/netstandard2.0/NuGet.Packaging.dll",
            "netcoreapp3.0": "lib/netstandard2.0/NuGet.Packaging.dll",
            "netcoreapp3.1": "lib/netstandard2.0/NuGet.Packaging.dll",
            "net5.0": "lib/net5.0/NuGet.Packaging.dll",
        },
        core_ref = {
            "netcoreapp2.0": "lib/netstandard2.0/NuGet.Packaging.dll",
            "netcoreapp2.1": "lib/netstandard2.0/NuGet.Packaging.dll",
            "netcoreapp2.2": "lib/netstandard2.0/NuGet.Packaging.dll",
            "netcoreapp3.0": "lib/netstandard2.0/NuGet.Packaging.dll",
            "netcoreapp3.1": "lib/netstandard2.0/NuGet.Packaging.dll",
            "net5.0": "lib/net5.0/NuGet.Packaging.dll",
        },
        core_deps = {
            "netcoreapp2.0": [
                "@paket2bazel.nuget.configuration//:lib",
                "@paket2bazel.nuget.versioning//:lib",
                "@paket2bazel.newtonsoft.json//:lib",
                "@paket2bazel.system.security.cryptography.cng//:lib",
                "@paket2bazel.system.security.cryptography.pkcs//:lib",
            ],
            "netcoreapp2.1": [
                "@paket2bazel.nuget.configuration//:lib",
                "@paket2bazel.nuget.versioning//:lib",
                "@paket2bazel.newtonsoft.json//:lib",
                "@paket2bazel.system.security.cryptography.cng//:lib",
                "@paket2bazel.system.security.cryptography.pkcs//:lib",
            ],
            "netcoreapp2.2": [
                "@paket2bazel.nuget.configuration//:lib",
                "@paket2bazel.nuget.versioning//:lib",
                "@paket2bazel.newtonsoft.json//:lib",
                "@paket2bazel.system.security.cryptography.cng//:lib",
                "@paket2bazel.system.security.cryptography.pkcs//:lib",
            ],
            "netcoreapp3.0": [
                "@paket2bazel.nuget.configuration//:lib",
                "@paket2bazel.nuget.versioning//:lib",
                "@paket2bazel.newtonsoft.json//:lib",
                "@paket2bazel.system.security.cryptography.cng//:lib",
                "@paket2bazel.system.security.cryptography.pkcs//:lib",
            ],
            "netcoreapp3.1": [
                "@paket2bazel.nuget.configuration//:lib",
                "@paket2bazel.nuget.versioning//:lib",
                "@paket2bazel.newtonsoft.json//:lib",
                "@paket2bazel.system.security.cryptography.cng//:lib",
                "@paket2bazel.system.security.cryptography.pkcs//:lib",
            ],
            "net5.0": [
                "@paket2bazel.nuget.configuration//:lib",
                "@paket2bazel.nuget.versioning//:lib",
                "@paket2bazel.newtonsoft.json//:lib",
                "@paket2bazel.system.security.cryptography.cng//:lib",
                "@paket2bazel.system.security.cryptography.pkcs//:lib",
            ],
        },
        core_files = {
            "netcoreapp2.0": [
                "lib/netstandard2.0/NuGet.Packaging.dll",
                "lib/netstandard2.0/NuGet.Packaging.xml",
            ],
            "netcoreapp2.1": [
                "lib/netstandard2.0/NuGet.Packaging.dll",
                "lib/netstandard2.0/NuGet.Packaging.xml",
            ],
            "netcoreapp2.2": [
                "lib/netstandard2.0/NuGet.Packaging.dll",
                "lib/netstandard2.0/NuGet.Packaging.xml",
            ],
            "netcoreapp3.0": [
                "lib/netstandard2.0/NuGet.Packaging.dll",
                "lib/netstandard2.0/NuGet.Packaging.xml",
            ],
            "netcoreapp3.1": [
                "lib/netstandard2.0/NuGet.Packaging.dll",
                "lib/netstandard2.0/NuGet.Packaging.xml",
            ],
            "net5.0": [
                "lib/net5.0/NuGet.Packaging.dll",
                "lib/net5.0/NuGet.Packaging.xml",
            ],
        },
    )
    nuget_package(
        name = "paket2bazel.nuget.projectmodel",
        package = "nuget.projectmodel",
        version = "6.2.0",
        sha256 = "486b6cec906b9702ebc130ea5fcf954757ab472a573580da8794aed87f4b59bb",
        core_lib = {
            "netcoreapp2.0": "lib/netstandard2.0/NuGet.ProjectModel.dll",
            "netcoreapp2.1": "lib/netstandard2.0/NuGet.ProjectModel.dll",
            "netcoreapp2.2": "lib/netstandard2.0/NuGet.ProjectModel.dll",
            "netcoreapp3.0": "lib/netstandard2.0/NuGet.ProjectModel.dll",
            "netcoreapp3.1": "lib/netstandard2.0/NuGet.ProjectModel.dll",
            "net5.0": "lib/net5.0/NuGet.ProjectModel.dll",
        },
        core_ref = {
            "netcoreapp2.0": "lib/netstandard2.0/NuGet.ProjectModel.dll",
            "netcoreapp2.1": "lib/netstandard2.0/NuGet.ProjectModel.dll",
            "netcoreapp2.2": "lib/netstandard2.0/NuGet.ProjectModel.dll",
            "netcoreapp3.0": "lib/netstandard2.0/NuGet.ProjectModel.dll",
            "netcoreapp3.1": "lib/netstandard2.0/NuGet.ProjectModel.dll",
            "net5.0": "lib/net5.0/NuGet.ProjectModel.dll",
        },
        core_deps = {
            "netcoreapp2.0": [
                "@paket2bazel.nuget.dependencyresolver.core//:lib",
            ],
            "netcoreapp2.1": [
                "@paket2bazel.nuget.dependencyresolver.core//:lib",
            ],
            "netcoreapp2.2": [
                "@paket2bazel.nuget.dependencyresolver.core//:lib",
            ],
            "netcoreapp3.0": [
                "@paket2bazel.nuget.dependencyresolver.core//:lib",
            ],
            "netcoreapp3.1": [
                "@paket2bazel.nuget.dependencyresolver.core//:lib",
            ],
            "net5.0": [
                "@paket2bazel.nuget.dependencyresolver.core//:lib",
            ],
        },
        core_files = {
            "netcoreapp2.0": [
                "lib/netstandard2.0/NuGet.ProjectModel.dll",
                "lib/netstandard2.0/NuGet.ProjectModel.xml",
            ],
            "netcoreapp2.1": [
                "lib/netstandard2.0/NuGet.ProjectModel.dll",
                "lib/netstandard2.0/NuGet.ProjectModel.xml",
            ],
            "netcoreapp2.2": [
                "lib/netstandard2.0/NuGet.ProjectModel.dll",
                "lib/netstandard2.0/NuGet.ProjectModel.xml",
            ],
            "netcoreapp3.0": [
                "lib/netstandard2.0/NuGet.ProjectModel.dll",
                "lib/netstandard2.0/NuGet.ProjectModel.xml",
            ],
            "netcoreapp3.1": [
                "lib/netstandard2.0/NuGet.ProjectModel.dll",
                "lib/netstandard2.0/NuGet.ProjectModel.xml",
            ],
            "net5.0": [
                "lib/net5.0/NuGet.ProjectModel.dll",
                "lib/net5.0/NuGet.ProjectModel.xml",
            ],
        },
    )
    nuget_package(
        name = "paket2bazel.nuget.protocol",
        package = "nuget.protocol",
        version = "6.2.0",
        sha256 = "633cf7c15435409cbca29460ddf4340ca26e82830f4b53398162eb42164151b9",
        core_lib = {
            "netcoreapp2.0": "lib/netstandard2.0/NuGet.Protocol.dll",
            "netcoreapp2.1": "lib/netstandard2.0/NuGet.Protocol.dll",
            "netcoreapp2.2": "lib/netstandard2.0/NuGet.Protocol.dll",
            "netcoreapp3.0": "lib/netstandard2.0/NuGet.Protocol.dll",
            "netcoreapp3.1": "lib/netstandard2.0/NuGet.Protocol.dll",
            "net5.0": "lib/net5.0/NuGet.Protocol.dll",
        },
        core_ref = {
            "netcoreapp2.0": "lib/netstandard2.0/NuGet.Protocol.dll",
            "netcoreapp2.1": "lib/netstandard2.0/NuGet.Protocol.dll",
            "netcoreapp2.2": "lib/netstandard2.0/NuGet.Protocol.dll",
            "netcoreapp3.0": "lib/netstandard2.0/NuGet.Protocol.dll",
            "netcoreapp3.1": "lib/netstandard2.0/NuGet.Protocol.dll",
            "net5.0": "lib/net5.0/NuGet.Protocol.dll",
        },
        core_deps = {
            "netcoreapp2.0": [
                "@paket2bazel.nuget.packaging//:lib",
            ],
            "netcoreapp2.1": [
                "@paket2bazel.nuget.packaging//:lib",
            ],
            "netcoreapp2.2": [
                "@paket2bazel.nuget.packaging//:lib",
            ],
            "netcoreapp3.0": [
                "@paket2bazel.nuget.packaging//:lib",
            ],
            "netcoreapp3.1": [
                "@paket2bazel.nuget.packaging//:lib",
            ],
            "net5.0": [
                "@paket2bazel.nuget.packaging//:lib",
            ],
        },
        core_files = {
            "netcoreapp2.0": [
                "lib/netstandard2.0/NuGet.Protocol.dll",
                "lib/netstandard2.0/NuGet.Protocol.xml",
            ],
            "netcoreapp2.1": [
                "lib/netstandard2.0/NuGet.Protocol.dll",
                "lib/netstandard2.0/NuGet.Protocol.xml",
            ],
            "netcoreapp2.2": [
                "lib/netstandard2.0/NuGet.Protocol.dll",
                "lib/netstandard2.0/NuGet.Protocol.xml",
            ],
            "netcoreapp3.0": [
                "lib/netstandard2.0/NuGet.Protocol.dll",
                "lib/netstandard2.0/NuGet.Protocol.xml",
            ],
            "netcoreapp3.1": [
                "lib/netstandard2.0/NuGet.Protocol.dll",
                "lib/netstandard2.0/NuGet.Protocol.xml",
            ],
            "net5.0": [
                "lib/net5.0/NuGet.Protocol.dll",
                "lib/net5.0/NuGet.Protocol.xml",
            ],
        },
    )
    nuget_package(
        name = "paket2bazel.nuget.resolver",
        package = "nuget.resolver",
        version = "6.2.0",
        sha256 = "a44e712368e7f131d89fb37c36049889fd0e46837f3d49bae4f5a363e7f8a12e",
        core_lib = {
            "netcoreapp2.0": "lib/netstandard2.0/NuGet.Resolver.dll",
            "netcoreapp2.1": "lib/netstandard2.0/NuGet.Resolver.dll",
            "netcoreapp2.2": "lib/netstandard2.0/NuGet.Resolver.dll",
            "netcoreapp3.0": "lib/netstandard2.0/NuGet.Resolver.dll",
            "netcoreapp3.1": "lib/netstandard2.0/NuGet.Resolver.dll",
            "net5.0": "lib/net5.0/NuGet.Resolver.dll",
        },
        core_ref = {
            "netcoreapp2.0": "lib/netstandard2.0/NuGet.Resolver.dll",
            "netcoreapp2.1": "lib/netstandard2.0/NuGet.Resolver.dll",
            "netcoreapp2.2": "lib/netstandard2.0/NuGet.Resolver.dll",
            "netcoreapp3.0": "lib/netstandard2.0/NuGet.Resolver.dll",
            "netcoreapp3.1": "lib/netstandard2.0/NuGet.Resolver.dll",
            "net5.0": "lib/net5.0/NuGet.Resolver.dll",
        },
        core_deps = {
            "netcoreapp2.0": [
                "@paket2bazel.nuget.protocol//:lib",
            ],
            "netcoreapp2.1": [
                "@paket2bazel.nuget.protocol//:lib",
            ],
            "netcoreapp2.2": [
                "@paket2bazel.nuget.protocol//:lib",
            ],
            "netcoreapp3.0": [
                "@paket2bazel.nuget.protocol//:lib",
            ],
            "netcoreapp3.1": [
                "@paket2bazel.nuget.protocol//:lib",
            ],
            "net5.0": [
                "@paket2bazel.nuget.protocol//:lib",
            ],
        },
        core_files = {
            "netcoreapp2.0": [
                "lib/netstandard2.0/NuGet.Resolver.dll",
                "lib/netstandard2.0/NuGet.Resolver.xml",
            ],
            "netcoreapp2.1": [
                "lib/netstandard2.0/NuGet.Resolver.dll",
                "lib/netstandard2.0/NuGet.Resolver.xml",
            ],
            "netcoreapp2.2": [
                "lib/netstandard2.0/NuGet.Resolver.dll",
                "lib/netstandard2.0/NuGet.Resolver.xml",
            ],
            "netcoreapp3.0": [
                "lib/netstandard2.0/NuGet.Resolver.dll",
                "lib/netstandard2.0/NuGet.Resolver.xml",
            ],
            "netcoreapp3.1": [
                "lib/netstandard2.0/NuGet.Resolver.dll",
                "lib/netstandard2.0/NuGet.Resolver.xml",
            ],
            "net5.0": [
                "lib/net5.0/NuGet.Resolver.dll",
                "lib/net5.0/NuGet.Resolver.xml",
            ],
        },
    )
    nuget_package(
        name = "paket2bazel.nuget.versioning",
        package = "nuget.versioning",
        version = "6.2.0",
        sha256 = "f683b4c6594c80f25e983e7a8e1e3d4149530d046bbf74414b2472ee7972fa62",
        core_lib = {
            "netcoreapp2.0": "lib/netstandard2.0/NuGet.Versioning.dll",
            "netcoreapp2.1": "lib/netstandard2.0/NuGet.Versioning.dll",
            "netcoreapp2.2": "lib/netstandard2.0/NuGet.Versioning.dll",
            "netcoreapp3.0": "lib/netstandard2.0/NuGet.Versioning.dll",
            "netcoreapp3.1": "lib/netstandard2.0/NuGet.Versioning.dll",
            "net5.0": "lib/netstandard2.0/NuGet.Versioning.dll",
        },
        core_ref = {
            "netcoreapp2.0": "lib/netstandard2.0/NuGet.Versioning.dll",
            "netcoreapp2.1": "lib/netstandard2.0/NuGet.Versioning.dll",
            "netcoreapp2.2": "lib/netstandard2.0/NuGet.Versioning.dll",
            "netcoreapp3.0": "lib/netstandard2.0/NuGet.Versioning.dll",
            "netcoreapp3.1": "lib/netstandard2.0/NuGet.Versioning.dll",
            "net5.0": "lib/netstandard2.0/NuGet.Versioning.dll",
        },
        core_files = {
            "netcoreapp2.0": [
                "lib/netstandard2.0/NuGet.Versioning.dll",
                "lib/netstandard2.0/NuGet.Versioning.xml",
            ],
            "netcoreapp2.1": [
                "lib/netstandard2.0/NuGet.Versioning.dll",
                "lib/netstandard2.0/NuGet.Versioning.xml",
            ],
            "netcoreapp2.2": [
                "lib/netstandard2.0/NuGet.Versioning.dll",
                "lib/netstandard2.0/NuGet.Versioning.xml",
            ],
            "netcoreapp3.0": [
                "lib/netstandard2.0/NuGet.Versioning.dll",
                "lib/netstandard2.0/NuGet.Versioning.xml",
            ],
            "netcoreapp3.1": [
                "lib/netstandard2.0/NuGet.Versioning.dll",
                "lib/netstandard2.0/NuGet.Versioning.xml",
            ],
            "net5.0": [
                "lib/netstandard2.0/NuGet.Versioning.dll",
                "lib/netstandard2.0/NuGet.Versioning.xml",
            ],
        },
    )
    nuget_package(
        name = "paket2bazel.paket.core",
        package = "paket.core",
        version = "7.1.5",
        sha256 = "b9c61e3422db5f0cdfbf234c345dc7e38509c9a5040e6e640f4ce8490c83ad98",
        core_lib = {
            "netcoreapp2.0": "lib/netstandard2.0/Paket.Core.dll",
            "netcoreapp2.1": "lib/netstandard2.0/Paket.Core.dll",
            "netcoreapp2.2": "lib/netstandard2.0/Paket.Core.dll",
            "netcoreapp3.0": "lib/netstandard2.0/Paket.Core.dll",
            "netcoreapp3.1": "lib/netstandard2.0/Paket.Core.dll",
            "net5.0": "lib/netstandard2.0/Paket.Core.dll",
        },
        core_ref = {
            "netcoreapp2.0": "lib/netstandard2.0/Paket.Core.dll",
            "netcoreapp2.1": "lib/netstandard2.0/Paket.Core.dll",
            "netcoreapp2.2": "lib/netstandard2.0/Paket.Core.dll",
            "netcoreapp3.0": "lib/netstandard2.0/Paket.Core.dll",
            "netcoreapp3.1": "lib/netstandard2.0/Paket.Core.dll",
            "net5.0": "lib/netstandard2.0/Paket.Core.dll",
        },
        core_deps = {
            "netcoreapp2.0": [
                "@paket2bazel.chessie//:lib",
                "@paket2bazel.fsharp.core//:lib",
                "@paket2bazel.mono.cecil//:lib",
                "@paket2bazel.newtonsoft.json//:lib",
                "@paket2bazel.nuget.packaging//:lib",
                "@paket2bazel.system.net.http//:lib",
                "@paket2bazel.system.net.http.winhttphandler//:lib",
                "@paket2bazel.system.security.cryptography.protecteddata//:lib",
            ],
            "netcoreapp2.1": [
                "@paket2bazel.chessie//:lib",
                "@paket2bazel.fsharp.core//:lib",
                "@paket2bazel.mono.cecil//:lib",
                "@paket2bazel.newtonsoft.json//:lib",
                "@paket2bazel.nuget.packaging//:lib",
                "@paket2bazel.system.net.http//:lib",
                "@paket2bazel.system.net.http.winhttphandler//:lib",
                "@paket2bazel.system.security.cryptography.protecteddata//:lib",
            ],
            "netcoreapp2.2": [
                "@paket2bazel.chessie//:lib",
                "@paket2bazel.fsharp.core//:lib",
                "@paket2bazel.mono.cecil//:lib",
                "@paket2bazel.newtonsoft.json//:lib",
                "@paket2bazel.nuget.packaging//:lib",
                "@paket2bazel.system.net.http//:lib",
                "@paket2bazel.system.net.http.winhttphandler//:lib",
                "@paket2bazel.system.security.cryptography.protecteddata//:lib",
            ],
            "netcoreapp3.0": [
                "@paket2bazel.chessie//:lib",
                "@paket2bazel.fsharp.core//:lib",
                "@paket2bazel.mono.cecil//:lib",
                "@paket2bazel.newtonsoft.json//:lib",
                "@paket2bazel.nuget.packaging//:lib",
                "@paket2bazel.system.net.http//:lib",
                "@paket2bazel.system.net.http.winhttphandler//:lib",
                "@paket2bazel.system.security.cryptography.protecteddata//:lib",
            ],
            "netcoreapp3.1": [
                "@paket2bazel.chessie//:lib",
                "@paket2bazel.fsharp.core//:lib",
                "@paket2bazel.mono.cecil//:lib",
                "@paket2bazel.newtonsoft.json//:lib",
                "@paket2bazel.nuget.packaging//:lib",
                "@paket2bazel.system.net.http//:lib",
                "@paket2bazel.system.net.http.winhttphandler//:lib",
                "@paket2bazel.system.security.cryptography.protecteddata//:lib",
            ],
            "net5.0": [
                "@paket2bazel.chessie//:lib",
                "@paket2bazel.fsharp.core//:lib",
                "@paket2bazel.mono.cecil//:lib",
                "@paket2bazel.newtonsoft.json//:lib",
                "@paket2bazel.nuget.packaging//:lib",
                "@paket2bazel.system.net.http//:lib",
                "@paket2bazel.system.net.http.winhttphandler//:lib",
                "@paket2bazel.system.security.cryptography.protecteddata//:lib",
            ],
        },
        core_files = {
            "netcoreapp2.0": [
                "lib/netstandard2.0/Paket.Core.dll",
                "lib/netstandard2.0/Paket.Core.xml",
            ],
            "netcoreapp2.1": [
                "lib/netstandard2.0/Paket.Core.dll",
                "lib/netstandard2.0/Paket.Core.xml",
            ],
            "netcoreapp2.2": [
                "lib/netstandard2.0/Paket.Core.dll",
                "lib/netstandard2.0/Paket.Core.xml",
            ],
            "netcoreapp3.0": [
                "lib/netstandard2.0/Paket.Core.dll",
                "lib/netstandard2.0/Paket.Core.xml",
            ],
            "netcoreapp3.1": [
                "lib/netstandard2.0/Paket.Core.dll",
                "lib/netstandard2.0/Paket.Core.xml",
            ],
            "net5.0": [
                "lib/netstandard2.0/Paket.Core.dll",
                "lib/netstandard2.0/Paket.Core.xml",
            ],
        },
    )
    nuget_package(
        name = "paket2bazel.runtime.debian.8-x64.runtime.native.system.security.cryptography.openssl",
        package = "runtime.debian.8-x64.runtime.native.system.security.cryptography.openssl",
        version = "4.3.3",
        sha256 = "66ef74f32004daf2aefde096bbf12dc5e6346e94aeda383e50f186bd0212abe9",
        core_files = {
            "netcoreapp2.0": [
                "runtimes/debian.8-x64/native/System.Security.Cryptography.Native.OpenSsl.so",
            ],
            "netcoreapp2.1": [
                "runtimes/debian.8-x64/native/System.Security.Cryptography.Native.OpenSsl.so",
            ],
            "netcoreapp2.2": [
                "runtimes/debian.8-x64/native/System.Security.Cryptography.Native.OpenSsl.so",
            ],
            "netcoreapp3.0": [
                "runtimes/debian.8-x64/native/System.Security.Cryptography.Native.OpenSsl.so",
            ],
            "netcoreapp3.1": [
                "runtimes/debian.8-x64/native/System.Security.Cryptography.Native.OpenSsl.so",
            ],
            "net5.0": [
                "runtimes/debian.8-x64/native/System.Security.Cryptography.Native.OpenSsl.so",
            ],
        },
    )
    nuget_package(
        name = "paket2bazel.runtime.debian.9-x64.runtime.native.system.security.cryptography.openssl",
        package = "runtime.debian.9-x64.runtime.native.system.security.cryptography.openssl",
        version = "4.3.3",
        sha256 = "3dc68ef505ec04a0468799e3a4cbec3dbe7a3ac84bb1baa56f733b409636f58e",
        core_files = {
            "netcoreapp2.0": [
                "runtimes/debian.9-x64/native/System.Security.Cryptography.Native.OpenSsl.so",
            ],
            "netcoreapp2.1": [
                "runtimes/debian.9-x64/native/System.Security.Cryptography.Native.OpenSsl.so",
            ],
            "netcoreapp2.2": [
                "runtimes/debian.9-x64/native/System.Security.Cryptography.Native.OpenSsl.so",
            ],
            "netcoreapp3.0": [
                "runtimes/debian.9-x64/native/System.Security.Cryptography.Native.OpenSsl.so",
            ],
            "netcoreapp3.1": [
                "runtimes/debian.9-x64/native/System.Security.Cryptography.Native.OpenSsl.so",
            ],
            "net5.0": [
                "runtimes/debian.9-x64/native/System.Security.Cryptography.Native.OpenSsl.so",
            ],
        },
    )
    nuget_package(
        name = "paket2bazel.runtime.fedora.23-x64.runtime.native.system.security.cryptography.openssl",
        package = "runtime.fedora.23-x64.runtime.native.system.security.cryptography.openssl",
        version = "4.3.3",
        sha256 = "726365cdebd7b9b35ff2f4f8dd7a5adaeb54d544182943377db6b2c61a6705e9",
        core_files = {
            "netcoreapp2.0": [
                "runtimes/fedora.23-x64/native/System.Security.Cryptography.Native.OpenSsl.so",
            ],
            "netcoreapp2.1": [
                "runtimes/fedora.23-x64/native/System.Security.Cryptography.Native.OpenSsl.so",
            ],
            "netcoreapp2.2": [
                "runtimes/fedora.23-x64/native/System.Security.Cryptography.Native.OpenSsl.so",
            ],
            "netcoreapp3.0": [
                "runtimes/fedora.23-x64/native/System.Security.Cryptography.Native.OpenSsl.so",
            ],
            "netcoreapp3.1": [
                "runtimes/fedora.23-x64/native/System.Security.Cryptography.Native.OpenSsl.so",
            ],
            "net5.0": [
                "runtimes/fedora.23-x64/native/System.Security.Cryptography.Native.OpenSsl.so",
            ],
        },
    )
    nuget_package(
        name = "paket2bazel.runtime.fedora.24-x64.runtime.native.system.security.cryptography.openssl",
        package = "runtime.fedora.24-x64.runtime.native.system.security.cryptography.openssl",
        version = "4.3.3",
        sha256 = "85e10f089aa59f07caf932ea762d0807b09c3aa3c743eea3a8a24b49f5341ac7",
        core_files = {
            "netcoreapp2.0": [
                "runtimes/fedora.24-x64/native/System.Security.Cryptography.Native.OpenSsl.so",
            ],
            "netcoreapp2.1": [
                "runtimes/fedora.24-x64/native/System.Security.Cryptography.Native.OpenSsl.so",
            ],
            "netcoreapp2.2": [
                "runtimes/fedora.24-x64/native/System.Security.Cryptography.Native.OpenSsl.so",
            ],
            "netcoreapp3.0": [
                "runtimes/fedora.24-x64/native/System.Security.Cryptography.Native.OpenSsl.so",
            ],
            "netcoreapp3.1": [
                "runtimes/fedora.24-x64/native/System.Security.Cryptography.Native.OpenSsl.so",
            ],
            "net5.0": [
                "runtimes/fedora.24-x64/native/System.Security.Cryptography.Native.OpenSsl.so",
            ],
        },
    )
    nuget_package(
        name = "paket2bazel.runtime.fedora.27-x64.runtime.native.system.security.cryptography.openssl",
        package = "runtime.fedora.27-x64.runtime.native.system.security.cryptography.openssl",
        version = "4.3.3",
        sha256 = "8c986e3cd983a6259842668726fc11748b7d87eb8b490736abaab4773870f0ae",
        core_files = {
            "netcoreapp2.0": [
                "runtimes/fedora.27-x64/native/System.Security.Cryptography.Native.OpenSsl.so",
            ],
            "netcoreapp2.1": [
                "runtimes/fedora.27-x64/native/System.Security.Cryptography.Native.OpenSsl.so",
            ],
            "netcoreapp2.2": [
                "runtimes/fedora.27-x64/native/System.Security.Cryptography.Native.OpenSsl.so",
            ],
            "netcoreapp3.0": [
                "runtimes/fedora.27-x64/native/System.Security.Cryptography.Native.OpenSsl.so",
            ],
            "netcoreapp3.1": [
                "runtimes/fedora.27-x64/native/System.Security.Cryptography.Native.OpenSsl.so",
            ],
            "net5.0": [
                "runtimes/fedora.27-x64/native/System.Security.Cryptography.Native.OpenSsl.so",
            ],
        },
    )
    nuget_package(
        name = "paket2bazel.runtime.fedora.28-x64.runtime.native.system.security.cryptography.openssl",
        package = "runtime.fedora.28-x64.runtime.native.system.security.cryptography.openssl",
        version = "4.3.3",
        sha256 = "36bf1cdfedaeac6d1e3ededf16b920fe25a8202ca98a95de473f99c2cfdac9a3",
        core_files = {
            "netcoreapp2.0": [
                "runtimes/fedora.28-x64/native/System.Security.Cryptography.Native.OpenSsl.so",
            ],
            "netcoreapp2.1": [
                "runtimes/fedora.28-x64/native/System.Security.Cryptography.Native.OpenSsl.so",
            ],
            "netcoreapp2.2": [
                "runtimes/fedora.28-x64/native/System.Security.Cryptography.Native.OpenSsl.so",
            ],
            "netcoreapp3.0": [
                "runtimes/fedora.28-x64/native/System.Security.Cryptography.Native.OpenSsl.so",
            ],
            "netcoreapp3.1": [
                "runtimes/fedora.28-x64/native/System.Security.Cryptography.Native.OpenSsl.so",
            ],
            "net5.0": [
                "runtimes/fedora.28-x64/native/System.Security.Cryptography.Native.OpenSsl.so",
            ],
        },
    )
    nuget_package(
        name = "paket2bazel.runtime.native.system",
        package = "runtime.native.system",
        version = "4.3.1",
        sha256 = "133c678bcfff928e17e7552b7f3fdcadbd3e76a59fab8e9e66f572b744b4b6ca",
        core_deps = {
            "netcoreapp2.0": [
                "@paket2bazel.microsoft.netcore.platforms//:lib",
                "@paket2bazel.microsoft.netcore.targets//:lib",
            ],
            "netcoreapp2.1": [
                "@paket2bazel.microsoft.netcore.platforms//:lib",
                "@paket2bazel.microsoft.netcore.targets//:lib",
            ],
            "netcoreapp2.2": [
                "@paket2bazel.microsoft.netcore.platforms//:lib",
                "@paket2bazel.microsoft.netcore.targets//:lib",
            ],
            "netcoreapp3.0": [
                "@paket2bazel.microsoft.netcore.platforms//:lib",
                "@paket2bazel.microsoft.netcore.targets//:lib",
            ],
            "netcoreapp3.1": [
                "@paket2bazel.microsoft.netcore.platforms//:lib",
                "@paket2bazel.microsoft.netcore.targets//:lib",
            ],
            "net5.0": [
                "@paket2bazel.microsoft.netcore.platforms//:lib",
                "@paket2bazel.microsoft.netcore.targets//:lib",
            ],
        },
    )
    nuget_package(
        name = "paket2bazel.runtime.native.system.net.http",
        package = "runtime.native.system.net.http",
        version = "4.3.1",
        sha256 = "4bc9a616992c8681b50fa560a6a57a5259a3af5941634e4812fba4deb285ca46",
        core_deps = {
            "netcoreapp2.0": [
                "@paket2bazel.microsoft.netcore.platforms//:lib",
                "@paket2bazel.microsoft.netcore.targets//:lib",
            ],
            "netcoreapp2.1": [
                "@paket2bazel.microsoft.netcore.platforms//:lib",
                "@paket2bazel.microsoft.netcore.targets//:lib",
            ],
            "netcoreapp2.2": [
                "@paket2bazel.microsoft.netcore.platforms//:lib",
                "@paket2bazel.microsoft.netcore.targets//:lib",
            ],
            "netcoreapp3.0": [
                "@paket2bazel.microsoft.netcore.platforms//:lib",
                "@paket2bazel.microsoft.netcore.targets//:lib",
            ],
            "netcoreapp3.1": [
                "@paket2bazel.microsoft.netcore.platforms//:lib",
                "@paket2bazel.microsoft.netcore.targets//:lib",
            ],
            "net5.0": [
                "@paket2bazel.microsoft.netcore.platforms//:lib",
                "@paket2bazel.microsoft.netcore.targets//:lib",
            ],
        },
    )
    nuget_package(
        name = "paket2bazel.runtime.native.system.security.cryptography.apple",
        package = "runtime.native.system.security.cryptography.apple",
        version = "4.3.1",
        sha256 = "32dd90023347e672a7c296f2a147b63be127f7b08ff381101684b70a49985c03",
        core_deps = {
            "netcoreapp2.0": [
                "@paket2bazel.runtime.osx.10.10-x64.runtime.native.system.security.cryptography.apple//:lib",
            ],
            "netcoreapp2.1": [
                "@paket2bazel.runtime.osx.10.10-x64.runtime.native.system.security.cryptography.apple//:lib",
            ],
            "netcoreapp2.2": [
                "@paket2bazel.runtime.osx.10.10-x64.runtime.native.system.security.cryptography.apple//:lib",
            ],
            "netcoreapp3.0": [
                "@paket2bazel.runtime.osx.10.10-x64.runtime.native.system.security.cryptography.apple//:lib",
            ],
            "netcoreapp3.1": [
                "@paket2bazel.runtime.osx.10.10-x64.runtime.native.system.security.cryptography.apple//:lib",
            ],
            "net5.0": [
                "@paket2bazel.runtime.osx.10.10-x64.runtime.native.system.security.cryptography.apple//:lib",
            ],
        },
    )
    nuget_package(
        name = "paket2bazel.runtime.native.system.security.cryptography.openssl",
        package = "runtime.native.system.security.cryptography.openssl",
        version = "4.3.3",
        sha256 = "ae9da242c639765de3b7d427c373647b14eacca3414b128f1babadb1fe0a8344",
        core_deps = {
            "netcoreapp2.0": [
                "@paket2bazel.runtime.debian.8-x64.runtime.native.system.security.cryptography.openssl//:lib",
                "@paket2bazel.runtime.debian.9-x64.runtime.native.system.security.cryptography.openssl//:lib",
                "@paket2bazel.runtime.fedora.23-x64.runtime.native.system.security.cryptography.openssl//:lib",
                "@paket2bazel.runtime.fedora.24-x64.runtime.native.system.security.cryptography.openssl//:lib",
                "@paket2bazel.runtime.fedora.27-x64.runtime.native.system.security.cryptography.openssl//:lib",
                "@paket2bazel.runtime.fedora.28-x64.runtime.native.system.security.cryptography.openssl//:lib",
                "@paket2bazel.runtime.opensuse.13.2-x64.runtime.native.system.security.cryptography.openssl//:lib",
                "@paket2bazel.runtime.opensuse.42.1-x64.runtime.native.system.security.cryptography.openssl//:lib",
                "@paket2bazel.runtime.opensuse.42.3-x64.runtime.native.system.security.cryptography.openssl//:lib",
                "@paket2bazel.runtime.osx.10.10-x64.runtime.native.system.security.cryptography.openssl//:lib",
                "@paket2bazel.runtime.rhel.7-x64.runtime.native.system.security.cryptography.openssl//:lib",
                "@paket2bazel.runtime.ubuntu.14.04-x64.runtime.native.system.security.cryptography.openssl//:lib",
                "@paket2bazel.runtime.ubuntu.16.04-x64.runtime.native.system.security.cryptography.openssl//:lib",
                "@paket2bazel.runtime.ubuntu.16.10-x64.runtime.native.system.security.cryptography.openssl//:lib",
                "@paket2bazel.runtime.ubuntu.18.04-x64.runtime.native.system.security.cryptography.openssl//:lib",
            ],
            "netcoreapp2.1": [
                "@paket2bazel.runtime.debian.8-x64.runtime.native.system.security.cryptography.openssl//:lib",
                "@paket2bazel.runtime.debian.9-x64.runtime.native.system.security.cryptography.openssl//:lib",
                "@paket2bazel.runtime.fedora.23-x64.runtime.native.system.security.cryptography.openssl//:lib",
                "@paket2bazel.runtime.fedora.24-x64.runtime.native.system.security.cryptography.openssl//:lib",
                "@paket2bazel.runtime.fedora.27-x64.runtime.native.system.security.cryptography.openssl//:lib",
                "@paket2bazel.runtime.fedora.28-x64.runtime.native.system.security.cryptography.openssl//:lib",
                "@paket2bazel.runtime.opensuse.13.2-x64.runtime.native.system.security.cryptography.openssl//:lib",
                "@paket2bazel.runtime.opensuse.42.1-x64.runtime.native.system.security.cryptography.openssl//:lib",
                "@paket2bazel.runtime.opensuse.42.3-x64.runtime.native.system.security.cryptography.openssl//:lib",
                "@paket2bazel.runtime.osx.10.10-x64.runtime.native.system.security.cryptography.openssl//:lib",
                "@paket2bazel.runtime.rhel.7-x64.runtime.native.system.security.cryptography.openssl//:lib",
                "@paket2bazel.runtime.ubuntu.14.04-x64.runtime.native.system.security.cryptography.openssl//:lib",
                "@paket2bazel.runtime.ubuntu.16.04-x64.runtime.native.system.security.cryptography.openssl//:lib",
                "@paket2bazel.runtime.ubuntu.16.10-x64.runtime.native.system.security.cryptography.openssl//:lib",
                "@paket2bazel.runtime.ubuntu.18.04-x64.runtime.native.system.security.cryptography.openssl//:lib",
            ],
            "netcoreapp2.2": [
                "@paket2bazel.runtime.debian.8-x64.runtime.native.system.security.cryptography.openssl//:lib",
                "@paket2bazel.runtime.debian.9-x64.runtime.native.system.security.cryptography.openssl//:lib",
                "@paket2bazel.runtime.fedora.23-x64.runtime.native.system.security.cryptography.openssl//:lib",
                "@paket2bazel.runtime.fedora.24-x64.runtime.native.system.security.cryptography.openssl//:lib",
                "@paket2bazel.runtime.fedora.27-x64.runtime.native.system.security.cryptography.openssl//:lib",
                "@paket2bazel.runtime.fedora.28-x64.runtime.native.system.security.cryptography.openssl//:lib",
                "@paket2bazel.runtime.opensuse.13.2-x64.runtime.native.system.security.cryptography.openssl//:lib",
                "@paket2bazel.runtime.opensuse.42.1-x64.runtime.native.system.security.cryptography.openssl//:lib",
                "@paket2bazel.runtime.opensuse.42.3-x64.runtime.native.system.security.cryptography.openssl//:lib",
                "@paket2bazel.runtime.osx.10.10-x64.runtime.native.system.security.cryptography.openssl//:lib",
                "@paket2bazel.runtime.rhel.7-x64.runtime.native.system.security.cryptography.openssl//:lib",
                "@paket2bazel.runtime.ubuntu.14.04-x64.runtime.native.system.security.cryptography.openssl//:lib",
                "@paket2bazel.runtime.ubuntu.16.04-x64.runtime.native.system.security.cryptography.openssl//:lib",
                "@paket2bazel.runtime.ubuntu.16.10-x64.runtime.native.system.security.cryptography.openssl//:lib",
                "@paket2bazel.runtime.ubuntu.18.04-x64.runtime.native.system.security.cryptography.openssl//:lib",
            ],
            "netcoreapp3.0": [
                "@paket2bazel.runtime.debian.8-x64.runtime.native.system.security.cryptography.openssl//:lib",
                "@paket2bazel.runtime.debian.9-x64.runtime.native.system.security.cryptography.openssl//:lib",
                "@paket2bazel.runtime.fedora.23-x64.runtime.native.system.security.cryptography.openssl//:lib",
                "@paket2bazel.runtime.fedora.24-x64.runtime.native.system.security.cryptography.openssl//:lib",
                "@paket2bazel.runtime.fedora.27-x64.runtime.native.system.security.cryptography.openssl//:lib",
                "@paket2bazel.runtime.fedora.28-x64.runtime.native.system.security.cryptography.openssl//:lib",
                "@paket2bazel.runtime.opensuse.13.2-x64.runtime.native.system.security.cryptography.openssl//:lib",
                "@paket2bazel.runtime.opensuse.42.1-x64.runtime.native.system.security.cryptography.openssl//:lib",
                "@paket2bazel.runtime.opensuse.42.3-x64.runtime.native.system.security.cryptography.openssl//:lib",
                "@paket2bazel.runtime.osx.10.10-x64.runtime.native.system.security.cryptography.openssl//:lib",
                "@paket2bazel.runtime.rhel.7-x64.runtime.native.system.security.cryptography.openssl//:lib",
                "@paket2bazel.runtime.ubuntu.14.04-x64.runtime.native.system.security.cryptography.openssl//:lib",
                "@paket2bazel.runtime.ubuntu.16.04-x64.runtime.native.system.security.cryptography.openssl//:lib",
                "@paket2bazel.runtime.ubuntu.16.10-x64.runtime.native.system.security.cryptography.openssl//:lib",
                "@paket2bazel.runtime.ubuntu.18.04-x64.runtime.native.system.security.cryptography.openssl//:lib",
            ],
            "netcoreapp3.1": [
                "@paket2bazel.runtime.debian.8-x64.runtime.native.system.security.cryptography.openssl//:lib",
                "@paket2bazel.runtime.debian.9-x64.runtime.native.system.security.cryptography.openssl//:lib",
                "@paket2bazel.runtime.fedora.23-x64.runtime.native.system.security.cryptography.openssl//:lib",
                "@paket2bazel.runtime.fedora.24-x64.runtime.native.system.security.cryptography.openssl//:lib",
                "@paket2bazel.runtime.fedora.27-x64.runtime.native.system.security.cryptography.openssl//:lib",
                "@paket2bazel.runtime.fedora.28-x64.runtime.native.system.security.cryptography.openssl//:lib",
                "@paket2bazel.runtime.opensuse.13.2-x64.runtime.native.system.security.cryptography.openssl//:lib",
                "@paket2bazel.runtime.opensuse.42.1-x64.runtime.native.system.security.cryptography.openssl//:lib",
                "@paket2bazel.runtime.opensuse.42.3-x64.runtime.native.system.security.cryptography.openssl//:lib",
                "@paket2bazel.runtime.osx.10.10-x64.runtime.native.system.security.cryptography.openssl//:lib",
                "@paket2bazel.runtime.rhel.7-x64.runtime.native.system.security.cryptography.openssl//:lib",
                "@paket2bazel.runtime.ubuntu.14.04-x64.runtime.native.system.security.cryptography.openssl//:lib",
                "@paket2bazel.runtime.ubuntu.16.04-x64.runtime.native.system.security.cryptography.openssl//:lib",
                "@paket2bazel.runtime.ubuntu.16.10-x64.runtime.native.system.security.cryptography.openssl//:lib",
                "@paket2bazel.runtime.ubuntu.18.04-x64.runtime.native.system.security.cryptography.openssl//:lib",
            ],
            "net5.0": [
                "@paket2bazel.runtime.debian.8-x64.runtime.native.system.security.cryptography.openssl//:lib",
                "@paket2bazel.runtime.debian.9-x64.runtime.native.system.security.cryptography.openssl//:lib",
                "@paket2bazel.runtime.fedora.23-x64.runtime.native.system.security.cryptography.openssl//:lib",
                "@paket2bazel.runtime.fedora.24-x64.runtime.native.system.security.cryptography.openssl//:lib",
                "@paket2bazel.runtime.fedora.27-x64.runtime.native.system.security.cryptography.openssl//:lib",
                "@paket2bazel.runtime.fedora.28-x64.runtime.native.system.security.cryptography.openssl//:lib",
                "@paket2bazel.runtime.opensuse.13.2-x64.runtime.native.system.security.cryptography.openssl//:lib",
                "@paket2bazel.runtime.opensuse.42.1-x64.runtime.native.system.security.cryptography.openssl//:lib",
                "@paket2bazel.runtime.opensuse.42.3-x64.runtime.native.system.security.cryptography.openssl//:lib",
                "@paket2bazel.runtime.osx.10.10-x64.runtime.native.system.security.cryptography.openssl//:lib",
                "@paket2bazel.runtime.rhel.7-x64.runtime.native.system.security.cryptography.openssl//:lib",
                "@paket2bazel.runtime.ubuntu.14.04-x64.runtime.native.system.security.cryptography.openssl//:lib",
                "@paket2bazel.runtime.ubuntu.16.04-x64.runtime.native.system.security.cryptography.openssl//:lib",
                "@paket2bazel.runtime.ubuntu.16.10-x64.runtime.native.system.security.cryptography.openssl//:lib",
                "@paket2bazel.runtime.ubuntu.18.04-x64.runtime.native.system.security.cryptography.openssl//:lib",
            ],
        },
    )
    nuget_package(
        name = "paket2bazel.runtime.opensuse.13.2-x64.runtime.native.system.security.cryptography.openssl",
        package = "runtime.opensuse.13.2-x64.runtime.native.system.security.cryptography.openssl",
        version = "4.3.3",
        sha256 = "51515175fd409b66f06f6560bb9cd8fa9c7ad228d8676c202a53e9c50a53f103",
        core_files = {
            "netcoreapp2.0": [
                "runtimes/opensuse.13.2-x64/native/System.Security.Cryptography.Native.OpenSsl.so",
            ],
            "netcoreapp2.1": [
                "runtimes/opensuse.13.2-x64/native/System.Security.Cryptography.Native.OpenSsl.so",
            ],
            "netcoreapp2.2": [
                "runtimes/opensuse.13.2-x64/native/System.Security.Cryptography.Native.OpenSsl.so",
            ],
            "netcoreapp3.0": [
                "runtimes/opensuse.13.2-x64/native/System.Security.Cryptography.Native.OpenSsl.so",
            ],
            "netcoreapp3.1": [
                "runtimes/opensuse.13.2-x64/native/System.Security.Cryptography.Native.OpenSsl.so",
            ],
            "net5.0": [
                "runtimes/opensuse.13.2-x64/native/System.Security.Cryptography.Native.OpenSsl.so",
            ],
        },
    )
    nuget_package(
        name = "paket2bazel.runtime.opensuse.42.1-x64.runtime.native.system.security.cryptography.openssl",
        package = "runtime.opensuse.42.1-x64.runtime.native.system.security.cryptography.openssl",
        version = "4.3.3",
        sha256 = "6d35285e7510d325083bb3c9a124aa3e0a907b75689644ab65e42d5dbe4e2e35",
        core_files = {
            "netcoreapp2.0": [
                "runtimes/opensuse.42.1-x64/native/System.Security.Cryptography.Native.OpenSsl.so",
            ],
            "netcoreapp2.1": [
                "runtimes/opensuse.42.1-x64/native/System.Security.Cryptography.Native.OpenSsl.so",
            ],
            "netcoreapp2.2": [
                "runtimes/opensuse.42.1-x64/native/System.Security.Cryptography.Native.OpenSsl.so",
            ],
            "netcoreapp3.0": [
                "runtimes/opensuse.42.1-x64/native/System.Security.Cryptography.Native.OpenSsl.so",
            ],
            "netcoreapp3.1": [
                "runtimes/opensuse.42.1-x64/native/System.Security.Cryptography.Native.OpenSsl.so",
            ],
            "net5.0": [
                "runtimes/opensuse.42.1-x64/native/System.Security.Cryptography.Native.OpenSsl.so",
            ],
        },
    )
    nuget_package(
        name = "paket2bazel.runtime.opensuse.42.3-x64.runtime.native.system.security.cryptography.openssl",
        package = "runtime.opensuse.42.3-x64.runtime.native.system.security.cryptography.openssl",
        version = "4.3.3",
        sha256 = "5462fd9ef60230e1c0825e8aea7197fa58e1441722d0079fedb0192d2034bbe4",
        core_files = {
            "netcoreapp2.0": [
                "runtimes/opensuse.42.3-x64/native/System.Security.Cryptography.Native.OpenSsl.so",
            ],
            "netcoreapp2.1": [
                "runtimes/opensuse.42.3-x64/native/System.Security.Cryptography.Native.OpenSsl.so",
            ],
            "netcoreapp2.2": [
                "runtimes/opensuse.42.3-x64/native/System.Security.Cryptography.Native.OpenSsl.so",
            ],
            "netcoreapp3.0": [
                "runtimes/opensuse.42.3-x64/native/System.Security.Cryptography.Native.OpenSsl.so",
            ],
            "netcoreapp3.1": [
                "runtimes/opensuse.42.3-x64/native/System.Security.Cryptography.Native.OpenSsl.so",
            ],
            "net5.0": [
                "runtimes/opensuse.42.3-x64/native/System.Security.Cryptography.Native.OpenSsl.so",
            ],
        },
    )
    nuget_package(
        name = "paket2bazel.runtime.osx.10.10-x64.runtime.native.system.security.cryptography.apple",
        package = "runtime.osx.10.10-x64.runtime.native.system.security.cryptography.apple",
        version = "4.3.1",
        sha256 = "279447cd221f52cd34d4db18f36f995e7d1922abb1f9a2ef63bb83b978d177c5",
        core_files = {
            "netcoreapp2.0": [
                "runtimes/osx.10.10-x64/native/System.Security.Cryptography.Native.Apple.dylib",
            ],
            "netcoreapp2.1": [
                "runtimes/osx.10.10-x64/native/System.Security.Cryptography.Native.Apple.dylib",
            ],
            "netcoreapp2.2": [
                "runtimes/osx.10.10-x64/native/System.Security.Cryptography.Native.Apple.dylib",
            ],
            "netcoreapp3.0": [
                "runtimes/osx.10.10-x64/native/System.Security.Cryptography.Native.Apple.dylib",
            ],
            "netcoreapp3.1": [
                "runtimes/osx.10.10-x64/native/System.Security.Cryptography.Native.Apple.dylib",
            ],
            "net5.0": [
                "runtimes/osx.10.10-x64/native/System.Security.Cryptography.Native.Apple.dylib",
            ],
        },
    )
    nuget_package(
        name = "paket2bazel.runtime.osx.10.10-x64.runtime.native.system.security.cryptography.openssl",
        package = "runtime.osx.10.10-x64.runtime.native.system.security.cryptography.openssl",
        version = "4.3.3",
        sha256 = "ef8d07da8d45dc73fe039867870b7509c983061fb80988ba95dd80feb1436d63",
        core_files = {
            "netcoreapp2.0": [
                "runtimes/osx.10.10-x64/native/System.Security.Cryptography.Native.OpenSsl.dylib",
            ],
            "netcoreapp2.1": [
                "runtimes/osx.10.10-x64/native/System.Security.Cryptography.Native.OpenSsl.dylib",
            ],
            "netcoreapp2.2": [
                "runtimes/osx.10.10-x64/native/System.Security.Cryptography.Native.OpenSsl.dylib",
            ],
            "netcoreapp3.0": [
                "runtimes/osx.10.10-x64/native/System.Security.Cryptography.Native.OpenSsl.dylib",
            ],
            "netcoreapp3.1": [
                "runtimes/osx.10.10-x64/native/System.Security.Cryptography.Native.OpenSsl.dylib",
            ],
            "net5.0": [
                "runtimes/osx.10.10-x64/native/System.Security.Cryptography.Native.OpenSsl.dylib",
            ],
        },
    )
    nuget_package(
        name = "paket2bazel.runtime.rhel.7-x64.runtime.native.system.security.cryptography.openssl",
        package = "runtime.rhel.7-x64.runtime.native.system.security.cryptography.openssl",
        version = "4.3.3",
        sha256 = "5e4e76d53ea9a429275beb232d95061d620dc1b79df7417a39b6111f8190e7cb",
        core_files = {
            "netcoreapp2.0": [
                "runtimes/rhel.7-x64/native/System.Security.Cryptography.Native.OpenSsl.so",
            ],
            "netcoreapp2.1": [
                "runtimes/rhel.7-x64/native/System.Security.Cryptography.Native.OpenSsl.so",
            ],
            "netcoreapp2.2": [
                "runtimes/rhel.7-x64/native/System.Security.Cryptography.Native.OpenSsl.so",
            ],
            "netcoreapp3.0": [
                "runtimes/rhel.7-x64/native/System.Security.Cryptography.Native.OpenSsl.so",
            ],
            "netcoreapp3.1": [
                "runtimes/rhel.7-x64/native/System.Security.Cryptography.Native.OpenSsl.so",
            ],
            "net5.0": [
                "runtimes/rhel.7-x64/native/System.Security.Cryptography.Native.OpenSsl.so",
            ],
        },
    )
    nuget_package(
        name = "paket2bazel.runtime.ubuntu.14.04-x64.runtime.native.system.security.cryptography.openssl",
        package = "runtime.ubuntu.14.04-x64.runtime.native.system.security.cryptography.openssl",
        version = "4.3.3",
        sha256 = "1d119746775d13c3b701a648a49b64e16324bde53a551975786959d7700a7b0a",
        core_files = {
            "netcoreapp2.0": [
                "runtimes/ubuntu.14.04-x64/native/System.Security.Cryptography.Native.OpenSsl.so",
            ],
            "netcoreapp2.1": [
                "runtimes/ubuntu.14.04-x64/native/System.Security.Cryptography.Native.OpenSsl.so",
            ],
            "netcoreapp2.2": [
                "runtimes/ubuntu.14.04-x64/native/System.Security.Cryptography.Native.OpenSsl.so",
            ],
            "netcoreapp3.0": [
                "runtimes/ubuntu.14.04-x64/native/System.Security.Cryptography.Native.OpenSsl.so",
            ],
            "netcoreapp3.1": [
                "runtimes/ubuntu.14.04-x64/native/System.Security.Cryptography.Native.OpenSsl.so",
            ],
            "net5.0": [
                "runtimes/ubuntu.14.04-x64/native/System.Security.Cryptography.Native.OpenSsl.so",
            ],
        },
    )
    nuget_package(
        name = "paket2bazel.runtime.ubuntu.16.04-x64.runtime.native.system.security.cryptography.openssl",
        package = "runtime.ubuntu.16.04-x64.runtime.native.system.security.cryptography.openssl",
        version = "4.3.3",
        sha256 = "657b6f94ad52b647b6d8f9dcf17767a4f97dd1ebf4efc967a62b97c2d417a730",
        core_files = {
            "netcoreapp2.0": [
                "runtimes/ubuntu.16.04-x64/native/System.Security.Cryptography.Native.OpenSsl.so",
            ],
            "netcoreapp2.1": [
                "runtimes/ubuntu.16.04-x64/native/System.Security.Cryptography.Native.OpenSsl.so",
            ],
            "netcoreapp2.2": [
                "runtimes/ubuntu.16.04-x64/native/System.Security.Cryptography.Native.OpenSsl.so",
            ],
            "netcoreapp3.0": [
                "runtimes/ubuntu.16.04-x64/native/System.Security.Cryptography.Native.OpenSsl.so",
            ],
            "netcoreapp3.1": [
                "runtimes/ubuntu.16.04-x64/native/System.Security.Cryptography.Native.OpenSsl.so",
            ],
            "net5.0": [
                "runtimes/ubuntu.16.04-x64/native/System.Security.Cryptography.Native.OpenSsl.so",
            ],
        },
    )
    nuget_package(
        name = "paket2bazel.runtime.ubuntu.16.10-x64.runtime.native.system.security.cryptography.openssl",
        package = "runtime.ubuntu.16.10-x64.runtime.native.system.security.cryptography.openssl",
        version = "4.3.3",
        sha256 = "49ec992ccbfd185c6fb7d6e599f4c0b9670c35cf9d2f4c613029b6c14b0754ad",
        core_files = {
            "netcoreapp2.0": [
                "runtimes/ubuntu.16.10-x64/native/System.Security.Cryptography.Native.OpenSsl.so",
            ],
            "netcoreapp2.1": [
                "runtimes/ubuntu.16.10-x64/native/System.Security.Cryptography.Native.OpenSsl.so",
            ],
            "netcoreapp2.2": [
                "runtimes/ubuntu.16.10-x64/native/System.Security.Cryptography.Native.OpenSsl.so",
            ],
            "netcoreapp3.0": [
                "runtimes/ubuntu.16.10-x64/native/System.Security.Cryptography.Native.OpenSsl.so",
            ],
            "netcoreapp3.1": [
                "runtimes/ubuntu.16.10-x64/native/System.Security.Cryptography.Native.OpenSsl.so",
            ],
            "net5.0": [
                "runtimes/ubuntu.16.10-x64/native/System.Security.Cryptography.Native.OpenSsl.so",
            ],
        },
    )
    nuget_package(
        name = "paket2bazel.runtime.ubuntu.18.04-x64.runtime.native.system.security.cryptography.openssl",
        package = "runtime.ubuntu.18.04-x64.runtime.native.system.security.cryptography.openssl",
        version = "4.3.3",
        sha256 = "ce11b56e6f108f52385ee620d38ee9dde148dfa42b06a5464536fe810a02446f",
        core_files = {
            "netcoreapp2.0": [
                "runtimes/ubuntu.18.04-x64/native/System.Security.Cryptography.Native.OpenSsl.so",
            ],
            "netcoreapp2.1": [
                "runtimes/ubuntu.18.04-x64/native/System.Security.Cryptography.Native.OpenSsl.so",
            ],
            "netcoreapp2.2": [
                "runtimes/ubuntu.18.04-x64/native/System.Security.Cryptography.Native.OpenSsl.so",
            ],
            "netcoreapp3.0": [
                "runtimes/ubuntu.18.04-x64/native/System.Security.Cryptography.Native.OpenSsl.so",
            ],
            "netcoreapp3.1": [
                "runtimes/ubuntu.18.04-x64/native/System.Security.Cryptography.Native.OpenSsl.so",
            ],
            "net5.0": [
                "runtimes/ubuntu.18.04-x64/native/System.Security.Cryptography.Native.OpenSsl.so",
            ],
        },
    )
    nuget_package(
        name = "paket2bazel.system.collections",
        package = "system.collections",
        version = "4.3.0",
        sha256 = "69f63b554b43eb0ff9998aab71ef2442bbc321f4b61970c834387bdc88f124a7",
        core_deps = {
            "netcoreapp2.0": [
                "@paket2bazel.microsoft.netcore.platforms//:lib",
                "@paket2bazel.microsoft.netcore.targets//:lib",
                "@paket2bazel.system.runtime//:lib",
            ],
            "netcoreapp2.1": [
                "@paket2bazel.microsoft.netcore.platforms//:lib",
                "@paket2bazel.microsoft.netcore.targets//:lib",
                "@paket2bazel.system.runtime//:lib",
            ],
            "netcoreapp2.2": [
                "@paket2bazel.microsoft.netcore.platforms//:lib",
                "@paket2bazel.microsoft.netcore.targets//:lib",
                "@paket2bazel.system.runtime//:lib",
            ],
            "netcoreapp3.0": [
                "@paket2bazel.microsoft.netcore.platforms//:lib",
                "@paket2bazel.microsoft.netcore.targets//:lib",
                "@paket2bazel.system.runtime//:lib",
            ],
            "netcoreapp3.1": [
                "@paket2bazel.microsoft.netcore.platforms//:lib",
                "@paket2bazel.microsoft.netcore.targets//:lib",
                "@paket2bazel.system.runtime//:lib",
            ],
            "net5.0": [
                "@paket2bazel.microsoft.netcore.platforms//:lib",
                "@paket2bazel.microsoft.netcore.targets//:lib",
                "@paket2bazel.system.runtime//:lib",
            ],
        },
    )
    nuget_package(
        name = "paket2bazel.system.collections.concurrent",
        package = "system.collections.concurrent",
        version = "4.3.0",
        sha256 = "28c6390df2670de22c6b5dc3a6abf237c36445e644300167966360955a052172",
        core_lib = {
            "netcoreapp2.0": "lib/netstandard1.3/System.Collections.Concurrent.dll",
            "netcoreapp2.1": "lib/netstandard1.3/System.Collections.Concurrent.dll",
            "netcoreapp2.2": "lib/netstandard1.3/System.Collections.Concurrent.dll",
            "netcoreapp3.0": "lib/netstandard1.3/System.Collections.Concurrent.dll",
            "netcoreapp3.1": "lib/netstandard1.3/System.Collections.Concurrent.dll",
            "net5.0": "lib/netstandard1.3/System.Collections.Concurrent.dll",
        },
        core_ref = {
            "netcoreapp2.0": "lib/netstandard1.3/System.Collections.Concurrent.dll",
            "netcoreapp2.1": "lib/netstandard1.3/System.Collections.Concurrent.dll",
            "netcoreapp2.2": "lib/netstandard1.3/System.Collections.Concurrent.dll",
            "netcoreapp3.0": "lib/netstandard1.3/System.Collections.Concurrent.dll",
            "netcoreapp3.1": "lib/netstandard1.3/System.Collections.Concurrent.dll",
            "net5.0": "lib/netstandard1.3/System.Collections.Concurrent.dll",
        },
        core_deps = {
            "netcoreapp2.0": [
                "@paket2bazel.system.collections//:lib",
                "@paket2bazel.system.diagnostics.debug//:lib",
                "@paket2bazel.system.diagnostics.tracing//:lib",
                "@paket2bazel.system.globalization//:lib",
                "@paket2bazel.system.reflection//:lib",
                "@paket2bazel.system.resources.resourcemanager//:lib",
                "@paket2bazel.system.runtime//:lib",
                "@paket2bazel.system.runtime.extensions//:lib",
                "@paket2bazel.system.threading//:lib",
                "@paket2bazel.system.threading.tasks//:lib",
            ],
            "netcoreapp2.1": [
                "@paket2bazel.system.collections//:lib",
                "@paket2bazel.system.diagnostics.debug//:lib",
                "@paket2bazel.system.diagnostics.tracing//:lib",
                "@paket2bazel.system.globalization//:lib",
                "@paket2bazel.system.reflection//:lib",
                "@paket2bazel.system.resources.resourcemanager//:lib",
                "@paket2bazel.system.runtime//:lib",
                "@paket2bazel.system.runtime.extensions//:lib",
                "@paket2bazel.system.threading//:lib",
                "@paket2bazel.system.threading.tasks//:lib",
            ],
            "netcoreapp2.2": [
                "@paket2bazel.system.collections//:lib",
                "@paket2bazel.system.diagnostics.debug//:lib",
                "@paket2bazel.system.diagnostics.tracing//:lib",
                "@paket2bazel.system.globalization//:lib",
                "@paket2bazel.system.reflection//:lib",
                "@paket2bazel.system.resources.resourcemanager//:lib",
                "@paket2bazel.system.runtime//:lib",
                "@paket2bazel.system.runtime.extensions//:lib",
                "@paket2bazel.system.threading//:lib",
                "@paket2bazel.system.threading.tasks//:lib",
            ],
            "netcoreapp3.0": [
                "@paket2bazel.system.collections//:lib",
                "@paket2bazel.system.diagnostics.debug//:lib",
                "@paket2bazel.system.diagnostics.tracing//:lib",
                "@paket2bazel.system.globalization//:lib",
                "@paket2bazel.system.reflection//:lib",
                "@paket2bazel.system.resources.resourcemanager//:lib",
                "@paket2bazel.system.runtime//:lib",
                "@paket2bazel.system.runtime.extensions//:lib",
                "@paket2bazel.system.threading//:lib",
                "@paket2bazel.system.threading.tasks//:lib",
            ],
            "netcoreapp3.1": [
                "@paket2bazel.system.collections//:lib",
                "@paket2bazel.system.diagnostics.debug//:lib",
                "@paket2bazel.system.diagnostics.tracing//:lib",
                "@paket2bazel.system.globalization//:lib",
                "@paket2bazel.system.reflection//:lib",
                "@paket2bazel.system.resources.resourcemanager//:lib",
                "@paket2bazel.system.runtime//:lib",
                "@paket2bazel.system.runtime.extensions//:lib",
                "@paket2bazel.system.threading//:lib",
                "@paket2bazel.system.threading.tasks//:lib",
            ],
            "net5.0": [
                "@paket2bazel.system.collections//:lib",
                "@paket2bazel.system.diagnostics.debug//:lib",
                "@paket2bazel.system.diagnostics.tracing//:lib",
                "@paket2bazel.system.globalization//:lib",
                "@paket2bazel.system.reflection//:lib",
                "@paket2bazel.system.resources.resourcemanager//:lib",
                "@paket2bazel.system.runtime//:lib",
                "@paket2bazel.system.runtime.extensions//:lib",
                "@paket2bazel.system.threading//:lib",
                "@paket2bazel.system.threading.tasks//:lib",
            ],
        },
        core_files = {
            "netcoreapp2.0": [
                "lib/netstandard1.3/System.Collections.Concurrent.dll",
            ],
            "netcoreapp2.1": [
                "lib/netstandard1.3/System.Collections.Concurrent.dll",
            ],
            "netcoreapp2.2": [
                "lib/netstandard1.3/System.Collections.Concurrent.dll",
            ],
            "netcoreapp3.0": [
                "lib/netstandard1.3/System.Collections.Concurrent.dll",
            ],
            "netcoreapp3.1": [
                "lib/netstandard1.3/System.Collections.Concurrent.dll",
            ],
            "net5.0": [
                "lib/netstandard1.3/System.Collections.Concurrent.dll",
            ],
        },
    )
    nuget_package(
        name = "paket2bazel.system.componentmodel.composition",
        package = "system.componentmodel.composition",
        version = "6.0.0",
        sha256 = "ec9c986ea5a5d4d1d334c256d7683a4ed61f91e988e769ce9d7ece1d6be9ee9b",
        core_lib = {
            "netcoreapp2.0": "lib/netstandard2.0/System.ComponentModel.Composition.dll",
            "netcoreapp2.1": "lib/netstandard2.0/System.ComponentModel.Composition.dll",
            "netcoreapp2.2": "lib/netstandard2.0/System.ComponentModel.Composition.dll",
            "netcoreapp3.0": "lib/netstandard2.0/System.ComponentModel.Composition.dll",
            "netcoreapp3.1": "lib/netcoreapp3.1/System.ComponentModel.Composition.dll",
            "net5.0": "lib/netcoreapp3.1/System.ComponentModel.Composition.dll",
        },
        core_ref = {
            "netcoreapp2.0": "lib/netstandard2.0/System.ComponentModel.Composition.dll",
            "netcoreapp2.1": "lib/netstandard2.0/System.ComponentModel.Composition.dll",
            "netcoreapp2.2": "lib/netstandard2.0/System.ComponentModel.Composition.dll",
            "netcoreapp3.0": "lib/netstandard2.0/System.ComponentModel.Composition.dll",
            "netcoreapp3.1": "lib/netcoreapp3.1/System.ComponentModel.Composition.dll",
            "net5.0": "lib/netcoreapp3.1/System.ComponentModel.Composition.dll",
        },
        core_files = {
            "netcoreapp2.0": [
                "lib/netstandard2.0/System.ComponentModel.Composition.dll",
                "lib/netstandard2.0/System.ComponentModel.Composition.xml",
            ],
            "netcoreapp2.1": [
                "lib/netstandard2.0/System.ComponentModel.Composition.dll",
                "lib/netstandard2.0/System.ComponentModel.Composition.xml",
            ],
            "netcoreapp2.2": [
                "lib/netstandard2.0/System.ComponentModel.Composition.dll",
                "lib/netstandard2.0/System.ComponentModel.Composition.xml",
            ],
            "netcoreapp3.0": [
                "lib/netstandard2.0/System.ComponentModel.Composition.dll",
                "lib/netstandard2.0/System.ComponentModel.Composition.xml",
            ],
            "netcoreapp3.1": [
                "lib/netcoreapp3.1/System.ComponentModel.Composition.dll",
                "lib/netcoreapp3.1/System.ComponentModel.Composition.xml",
            ],
            "net5.0": [
                "lib/netcoreapp3.1/System.ComponentModel.Composition.dll",
                "lib/netcoreapp3.1/System.ComponentModel.Composition.xml",
            ],
        },
    )
    nuget_package(
        name = "paket2bazel.system.configuration.configurationmanager",
        package = "system.configuration.configurationmanager",
        version = "6.0.0",
        sha256 = "7cf57aebc09f8bef29356aef1806ab1787dec1d3d5103c25256bc9934cbe0a6b",
        core_lib = {
            "netcoreapp2.0": "lib/netstandard2.0/System.Configuration.ConfigurationManager.dll",
            "netcoreapp2.1": "lib/netstandard2.0/System.Configuration.ConfigurationManager.dll",
            "netcoreapp2.2": "lib/netstandard2.0/System.Configuration.ConfigurationManager.dll",
            "netcoreapp3.0": "lib/netstandard2.0/System.Configuration.ConfigurationManager.dll",
            "netcoreapp3.1": "lib/netstandard2.0/System.Configuration.ConfigurationManager.dll",
            "net5.0": "lib/netstandard2.0/System.Configuration.ConfigurationManager.dll",
        },
        core_ref = {
            "netcoreapp2.0": "lib/netstandard2.0/System.Configuration.ConfigurationManager.dll",
            "netcoreapp2.1": "lib/netstandard2.0/System.Configuration.ConfigurationManager.dll",
            "netcoreapp2.2": "lib/netstandard2.0/System.Configuration.ConfigurationManager.dll",
            "netcoreapp3.0": "lib/netstandard2.0/System.Configuration.ConfigurationManager.dll",
            "netcoreapp3.1": "lib/netstandard2.0/System.Configuration.ConfigurationManager.dll",
            "net5.0": "lib/netstandard2.0/System.Configuration.ConfigurationManager.dll",
        },
        core_deps = {
            "netcoreapp2.0": [
                "@paket2bazel.system.security.cryptography.protecteddata//:lib",
                "@paket2bazel.system.security.permissions//:lib",
            ],
            "netcoreapp2.1": [
                "@paket2bazel.system.security.cryptography.protecteddata//:lib",
                "@paket2bazel.system.security.permissions//:lib",
            ],
            "netcoreapp2.2": [
                "@paket2bazel.system.security.cryptography.protecteddata//:lib",
                "@paket2bazel.system.security.permissions//:lib",
            ],
            "netcoreapp3.0": [
                "@paket2bazel.system.security.cryptography.protecteddata//:lib",
                "@paket2bazel.system.security.permissions//:lib",
            ],
            "netcoreapp3.1": [
                "@paket2bazel.system.security.cryptography.protecteddata//:lib",
                "@paket2bazel.system.security.permissions//:lib",
            ],
            "net5.0": [
                "@paket2bazel.system.security.cryptography.protecteddata//:lib",
                "@paket2bazel.system.security.permissions//:lib",
            ],
        },
        core_files = {
            "netcoreapp2.0": [
                "lib/netstandard2.0/System.Configuration.ConfigurationManager.dll",
                "lib/netstandard2.0/System.Configuration.ConfigurationManager.xml",
            ],
            "netcoreapp2.1": [
                "lib/netstandard2.0/System.Configuration.ConfigurationManager.dll",
                "lib/netstandard2.0/System.Configuration.ConfigurationManager.xml",
            ],
            "netcoreapp2.2": [
                "lib/netstandard2.0/System.Configuration.ConfigurationManager.dll",
                "lib/netstandard2.0/System.Configuration.ConfigurationManager.xml",
            ],
            "netcoreapp3.0": [
                "lib/netstandard2.0/System.Configuration.ConfigurationManager.dll",
                "lib/netstandard2.0/System.Configuration.ConfigurationManager.xml",
            ],
            "netcoreapp3.1": [
                "lib/netstandard2.0/System.Configuration.ConfigurationManager.dll",
                "lib/netstandard2.0/System.Configuration.ConfigurationManager.xml",
            ],
            "net5.0": [
                "lib/netstandard2.0/System.Configuration.ConfigurationManager.dll",
                "lib/netstandard2.0/System.Configuration.ConfigurationManager.xml",
            ],
        },
    )
    nuget_package(
        name = "paket2bazel.system.diagnostics.debug",
        package = "system.diagnostics.debug",
        version = "4.3.0",
        sha256 = "7e403bf528cf6d27a211cadb6d4b1bef4bbd07bc2a6ec74cf6cd4b9e82a3d203",
        core_deps = {
            "netcoreapp2.0": [
                "@paket2bazel.microsoft.netcore.platforms//:lib",
                "@paket2bazel.microsoft.netcore.targets//:lib",
                "@paket2bazel.system.runtime//:lib",
            ],
            "netcoreapp2.1": [
                "@paket2bazel.microsoft.netcore.platforms//:lib",
                "@paket2bazel.microsoft.netcore.targets//:lib",
                "@paket2bazel.system.runtime//:lib",
            ],
            "netcoreapp2.2": [
                "@paket2bazel.microsoft.netcore.platforms//:lib",
                "@paket2bazel.microsoft.netcore.targets//:lib",
                "@paket2bazel.system.runtime//:lib",
            ],
            "netcoreapp3.0": [
                "@paket2bazel.microsoft.netcore.platforms//:lib",
                "@paket2bazel.microsoft.netcore.targets//:lib",
                "@paket2bazel.system.runtime//:lib",
            ],
            "netcoreapp3.1": [
                "@paket2bazel.microsoft.netcore.platforms//:lib",
                "@paket2bazel.microsoft.netcore.targets//:lib",
                "@paket2bazel.system.runtime//:lib",
            ],
            "net5.0": [
                "@paket2bazel.microsoft.netcore.platforms//:lib",
                "@paket2bazel.microsoft.netcore.targets//:lib",
                "@paket2bazel.system.runtime//:lib",
            ],
        },
    )
    nuget_package(
        name = "paket2bazel.system.diagnostics.diagnosticsource",
        package = "system.diagnostics.diagnosticsource",
        version = "6.0.0",
        sha256 = "458f6e5923dd2b67e04b0963d4e1c1181568dd9bc642004937302c4b93863167",
        core_lib = {
            "netcoreapp2.0": "lib/netstandard2.0/System.Diagnostics.DiagnosticSource.dll",
            "netcoreapp2.1": "lib/netstandard2.0/System.Diagnostics.DiagnosticSource.dll",
            "netcoreapp2.2": "lib/netstandard2.0/System.Diagnostics.DiagnosticSource.dll",
            "netcoreapp3.0": "lib/netstandard2.0/System.Diagnostics.DiagnosticSource.dll",
            "netcoreapp3.1": "lib/netstandard2.0/System.Diagnostics.DiagnosticSource.dll",
            "net5.0": "lib/net5.0/System.Diagnostics.DiagnosticSource.dll",
        },
        core_ref = {
            "netcoreapp2.0": "lib/netstandard2.0/System.Diagnostics.DiagnosticSource.dll",
            "netcoreapp2.1": "lib/netstandard2.0/System.Diagnostics.DiagnosticSource.dll",
            "netcoreapp2.2": "lib/netstandard2.0/System.Diagnostics.DiagnosticSource.dll",
            "netcoreapp3.0": "lib/netstandard2.0/System.Diagnostics.DiagnosticSource.dll",
            "netcoreapp3.1": "lib/netstandard2.0/System.Diagnostics.DiagnosticSource.dll",
            "net5.0": "lib/net5.0/System.Diagnostics.DiagnosticSource.dll",
        },
        core_deps = {
            "netcoreapp2.0": [
                "@paket2bazel.system.runtime.compilerservices.unsafe//:lib",
                "@paket2bazel.system.memory//:lib",
            ],
            "netcoreapp2.1": [
                "@paket2bazel.system.runtime.compilerservices.unsafe//:lib",
                "@paket2bazel.system.memory//:lib",
            ],
            "netcoreapp2.2": [
                "@paket2bazel.system.runtime.compilerservices.unsafe//:lib",
                "@paket2bazel.system.memory//:lib",
            ],
            "netcoreapp3.0": [
                "@paket2bazel.system.runtime.compilerservices.unsafe//:lib",
                "@paket2bazel.system.memory//:lib",
            ],
            "netcoreapp3.1": [
                "@paket2bazel.system.runtime.compilerservices.unsafe//:lib",
                "@paket2bazel.system.memory//:lib",
            ],
            "net5.0": [
                "@paket2bazel.system.runtime.compilerservices.unsafe//:lib",
            ],
        },
        core_files = {
            "netcoreapp2.0": [
                "lib/netstandard2.0/System.Diagnostics.DiagnosticSource.dll",
                "lib/netstandard2.0/System.Diagnostics.DiagnosticSource.xml",
            ],
            "netcoreapp2.1": [
                "lib/netstandard2.0/System.Diagnostics.DiagnosticSource.dll",
                "lib/netstandard2.0/System.Diagnostics.DiagnosticSource.xml",
            ],
            "netcoreapp2.2": [
                "lib/netstandard2.0/System.Diagnostics.DiagnosticSource.dll",
                "lib/netstandard2.0/System.Diagnostics.DiagnosticSource.xml",
            ],
            "netcoreapp3.0": [
                "lib/netstandard2.0/System.Diagnostics.DiagnosticSource.dll",
                "lib/netstandard2.0/System.Diagnostics.DiagnosticSource.xml",
            ],
            "netcoreapp3.1": [
                "lib/netstandard2.0/System.Diagnostics.DiagnosticSource.dll",
                "lib/netstandard2.0/System.Diagnostics.DiagnosticSource.xml",
            ],
            "net5.0": [
                "lib/net5.0/System.Diagnostics.DiagnosticSource.dll",
                "lib/net5.0/System.Diagnostics.DiagnosticSource.xml",
            ],
        },
    )
    nuget_package(
        name = "paket2bazel.system.diagnostics.tracing",
        package = "system.diagnostics.tracing",
        version = "4.3.0",
        sha256 = "8421136691c719584f62f6f80b47e1e33b3ef33bf818fa22c5a8242d98e96bd4",
        core_deps = {
            "netcoreapp2.0": [
                "@paket2bazel.microsoft.netcore.platforms//:lib",
                "@paket2bazel.microsoft.netcore.targets//:lib",
                "@paket2bazel.system.runtime//:lib",
            ],
            "netcoreapp2.1": [
                "@paket2bazel.microsoft.netcore.platforms//:lib",
                "@paket2bazel.microsoft.netcore.targets//:lib",
                "@paket2bazel.system.runtime//:lib",
            ],
            "netcoreapp2.2": [
                "@paket2bazel.microsoft.netcore.platforms//:lib",
                "@paket2bazel.microsoft.netcore.targets//:lib",
                "@paket2bazel.system.runtime//:lib",
            ],
            "netcoreapp3.0": [
                "@paket2bazel.microsoft.netcore.platforms//:lib",
                "@paket2bazel.microsoft.netcore.targets//:lib",
                "@paket2bazel.system.runtime//:lib",
            ],
            "netcoreapp3.1": [
                "@paket2bazel.microsoft.netcore.platforms//:lib",
                "@paket2bazel.microsoft.netcore.targets//:lib",
                "@paket2bazel.system.runtime//:lib",
            ],
            "net5.0": [
                "@paket2bazel.microsoft.netcore.platforms//:lib",
                "@paket2bazel.microsoft.netcore.targets//:lib",
                "@paket2bazel.system.runtime//:lib",
            ],
        },
    )
    nuget_package(
        name = "paket2bazel.system.drawing.common",
        package = "system.drawing.common",
        version = "6.0.0",
        sha256 = "ffd11a01b11e3a310b452319688992d4ef059947bc8f85ae154c3554eacfc80a",
        core_lib = {
            "netcoreapp2.0": "lib/netstandard2.0/System.Drawing.Common.dll",
            "netcoreapp2.1": "lib/netstandard2.0/System.Drawing.Common.dll",
            "netcoreapp2.2": "lib/netstandard2.0/System.Drawing.Common.dll",
            "netcoreapp3.0": "lib/netstandard2.0/System.Drawing.Common.dll",
            "netcoreapp3.1": "lib/netcoreapp3.1/System.Drawing.Common.dll",
            "net5.0": "lib/netcoreapp3.1/System.Drawing.Common.dll",
        },
        core_ref = {
            "netcoreapp2.0": "lib/netstandard2.0/System.Drawing.Common.dll",
            "netcoreapp2.1": "lib/netstandard2.0/System.Drawing.Common.dll",
            "netcoreapp2.2": "lib/netstandard2.0/System.Drawing.Common.dll",
            "netcoreapp3.0": "lib/netstandard2.0/System.Drawing.Common.dll",
            "netcoreapp3.1": "lib/netcoreapp3.1/System.Drawing.Common.dll",
            "net5.0": "lib/netcoreapp3.1/System.Drawing.Common.dll",
        },
        core_deps = {
            "netcoreapp3.1": [
                "@paket2bazel.microsoft.win32.systemevents//:lib",
            ],
            "net5.0": [
                "@paket2bazel.microsoft.win32.systemevents//:lib",
            ],
        },
        core_files = {
            "netcoreapp2.0": [
                "lib/netstandard2.0/System.Drawing.Common.dll",
                "lib/netstandard2.0/System.Drawing.Common.xml",
                "runtimes/unix/lib/net6.0/System.Drawing.Common.dll",
                "runtimes/unix/lib/net6.0/System.Drawing.Common.xml",
                "runtimes/unix/lib/netcoreapp3.1/System.Drawing.Common.dll",
                "runtimes/unix/lib/netcoreapp3.1/System.Drawing.Common.xml",
            ],
            "netcoreapp2.1": [
                "lib/netstandard2.0/System.Drawing.Common.dll",
                "lib/netstandard2.0/System.Drawing.Common.xml",
                "runtimes/unix/lib/net6.0/System.Drawing.Common.dll",
                "runtimes/unix/lib/net6.0/System.Drawing.Common.xml",
                "runtimes/unix/lib/netcoreapp3.1/System.Drawing.Common.dll",
                "runtimes/unix/lib/netcoreapp3.1/System.Drawing.Common.xml",
            ],
            "netcoreapp2.2": [
                "lib/netstandard2.0/System.Drawing.Common.dll",
                "lib/netstandard2.0/System.Drawing.Common.xml",
                "runtimes/unix/lib/net6.0/System.Drawing.Common.dll",
                "runtimes/unix/lib/net6.0/System.Drawing.Common.xml",
                "runtimes/unix/lib/netcoreapp3.1/System.Drawing.Common.dll",
                "runtimes/unix/lib/netcoreapp3.1/System.Drawing.Common.xml",
            ],
            "netcoreapp3.0": [
                "lib/netstandard2.0/System.Drawing.Common.dll",
                "lib/netstandard2.0/System.Drawing.Common.xml",
                "runtimes/unix/lib/net6.0/System.Drawing.Common.dll",
                "runtimes/unix/lib/net6.0/System.Drawing.Common.xml",
                "runtimes/unix/lib/netcoreapp3.1/System.Drawing.Common.dll",
                "runtimes/unix/lib/netcoreapp3.1/System.Drawing.Common.xml",
            ],
            "netcoreapp3.1": [
                "lib/netcoreapp3.1/System.Drawing.Common.dll",
                "lib/netcoreapp3.1/System.Drawing.Common.xml",
                "runtimes/unix/lib/net6.0/System.Drawing.Common.dll",
                "runtimes/unix/lib/net6.0/System.Drawing.Common.xml",
                "runtimes/unix/lib/netcoreapp3.1/System.Drawing.Common.dll",
                "runtimes/unix/lib/netcoreapp3.1/System.Drawing.Common.xml",
            ],
            "net5.0": [
                "lib/netcoreapp3.1/System.Drawing.Common.dll",
                "lib/netcoreapp3.1/System.Drawing.Common.xml",
                "runtimes/unix/lib/net6.0/System.Drawing.Common.dll",
                "runtimes/unix/lib/net6.0/System.Drawing.Common.xml",
                "runtimes/unix/lib/netcoreapp3.1/System.Drawing.Common.dll",
                "runtimes/unix/lib/netcoreapp3.1/System.Drawing.Common.xml",
            ],
        },
    )
    nuget_package(
        name = "paket2bazel.system.formats.asn1",
        package = "system.formats.asn1",
        version = "6.0.0",
        sha256 = "29a30780844117b35fdd5c0ea3e8094b50dc0fee357090cf58587e4c343c79ef",
        core_lib = {
            "netcoreapp2.0": "lib/netstandard2.0/System.Formats.Asn1.dll",
            "netcoreapp2.1": "lib/netstandard2.0/System.Formats.Asn1.dll",
            "netcoreapp2.2": "lib/netstandard2.0/System.Formats.Asn1.dll",
            "netcoreapp3.0": "lib/netstandard2.0/System.Formats.Asn1.dll",
            "netcoreapp3.1": "lib/netstandard2.0/System.Formats.Asn1.dll",
            "net5.0": "lib/netstandard2.0/System.Formats.Asn1.dll",
        },
        core_ref = {
            "netcoreapp2.0": "lib/netstandard2.0/System.Formats.Asn1.dll",
            "netcoreapp2.1": "lib/netstandard2.0/System.Formats.Asn1.dll",
            "netcoreapp2.2": "lib/netstandard2.0/System.Formats.Asn1.dll",
            "netcoreapp3.0": "lib/netstandard2.0/System.Formats.Asn1.dll",
            "netcoreapp3.1": "lib/netstandard2.0/System.Formats.Asn1.dll",
            "net5.0": "lib/netstandard2.0/System.Formats.Asn1.dll",
        },
        core_deps = {
            "netcoreapp2.0": [
                "@paket2bazel.system.buffers//:lib",
                "@paket2bazel.system.memory//:lib",
            ],
            "netcoreapp2.1": [
                "@paket2bazel.system.buffers//:lib",
                "@paket2bazel.system.memory//:lib",
            ],
            "netcoreapp2.2": [
                "@paket2bazel.system.buffers//:lib",
                "@paket2bazel.system.memory//:lib",
            ],
            "netcoreapp3.0": [
                "@paket2bazel.system.buffers//:lib",
                "@paket2bazel.system.memory//:lib",
            ],
            "netcoreapp3.1": [
                "@paket2bazel.system.buffers//:lib",
                "@paket2bazel.system.memory//:lib",
            ],
            "net5.0": [
                "@paket2bazel.system.buffers//:lib",
                "@paket2bazel.system.memory//:lib",
            ],
        },
        core_files = {
            "netcoreapp2.0": [
                "lib/netstandard2.0/System.Formats.Asn1.dll",
                "lib/netstandard2.0/System.Formats.Asn1.xml",
            ],
            "netcoreapp2.1": [
                "lib/netstandard2.0/System.Formats.Asn1.dll",
                "lib/netstandard2.0/System.Formats.Asn1.xml",
            ],
            "netcoreapp2.2": [
                "lib/netstandard2.0/System.Formats.Asn1.dll",
                "lib/netstandard2.0/System.Formats.Asn1.xml",
            ],
            "netcoreapp3.0": [
                "lib/netstandard2.0/System.Formats.Asn1.dll",
                "lib/netstandard2.0/System.Formats.Asn1.xml",
            ],
            "netcoreapp3.1": [
                "lib/netstandard2.0/System.Formats.Asn1.dll",
                "lib/netstandard2.0/System.Formats.Asn1.xml",
            ],
            "net5.0": [
                "lib/netstandard2.0/System.Formats.Asn1.dll",
                "lib/netstandard2.0/System.Formats.Asn1.xml",
            ],
        },
    )
    nuget_package(
        name = "paket2bazel.system.globalization",
        package = "system.globalization",
        version = "4.3.0",
        sha256 = "71a2f4a51985484b1aa1e65e58de414d0b46ac0b5a40fc058bc60e64f646e6b2",
        core_deps = {
            "netcoreapp2.0": [
                "@paket2bazel.microsoft.netcore.platforms//:lib",
                "@paket2bazel.microsoft.netcore.targets//:lib",
                "@paket2bazel.system.runtime//:lib",
            ],
            "netcoreapp2.1": [
                "@paket2bazel.microsoft.netcore.platforms//:lib",
                "@paket2bazel.microsoft.netcore.targets//:lib",
                "@paket2bazel.system.runtime//:lib",
            ],
            "netcoreapp2.2": [
                "@paket2bazel.microsoft.netcore.platforms//:lib",
                "@paket2bazel.microsoft.netcore.targets//:lib",
                "@paket2bazel.system.runtime//:lib",
            ],
            "netcoreapp3.0": [
                "@paket2bazel.microsoft.netcore.platforms//:lib",
                "@paket2bazel.microsoft.netcore.targets//:lib",
                "@paket2bazel.system.runtime//:lib",
            ],
            "netcoreapp3.1": [
                "@paket2bazel.microsoft.netcore.platforms//:lib",
                "@paket2bazel.microsoft.netcore.targets//:lib",
                "@paket2bazel.system.runtime//:lib",
            ],
            "net5.0": [
                "@paket2bazel.microsoft.netcore.platforms//:lib",
                "@paket2bazel.microsoft.netcore.targets//:lib",
                "@paket2bazel.system.runtime//:lib",
            ],
        },
    )
    nuget_package(
        name = "paket2bazel.system.globalization.calendars",
        package = "system.globalization.calendars",
        version = "4.3.0",
        sha256 = "b8d383d043951609d2d9f30abcc884b48f5a3b0d34f8f7f2fc7faab9c01094f7",
        core_deps = {
            "netcoreapp2.0": [
                "@paket2bazel.microsoft.netcore.platforms//:lib",
                "@paket2bazel.microsoft.netcore.targets//:lib",
                "@paket2bazel.system.globalization//:lib",
                "@paket2bazel.system.runtime//:lib",
            ],
            "netcoreapp2.1": [
                "@paket2bazel.microsoft.netcore.platforms//:lib",
                "@paket2bazel.microsoft.netcore.targets//:lib",
                "@paket2bazel.system.globalization//:lib",
                "@paket2bazel.system.runtime//:lib",
            ],
            "netcoreapp2.2": [
                "@paket2bazel.microsoft.netcore.platforms//:lib",
                "@paket2bazel.microsoft.netcore.targets//:lib",
                "@paket2bazel.system.globalization//:lib",
                "@paket2bazel.system.runtime//:lib",
            ],
            "netcoreapp3.0": [
                "@paket2bazel.microsoft.netcore.platforms//:lib",
                "@paket2bazel.microsoft.netcore.targets//:lib",
                "@paket2bazel.system.globalization//:lib",
                "@paket2bazel.system.runtime//:lib",
            ],
            "netcoreapp3.1": [
                "@paket2bazel.microsoft.netcore.platforms//:lib",
                "@paket2bazel.microsoft.netcore.targets//:lib",
                "@paket2bazel.system.globalization//:lib",
                "@paket2bazel.system.runtime//:lib",
            ],
            "net5.0": [
                "@paket2bazel.microsoft.netcore.platforms//:lib",
                "@paket2bazel.microsoft.netcore.targets//:lib",
                "@paket2bazel.system.globalization//:lib",
                "@paket2bazel.system.runtime//:lib",
            ],
        },
    )
    nuget_package(
        name = "paket2bazel.system.globalization.extensions",
        package = "system.globalization.extensions",
        version = "4.3.0",
        sha256 = "9a6256036ed3d06455b853fdfec8fee13ad1e06256af33489363c3adbafb4509",
        core_deps = {
            "netcoreapp2.0": [
                "@paket2bazel.microsoft.netcore.platforms//:lib",
                "@paket2bazel.system.globalization//:lib",
                "@paket2bazel.system.resources.resourcemanager//:lib",
                "@paket2bazel.system.runtime//:lib",
                "@paket2bazel.system.runtime.extensions//:lib",
                "@paket2bazel.system.runtime.interopservices//:lib",
            ],
            "netcoreapp2.1": [
                "@paket2bazel.microsoft.netcore.platforms//:lib",
                "@paket2bazel.system.globalization//:lib",
                "@paket2bazel.system.resources.resourcemanager//:lib",
                "@paket2bazel.system.runtime//:lib",
                "@paket2bazel.system.runtime.extensions//:lib",
                "@paket2bazel.system.runtime.interopservices//:lib",
            ],
            "netcoreapp2.2": [
                "@paket2bazel.microsoft.netcore.platforms//:lib",
                "@paket2bazel.system.globalization//:lib",
                "@paket2bazel.system.resources.resourcemanager//:lib",
                "@paket2bazel.system.runtime//:lib",
                "@paket2bazel.system.runtime.extensions//:lib",
                "@paket2bazel.system.runtime.interopservices//:lib",
            ],
            "netcoreapp3.0": [
                "@paket2bazel.microsoft.netcore.platforms//:lib",
                "@paket2bazel.system.globalization//:lib",
                "@paket2bazel.system.resources.resourcemanager//:lib",
                "@paket2bazel.system.runtime//:lib",
                "@paket2bazel.system.runtime.extensions//:lib",
                "@paket2bazel.system.runtime.interopservices//:lib",
            ],
            "netcoreapp3.1": [
                "@paket2bazel.microsoft.netcore.platforms//:lib",
                "@paket2bazel.system.globalization//:lib",
                "@paket2bazel.system.resources.resourcemanager//:lib",
                "@paket2bazel.system.runtime//:lib",
                "@paket2bazel.system.runtime.extensions//:lib",
                "@paket2bazel.system.runtime.interopservices//:lib",
            ],
            "net5.0": [
                "@paket2bazel.microsoft.netcore.platforms//:lib",
                "@paket2bazel.system.globalization//:lib",
                "@paket2bazel.system.resources.resourcemanager//:lib",
                "@paket2bazel.system.runtime//:lib",
                "@paket2bazel.system.runtime.extensions//:lib",
                "@paket2bazel.system.runtime.interopservices//:lib",
            ],
        },
        core_files = {
            "netcoreapp2.0": [
                "runtimes/unix/lib/netstandard1.3/System.Globalization.Extensions.dll",
            ],
            "netcoreapp2.1": [
                "runtimes/unix/lib/netstandard1.3/System.Globalization.Extensions.dll",
            ],
            "netcoreapp2.2": [
                "runtimes/unix/lib/netstandard1.3/System.Globalization.Extensions.dll",
            ],
            "netcoreapp3.0": [
                "runtimes/unix/lib/netstandard1.3/System.Globalization.Extensions.dll",
            ],
            "netcoreapp3.1": [
                "runtimes/unix/lib/netstandard1.3/System.Globalization.Extensions.dll",
            ],
            "net5.0": [
                "runtimes/unix/lib/netstandard1.3/System.Globalization.Extensions.dll",
            ],
        },
    )
    nuget_package(
        name = "paket2bazel.system.io",
        package = "system.io",
        version = "4.3.0",
        sha256 = "aeeca74077a414fe703eb0e257284d891217799fc8f4da632b9a54f873c38916",
        core_deps = {
            "netcoreapp2.0": [
                "@paket2bazel.microsoft.netcore.platforms//:lib",
                "@paket2bazel.microsoft.netcore.targets//:lib",
                "@paket2bazel.system.runtime//:lib",
                "@paket2bazel.system.text.encoding//:lib",
                "@paket2bazel.system.threading.tasks//:lib",
            ],
            "netcoreapp2.1": [
                "@paket2bazel.microsoft.netcore.platforms//:lib",
                "@paket2bazel.microsoft.netcore.targets//:lib",
                "@paket2bazel.system.runtime//:lib",
                "@paket2bazel.system.text.encoding//:lib",
                "@paket2bazel.system.threading.tasks//:lib",
            ],
            "netcoreapp2.2": [
                "@paket2bazel.microsoft.netcore.platforms//:lib",
                "@paket2bazel.microsoft.netcore.targets//:lib",
                "@paket2bazel.system.runtime//:lib",
                "@paket2bazel.system.text.encoding//:lib",
                "@paket2bazel.system.threading.tasks//:lib",
            ],
            "netcoreapp3.0": [
                "@paket2bazel.microsoft.netcore.platforms//:lib",
                "@paket2bazel.microsoft.netcore.targets//:lib",
                "@paket2bazel.system.runtime//:lib",
                "@paket2bazel.system.text.encoding//:lib",
                "@paket2bazel.system.threading.tasks//:lib",
            ],
            "netcoreapp3.1": [
                "@paket2bazel.microsoft.netcore.platforms//:lib",
                "@paket2bazel.microsoft.netcore.targets//:lib",
                "@paket2bazel.system.runtime//:lib",
                "@paket2bazel.system.text.encoding//:lib",
                "@paket2bazel.system.threading.tasks//:lib",
            ],
            "net5.0": [
                "@paket2bazel.microsoft.netcore.platforms//:lib",
                "@paket2bazel.microsoft.netcore.targets//:lib",
                "@paket2bazel.system.runtime//:lib",
                "@paket2bazel.system.text.encoding//:lib",
                "@paket2bazel.system.threading.tasks//:lib",
            ],
        },
    )
    nuget_package(
        name = "paket2bazel.system.io.filesystem",
        package = "system.io.filesystem",
        version = "4.3.0",
        sha256 = "bcd2189ef95acae563d167d17d82a90eb843a6d961a75a4df026269557764d7c",
        core_deps = {
            "netcoreapp2.0": [
                "@paket2bazel.microsoft.netcore.platforms//:lib",
                "@paket2bazel.microsoft.netcore.targets//:lib",
                "@paket2bazel.system.io//:lib",
                "@paket2bazel.system.io.filesystem.primitives//:lib",
                "@paket2bazel.system.runtime//:lib",
                "@paket2bazel.system.runtime.handles//:lib",
                "@paket2bazel.system.text.encoding//:lib",
                "@paket2bazel.system.threading.tasks//:lib",
            ],
            "netcoreapp2.1": [
                "@paket2bazel.microsoft.netcore.platforms//:lib",
                "@paket2bazel.microsoft.netcore.targets//:lib",
                "@paket2bazel.system.io//:lib",
                "@paket2bazel.system.io.filesystem.primitives//:lib",
                "@paket2bazel.system.runtime//:lib",
                "@paket2bazel.system.runtime.handles//:lib",
                "@paket2bazel.system.text.encoding//:lib",
                "@paket2bazel.system.threading.tasks//:lib",
            ],
            "netcoreapp2.2": [
                "@paket2bazel.microsoft.netcore.platforms//:lib",
                "@paket2bazel.microsoft.netcore.targets//:lib",
                "@paket2bazel.system.io//:lib",
                "@paket2bazel.system.io.filesystem.primitives//:lib",
                "@paket2bazel.system.runtime//:lib",
                "@paket2bazel.system.runtime.handles//:lib",
                "@paket2bazel.system.text.encoding//:lib",
                "@paket2bazel.system.threading.tasks//:lib",
            ],
            "netcoreapp3.0": [
                "@paket2bazel.microsoft.netcore.platforms//:lib",
                "@paket2bazel.microsoft.netcore.targets//:lib",
                "@paket2bazel.system.io//:lib",
                "@paket2bazel.system.io.filesystem.primitives//:lib",
                "@paket2bazel.system.runtime//:lib",
                "@paket2bazel.system.runtime.handles//:lib",
                "@paket2bazel.system.text.encoding//:lib",
                "@paket2bazel.system.threading.tasks//:lib",
            ],
            "netcoreapp3.1": [
                "@paket2bazel.microsoft.netcore.platforms//:lib",
                "@paket2bazel.microsoft.netcore.targets//:lib",
                "@paket2bazel.system.io//:lib",
                "@paket2bazel.system.io.filesystem.primitives//:lib",
                "@paket2bazel.system.runtime//:lib",
                "@paket2bazel.system.runtime.handles//:lib",
                "@paket2bazel.system.text.encoding//:lib",
                "@paket2bazel.system.threading.tasks//:lib",
            ],
            "net5.0": [
                "@paket2bazel.microsoft.netcore.platforms//:lib",
                "@paket2bazel.microsoft.netcore.targets//:lib",
                "@paket2bazel.system.io//:lib",
                "@paket2bazel.system.io.filesystem.primitives//:lib",
                "@paket2bazel.system.runtime//:lib",
                "@paket2bazel.system.runtime.handles//:lib",
                "@paket2bazel.system.text.encoding//:lib",
                "@paket2bazel.system.threading.tasks//:lib",
            ],
        },
    )
    nuget_package(
        name = "paket2bazel.system.io.filesystem.primitives",
        package = "system.io.filesystem.primitives",
        version = "4.3.0",
        sha256 = "2cc9df83c5706afb3d70c9eaf67347f085ad02d49f934fc5cb8b3846df6bd648",
        core_lib = {
            "netcoreapp2.0": "lib/netstandard1.3/System.IO.FileSystem.Primitives.dll",
            "netcoreapp2.1": "lib/netstandard1.3/System.IO.FileSystem.Primitives.dll",
            "netcoreapp2.2": "lib/netstandard1.3/System.IO.FileSystem.Primitives.dll",
            "netcoreapp3.0": "lib/netstandard1.3/System.IO.FileSystem.Primitives.dll",
            "netcoreapp3.1": "lib/netstandard1.3/System.IO.FileSystem.Primitives.dll",
            "net5.0": "lib/netstandard1.3/System.IO.FileSystem.Primitives.dll",
        },
        core_ref = {
            "netcoreapp2.0": "lib/netstandard1.3/System.IO.FileSystem.Primitives.dll",
            "netcoreapp2.1": "lib/netstandard1.3/System.IO.FileSystem.Primitives.dll",
            "netcoreapp2.2": "lib/netstandard1.3/System.IO.FileSystem.Primitives.dll",
            "netcoreapp3.0": "lib/netstandard1.3/System.IO.FileSystem.Primitives.dll",
            "netcoreapp3.1": "lib/netstandard1.3/System.IO.FileSystem.Primitives.dll",
            "net5.0": "lib/netstandard1.3/System.IO.FileSystem.Primitives.dll",
        },
        core_deps = {
            "netcoreapp2.0": [
                "@paket2bazel.system.runtime//:lib",
            ],
            "netcoreapp2.1": [
                "@paket2bazel.system.runtime//:lib",
            ],
            "netcoreapp2.2": [
                "@paket2bazel.system.runtime//:lib",
            ],
            "netcoreapp3.0": [
                "@paket2bazel.system.runtime//:lib",
            ],
            "netcoreapp3.1": [
                "@paket2bazel.system.runtime//:lib",
            ],
            "net5.0": [
                "@paket2bazel.system.runtime//:lib",
            ],
        },
        core_files = {
            "netcoreapp2.0": [
                "lib/netstandard1.3/System.IO.FileSystem.Primitives.dll",
            ],
            "netcoreapp2.1": [
                "lib/netstandard1.3/System.IO.FileSystem.Primitives.dll",
            ],
            "netcoreapp2.2": [
                "lib/netstandard1.3/System.IO.FileSystem.Primitives.dll",
            ],
            "netcoreapp3.0": [
                "lib/netstandard1.3/System.IO.FileSystem.Primitives.dll",
            ],
            "netcoreapp3.1": [
                "lib/netstandard1.3/System.IO.FileSystem.Primitives.dll",
            ],
            "net5.0": [
                "lib/netstandard1.3/System.IO.FileSystem.Primitives.dll",
            ],
        },
    )
    nuget_package(
        name = "paket2bazel.system.linq",
        package = "system.linq",
        version = "4.3.0",
        sha256 = "479ba248bde5e9add7ad74922fa8f3faafcf732550cc4001ca2b9764d4aa0ff0",
        core_lib = {
            "netcoreapp2.0": "lib/netstandard1.6/System.Linq.dll",
            "netcoreapp2.1": "lib/netstandard1.6/System.Linq.dll",
            "netcoreapp2.2": "lib/netstandard1.6/System.Linq.dll",
            "netcoreapp3.0": "lib/netstandard1.6/System.Linq.dll",
            "netcoreapp3.1": "lib/netstandard1.6/System.Linq.dll",
            "net5.0": "lib/netstandard1.6/System.Linq.dll",
        },
        core_ref = {
            "netcoreapp2.0": "lib/netstandard1.6/System.Linq.dll",
            "netcoreapp2.1": "lib/netstandard1.6/System.Linq.dll",
            "netcoreapp2.2": "lib/netstandard1.6/System.Linq.dll",
            "netcoreapp3.0": "lib/netstandard1.6/System.Linq.dll",
            "netcoreapp3.1": "lib/netstandard1.6/System.Linq.dll",
            "net5.0": "lib/netstandard1.6/System.Linq.dll",
        },
        core_deps = {
            "netcoreapp2.0": [
                "@paket2bazel.system.collections//:lib",
                "@paket2bazel.system.diagnostics.debug//:lib",
                "@paket2bazel.system.resources.resourcemanager//:lib",
                "@paket2bazel.system.runtime//:lib",
                "@paket2bazel.system.runtime.extensions//:lib",
            ],
            "netcoreapp2.1": [
                "@paket2bazel.system.collections//:lib",
                "@paket2bazel.system.diagnostics.debug//:lib",
                "@paket2bazel.system.resources.resourcemanager//:lib",
                "@paket2bazel.system.runtime//:lib",
                "@paket2bazel.system.runtime.extensions//:lib",
            ],
            "netcoreapp2.2": [
                "@paket2bazel.system.collections//:lib",
                "@paket2bazel.system.diagnostics.debug//:lib",
                "@paket2bazel.system.resources.resourcemanager//:lib",
                "@paket2bazel.system.runtime//:lib",
                "@paket2bazel.system.runtime.extensions//:lib",
            ],
            "netcoreapp3.0": [
                "@paket2bazel.system.collections//:lib",
                "@paket2bazel.system.diagnostics.debug//:lib",
                "@paket2bazel.system.resources.resourcemanager//:lib",
                "@paket2bazel.system.runtime//:lib",
                "@paket2bazel.system.runtime.extensions//:lib",
            ],
            "netcoreapp3.1": [
                "@paket2bazel.system.collections//:lib",
                "@paket2bazel.system.diagnostics.debug//:lib",
                "@paket2bazel.system.resources.resourcemanager//:lib",
                "@paket2bazel.system.runtime//:lib",
                "@paket2bazel.system.runtime.extensions//:lib",
            ],
            "net5.0": [
                "@paket2bazel.system.collections//:lib",
                "@paket2bazel.system.diagnostics.debug//:lib",
                "@paket2bazel.system.resources.resourcemanager//:lib",
                "@paket2bazel.system.runtime//:lib",
                "@paket2bazel.system.runtime.extensions//:lib",
            ],
        },
        core_files = {
            "netcoreapp2.0": [
                "lib/netstandard1.6/System.Linq.dll",
            ],
            "netcoreapp2.1": [
                "lib/netstandard1.6/System.Linq.dll",
            ],
            "netcoreapp2.2": [
                "lib/netstandard1.6/System.Linq.dll",
            ],
            "netcoreapp3.0": [
                "lib/netstandard1.6/System.Linq.dll",
            ],
            "netcoreapp3.1": [
                "lib/netstandard1.6/System.Linq.dll",
            ],
            "net5.0": [
                "lib/netstandard1.6/System.Linq.dll",
            ],
        },
    )
    nuget_package(
        name = "paket2bazel.system.net.http",
        package = "system.net.http",
        version = "4.3.4",
        sha256 = "14ca14d0aee794f2f1a038eed0d2f6d568e581af46a67028423b05845618b74d",
        core_deps = {
            "netcoreapp2.0": [
                "@paket2bazel.microsoft.netcore.platforms//:lib",
                "@paket2bazel.runtime.native.system//:lib",
                "@paket2bazel.runtime.native.system.net.http//:lib",
                "@paket2bazel.runtime.native.system.security.cryptography.openssl//:lib",
                "@paket2bazel.system.collections//:lib",
                "@paket2bazel.system.diagnostics.debug//:lib",
                "@paket2bazel.system.diagnostics.diagnosticsource//:lib",
                "@paket2bazel.system.diagnostics.tracing//:lib",
                "@paket2bazel.system.globalization//:lib",
                "@paket2bazel.system.globalization.extensions//:lib",
                "@paket2bazel.system.io//:lib",
                "@paket2bazel.system.io.filesystem//:lib",
                "@paket2bazel.system.net.primitives//:lib",
                "@paket2bazel.system.resources.resourcemanager//:lib",
                "@paket2bazel.system.runtime//:lib",
                "@paket2bazel.system.runtime.extensions//:lib",
                "@paket2bazel.system.runtime.handles//:lib",
                "@paket2bazel.system.runtime.interopservices//:lib",
                "@paket2bazel.system.security.cryptography.algorithms//:lib",
                "@paket2bazel.system.security.cryptography.encoding//:lib",
                "@paket2bazel.system.security.cryptography.openssl//:lib",
                "@paket2bazel.system.security.cryptography.primitives//:lib",
                "@paket2bazel.system.security.cryptography.x509certificates//:lib",
                "@paket2bazel.system.text.encoding//:lib",
                "@paket2bazel.system.threading//:lib",
                "@paket2bazel.system.threading.tasks//:lib",
            ],
            "netcoreapp2.1": [
                "@paket2bazel.microsoft.netcore.platforms//:lib",
                "@paket2bazel.runtime.native.system//:lib",
                "@paket2bazel.runtime.native.system.net.http//:lib",
                "@paket2bazel.runtime.native.system.security.cryptography.openssl//:lib",
                "@paket2bazel.system.collections//:lib",
                "@paket2bazel.system.diagnostics.debug//:lib",
                "@paket2bazel.system.diagnostics.diagnosticsource//:lib",
                "@paket2bazel.system.diagnostics.tracing//:lib",
                "@paket2bazel.system.globalization//:lib",
                "@paket2bazel.system.globalization.extensions//:lib",
                "@paket2bazel.system.io//:lib",
                "@paket2bazel.system.io.filesystem//:lib",
                "@paket2bazel.system.net.primitives//:lib",
                "@paket2bazel.system.resources.resourcemanager//:lib",
                "@paket2bazel.system.runtime//:lib",
                "@paket2bazel.system.runtime.extensions//:lib",
                "@paket2bazel.system.runtime.handles//:lib",
                "@paket2bazel.system.runtime.interopservices//:lib",
                "@paket2bazel.system.security.cryptography.algorithms//:lib",
                "@paket2bazel.system.security.cryptography.encoding//:lib",
                "@paket2bazel.system.security.cryptography.openssl//:lib",
                "@paket2bazel.system.security.cryptography.primitives//:lib",
                "@paket2bazel.system.security.cryptography.x509certificates//:lib",
                "@paket2bazel.system.text.encoding//:lib",
                "@paket2bazel.system.threading//:lib",
                "@paket2bazel.system.threading.tasks//:lib",
            ],
            "netcoreapp2.2": [
                "@paket2bazel.microsoft.netcore.platforms//:lib",
                "@paket2bazel.runtime.native.system//:lib",
                "@paket2bazel.runtime.native.system.net.http//:lib",
                "@paket2bazel.runtime.native.system.security.cryptography.openssl//:lib",
                "@paket2bazel.system.collections//:lib",
                "@paket2bazel.system.diagnostics.debug//:lib",
                "@paket2bazel.system.diagnostics.diagnosticsource//:lib",
                "@paket2bazel.system.diagnostics.tracing//:lib",
                "@paket2bazel.system.globalization//:lib",
                "@paket2bazel.system.globalization.extensions//:lib",
                "@paket2bazel.system.io//:lib",
                "@paket2bazel.system.io.filesystem//:lib",
                "@paket2bazel.system.net.primitives//:lib",
                "@paket2bazel.system.resources.resourcemanager//:lib",
                "@paket2bazel.system.runtime//:lib",
                "@paket2bazel.system.runtime.extensions//:lib",
                "@paket2bazel.system.runtime.handles//:lib",
                "@paket2bazel.system.runtime.interopservices//:lib",
                "@paket2bazel.system.security.cryptography.algorithms//:lib",
                "@paket2bazel.system.security.cryptography.encoding//:lib",
                "@paket2bazel.system.security.cryptography.openssl//:lib",
                "@paket2bazel.system.security.cryptography.primitives//:lib",
                "@paket2bazel.system.security.cryptography.x509certificates//:lib",
                "@paket2bazel.system.text.encoding//:lib",
                "@paket2bazel.system.threading//:lib",
                "@paket2bazel.system.threading.tasks//:lib",
            ],
            "netcoreapp3.0": [
                "@paket2bazel.microsoft.netcore.platforms//:lib",
                "@paket2bazel.runtime.native.system//:lib",
                "@paket2bazel.runtime.native.system.net.http//:lib",
                "@paket2bazel.runtime.native.system.security.cryptography.openssl//:lib",
                "@paket2bazel.system.collections//:lib",
                "@paket2bazel.system.diagnostics.debug//:lib",
                "@paket2bazel.system.diagnostics.diagnosticsource//:lib",
                "@paket2bazel.system.diagnostics.tracing//:lib",
                "@paket2bazel.system.globalization//:lib",
                "@paket2bazel.system.globalization.extensions//:lib",
                "@paket2bazel.system.io//:lib",
                "@paket2bazel.system.io.filesystem//:lib",
                "@paket2bazel.system.net.primitives//:lib",
                "@paket2bazel.system.resources.resourcemanager//:lib",
                "@paket2bazel.system.runtime//:lib",
                "@paket2bazel.system.runtime.extensions//:lib",
                "@paket2bazel.system.runtime.handles//:lib",
                "@paket2bazel.system.runtime.interopservices//:lib",
                "@paket2bazel.system.security.cryptography.algorithms//:lib",
                "@paket2bazel.system.security.cryptography.encoding//:lib",
                "@paket2bazel.system.security.cryptography.openssl//:lib",
                "@paket2bazel.system.security.cryptography.primitives//:lib",
                "@paket2bazel.system.security.cryptography.x509certificates//:lib",
                "@paket2bazel.system.text.encoding//:lib",
                "@paket2bazel.system.threading//:lib",
                "@paket2bazel.system.threading.tasks//:lib",
            ],
            "netcoreapp3.1": [
                "@paket2bazel.microsoft.netcore.platforms//:lib",
                "@paket2bazel.runtime.native.system//:lib",
                "@paket2bazel.runtime.native.system.net.http//:lib",
                "@paket2bazel.runtime.native.system.security.cryptography.openssl//:lib",
                "@paket2bazel.system.collections//:lib",
                "@paket2bazel.system.diagnostics.debug//:lib",
                "@paket2bazel.system.diagnostics.diagnosticsource//:lib",
                "@paket2bazel.system.diagnostics.tracing//:lib",
                "@paket2bazel.system.globalization//:lib",
                "@paket2bazel.system.globalization.extensions//:lib",
                "@paket2bazel.system.io//:lib",
                "@paket2bazel.system.io.filesystem//:lib",
                "@paket2bazel.system.net.primitives//:lib",
                "@paket2bazel.system.resources.resourcemanager//:lib",
                "@paket2bazel.system.runtime//:lib",
                "@paket2bazel.system.runtime.extensions//:lib",
                "@paket2bazel.system.runtime.handles//:lib",
                "@paket2bazel.system.runtime.interopservices//:lib",
                "@paket2bazel.system.security.cryptography.algorithms//:lib",
                "@paket2bazel.system.security.cryptography.encoding//:lib",
                "@paket2bazel.system.security.cryptography.openssl//:lib",
                "@paket2bazel.system.security.cryptography.primitives//:lib",
                "@paket2bazel.system.security.cryptography.x509certificates//:lib",
                "@paket2bazel.system.text.encoding//:lib",
                "@paket2bazel.system.threading//:lib",
                "@paket2bazel.system.threading.tasks//:lib",
            ],
            "net5.0": [
                "@paket2bazel.microsoft.netcore.platforms//:lib",
                "@paket2bazel.runtime.native.system//:lib",
                "@paket2bazel.runtime.native.system.net.http//:lib",
                "@paket2bazel.runtime.native.system.security.cryptography.openssl//:lib",
                "@paket2bazel.system.collections//:lib",
                "@paket2bazel.system.diagnostics.debug//:lib",
                "@paket2bazel.system.diagnostics.diagnosticsource//:lib",
                "@paket2bazel.system.diagnostics.tracing//:lib",
                "@paket2bazel.system.globalization//:lib",
                "@paket2bazel.system.globalization.extensions//:lib",
                "@paket2bazel.system.io//:lib",
                "@paket2bazel.system.io.filesystem//:lib",
                "@paket2bazel.system.net.primitives//:lib",
                "@paket2bazel.system.resources.resourcemanager//:lib",
                "@paket2bazel.system.runtime//:lib",
                "@paket2bazel.system.runtime.extensions//:lib",
                "@paket2bazel.system.runtime.handles//:lib",
                "@paket2bazel.system.runtime.interopservices//:lib",
                "@paket2bazel.system.security.cryptography.algorithms//:lib",
                "@paket2bazel.system.security.cryptography.encoding//:lib",
                "@paket2bazel.system.security.cryptography.openssl//:lib",
                "@paket2bazel.system.security.cryptography.primitives//:lib",
                "@paket2bazel.system.security.cryptography.x509certificates//:lib",
                "@paket2bazel.system.text.encoding//:lib",
                "@paket2bazel.system.threading//:lib",
                "@paket2bazel.system.threading.tasks//:lib",
            ],
        },
        core_files = {
            "netcoreapp2.0": [
                "runtimes/unix/lib/netstandard1.6/System.Net.Http.dll",
            ],
            "netcoreapp2.1": [
                "runtimes/unix/lib/netstandard1.6/System.Net.Http.dll",
            ],
            "netcoreapp2.2": [
                "runtimes/unix/lib/netstandard1.6/System.Net.Http.dll",
            ],
            "netcoreapp3.0": [
                "runtimes/unix/lib/netstandard1.6/System.Net.Http.dll",
            ],
            "netcoreapp3.1": [
                "runtimes/unix/lib/netstandard1.6/System.Net.Http.dll",
            ],
            "net5.0": [
                "runtimes/unix/lib/netstandard1.6/System.Net.Http.dll",
            ],
        },
    )
    nuget_package(
        name = "paket2bazel.system.net.http.winhttphandler",
        package = "system.net.http.winhttphandler",
        version = "6.0.1",
        sha256 = "f27da9601585b7d76cf38fe2529250e3c3279b031ccc6278823b1eca0337f793",
        core_lib = {
            "netcoreapp2.0": "lib/netstandard2.0/System.Net.Http.WinHttpHandler.dll",
            "netcoreapp2.1": "lib/netstandard2.0/System.Net.Http.WinHttpHandler.dll",
            "netcoreapp2.2": "lib/netstandard2.0/System.Net.Http.WinHttpHandler.dll",
            "netcoreapp3.0": "lib/netstandard2.1/System.Net.Http.WinHttpHandler.dll",
            "netcoreapp3.1": "lib/netstandard2.1/System.Net.Http.WinHttpHandler.dll",
            "net5.0": "lib/netstandard2.1/System.Net.Http.WinHttpHandler.dll",
        },
        core_ref = {
            "netcoreapp2.0": "lib/netstandard2.0/System.Net.Http.WinHttpHandler.dll",
            "netcoreapp2.1": "lib/netstandard2.0/System.Net.Http.WinHttpHandler.dll",
            "netcoreapp2.2": "lib/netstandard2.0/System.Net.Http.WinHttpHandler.dll",
            "netcoreapp3.0": "lib/netstandard2.1/System.Net.Http.WinHttpHandler.dll",
            "netcoreapp3.1": "lib/netstandard2.1/System.Net.Http.WinHttpHandler.dll",
            "net5.0": "lib/netstandard2.1/System.Net.Http.WinHttpHandler.dll",
        },
        core_deps = {
            "netcoreapp2.0": [
                "@paket2bazel.system.buffers//:lib",
                "@paket2bazel.system.memory//:lib",
            ],
            "netcoreapp2.1": [
                "@paket2bazel.system.buffers//:lib",
                "@paket2bazel.system.memory//:lib",
            ],
            "netcoreapp2.2": [
                "@paket2bazel.system.buffers//:lib",
                "@paket2bazel.system.memory//:lib",
            ],
        },
        core_files = {
            "netcoreapp2.0": [
                "lib/netstandard2.0/System.Net.Http.WinHttpHandler.dll",
                "lib/netstandard2.0/System.Net.Http.WinHttpHandler.xml",
            ],
            "netcoreapp2.1": [
                "lib/netstandard2.0/System.Net.Http.WinHttpHandler.dll",
                "lib/netstandard2.0/System.Net.Http.WinHttpHandler.xml",
            ],
            "netcoreapp2.2": [
                "lib/netstandard2.0/System.Net.Http.WinHttpHandler.dll",
                "lib/netstandard2.0/System.Net.Http.WinHttpHandler.xml",
            ],
            "netcoreapp3.0": [
                "lib/netstandard2.1/System.Net.Http.WinHttpHandler.dll",
                "lib/netstandard2.1/System.Net.Http.WinHttpHandler.xml",
            ],
            "netcoreapp3.1": [
                "lib/netstandard2.1/System.Net.Http.WinHttpHandler.dll",
                "lib/netstandard2.1/System.Net.Http.WinHttpHandler.xml",
            ],
            "net5.0": [
                "lib/netstandard2.1/System.Net.Http.WinHttpHandler.dll",
                "lib/netstandard2.1/System.Net.Http.WinHttpHandler.xml",
            ],
        },
    )
    nuget_package(
        name = "paket2bazel.system.net.primitives",
        package = "system.net.primitives",
        version = "4.3.1",
        sha256 = "a880858d0a3915c49f35279bf1738cc00e5a5203fe3ced227653b91d5a60bac3",
        core_deps = {
            "netcoreapp2.0": [
                "@paket2bazel.microsoft.netcore.platforms//:lib",
                "@paket2bazel.microsoft.netcore.targets//:lib",
                "@paket2bazel.system.runtime//:lib",
                "@paket2bazel.system.runtime.handles//:lib",
            ],
            "netcoreapp2.1": [
                "@paket2bazel.microsoft.netcore.platforms//:lib",
                "@paket2bazel.microsoft.netcore.targets//:lib",
                "@paket2bazel.system.runtime//:lib",
                "@paket2bazel.system.runtime.handles//:lib",
            ],
            "netcoreapp2.2": [
                "@paket2bazel.microsoft.netcore.platforms//:lib",
                "@paket2bazel.microsoft.netcore.targets//:lib",
                "@paket2bazel.system.runtime//:lib",
                "@paket2bazel.system.runtime.handles//:lib",
            ],
            "netcoreapp3.0": [
                "@paket2bazel.microsoft.netcore.platforms//:lib",
                "@paket2bazel.microsoft.netcore.targets//:lib",
                "@paket2bazel.system.runtime//:lib",
                "@paket2bazel.system.runtime.handles//:lib",
            ],
            "netcoreapp3.1": [
                "@paket2bazel.microsoft.netcore.platforms//:lib",
                "@paket2bazel.microsoft.netcore.targets//:lib",
                "@paket2bazel.system.runtime//:lib",
                "@paket2bazel.system.runtime.handles//:lib",
            ],
            "net5.0": [
                "@paket2bazel.microsoft.netcore.platforms//:lib",
                "@paket2bazel.microsoft.netcore.targets//:lib",
                "@paket2bazel.system.runtime//:lib",
                "@paket2bazel.system.runtime.handles//:lib",
            ],
        },
    )
    nuget_package(
        name = "paket2bazel.system.reflection",
        package = "system.reflection",
        version = "4.3.0",
        sha256 = "35049946964bbed3d60e5be6308746c5c56ec949f0f76654468d215ec12c8576",
        core_deps = {
            "netcoreapp2.0": [
                "@paket2bazel.microsoft.netcore.platforms//:lib",
                "@paket2bazel.microsoft.netcore.targets//:lib",
                "@paket2bazel.system.io//:lib",
                "@paket2bazel.system.reflection.primitives//:lib",
                "@paket2bazel.system.runtime//:lib",
            ],
            "netcoreapp2.1": [
                "@paket2bazel.microsoft.netcore.platforms//:lib",
                "@paket2bazel.microsoft.netcore.targets//:lib",
                "@paket2bazel.system.io//:lib",
                "@paket2bazel.system.reflection.primitives//:lib",
                "@paket2bazel.system.runtime//:lib",
            ],
            "netcoreapp2.2": [
                "@paket2bazel.microsoft.netcore.platforms//:lib",
                "@paket2bazel.microsoft.netcore.targets//:lib",
                "@paket2bazel.system.io//:lib",
                "@paket2bazel.system.reflection.primitives//:lib",
                "@paket2bazel.system.runtime//:lib",
            ],
            "netcoreapp3.0": [
                "@paket2bazel.microsoft.netcore.platforms//:lib",
                "@paket2bazel.microsoft.netcore.targets//:lib",
                "@paket2bazel.system.io//:lib",
                "@paket2bazel.system.reflection.primitives//:lib",
                "@paket2bazel.system.runtime//:lib",
            ],
            "netcoreapp3.1": [
                "@paket2bazel.microsoft.netcore.platforms//:lib",
                "@paket2bazel.microsoft.netcore.targets//:lib",
                "@paket2bazel.system.io//:lib",
                "@paket2bazel.system.reflection.primitives//:lib",
                "@paket2bazel.system.runtime//:lib",
            ],
            "net5.0": [
                "@paket2bazel.microsoft.netcore.platforms//:lib",
                "@paket2bazel.microsoft.netcore.targets//:lib",
                "@paket2bazel.system.io//:lib",
                "@paket2bazel.system.reflection.primitives//:lib",
                "@paket2bazel.system.runtime//:lib",
            ],
        },
    )
    nuget_package(
        name = "paket2bazel.system.reflection.emit.lightweight",
        package = "system.reflection.emit.lightweight",
        version = "4.7.0",
        sha256 = "5745b3fd45283481dd4c64bd7b54d1f3dbb9f33263a3fc0f516c3a55a5727255",
        core_files = {
            "netcoreapp2.0": [
                "runtimes/aot/lib/netcore50/System.Reflection.Emit.Lightweight.dll",
                "runtimes/aot/lib/netcore50/System.Reflection.Emit.Lightweight.xml",
            ],
            "netcoreapp2.1": [
                "runtimes/aot/lib/netcore50/System.Reflection.Emit.Lightweight.dll",
                "runtimes/aot/lib/netcore50/System.Reflection.Emit.Lightweight.xml",
            ],
            "netcoreapp2.2": [
                "runtimes/aot/lib/netcore50/System.Reflection.Emit.Lightweight.dll",
                "runtimes/aot/lib/netcore50/System.Reflection.Emit.Lightweight.xml",
            ],
            "netcoreapp3.0": [
                "runtimes/aot/lib/netcore50/System.Reflection.Emit.Lightweight.dll",
                "runtimes/aot/lib/netcore50/System.Reflection.Emit.Lightweight.xml",
            ],
            "netcoreapp3.1": [
                "runtimes/aot/lib/netcore50/System.Reflection.Emit.Lightweight.dll",
                "runtimes/aot/lib/netcore50/System.Reflection.Emit.Lightweight.xml",
            ],
            "net5.0": [
                "runtimes/aot/lib/netcore50/System.Reflection.Emit.Lightweight.dll",
                "runtimes/aot/lib/netcore50/System.Reflection.Emit.Lightweight.xml",
            ],
        },
    )
    nuget_package(
        name = "paket2bazel.system.reflection.primitives",
        package = "system.reflection.primitives",
        version = "4.3.0",
        sha256 = "e68830581e2f9504e5de38e4d718e7886da8cdb1488d94cbf6e834bac650b813",
        core_deps = {
            "netcoreapp2.0": [
                "@paket2bazel.microsoft.netcore.platforms//:lib",
                "@paket2bazel.microsoft.netcore.targets//:lib",
                "@paket2bazel.system.runtime//:lib",
            ],
            "netcoreapp2.1": [
                "@paket2bazel.microsoft.netcore.platforms//:lib",
                "@paket2bazel.microsoft.netcore.targets//:lib",
                "@paket2bazel.system.runtime//:lib",
            ],
            "netcoreapp2.2": [
                "@paket2bazel.microsoft.netcore.platforms//:lib",
                "@paket2bazel.microsoft.netcore.targets//:lib",
                "@paket2bazel.system.runtime//:lib",
            ],
            "netcoreapp3.0": [
                "@paket2bazel.microsoft.netcore.platforms//:lib",
                "@paket2bazel.microsoft.netcore.targets//:lib",
                "@paket2bazel.system.runtime//:lib",
            ],
            "netcoreapp3.1": [
                "@paket2bazel.microsoft.netcore.platforms//:lib",
                "@paket2bazel.microsoft.netcore.targets//:lib",
                "@paket2bazel.system.runtime//:lib",
            ],
            "net5.0": [
                "@paket2bazel.microsoft.netcore.platforms//:lib",
                "@paket2bazel.microsoft.netcore.targets//:lib",
                "@paket2bazel.system.runtime//:lib",
            ],
        },
    )
    nuget_package(
        name = "paket2bazel.system.resources.resourcemanager",
        package = "system.resources.resourcemanager",
        version = "4.3.0",
        sha256 = "89d88e0fddf16dbadbc304a70f898e440f51622fc3fd4e3c79152c9ff5a7586a",
        core_deps = {
            "netcoreapp2.0": [
                "@paket2bazel.microsoft.netcore.platforms//:lib",
                "@paket2bazel.microsoft.netcore.targets//:lib",
                "@paket2bazel.system.globalization//:lib",
                "@paket2bazel.system.reflection//:lib",
                "@paket2bazel.system.runtime//:lib",
            ],
            "netcoreapp2.1": [
                "@paket2bazel.microsoft.netcore.platforms//:lib",
                "@paket2bazel.microsoft.netcore.targets//:lib",
                "@paket2bazel.system.globalization//:lib",
                "@paket2bazel.system.reflection//:lib",
                "@paket2bazel.system.runtime//:lib",
            ],
            "netcoreapp2.2": [
                "@paket2bazel.microsoft.netcore.platforms//:lib",
                "@paket2bazel.microsoft.netcore.targets//:lib",
                "@paket2bazel.system.globalization//:lib",
                "@paket2bazel.system.reflection//:lib",
                "@paket2bazel.system.runtime//:lib",
            ],
            "netcoreapp3.0": [
                "@paket2bazel.microsoft.netcore.platforms//:lib",
                "@paket2bazel.microsoft.netcore.targets//:lib",
                "@paket2bazel.system.globalization//:lib",
                "@paket2bazel.system.reflection//:lib",
                "@paket2bazel.system.runtime//:lib",
            ],
            "netcoreapp3.1": [
                "@paket2bazel.microsoft.netcore.platforms//:lib",
                "@paket2bazel.microsoft.netcore.targets//:lib",
                "@paket2bazel.system.globalization//:lib",
                "@paket2bazel.system.reflection//:lib",
                "@paket2bazel.system.runtime//:lib",
            ],
            "net5.0": [
                "@paket2bazel.microsoft.netcore.platforms//:lib",
                "@paket2bazel.microsoft.netcore.targets//:lib",
                "@paket2bazel.system.globalization//:lib",
                "@paket2bazel.system.reflection//:lib",
                "@paket2bazel.system.runtime//:lib",
            ],
        },
    )
    nuget_package(
        name = "paket2bazel.system.runtime",
        package = "system.runtime",
        version = "4.3.1",
        sha256 = "47d4faf00cd2d4f249eefe80473f6fa3cf2928bd5d5aa2ce00d838a64423900d",
        core_deps = {
            "netcoreapp2.0": [
                "@paket2bazel.microsoft.netcore.platforms//:lib",
                "@paket2bazel.microsoft.netcore.targets//:lib",
            ],
            "netcoreapp2.1": [
                "@paket2bazel.microsoft.netcore.platforms//:lib",
                "@paket2bazel.microsoft.netcore.targets//:lib",
            ],
            "netcoreapp2.2": [
                "@paket2bazel.microsoft.netcore.platforms//:lib",
                "@paket2bazel.microsoft.netcore.targets//:lib",
            ],
            "netcoreapp3.0": [
                "@paket2bazel.microsoft.netcore.platforms//:lib",
                "@paket2bazel.microsoft.netcore.targets//:lib",
            ],
            "netcoreapp3.1": [
                "@paket2bazel.microsoft.netcore.platforms//:lib",
                "@paket2bazel.microsoft.netcore.targets//:lib",
            ],
            "net5.0": [
                "@paket2bazel.microsoft.netcore.platforms//:lib",
                "@paket2bazel.microsoft.netcore.targets//:lib",
            ],
        },
    )
    nuget_package(
        name = "paket2bazel.system.runtime.compilerservices.unsafe",
        package = "system.runtime.compilerservices.unsafe",
        version = "6.0.0",
        sha256 = "6c41b53e70e9eee298cff3a02ce5acdd15b04125589be0273f0566026720a762",
        core_lib = {
            "netcoreapp2.0": "lib/netstandard2.0/System.Runtime.CompilerServices.Unsafe.dll",
            "netcoreapp2.1": "lib/netstandard2.0/System.Runtime.CompilerServices.Unsafe.dll",
            "netcoreapp2.2": "lib/netstandard2.0/System.Runtime.CompilerServices.Unsafe.dll",
            "netcoreapp3.0": "lib/netstandard2.0/System.Runtime.CompilerServices.Unsafe.dll",
            "netcoreapp3.1": "lib/netcoreapp3.1/System.Runtime.CompilerServices.Unsafe.dll",
            "net5.0": "lib/netcoreapp3.1/System.Runtime.CompilerServices.Unsafe.dll",
        },
        core_ref = {
            "netcoreapp2.0": "lib/netstandard2.0/System.Runtime.CompilerServices.Unsafe.dll",
            "netcoreapp2.1": "lib/netstandard2.0/System.Runtime.CompilerServices.Unsafe.dll",
            "netcoreapp2.2": "lib/netstandard2.0/System.Runtime.CompilerServices.Unsafe.dll",
            "netcoreapp3.0": "lib/netstandard2.0/System.Runtime.CompilerServices.Unsafe.dll",
            "netcoreapp3.1": "lib/netcoreapp3.1/System.Runtime.CompilerServices.Unsafe.dll",
            "net5.0": "lib/netcoreapp3.1/System.Runtime.CompilerServices.Unsafe.dll",
        },
        core_files = {
            "netcoreapp2.0": [
                "lib/netstandard2.0/System.Runtime.CompilerServices.Unsafe.dll",
                "lib/netstandard2.0/System.Runtime.CompilerServices.Unsafe.xml",
            ],
            "netcoreapp2.1": [
                "lib/netstandard2.0/System.Runtime.CompilerServices.Unsafe.dll",
                "lib/netstandard2.0/System.Runtime.CompilerServices.Unsafe.xml",
            ],
            "netcoreapp2.2": [
                "lib/netstandard2.0/System.Runtime.CompilerServices.Unsafe.dll",
                "lib/netstandard2.0/System.Runtime.CompilerServices.Unsafe.xml",
            ],
            "netcoreapp3.0": [
                "lib/netstandard2.0/System.Runtime.CompilerServices.Unsafe.dll",
                "lib/netstandard2.0/System.Runtime.CompilerServices.Unsafe.xml",
            ],
            "netcoreapp3.1": [
                "lib/netcoreapp3.1/System.Runtime.CompilerServices.Unsafe.dll",
                "lib/netcoreapp3.1/System.Runtime.CompilerServices.Unsafe.xml",
            ],
            "net5.0": [
                "lib/netcoreapp3.1/System.Runtime.CompilerServices.Unsafe.dll",
                "lib/netcoreapp3.1/System.Runtime.CompilerServices.Unsafe.xml",
            ],
        },
    )
    nuget_package(
        name = "paket2bazel.system.runtime.extensions",
        package = "system.runtime.extensions",
        version = "4.3.1",
        sha256 = "c6597f005eac175b28435e69ac03c8547487ebd0a22f813d3875431f2ae6f3af",
        core_deps = {
            "netcoreapp2.0": [
                "@paket2bazel.microsoft.netcore.platforms//:lib",
                "@paket2bazel.microsoft.netcore.targets//:lib",
                "@paket2bazel.system.runtime//:lib",
            ],
            "netcoreapp2.1": [
                "@paket2bazel.microsoft.netcore.platforms//:lib",
                "@paket2bazel.microsoft.netcore.targets//:lib",
                "@paket2bazel.system.runtime//:lib",
            ],
            "netcoreapp2.2": [
                "@paket2bazel.microsoft.netcore.platforms//:lib",
                "@paket2bazel.microsoft.netcore.targets//:lib",
                "@paket2bazel.system.runtime//:lib",
            ],
            "netcoreapp3.0": [
                "@paket2bazel.microsoft.netcore.platforms//:lib",
                "@paket2bazel.microsoft.netcore.targets//:lib",
                "@paket2bazel.system.runtime//:lib",
            ],
            "netcoreapp3.1": [
                "@paket2bazel.microsoft.netcore.platforms//:lib",
                "@paket2bazel.microsoft.netcore.targets//:lib",
                "@paket2bazel.system.runtime//:lib",
            ],
            "net5.0": [
                "@paket2bazel.microsoft.netcore.platforms//:lib",
                "@paket2bazel.microsoft.netcore.targets//:lib",
                "@paket2bazel.system.runtime//:lib",
            ],
        },
    )
    nuget_package(
        name = "paket2bazel.system.runtime.handles",
        package = "system.runtime.handles",
        version = "4.3.0",
        sha256 = "289e5a5e81a9079e98ebe89ea4191da71fc07da243022b71e2fae42ea47b826b",
        core_deps = {
            "netcoreapp2.0": [
                "@paket2bazel.microsoft.netcore.platforms//:lib",
                "@paket2bazel.microsoft.netcore.targets//:lib",
                "@paket2bazel.system.runtime//:lib",
            ],
            "netcoreapp2.1": [
                "@paket2bazel.microsoft.netcore.platforms//:lib",
                "@paket2bazel.microsoft.netcore.targets//:lib",
                "@paket2bazel.system.runtime//:lib",
            ],
            "netcoreapp2.2": [
                "@paket2bazel.microsoft.netcore.platforms//:lib",
                "@paket2bazel.microsoft.netcore.targets//:lib",
                "@paket2bazel.system.runtime//:lib",
            ],
            "netcoreapp3.0": [
                "@paket2bazel.microsoft.netcore.platforms//:lib",
                "@paket2bazel.microsoft.netcore.targets//:lib",
                "@paket2bazel.system.runtime//:lib",
            ],
            "netcoreapp3.1": [
                "@paket2bazel.microsoft.netcore.platforms//:lib",
                "@paket2bazel.microsoft.netcore.targets//:lib",
                "@paket2bazel.system.runtime//:lib",
            ],
            "net5.0": [
                "@paket2bazel.microsoft.netcore.platforms//:lib",
                "@paket2bazel.microsoft.netcore.targets//:lib",
                "@paket2bazel.system.runtime//:lib",
            ],
        },
    )
    nuget_package(
        name = "paket2bazel.system.runtime.interopservices",
        package = "system.runtime.interopservices",
        version = "4.3.0",
        sha256 = "f2c0c7f965097c247eedee277e97ed8fffa5b2d122662c56501b9e476ce61e02",
        core_deps = {
            "netcoreapp2.0": [
                "@paket2bazel.microsoft.netcore.platforms//:lib",
                "@paket2bazel.microsoft.netcore.targets//:lib",
                "@paket2bazel.system.reflection//:lib",
                "@paket2bazel.system.reflection.primitives//:lib",
                "@paket2bazel.system.runtime//:lib",
                "@paket2bazel.system.runtime.handles//:lib",
            ],
            "netcoreapp2.1": [
                "@paket2bazel.microsoft.netcore.platforms//:lib",
                "@paket2bazel.microsoft.netcore.targets//:lib",
                "@paket2bazel.system.reflection//:lib",
                "@paket2bazel.system.reflection.primitives//:lib",
                "@paket2bazel.system.runtime//:lib",
                "@paket2bazel.system.runtime.handles//:lib",
            ],
            "netcoreapp2.2": [
                "@paket2bazel.microsoft.netcore.platforms//:lib",
                "@paket2bazel.microsoft.netcore.targets//:lib",
                "@paket2bazel.system.reflection//:lib",
                "@paket2bazel.system.reflection.primitives//:lib",
                "@paket2bazel.system.runtime//:lib",
                "@paket2bazel.system.runtime.handles//:lib",
            ],
            "netcoreapp3.0": [
                "@paket2bazel.microsoft.netcore.platforms//:lib",
                "@paket2bazel.microsoft.netcore.targets//:lib",
                "@paket2bazel.system.reflection//:lib",
                "@paket2bazel.system.reflection.primitives//:lib",
                "@paket2bazel.system.runtime//:lib",
                "@paket2bazel.system.runtime.handles//:lib",
            ],
            "netcoreapp3.1": [
                "@paket2bazel.microsoft.netcore.platforms//:lib",
                "@paket2bazel.microsoft.netcore.targets//:lib",
                "@paket2bazel.system.reflection//:lib",
                "@paket2bazel.system.reflection.primitives//:lib",
                "@paket2bazel.system.runtime//:lib",
                "@paket2bazel.system.runtime.handles//:lib",
            ],
            "net5.0": [
                "@paket2bazel.microsoft.netcore.platforms//:lib",
                "@paket2bazel.microsoft.netcore.targets//:lib",
                "@paket2bazel.system.reflection//:lib",
                "@paket2bazel.system.reflection.primitives//:lib",
                "@paket2bazel.system.runtime//:lib",
                "@paket2bazel.system.runtime.handles//:lib",
            ],
        },
    )
    nuget_package(
        name = "paket2bazel.system.runtime.numerics",
        package = "system.runtime.numerics",
        version = "4.3.0",
        sha256 = "3f98c70a031b80531888e36fce668a15e3aa7002033eefd4f1b395acd3d82aa7",
        core_lib = {
            "netcoreapp2.0": "lib/netstandard1.3/System.Runtime.Numerics.dll",
            "netcoreapp2.1": "lib/netstandard1.3/System.Runtime.Numerics.dll",
            "netcoreapp2.2": "lib/netstandard1.3/System.Runtime.Numerics.dll",
            "netcoreapp3.0": "lib/netstandard1.3/System.Runtime.Numerics.dll",
            "netcoreapp3.1": "lib/netstandard1.3/System.Runtime.Numerics.dll",
            "net5.0": "lib/netstandard1.3/System.Runtime.Numerics.dll",
        },
        core_ref = {
            "netcoreapp2.0": "lib/netstandard1.3/System.Runtime.Numerics.dll",
            "netcoreapp2.1": "lib/netstandard1.3/System.Runtime.Numerics.dll",
            "netcoreapp2.2": "lib/netstandard1.3/System.Runtime.Numerics.dll",
            "netcoreapp3.0": "lib/netstandard1.3/System.Runtime.Numerics.dll",
            "netcoreapp3.1": "lib/netstandard1.3/System.Runtime.Numerics.dll",
            "net5.0": "lib/netstandard1.3/System.Runtime.Numerics.dll",
        },
        core_deps = {
            "netcoreapp2.0": [
                "@paket2bazel.system.globalization//:lib",
                "@paket2bazel.system.resources.resourcemanager//:lib",
                "@paket2bazel.system.runtime//:lib",
                "@paket2bazel.system.runtime.extensions//:lib",
            ],
            "netcoreapp2.1": [
                "@paket2bazel.system.globalization//:lib",
                "@paket2bazel.system.resources.resourcemanager//:lib",
                "@paket2bazel.system.runtime//:lib",
                "@paket2bazel.system.runtime.extensions//:lib",
            ],
            "netcoreapp2.2": [
                "@paket2bazel.system.globalization//:lib",
                "@paket2bazel.system.resources.resourcemanager//:lib",
                "@paket2bazel.system.runtime//:lib",
                "@paket2bazel.system.runtime.extensions//:lib",
            ],
            "netcoreapp3.0": [
                "@paket2bazel.system.globalization//:lib",
                "@paket2bazel.system.resources.resourcemanager//:lib",
                "@paket2bazel.system.runtime//:lib",
                "@paket2bazel.system.runtime.extensions//:lib",
            ],
            "netcoreapp3.1": [
                "@paket2bazel.system.globalization//:lib",
                "@paket2bazel.system.resources.resourcemanager//:lib",
                "@paket2bazel.system.runtime//:lib",
                "@paket2bazel.system.runtime.extensions//:lib",
            ],
            "net5.0": [
                "@paket2bazel.system.globalization//:lib",
                "@paket2bazel.system.resources.resourcemanager//:lib",
                "@paket2bazel.system.runtime//:lib",
                "@paket2bazel.system.runtime.extensions//:lib",
            ],
        },
        core_files = {
            "netcoreapp2.0": [
                "lib/netstandard1.3/System.Runtime.Numerics.dll",
            ],
            "netcoreapp2.1": [
                "lib/netstandard1.3/System.Runtime.Numerics.dll",
            ],
            "netcoreapp2.2": [
                "lib/netstandard1.3/System.Runtime.Numerics.dll",
            ],
            "netcoreapp3.0": [
                "lib/netstandard1.3/System.Runtime.Numerics.dll",
            ],
            "netcoreapp3.1": [
                "lib/netstandard1.3/System.Runtime.Numerics.dll",
            ],
            "net5.0": [
                "lib/netstandard1.3/System.Runtime.Numerics.dll",
            ],
        },
    )
    nuget_package(
        name = "paket2bazel.system.security.accesscontrol",
        package = "system.security.accesscontrol",
        version = "6.0.0",
        sha256 = "a8ec961016cdaf7123c92f9eb451bcff331bb8f8c0f8ef9d8bbd7b24ff42c728",
        core_lib = {
            "netcoreapp2.0": "lib/netstandard2.0/System.Security.AccessControl.dll",
            "netcoreapp2.1": "lib/netstandard2.0/System.Security.AccessControl.dll",
            "netcoreapp2.2": "lib/netstandard2.0/System.Security.AccessControl.dll",
            "netcoreapp3.0": "lib/netstandard2.0/System.Security.AccessControl.dll",
            "netcoreapp3.1": "lib/netstandard2.0/System.Security.AccessControl.dll",
            "net5.0": "lib/netstandard2.0/System.Security.AccessControl.dll",
        },
        core_ref = {
            "netcoreapp2.0": "lib/netstandard2.0/System.Security.AccessControl.dll",
            "netcoreapp2.1": "lib/netstandard2.0/System.Security.AccessControl.dll",
            "netcoreapp2.2": "lib/netstandard2.0/System.Security.AccessControl.dll",
            "netcoreapp3.0": "lib/netstandard2.0/System.Security.AccessControl.dll",
            "netcoreapp3.1": "lib/netstandard2.0/System.Security.AccessControl.dll",
            "net5.0": "lib/netstandard2.0/System.Security.AccessControl.dll",
        },
        core_deps = {
            "netcoreapp2.0": [
                "@paket2bazel.system.security.principal.windows//:lib",
            ],
            "netcoreapp2.1": [
                "@paket2bazel.system.security.principal.windows//:lib",
            ],
            "netcoreapp2.2": [
                "@paket2bazel.system.security.principal.windows//:lib",
            ],
            "netcoreapp3.0": [
                "@paket2bazel.system.security.principal.windows//:lib",
            ],
            "netcoreapp3.1": [
                "@paket2bazel.system.security.principal.windows//:lib",
            ],
            "net5.0": [
                "@paket2bazel.system.security.principal.windows//:lib",
            ],
        },
        core_files = {
            "netcoreapp2.0": [
                "lib/netstandard2.0/System.Security.AccessControl.dll",
                "lib/netstandard2.0/System.Security.AccessControl.xml",
            ],
            "netcoreapp2.1": [
                "lib/netstandard2.0/System.Security.AccessControl.dll",
                "lib/netstandard2.0/System.Security.AccessControl.xml",
            ],
            "netcoreapp2.2": [
                "lib/netstandard2.0/System.Security.AccessControl.dll",
                "lib/netstandard2.0/System.Security.AccessControl.xml",
            ],
            "netcoreapp3.0": [
                "lib/netstandard2.0/System.Security.AccessControl.dll",
                "lib/netstandard2.0/System.Security.AccessControl.xml",
            ],
            "netcoreapp3.1": [
                "lib/netstandard2.0/System.Security.AccessControl.dll",
                "lib/netstandard2.0/System.Security.AccessControl.xml",
            ],
            "net5.0": [
                "lib/netstandard2.0/System.Security.AccessControl.dll",
                "lib/netstandard2.0/System.Security.AccessControl.xml",
            ],
        },
    )
    nuget_package(
        name = "paket2bazel.system.security.cryptography.algorithms",
        package = "system.security.cryptography.algorithms",
        version = "4.3.1",
        sha256 = "4253bfa69464fcec836070a2983f3aed102528839a922743d0808d3adeb75cd4",
        core_deps = {
            "netcoreapp2.0": [
                "@paket2bazel.microsoft.netcore.platforms//:lib",
                "@paket2bazel.runtime.native.system.security.cryptography.apple//:lib",
                "@paket2bazel.runtime.native.system.security.cryptography.openssl//:lib",
                "@paket2bazel.system.collections//:lib",
                "@paket2bazel.system.io//:lib",
                "@paket2bazel.system.resources.resourcemanager//:lib",
                "@paket2bazel.system.runtime//:lib",
                "@paket2bazel.system.runtime.extensions//:lib",
                "@paket2bazel.system.runtime.handles//:lib",
                "@paket2bazel.system.runtime.interopservices//:lib",
                "@paket2bazel.system.runtime.numerics//:lib",
                "@paket2bazel.system.security.cryptography.encoding//:lib",
                "@paket2bazel.system.security.cryptography.primitives//:lib",
                "@paket2bazel.system.text.encoding//:lib",
            ],
            "netcoreapp2.1": [
                "@paket2bazel.microsoft.netcore.platforms//:lib",
                "@paket2bazel.runtime.native.system.security.cryptography.apple//:lib",
                "@paket2bazel.runtime.native.system.security.cryptography.openssl//:lib",
                "@paket2bazel.system.collections//:lib",
                "@paket2bazel.system.io//:lib",
                "@paket2bazel.system.resources.resourcemanager//:lib",
                "@paket2bazel.system.runtime//:lib",
                "@paket2bazel.system.runtime.extensions//:lib",
                "@paket2bazel.system.runtime.handles//:lib",
                "@paket2bazel.system.runtime.interopservices//:lib",
                "@paket2bazel.system.runtime.numerics//:lib",
                "@paket2bazel.system.security.cryptography.encoding//:lib",
                "@paket2bazel.system.security.cryptography.primitives//:lib",
                "@paket2bazel.system.text.encoding//:lib",
            ],
            "netcoreapp2.2": [
                "@paket2bazel.microsoft.netcore.platforms//:lib",
                "@paket2bazel.runtime.native.system.security.cryptography.apple//:lib",
                "@paket2bazel.runtime.native.system.security.cryptography.openssl//:lib",
                "@paket2bazel.system.collections//:lib",
                "@paket2bazel.system.io//:lib",
                "@paket2bazel.system.resources.resourcemanager//:lib",
                "@paket2bazel.system.runtime//:lib",
                "@paket2bazel.system.runtime.extensions//:lib",
                "@paket2bazel.system.runtime.handles//:lib",
                "@paket2bazel.system.runtime.interopservices//:lib",
                "@paket2bazel.system.runtime.numerics//:lib",
                "@paket2bazel.system.security.cryptography.encoding//:lib",
                "@paket2bazel.system.security.cryptography.primitives//:lib",
                "@paket2bazel.system.text.encoding//:lib",
            ],
            "netcoreapp3.0": [
                "@paket2bazel.microsoft.netcore.platforms//:lib",
                "@paket2bazel.runtime.native.system.security.cryptography.apple//:lib",
                "@paket2bazel.runtime.native.system.security.cryptography.openssl//:lib",
                "@paket2bazel.system.collections//:lib",
                "@paket2bazel.system.io//:lib",
                "@paket2bazel.system.resources.resourcemanager//:lib",
                "@paket2bazel.system.runtime//:lib",
                "@paket2bazel.system.runtime.extensions//:lib",
                "@paket2bazel.system.runtime.handles//:lib",
                "@paket2bazel.system.runtime.interopservices//:lib",
                "@paket2bazel.system.runtime.numerics//:lib",
                "@paket2bazel.system.security.cryptography.encoding//:lib",
                "@paket2bazel.system.security.cryptography.primitives//:lib",
                "@paket2bazel.system.text.encoding//:lib",
            ],
            "netcoreapp3.1": [
                "@paket2bazel.microsoft.netcore.platforms//:lib",
                "@paket2bazel.runtime.native.system.security.cryptography.apple//:lib",
                "@paket2bazel.runtime.native.system.security.cryptography.openssl//:lib",
                "@paket2bazel.system.collections//:lib",
                "@paket2bazel.system.io//:lib",
                "@paket2bazel.system.resources.resourcemanager//:lib",
                "@paket2bazel.system.runtime//:lib",
                "@paket2bazel.system.runtime.extensions//:lib",
                "@paket2bazel.system.runtime.handles//:lib",
                "@paket2bazel.system.runtime.interopservices//:lib",
                "@paket2bazel.system.runtime.numerics//:lib",
                "@paket2bazel.system.security.cryptography.encoding//:lib",
                "@paket2bazel.system.security.cryptography.primitives//:lib",
                "@paket2bazel.system.text.encoding//:lib",
            ],
            "net5.0": [
                "@paket2bazel.microsoft.netcore.platforms//:lib",
                "@paket2bazel.runtime.native.system.security.cryptography.apple//:lib",
                "@paket2bazel.runtime.native.system.security.cryptography.openssl//:lib",
                "@paket2bazel.system.collections//:lib",
                "@paket2bazel.system.io//:lib",
                "@paket2bazel.system.resources.resourcemanager//:lib",
                "@paket2bazel.system.runtime//:lib",
                "@paket2bazel.system.runtime.extensions//:lib",
                "@paket2bazel.system.runtime.handles//:lib",
                "@paket2bazel.system.runtime.interopservices//:lib",
                "@paket2bazel.system.runtime.numerics//:lib",
                "@paket2bazel.system.security.cryptography.encoding//:lib",
                "@paket2bazel.system.security.cryptography.primitives//:lib",
                "@paket2bazel.system.text.encoding//:lib",
            ],
        },
        core_files = {
            "netcoreapp2.0": [
                "runtimes/osx/lib/netstandard1.6/System.Security.Cryptography.Algorithms.dll",
                "runtimes/unix/lib/netstandard1.6/System.Security.Cryptography.Algorithms.dll",
            ],
            "netcoreapp2.1": [
                "runtimes/osx/lib/netstandard1.6/System.Security.Cryptography.Algorithms.dll",
                "runtimes/unix/lib/netstandard1.6/System.Security.Cryptography.Algorithms.dll",
            ],
            "netcoreapp2.2": [
                "runtimes/osx/lib/netstandard1.6/System.Security.Cryptography.Algorithms.dll",
                "runtimes/unix/lib/netstandard1.6/System.Security.Cryptography.Algorithms.dll",
            ],
            "netcoreapp3.0": [
                "runtimes/osx/lib/netstandard1.6/System.Security.Cryptography.Algorithms.dll",
                "runtimes/unix/lib/netstandard1.6/System.Security.Cryptography.Algorithms.dll",
            ],
            "netcoreapp3.1": [
                "runtimes/osx/lib/netstandard1.6/System.Security.Cryptography.Algorithms.dll",
                "runtimes/unix/lib/netstandard1.6/System.Security.Cryptography.Algorithms.dll",
            ],
            "net5.0": [
                "runtimes/osx/lib/netstandard1.6/System.Security.Cryptography.Algorithms.dll",
                "runtimes/unix/lib/netstandard1.6/System.Security.Cryptography.Algorithms.dll",
            ],
        },
    )
    nuget_package(
        name = "paket2bazel.system.security.cryptography.cng",
        package = "system.security.cryptography.cng",
        version = "5.0.0",
        sha256 = "9ce24fdef76641a600d3b4c8dfbdcebd95fab96b211138a9be2e4aa4bee8131a",
        core_lib = {
            "netcoreapp2.0": "lib/netstandard2.0/System.Security.Cryptography.Cng.dll",
            "netcoreapp2.1": "lib/netcoreapp2.1/System.Security.Cryptography.Cng.dll",
            "netcoreapp2.2": "lib/netcoreapp2.1/System.Security.Cryptography.Cng.dll",
            "netcoreapp3.0": "lib/netcoreapp3.0/System.Security.Cryptography.Cng.dll",
            "netcoreapp3.1": "lib/netcoreapp3.0/System.Security.Cryptography.Cng.dll",
            "net5.0": "lib/netcoreapp3.0/System.Security.Cryptography.Cng.dll",
        },
        core_ref = {
            "netcoreapp2.0": "lib/netstandard2.0/System.Security.Cryptography.Cng.dll",
            "netcoreapp2.1": "lib/netcoreapp2.1/System.Security.Cryptography.Cng.dll",
            "netcoreapp2.2": "lib/netcoreapp2.1/System.Security.Cryptography.Cng.dll",
            "netcoreapp3.0": "lib/netcoreapp3.0/System.Security.Cryptography.Cng.dll",
            "netcoreapp3.1": "lib/netcoreapp3.0/System.Security.Cryptography.Cng.dll",
            "net5.0": "lib/netcoreapp3.0/System.Security.Cryptography.Cng.dll",
        },
        core_deps = {
            "netcoreapp2.0": [
                "@paket2bazel.microsoft.netcore.platforms//:lib",
            ],
            "netcoreapp3.0": [
                "@paket2bazel.system.formats.asn1//:lib",
            ],
            "netcoreapp3.1": [
                "@paket2bazel.system.formats.asn1//:lib",
            ],
            "net5.0": [
                "@paket2bazel.system.formats.asn1//:lib",
            ],
        },
        core_files = {
            "netcoreapp2.0": [
                "lib/netstandard2.0/System.Security.Cryptography.Cng.dll",
                "lib/netstandard2.0/System.Security.Cryptography.Cng.xml",
            ],
            "netcoreapp2.1": [
                "lib/netcoreapp2.1/System.Security.Cryptography.Cng.dll",
            ],
            "netcoreapp2.2": [
                "lib/netcoreapp2.1/System.Security.Cryptography.Cng.dll",
            ],
            "netcoreapp3.0": [
                "lib/netcoreapp3.0/System.Security.Cryptography.Cng.dll",
                "lib/netcoreapp3.0/System.Security.Cryptography.Cng.xml",
            ],
            "netcoreapp3.1": [
                "lib/netcoreapp3.0/System.Security.Cryptography.Cng.dll",
                "lib/netcoreapp3.0/System.Security.Cryptography.Cng.xml",
            ],
            "net5.0": [
                "lib/netcoreapp3.0/System.Security.Cryptography.Cng.dll",
                "lib/netcoreapp3.0/System.Security.Cryptography.Cng.xml",
            ],
        },
    )
    nuget_package(
        name = "paket2bazel.system.security.cryptography.csp",
        package = "system.security.cryptography.csp",
        version = "4.3.0",
        sha256 = "a1e7dd4d4fd9d8f594f6795ab7cba24431aafcf199a123d182430bd75a66bcf4",
        core_deps = {
            "netcoreapp2.0": [
                "@paket2bazel.microsoft.netcore.platforms//:lib",
                "@paket2bazel.system.io//:lib",
                "@paket2bazel.system.reflection//:lib",
                "@paket2bazel.system.resources.resourcemanager//:lib",
                "@paket2bazel.system.runtime//:lib",
                "@paket2bazel.system.runtime.extensions//:lib",
                "@paket2bazel.system.runtime.handles//:lib",
                "@paket2bazel.system.runtime.interopservices//:lib",
                "@paket2bazel.system.security.cryptography.algorithms//:lib",
                "@paket2bazel.system.security.cryptography.encoding//:lib",
                "@paket2bazel.system.security.cryptography.primitives//:lib",
                "@paket2bazel.system.text.encoding//:lib",
                "@paket2bazel.system.threading//:lib",
            ],
            "netcoreapp2.1": [
                "@paket2bazel.microsoft.netcore.platforms//:lib",
                "@paket2bazel.system.io//:lib",
                "@paket2bazel.system.reflection//:lib",
                "@paket2bazel.system.resources.resourcemanager//:lib",
                "@paket2bazel.system.runtime//:lib",
                "@paket2bazel.system.runtime.extensions//:lib",
                "@paket2bazel.system.runtime.handles//:lib",
                "@paket2bazel.system.runtime.interopservices//:lib",
                "@paket2bazel.system.security.cryptography.algorithms//:lib",
                "@paket2bazel.system.security.cryptography.encoding//:lib",
                "@paket2bazel.system.security.cryptography.primitives//:lib",
                "@paket2bazel.system.text.encoding//:lib",
                "@paket2bazel.system.threading//:lib",
            ],
            "netcoreapp2.2": [
                "@paket2bazel.microsoft.netcore.platforms//:lib",
                "@paket2bazel.system.io//:lib",
                "@paket2bazel.system.reflection//:lib",
                "@paket2bazel.system.resources.resourcemanager//:lib",
                "@paket2bazel.system.runtime//:lib",
                "@paket2bazel.system.runtime.extensions//:lib",
                "@paket2bazel.system.runtime.handles//:lib",
                "@paket2bazel.system.runtime.interopservices//:lib",
                "@paket2bazel.system.security.cryptography.algorithms//:lib",
                "@paket2bazel.system.security.cryptography.encoding//:lib",
                "@paket2bazel.system.security.cryptography.primitives//:lib",
                "@paket2bazel.system.text.encoding//:lib",
                "@paket2bazel.system.threading//:lib",
            ],
            "netcoreapp3.0": [
                "@paket2bazel.microsoft.netcore.platforms//:lib",
                "@paket2bazel.system.io//:lib",
                "@paket2bazel.system.reflection//:lib",
                "@paket2bazel.system.resources.resourcemanager//:lib",
                "@paket2bazel.system.runtime//:lib",
                "@paket2bazel.system.runtime.extensions//:lib",
                "@paket2bazel.system.runtime.handles//:lib",
                "@paket2bazel.system.runtime.interopservices//:lib",
                "@paket2bazel.system.security.cryptography.algorithms//:lib",
                "@paket2bazel.system.security.cryptography.encoding//:lib",
                "@paket2bazel.system.security.cryptography.primitives//:lib",
                "@paket2bazel.system.text.encoding//:lib",
                "@paket2bazel.system.threading//:lib",
            ],
            "netcoreapp3.1": [
                "@paket2bazel.microsoft.netcore.platforms//:lib",
                "@paket2bazel.system.io//:lib",
                "@paket2bazel.system.reflection//:lib",
                "@paket2bazel.system.resources.resourcemanager//:lib",
                "@paket2bazel.system.runtime//:lib",
                "@paket2bazel.system.runtime.extensions//:lib",
                "@paket2bazel.system.runtime.handles//:lib",
                "@paket2bazel.system.runtime.interopservices//:lib",
                "@paket2bazel.system.security.cryptography.algorithms//:lib",
                "@paket2bazel.system.security.cryptography.encoding//:lib",
                "@paket2bazel.system.security.cryptography.primitives//:lib",
                "@paket2bazel.system.text.encoding//:lib",
                "@paket2bazel.system.threading//:lib",
            ],
            "net5.0": [
                "@paket2bazel.microsoft.netcore.platforms//:lib",
                "@paket2bazel.system.io//:lib",
                "@paket2bazel.system.reflection//:lib",
                "@paket2bazel.system.resources.resourcemanager//:lib",
                "@paket2bazel.system.runtime//:lib",
                "@paket2bazel.system.runtime.extensions//:lib",
                "@paket2bazel.system.runtime.handles//:lib",
                "@paket2bazel.system.runtime.interopservices//:lib",
                "@paket2bazel.system.security.cryptography.algorithms//:lib",
                "@paket2bazel.system.security.cryptography.encoding//:lib",
                "@paket2bazel.system.security.cryptography.primitives//:lib",
                "@paket2bazel.system.text.encoding//:lib",
                "@paket2bazel.system.threading//:lib",
            ],
        },
        core_files = {
            "netcoreapp2.0": [
                "runtimes/unix/lib/netstandard1.3/System.Security.Cryptography.Csp.dll",
            ],
            "netcoreapp2.1": [
                "runtimes/unix/lib/netstandard1.3/System.Security.Cryptography.Csp.dll",
            ],
            "netcoreapp2.2": [
                "runtimes/unix/lib/netstandard1.3/System.Security.Cryptography.Csp.dll",
            ],
            "netcoreapp3.0": [
                "runtimes/unix/lib/netstandard1.3/System.Security.Cryptography.Csp.dll",
            ],
            "netcoreapp3.1": [
                "runtimes/unix/lib/netstandard1.3/System.Security.Cryptography.Csp.dll",
            ],
            "net5.0": [
                "runtimes/unix/lib/netstandard1.3/System.Security.Cryptography.Csp.dll",
            ],
        },
    )
    nuget_package(
        name = "paket2bazel.system.security.cryptography.encoding",
        package = "system.security.cryptography.encoding",
        version = "4.3.0",
        sha256 = "62e81ef3d37a33e35c6e572f5cc7b21d9ea46437f006fdcb3cc0e217c1e126cb",
        core_deps = {
            "netcoreapp2.0": [
                "@paket2bazel.microsoft.netcore.platforms//:lib",
                "@paket2bazel.runtime.native.system.security.cryptography.openssl//:lib",
                "@paket2bazel.system.collections//:lib",
                "@paket2bazel.system.collections.concurrent//:lib",
                "@paket2bazel.system.linq//:lib",
                "@paket2bazel.system.resources.resourcemanager//:lib",
                "@paket2bazel.system.runtime//:lib",
                "@paket2bazel.system.runtime.extensions//:lib",
                "@paket2bazel.system.runtime.handles//:lib",
                "@paket2bazel.system.runtime.interopservices//:lib",
                "@paket2bazel.system.security.cryptography.primitives//:lib",
                "@paket2bazel.system.text.encoding//:lib",
            ],
            "netcoreapp2.1": [
                "@paket2bazel.microsoft.netcore.platforms//:lib",
                "@paket2bazel.runtime.native.system.security.cryptography.openssl//:lib",
                "@paket2bazel.system.collections//:lib",
                "@paket2bazel.system.collections.concurrent//:lib",
                "@paket2bazel.system.linq//:lib",
                "@paket2bazel.system.resources.resourcemanager//:lib",
                "@paket2bazel.system.runtime//:lib",
                "@paket2bazel.system.runtime.extensions//:lib",
                "@paket2bazel.system.runtime.handles//:lib",
                "@paket2bazel.system.runtime.interopservices//:lib",
                "@paket2bazel.system.security.cryptography.primitives//:lib",
                "@paket2bazel.system.text.encoding//:lib",
            ],
            "netcoreapp2.2": [
                "@paket2bazel.microsoft.netcore.platforms//:lib",
                "@paket2bazel.runtime.native.system.security.cryptography.openssl//:lib",
                "@paket2bazel.system.collections//:lib",
                "@paket2bazel.system.collections.concurrent//:lib",
                "@paket2bazel.system.linq//:lib",
                "@paket2bazel.system.resources.resourcemanager//:lib",
                "@paket2bazel.system.runtime//:lib",
                "@paket2bazel.system.runtime.extensions//:lib",
                "@paket2bazel.system.runtime.handles//:lib",
                "@paket2bazel.system.runtime.interopservices//:lib",
                "@paket2bazel.system.security.cryptography.primitives//:lib",
                "@paket2bazel.system.text.encoding//:lib",
            ],
            "netcoreapp3.0": [
                "@paket2bazel.microsoft.netcore.platforms//:lib",
                "@paket2bazel.runtime.native.system.security.cryptography.openssl//:lib",
                "@paket2bazel.system.collections//:lib",
                "@paket2bazel.system.collections.concurrent//:lib",
                "@paket2bazel.system.linq//:lib",
                "@paket2bazel.system.resources.resourcemanager//:lib",
                "@paket2bazel.system.runtime//:lib",
                "@paket2bazel.system.runtime.extensions//:lib",
                "@paket2bazel.system.runtime.handles//:lib",
                "@paket2bazel.system.runtime.interopservices//:lib",
                "@paket2bazel.system.security.cryptography.primitives//:lib",
                "@paket2bazel.system.text.encoding//:lib",
            ],
            "netcoreapp3.1": [
                "@paket2bazel.microsoft.netcore.platforms//:lib",
                "@paket2bazel.runtime.native.system.security.cryptography.openssl//:lib",
                "@paket2bazel.system.collections//:lib",
                "@paket2bazel.system.collections.concurrent//:lib",
                "@paket2bazel.system.linq//:lib",
                "@paket2bazel.system.resources.resourcemanager//:lib",
                "@paket2bazel.system.runtime//:lib",
                "@paket2bazel.system.runtime.extensions//:lib",
                "@paket2bazel.system.runtime.handles//:lib",
                "@paket2bazel.system.runtime.interopservices//:lib",
                "@paket2bazel.system.security.cryptography.primitives//:lib",
                "@paket2bazel.system.text.encoding//:lib",
            ],
            "net5.0": [
                "@paket2bazel.microsoft.netcore.platforms//:lib",
                "@paket2bazel.runtime.native.system.security.cryptography.openssl//:lib",
                "@paket2bazel.system.collections//:lib",
                "@paket2bazel.system.collections.concurrent//:lib",
                "@paket2bazel.system.linq//:lib",
                "@paket2bazel.system.resources.resourcemanager//:lib",
                "@paket2bazel.system.runtime//:lib",
                "@paket2bazel.system.runtime.extensions//:lib",
                "@paket2bazel.system.runtime.handles//:lib",
                "@paket2bazel.system.runtime.interopservices//:lib",
                "@paket2bazel.system.security.cryptography.primitives//:lib",
                "@paket2bazel.system.text.encoding//:lib",
            ],
        },
        core_files = {
            "netcoreapp2.0": [
                "runtimes/unix/lib/netstandard1.3/System.Security.Cryptography.Encoding.dll",
            ],
            "netcoreapp2.1": [
                "runtimes/unix/lib/netstandard1.3/System.Security.Cryptography.Encoding.dll",
            ],
            "netcoreapp2.2": [
                "runtimes/unix/lib/netstandard1.3/System.Security.Cryptography.Encoding.dll",
            ],
            "netcoreapp3.0": [
                "runtimes/unix/lib/netstandard1.3/System.Security.Cryptography.Encoding.dll",
            ],
            "netcoreapp3.1": [
                "runtimes/unix/lib/netstandard1.3/System.Security.Cryptography.Encoding.dll",
            ],
            "net5.0": [
                "runtimes/unix/lib/netstandard1.3/System.Security.Cryptography.Encoding.dll",
            ],
        },
    )
    nuget_package(
        name = "paket2bazel.system.security.cryptography.openssl",
        package = "system.security.cryptography.openssl",
        version = "5.0.0",
        sha256 = "ca9af0d52a644f6e71a47b061d73b94587de65afde6bb0b111d469e17ec65071",
        core_lib = {
            "netcoreapp2.0": "lib/netstandard2.0/System.Security.Cryptography.OpenSsl.dll",
            "netcoreapp2.1": "lib/netcoreapp2.1/System.Security.Cryptography.OpenSsl.dll",
            "netcoreapp2.2": "lib/netcoreapp2.1/System.Security.Cryptography.OpenSsl.dll",
            "netcoreapp3.0": "lib/netcoreapp3.0/System.Security.Cryptography.OpenSsl.dll",
            "netcoreapp3.1": "lib/netcoreapp3.0/System.Security.Cryptography.OpenSsl.dll",
            "net5.0": "lib/netcoreapp3.0/System.Security.Cryptography.OpenSsl.dll",
        },
        core_ref = {
            "netcoreapp2.0": "lib/netstandard2.0/System.Security.Cryptography.OpenSsl.dll",
            "netcoreapp2.1": "lib/netcoreapp2.1/System.Security.Cryptography.OpenSsl.dll",
            "netcoreapp2.2": "lib/netcoreapp2.1/System.Security.Cryptography.OpenSsl.dll",
            "netcoreapp3.0": "lib/netcoreapp3.0/System.Security.Cryptography.OpenSsl.dll",
            "netcoreapp3.1": "lib/netcoreapp3.0/System.Security.Cryptography.OpenSsl.dll",
            "net5.0": "lib/netcoreapp3.0/System.Security.Cryptography.OpenSsl.dll",
        },
        core_deps = {
            "netcoreapp2.0": [
                "@paket2bazel.microsoft.netcore.platforms//:lib",
            ],
            "netcoreapp3.0": [
                "@paket2bazel.system.formats.asn1//:lib",
            ],
            "netcoreapp3.1": [
                "@paket2bazel.system.formats.asn1//:lib",
            ],
            "net5.0": [
                "@paket2bazel.system.formats.asn1//:lib",
            ],
        },
        core_files = {
            "netcoreapp2.0": [
                "lib/netstandard2.0/System.Security.Cryptography.OpenSsl.dll",
                "lib/netstandard2.0/System.Security.Cryptography.OpenSsl.xml",
                "runtimes/unix/lib/netcoreapp2.0/System.Security.Cryptography.OpenSsl.dll",
                "runtimes/unix/lib/netcoreapp2.1/System.Security.Cryptography.OpenSsl.dll",
                "runtimes/unix/lib/netcoreapp3.0/System.Security.Cryptography.OpenSsl.dll",
                "runtimes/unix/lib/netcoreapp3.0/System.Security.Cryptography.OpenSsl.xml",
                "runtimes/unix/lib/netstandard1.6/System.Security.Cryptography.OpenSsl.dll",
            ],
            "netcoreapp2.1": [
                "lib/netcoreapp2.1/System.Security.Cryptography.OpenSsl.dll",
                "runtimes/unix/lib/netcoreapp2.0/System.Security.Cryptography.OpenSsl.dll",
                "runtimes/unix/lib/netcoreapp2.1/System.Security.Cryptography.OpenSsl.dll",
                "runtimes/unix/lib/netcoreapp3.0/System.Security.Cryptography.OpenSsl.dll",
                "runtimes/unix/lib/netcoreapp3.0/System.Security.Cryptography.OpenSsl.xml",
                "runtimes/unix/lib/netstandard1.6/System.Security.Cryptography.OpenSsl.dll",
            ],
            "netcoreapp2.2": [
                "lib/netcoreapp2.1/System.Security.Cryptography.OpenSsl.dll",
                "runtimes/unix/lib/netcoreapp2.0/System.Security.Cryptography.OpenSsl.dll",
                "runtimes/unix/lib/netcoreapp2.1/System.Security.Cryptography.OpenSsl.dll",
                "runtimes/unix/lib/netcoreapp3.0/System.Security.Cryptography.OpenSsl.dll",
                "runtimes/unix/lib/netcoreapp3.0/System.Security.Cryptography.OpenSsl.xml",
                "runtimes/unix/lib/netstandard1.6/System.Security.Cryptography.OpenSsl.dll",
            ],
            "netcoreapp3.0": [
                "lib/netcoreapp3.0/System.Security.Cryptography.OpenSsl.dll",
                "lib/netcoreapp3.0/System.Security.Cryptography.OpenSsl.xml",
                "runtimes/unix/lib/netcoreapp2.0/System.Security.Cryptography.OpenSsl.dll",
                "runtimes/unix/lib/netcoreapp2.1/System.Security.Cryptography.OpenSsl.dll",
                "runtimes/unix/lib/netcoreapp3.0/System.Security.Cryptography.OpenSsl.dll",
                "runtimes/unix/lib/netcoreapp3.0/System.Security.Cryptography.OpenSsl.xml",
                "runtimes/unix/lib/netstandard1.6/System.Security.Cryptography.OpenSsl.dll",
            ],
            "netcoreapp3.1": [
                "lib/netcoreapp3.0/System.Security.Cryptography.OpenSsl.dll",
                "lib/netcoreapp3.0/System.Security.Cryptography.OpenSsl.xml",
                "runtimes/unix/lib/netcoreapp2.0/System.Security.Cryptography.OpenSsl.dll",
                "runtimes/unix/lib/netcoreapp2.1/System.Security.Cryptography.OpenSsl.dll",
                "runtimes/unix/lib/netcoreapp3.0/System.Security.Cryptography.OpenSsl.dll",
                "runtimes/unix/lib/netcoreapp3.0/System.Security.Cryptography.OpenSsl.xml",
                "runtimes/unix/lib/netstandard1.6/System.Security.Cryptography.OpenSsl.dll",
            ],
            "net5.0": [
                "lib/netcoreapp3.0/System.Security.Cryptography.OpenSsl.dll",
                "lib/netcoreapp3.0/System.Security.Cryptography.OpenSsl.xml",
                "runtimes/unix/lib/netcoreapp2.0/System.Security.Cryptography.OpenSsl.dll",
                "runtimes/unix/lib/netcoreapp2.1/System.Security.Cryptography.OpenSsl.dll",
                "runtimes/unix/lib/netcoreapp3.0/System.Security.Cryptography.OpenSsl.dll",
                "runtimes/unix/lib/netcoreapp3.0/System.Security.Cryptography.OpenSsl.xml",
                "runtimes/unix/lib/netstandard1.6/System.Security.Cryptography.OpenSsl.dll",
            ],
        },
    )
    nuget_package(
        name = "paket2bazel.system.security.cryptography.pkcs",
        package = "system.security.cryptography.pkcs",
        version = "6.0.1",
        sha256 = "389e0d27c13ff25f3a691f87b30fa4ffb208eb763fccf4be3200be51f7825c73",
        core_lib = {
            "netcoreapp2.0": "lib/netstandard2.0/System.Security.Cryptography.Pkcs.dll",
            "netcoreapp2.1": "lib/netstandard2.0/System.Security.Cryptography.Pkcs.dll",
            "netcoreapp2.2": "lib/netstandard2.0/System.Security.Cryptography.Pkcs.dll",
            "netcoreapp3.0": "lib/netstandard2.1/System.Security.Cryptography.Pkcs.dll",
            "netcoreapp3.1": "lib/netcoreapp3.1/System.Security.Cryptography.Pkcs.dll",
            "net5.0": "lib/netcoreapp3.1/System.Security.Cryptography.Pkcs.dll",
        },
        core_ref = {
            "netcoreapp2.0": "lib/netstandard2.0/System.Security.Cryptography.Pkcs.dll",
            "netcoreapp2.1": "lib/netstandard2.0/System.Security.Cryptography.Pkcs.dll",
            "netcoreapp2.2": "lib/netstandard2.0/System.Security.Cryptography.Pkcs.dll",
            "netcoreapp3.0": "lib/netstandard2.1/System.Security.Cryptography.Pkcs.dll",
            "netcoreapp3.1": "lib/netcoreapp3.1/System.Security.Cryptography.Pkcs.dll",
            "net5.0": "lib/netcoreapp3.1/System.Security.Cryptography.Pkcs.dll",
        },
        core_deps = {
            "netcoreapp2.0": [
                "@paket2bazel.system.formats.asn1//:lib",
                "@paket2bazel.system.buffers//:lib",
                "@paket2bazel.system.memory//:lib",
                "@paket2bazel.system.security.cryptography.cng//:lib",
            ],
            "netcoreapp2.1": [
                "@paket2bazel.system.formats.asn1//:lib",
                "@paket2bazel.system.buffers//:lib",
                "@paket2bazel.system.memory//:lib",
                "@paket2bazel.system.security.cryptography.cng//:lib",
            ],
            "netcoreapp2.2": [
                "@paket2bazel.system.formats.asn1//:lib",
                "@paket2bazel.system.buffers//:lib",
                "@paket2bazel.system.memory//:lib",
                "@paket2bazel.system.security.cryptography.cng//:lib",
            ],
            "netcoreapp3.0": [
                "@paket2bazel.system.formats.asn1//:lib",
                "@paket2bazel.system.security.cryptography.cng//:lib",
            ],
            "netcoreapp3.1": [
                "@paket2bazel.system.formats.asn1//:lib",
                "@paket2bazel.system.security.cryptography.cng//:lib",
            ],
            "net5.0": [
                "@paket2bazel.system.formats.asn1//:lib",
                "@paket2bazel.system.security.cryptography.cng//:lib",
            ],
        },
        core_files = {
            "netcoreapp2.0": [
                "lib/netstandard2.0/System.Security.Cryptography.Pkcs.dll",
                "lib/netstandard2.0/System.Security.Cryptography.Pkcs.xml",
            ],
            "netcoreapp2.1": [
                "lib/netstandard2.0/System.Security.Cryptography.Pkcs.dll",
                "lib/netstandard2.0/System.Security.Cryptography.Pkcs.xml",
            ],
            "netcoreapp2.2": [
                "lib/netstandard2.0/System.Security.Cryptography.Pkcs.dll",
                "lib/netstandard2.0/System.Security.Cryptography.Pkcs.xml",
            ],
            "netcoreapp3.0": [
                "lib/netstandard2.1/System.Security.Cryptography.Pkcs.dll",
                "lib/netstandard2.1/System.Security.Cryptography.Pkcs.xml",
            ],
            "netcoreapp3.1": [
                "lib/netcoreapp3.1/System.Security.Cryptography.Pkcs.dll",
                "lib/netcoreapp3.1/System.Security.Cryptography.Pkcs.xml",
            ],
            "net5.0": [
                "lib/netcoreapp3.1/System.Security.Cryptography.Pkcs.dll",
                "lib/netcoreapp3.1/System.Security.Cryptography.Pkcs.xml",
            ],
        },
    )
    nuget_package(
        name = "paket2bazel.system.security.cryptography.primitives",
        package = "system.security.cryptography.primitives",
        version = "4.3.0",
        sha256 = "7e7162ec1dd29d58f96be05b8179db8e718dbd6ac2114e87a7fc23b235b3df5f",
        core_lib = {
            "netcoreapp2.0": "lib/netstandard1.3/System.Security.Cryptography.Primitives.dll",
            "netcoreapp2.1": "lib/netstandard1.3/System.Security.Cryptography.Primitives.dll",
            "netcoreapp2.2": "lib/netstandard1.3/System.Security.Cryptography.Primitives.dll",
            "netcoreapp3.0": "lib/netstandard1.3/System.Security.Cryptography.Primitives.dll",
            "netcoreapp3.1": "lib/netstandard1.3/System.Security.Cryptography.Primitives.dll",
            "net5.0": "lib/netstandard1.3/System.Security.Cryptography.Primitives.dll",
        },
        core_ref = {
            "netcoreapp2.0": "lib/netstandard1.3/System.Security.Cryptography.Primitives.dll",
            "netcoreapp2.1": "lib/netstandard1.3/System.Security.Cryptography.Primitives.dll",
            "netcoreapp2.2": "lib/netstandard1.3/System.Security.Cryptography.Primitives.dll",
            "netcoreapp3.0": "lib/netstandard1.3/System.Security.Cryptography.Primitives.dll",
            "netcoreapp3.1": "lib/netstandard1.3/System.Security.Cryptography.Primitives.dll",
            "net5.0": "lib/netstandard1.3/System.Security.Cryptography.Primitives.dll",
        },
        core_deps = {
            "netcoreapp2.0": [
                "@paket2bazel.system.diagnostics.debug//:lib",
                "@paket2bazel.system.globalization//:lib",
                "@paket2bazel.system.io//:lib",
                "@paket2bazel.system.resources.resourcemanager//:lib",
                "@paket2bazel.system.runtime//:lib",
                "@paket2bazel.system.threading//:lib",
                "@paket2bazel.system.threading.tasks//:lib",
            ],
            "netcoreapp2.1": [
                "@paket2bazel.system.diagnostics.debug//:lib",
                "@paket2bazel.system.globalization//:lib",
                "@paket2bazel.system.io//:lib",
                "@paket2bazel.system.resources.resourcemanager//:lib",
                "@paket2bazel.system.runtime//:lib",
                "@paket2bazel.system.threading//:lib",
                "@paket2bazel.system.threading.tasks//:lib",
            ],
            "netcoreapp2.2": [
                "@paket2bazel.system.diagnostics.debug//:lib",
                "@paket2bazel.system.globalization//:lib",
                "@paket2bazel.system.io//:lib",
                "@paket2bazel.system.resources.resourcemanager//:lib",
                "@paket2bazel.system.runtime//:lib",
                "@paket2bazel.system.threading//:lib",
                "@paket2bazel.system.threading.tasks//:lib",
            ],
            "netcoreapp3.0": [
                "@paket2bazel.system.diagnostics.debug//:lib",
                "@paket2bazel.system.globalization//:lib",
                "@paket2bazel.system.io//:lib",
                "@paket2bazel.system.resources.resourcemanager//:lib",
                "@paket2bazel.system.runtime//:lib",
                "@paket2bazel.system.threading//:lib",
                "@paket2bazel.system.threading.tasks//:lib",
            ],
            "netcoreapp3.1": [
                "@paket2bazel.system.diagnostics.debug//:lib",
                "@paket2bazel.system.globalization//:lib",
                "@paket2bazel.system.io//:lib",
                "@paket2bazel.system.resources.resourcemanager//:lib",
                "@paket2bazel.system.runtime//:lib",
                "@paket2bazel.system.threading//:lib",
                "@paket2bazel.system.threading.tasks//:lib",
            ],
            "net5.0": [
                "@paket2bazel.system.diagnostics.debug//:lib",
                "@paket2bazel.system.globalization//:lib",
                "@paket2bazel.system.io//:lib",
                "@paket2bazel.system.resources.resourcemanager//:lib",
                "@paket2bazel.system.runtime//:lib",
                "@paket2bazel.system.threading//:lib",
                "@paket2bazel.system.threading.tasks//:lib",
            ],
        },
        core_files = {
            "netcoreapp2.0": [
                "lib/netstandard1.3/System.Security.Cryptography.Primitives.dll",
            ],
            "netcoreapp2.1": [
                "lib/netstandard1.3/System.Security.Cryptography.Primitives.dll",
            ],
            "netcoreapp2.2": [
                "lib/netstandard1.3/System.Security.Cryptography.Primitives.dll",
            ],
            "netcoreapp3.0": [
                "lib/netstandard1.3/System.Security.Cryptography.Primitives.dll",
            ],
            "netcoreapp3.1": [
                "lib/netstandard1.3/System.Security.Cryptography.Primitives.dll",
            ],
            "net5.0": [
                "lib/netstandard1.3/System.Security.Cryptography.Primitives.dll",
            ],
        },
    )
    nuget_package(
        name = "paket2bazel.system.security.cryptography.protecteddata",
        package = "system.security.cryptography.protecteddata",
        version = "6.0.0",
        sha256 = "5a2f48f4d6d99694035e04bb2a5d3a44817163ff7aef84bb84a898c3911a6d16",
        core_lib = {
            "netcoreapp2.0": "lib/netstandard2.0/System.Security.Cryptography.ProtectedData.dll",
            "netcoreapp2.1": "lib/netstandard2.0/System.Security.Cryptography.ProtectedData.dll",
            "netcoreapp2.2": "lib/netstandard2.0/System.Security.Cryptography.ProtectedData.dll",
            "netcoreapp3.0": "lib/netstandard2.0/System.Security.Cryptography.ProtectedData.dll",
            "netcoreapp3.1": "lib/netstandard2.0/System.Security.Cryptography.ProtectedData.dll",
            "net5.0": "lib/netstandard2.0/System.Security.Cryptography.ProtectedData.dll",
        },
        core_ref = {
            "netcoreapp2.0": "lib/netstandard2.0/System.Security.Cryptography.ProtectedData.dll",
            "netcoreapp2.1": "lib/netstandard2.0/System.Security.Cryptography.ProtectedData.dll",
            "netcoreapp2.2": "lib/netstandard2.0/System.Security.Cryptography.ProtectedData.dll",
            "netcoreapp3.0": "lib/netstandard2.0/System.Security.Cryptography.ProtectedData.dll",
            "netcoreapp3.1": "lib/netstandard2.0/System.Security.Cryptography.ProtectedData.dll",
            "net5.0": "lib/netstandard2.0/System.Security.Cryptography.ProtectedData.dll",
        },
        core_deps = {
            "netcoreapp2.0": [
                "@paket2bazel.system.memory//:lib",
            ],
            "netcoreapp2.1": [
                "@paket2bazel.system.memory//:lib",
            ],
            "netcoreapp2.2": [
                "@paket2bazel.system.memory//:lib",
            ],
            "netcoreapp3.0": [
                "@paket2bazel.system.memory//:lib",
            ],
            "netcoreapp3.1": [
                "@paket2bazel.system.memory//:lib",
            ],
            "net5.0": [
                "@paket2bazel.system.memory//:lib",
            ],
        },
        core_files = {
            "netcoreapp2.0": [
                "lib/netstandard2.0/System.Security.Cryptography.ProtectedData.dll",
                "lib/netstandard2.0/System.Security.Cryptography.ProtectedData.xml",
            ],
            "netcoreapp2.1": [
                "lib/netstandard2.0/System.Security.Cryptography.ProtectedData.dll",
                "lib/netstandard2.0/System.Security.Cryptography.ProtectedData.xml",
            ],
            "netcoreapp2.2": [
                "lib/netstandard2.0/System.Security.Cryptography.ProtectedData.dll",
                "lib/netstandard2.0/System.Security.Cryptography.ProtectedData.xml",
            ],
            "netcoreapp3.0": [
                "lib/netstandard2.0/System.Security.Cryptography.ProtectedData.dll",
                "lib/netstandard2.0/System.Security.Cryptography.ProtectedData.xml",
            ],
            "netcoreapp3.1": [
                "lib/netstandard2.0/System.Security.Cryptography.ProtectedData.dll",
                "lib/netstandard2.0/System.Security.Cryptography.ProtectedData.xml",
            ],
            "net5.0": [
                "lib/netstandard2.0/System.Security.Cryptography.ProtectedData.dll",
                "lib/netstandard2.0/System.Security.Cryptography.ProtectedData.xml",
            ],
        },
    )
    nuget_package(
        name = "paket2bazel.system.security.cryptography.x509certificates",
        package = "system.security.cryptography.x509certificates",
        version = "4.3.2",
        sha256 = "b24680b48aa291b06fd79f3a1287128b083e42a06cf6de6329402bfd06fdca2d",
        core_deps = {
            "netcoreapp2.0": [
                "@paket2bazel.microsoft.netcore.platforms//:lib",
                "@paket2bazel.runtime.native.system//:lib",
                "@paket2bazel.runtime.native.system.net.http//:lib",
                "@paket2bazel.runtime.native.system.security.cryptography.openssl//:lib",
                "@paket2bazel.system.collections//:lib",
                "@paket2bazel.system.diagnostics.debug//:lib",
                "@paket2bazel.system.globalization//:lib",
                "@paket2bazel.system.globalization.calendars//:lib",
                "@paket2bazel.system.io//:lib",
                "@paket2bazel.system.io.filesystem//:lib",
                "@paket2bazel.system.io.filesystem.primitives//:lib",
                "@paket2bazel.system.resources.resourcemanager//:lib",
                "@paket2bazel.system.runtime//:lib",
                "@paket2bazel.system.runtime.extensions//:lib",
                "@paket2bazel.system.runtime.handles//:lib",
                "@paket2bazel.system.runtime.interopservices//:lib",
                "@paket2bazel.system.runtime.numerics//:lib",
                "@paket2bazel.system.security.cryptography.algorithms//:lib",
                "@paket2bazel.system.security.cryptography.cng//:lib",
                "@paket2bazel.system.security.cryptography.csp//:lib",
                "@paket2bazel.system.security.cryptography.encoding//:lib",
                "@paket2bazel.system.security.cryptography.openssl//:lib",
                "@paket2bazel.system.security.cryptography.primitives//:lib",
                "@paket2bazel.system.text.encoding//:lib",
                "@paket2bazel.system.threading//:lib",
            ],
            "netcoreapp2.1": [
                "@paket2bazel.microsoft.netcore.platforms//:lib",
                "@paket2bazel.runtime.native.system//:lib",
                "@paket2bazel.runtime.native.system.net.http//:lib",
                "@paket2bazel.runtime.native.system.security.cryptography.openssl//:lib",
                "@paket2bazel.system.collections//:lib",
                "@paket2bazel.system.diagnostics.debug//:lib",
                "@paket2bazel.system.globalization//:lib",
                "@paket2bazel.system.globalization.calendars//:lib",
                "@paket2bazel.system.io//:lib",
                "@paket2bazel.system.io.filesystem//:lib",
                "@paket2bazel.system.io.filesystem.primitives//:lib",
                "@paket2bazel.system.resources.resourcemanager//:lib",
                "@paket2bazel.system.runtime//:lib",
                "@paket2bazel.system.runtime.extensions//:lib",
                "@paket2bazel.system.runtime.handles//:lib",
                "@paket2bazel.system.runtime.interopservices//:lib",
                "@paket2bazel.system.runtime.numerics//:lib",
                "@paket2bazel.system.security.cryptography.algorithms//:lib",
                "@paket2bazel.system.security.cryptography.cng//:lib",
                "@paket2bazel.system.security.cryptography.csp//:lib",
                "@paket2bazel.system.security.cryptography.encoding//:lib",
                "@paket2bazel.system.security.cryptography.openssl//:lib",
                "@paket2bazel.system.security.cryptography.primitives//:lib",
                "@paket2bazel.system.text.encoding//:lib",
                "@paket2bazel.system.threading//:lib",
            ],
            "netcoreapp2.2": [
                "@paket2bazel.microsoft.netcore.platforms//:lib",
                "@paket2bazel.runtime.native.system//:lib",
                "@paket2bazel.runtime.native.system.net.http//:lib",
                "@paket2bazel.runtime.native.system.security.cryptography.openssl//:lib",
                "@paket2bazel.system.collections//:lib",
                "@paket2bazel.system.diagnostics.debug//:lib",
                "@paket2bazel.system.globalization//:lib",
                "@paket2bazel.system.globalization.calendars//:lib",
                "@paket2bazel.system.io//:lib",
                "@paket2bazel.system.io.filesystem//:lib",
                "@paket2bazel.system.io.filesystem.primitives//:lib",
                "@paket2bazel.system.resources.resourcemanager//:lib",
                "@paket2bazel.system.runtime//:lib",
                "@paket2bazel.system.runtime.extensions//:lib",
                "@paket2bazel.system.runtime.handles//:lib",
                "@paket2bazel.system.runtime.interopservices//:lib",
                "@paket2bazel.system.runtime.numerics//:lib",
                "@paket2bazel.system.security.cryptography.algorithms//:lib",
                "@paket2bazel.system.security.cryptography.cng//:lib",
                "@paket2bazel.system.security.cryptography.csp//:lib",
                "@paket2bazel.system.security.cryptography.encoding//:lib",
                "@paket2bazel.system.security.cryptography.openssl//:lib",
                "@paket2bazel.system.security.cryptography.primitives//:lib",
                "@paket2bazel.system.text.encoding//:lib",
                "@paket2bazel.system.threading//:lib",
            ],
            "netcoreapp3.0": [
                "@paket2bazel.microsoft.netcore.platforms//:lib",
                "@paket2bazel.runtime.native.system//:lib",
                "@paket2bazel.runtime.native.system.net.http//:lib",
                "@paket2bazel.runtime.native.system.security.cryptography.openssl//:lib",
                "@paket2bazel.system.collections//:lib",
                "@paket2bazel.system.diagnostics.debug//:lib",
                "@paket2bazel.system.globalization//:lib",
                "@paket2bazel.system.globalization.calendars//:lib",
                "@paket2bazel.system.io//:lib",
                "@paket2bazel.system.io.filesystem//:lib",
                "@paket2bazel.system.io.filesystem.primitives//:lib",
                "@paket2bazel.system.resources.resourcemanager//:lib",
                "@paket2bazel.system.runtime//:lib",
                "@paket2bazel.system.runtime.extensions//:lib",
                "@paket2bazel.system.runtime.handles//:lib",
                "@paket2bazel.system.runtime.interopservices//:lib",
                "@paket2bazel.system.runtime.numerics//:lib",
                "@paket2bazel.system.security.cryptography.algorithms//:lib",
                "@paket2bazel.system.security.cryptography.cng//:lib",
                "@paket2bazel.system.security.cryptography.csp//:lib",
                "@paket2bazel.system.security.cryptography.encoding//:lib",
                "@paket2bazel.system.security.cryptography.openssl//:lib",
                "@paket2bazel.system.security.cryptography.primitives//:lib",
                "@paket2bazel.system.text.encoding//:lib",
                "@paket2bazel.system.threading//:lib",
            ],
            "netcoreapp3.1": [
                "@paket2bazel.microsoft.netcore.platforms//:lib",
                "@paket2bazel.runtime.native.system//:lib",
                "@paket2bazel.runtime.native.system.net.http//:lib",
                "@paket2bazel.runtime.native.system.security.cryptography.openssl//:lib",
                "@paket2bazel.system.collections//:lib",
                "@paket2bazel.system.diagnostics.debug//:lib",
                "@paket2bazel.system.globalization//:lib",
                "@paket2bazel.system.globalization.calendars//:lib",
                "@paket2bazel.system.io//:lib",
                "@paket2bazel.system.io.filesystem//:lib",
                "@paket2bazel.system.io.filesystem.primitives//:lib",
                "@paket2bazel.system.resources.resourcemanager//:lib",
                "@paket2bazel.system.runtime//:lib",
                "@paket2bazel.system.runtime.extensions//:lib",
                "@paket2bazel.system.runtime.handles//:lib",
                "@paket2bazel.system.runtime.interopservices//:lib",
                "@paket2bazel.system.runtime.numerics//:lib",
                "@paket2bazel.system.security.cryptography.algorithms//:lib",
                "@paket2bazel.system.security.cryptography.cng//:lib",
                "@paket2bazel.system.security.cryptography.csp//:lib",
                "@paket2bazel.system.security.cryptography.encoding//:lib",
                "@paket2bazel.system.security.cryptography.openssl//:lib",
                "@paket2bazel.system.security.cryptography.primitives//:lib",
                "@paket2bazel.system.text.encoding//:lib",
                "@paket2bazel.system.threading//:lib",
            ],
            "net5.0": [
                "@paket2bazel.microsoft.netcore.platforms//:lib",
                "@paket2bazel.runtime.native.system//:lib",
                "@paket2bazel.runtime.native.system.net.http//:lib",
                "@paket2bazel.runtime.native.system.security.cryptography.openssl//:lib",
                "@paket2bazel.system.collections//:lib",
                "@paket2bazel.system.diagnostics.debug//:lib",
                "@paket2bazel.system.globalization//:lib",
                "@paket2bazel.system.globalization.calendars//:lib",
                "@paket2bazel.system.io//:lib",
                "@paket2bazel.system.io.filesystem//:lib",
                "@paket2bazel.system.io.filesystem.primitives//:lib",
                "@paket2bazel.system.resources.resourcemanager//:lib",
                "@paket2bazel.system.runtime//:lib",
                "@paket2bazel.system.runtime.extensions//:lib",
                "@paket2bazel.system.runtime.handles//:lib",
                "@paket2bazel.system.runtime.interopservices//:lib",
                "@paket2bazel.system.runtime.numerics//:lib",
                "@paket2bazel.system.security.cryptography.algorithms//:lib",
                "@paket2bazel.system.security.cryptography.cng//:lib",
                "@paket2bazel.system.security.cryptography.csp//:lib",
                "@paket2bazel.system.security.cryptography.encoding//:lib",
                "@paket2bazel.system.security.cryptography.openssl//:lib",
                "@paket2bazel.system.security.cryptography.primitives//:lib",
                "@paket2bazel.system.text.encoding//:lib",
                "@paket2bazel.system.threading//:lib",
            ],
        },
        core_files = {
            "netcoreapp2.0": [
                "runtimes/unix/lib/netstandard1.6/System.Security.Cryptography.X509Certificates.dll",
            ],
            "netcoreapp2.1": [
                "runtimes/unix/lib/netstandard1.6/System.Security.Cryptography.X509Certificates.dll",
            ],
            "netcoreapp2.2": [
                "runtimes/unix/lib/netstandard1.6/System.Security.Cryptography.X509Certificates.dll",
            ],
            "netcoreapp3.0": [
                "runtimes/unix/lib/netstandard1.6/System.Security.Cryptography.X509Certificates.dll",
            ],
            "netcoreapp3.1": [
                "runtimes/unix/lib/netstandard1.6/System.Security.Cryptography.X509Certificates.dll",
            ],
            "net5.0": [
                "runtimes/unix/lib/netstandard1.6/System.Security.Cryptography.X509Certificates.dll",
            ],
        },
    )
    nuget_package(
        name = "paket2bazel.system.security.permissions",
        package = "system.security.permissions",
        version = "6.0.0",
        sha256 = "fcc32fb4558637fbce41f8d774e85eb7582c9cc821ea58790c21e2995b27544b",
        core_lib = {
            "netcoreapp2.0": "lib/netstandard2.0/System.Security.Permissions.dll",
            "netcoreapp2.1": "lib/netstandard2.0/System.Security.Permissions.dll",
            "netcoreapp2.2": "lib/netstandard2.0/System.Security.Permissions.dll",
            "netcoreapp3.0": "lib/netstandard2.0/System.Security.Permissions.dll",
            "netcoreapp3.1": "lib/netcoreapp3.1/System.Security.Permissions.dll",
            "net5.0": "lib/net5.0/System.Security.Permissions.dll",
        },
        core_ref = {
            "netcoreapp2.0": "lib/netstandard2.0/System.Security.Permissions.dll",
            "netcoreapp2.1": "lib/netstandard2.0/System.Security.Permissions.dll",
            "netcoreapp2.2": "lib/netstandard2.0/System.Security.Permissions.dll",
            "netcoreapp3.0": "lib/netstandard2.0/System.Security.Permissions.dll",
            "netcoreapp3.1": "lib/netcoreapp3.1/System.Security.Permissions.dll",
            "net5.0": "lib/net5.0/System.Security.Permissions.dll",
        },
        core_deps = {
            "netcoreapp2.0": [
                "@paket2bazel.system.security.accesscontrol//:lib",
            ],
            "netcoreapp2.1": [
                "@paket2bazel.system.security.accesscontrol//:lib",
            ],
            "netcoreapp2.2": [
                "@paket2bazel.system.security.accesscontrol//:lib",
            ],
            "netcoreapp3.0": [
                "@paket2bazel.system.security.accesscontrol//:lib",
            ],
            "netcoreapp3.1": [
                "@paket2bazel.system.security.accesscontrol//:lib",
                "@paket2bazel.system.windows.extensions//:lib",
            ],
            "net5.0": [
                "@paket2bazel.system.security.accesscontrol//:lib",
                "@paket2bazel.system.windows.extensions//:lib",
            ],
        },
        core_files = {
            "netcoreapp2.0": [
                "lib/netstandard2.0/System.Security.Permissions.dll",
                "lib/netstandard2.0/System.Security.Permissions.xml",
            ],
            "netcoreapp2.1": [
                "lib/netstandard2.0/System.Security.Permissions.dll",
                "lib/netstandard2.0/System.Security.Permissions.xml",
            ],
            "netcoreapp2.2": [
                "lib/netstandard2.0/System.Security.Permissions.dll",
                "lib/netstandard2.0/System.Security.Permissions.xml",
            ],
            "netcoreapp3.0": [
                "lib/netstandard2.0/System.Security.Permissions.dll",
                "lib/netstandard2.0/System.Security.Permissions.xml",
            ],
            "netcoreapp3.1": [
                "lib/netcoreapp3.1/System.Security.Permissions.dll",
                "lib/netcoreapp3.1/System.Security.Permissions.xml",
            ],
            "net5.0": [
                "lib/net5.0/System.Security.Permissions.dll",
                "lib/net5.0/System.Security.Permissions.xml",
            ],
        },
    )
    nuget_package(
        name = "paket2bazel.system.text.encoding",
        package = "system.text.encoding",
        version = "4.3.0",
        sha256 = "19cb475462d901afebaa404d86c0469ec89674acafe950ee6d8a4692e3a404b8",
        core_deps = {
            "netcoreapp2.0": [
                "@paket2bazel.microsoft.netcore.platforms//:lib",
                "@paket2bazel.microsoft.netcore.targets//:lib",
                "@paket2bazel.system.runtime//:lib",
            ],
            "netcoreapp2.1": [
                "@paket2bazel.microsoft.netcore.platforms//:lib",
                "@paket2bazel.microsoft.netcore.targets//:lib",
                "@paket2bazel.system.runtime//:lib",
            ],
            "netcoreapp2.2": [
                "@paket2bazel.microsoft.netcore.platforms//:lib",
                "@paket2bazel.microsoft.netcore.targets//:lib",
                "@paket2bazel.system.runtime//:lib",
            ],
            "netcoreapp3.0": [
                "@paket2bazel.microsoft.netcore.platforms//:lib",
                "@paket2bazel.microsoft.netcore.targets//:lib",
                "@paket2bazel.system.runtime//:lib",
            ],
            "netcoreapp3.1": [
                "@paket2bazel.microsoft.netcore.platforms//:lib",
                "@paket2bazel.microsoft.netcore.targets//:lib",
                "@paket2bazel.system.runtime//:lib",
            ],
            "net5.0": [
                "@paket2bazel.microsoft.netcore.platforms//:lib",
                "@paket2bazel.microsoft.netcore.targets//:lib",
                "@paket2bazel.system.runtime//:lib",
            ],
        },
    )
    nuget_package(
        name = "paket2bazel.system.text.json",
        package = "system.text.json",
        version = "5.0.2",
        sha256 = "dde1c8e56b1a7250fdfe25787252ed480bab431a5c27faac640f369644e3a06d",
        core_lib = {
            "netcoreapp2.0": "lib/netstandard2.0/System.Text.Json.dll",
            "netcoreapp2.1": "lib/netstandard2.0/System.Text.Json.dll",
            "netcoreapp2.2": "lib/netstandard2.0/System.Text.Json.dll",
            "netcoreapp3.0": "lib/netcoreapp3.0/System.Text.Json.dll",
            "netcoreapp3.1": "lib/netcoreapp3.0/System.Text.Json.dll",
            "net5.0": "lib/netcoreapp3.0/System.Text.Json.dll",
        },
        core_ref = {
            "netcoreapp2.0": "lib/netstandard2.0/System.Text.Json.dll",
            "netcoreapp2.1": "lib/netstandard2.0/System.Text.Json.dll",
            "netcoreapp2.2": "lib/netstandard2.0/System.Text.Json.dll",
            "netcoreapp3.0": "lib/netcoreapp3.0/System.Text.Json.dll",
            "netcoreapp3.1": "lib/netcoreapp3.0/System.Text.Json.dll",
            "net5.0": "lib/netcoreapp3.0/System.Text.Json.dll",
        },
        core_deps = {
            "netcoreapp2.0": [
                "@paket2bazel.microsoft.bcl.asyncinterfaces//:lib",
                "@paket2bazel.system.memory//:lib",
                "@paket2bazel.system.runtime.compilerservices.unsafe//:lib",
                "@paket2bazel.system.text.encodings.web//:lib",
                "@paket2bazel.system.threading.tasks.extensions//:lib",
            ],
            "netcoreapp2.1": [
                "@paket2bazel.microsoft.bcl.asyncinterfaces//:lib",
                "@paket2bazel.system.runtime.compilerservices.unsafe//:lib",
                "@paket2bazel.system.text.encodings.web//:lib",
            ],
            "netcoreapp2.2": [
                "@paket2bazel.microsoft.bcl.asyncinterfaces//:lib",
                "@paket2bazel.system.runtime.compilerservices.unsafe//:lib",
                "@paket2bazel.system.text.encodings.web//:lib",
            ],
            "netcoreapp3.0": [
                "@paket2bazel.system.runtime.compilerservices.unsafe//:lib",
                "@paket2bazel.system.text.encodings.web//:lib",
            ],
            "netcoreapp3.1": [
                "@paket2bazel.system.runtime.compilerservices.unsafe//:lib",
                "@paket2bazel.system.text.encodings.web//:lib",
            ],
        },
        core_files = {
            "netcoreapp2.0": [
                "lib/netstandard2.0/System.Text.Json.dll",
                "lib/netstandard2.0/System.Text.Json.xml",
            ],
            "netcoreapp2.1": [
                "lib/netstandard2.0/System.Text.Json.dll",
                "lib/netstandard2.0/System.Text.Json.xml",
            ],
            "netcoreapp2.2": [
                "lib/netstandard2.0/System.Text.Json.dll",
                "lib/netstandard2.0/System.Text.Json.xml",
            ],
            "netcoreapp3.0": [
                "lib/netcoreapp3.0/System.Text.Json.dll",
                "lib/netcoreapp3.0/System.Text.Json.xml",
            ],
            "netcoreapp3.1": [
                "lib/netcoreapp3.0/System.Text.Json.dll",
                "lib/netcoreapp3.0/System.Text.Json.xml",
            ],
            "net5.0": [
                "lib/netcoreapp3.0/System.Text.Json.dll",
                "lib/netcoreapp3.0/System.Text.Json.xml",
            ],
        },
    )
    nuget_package(
        name = "paket2bazel.system.threading",
        package = "system.threading",
        version = "4.3.0",
        sha256 = "643437751e29cd5c266aa060e2169c65a55e9d0ff7c8017fb95ec15d95e38967",
        core_lib = {
            "netcoreapp2.0": "lib/netstandard1.3/System.Threading.dll",
            "netcoreapp2.1": "lib/netstandard1.3/System.Threading.dll",
            "netcoreapp2.2": "lib/netstandard1.3/System.Threading.dll",
            "netcoreapp3.0": "lib/netstandard1.3/System.Threading.dll",
            "netcoreapp3.1": "lib/netstandard1.3/System.Threading.dll",
            "net5.0": "lib/netstandard1.3/System.Threading.dll",
        },
        core_ref = {
            "netcoreapp2.0": "lib/netstandard1.3/System.Threading.dll",
            "netcoreapp2.1": "lib/netstandard1.3/System.Threading.dll",
            "netcoreapp2.2": "lib/netstandard1.3/System.Threading.dll",
            "netcoreapp3.0": "lib/netstandard1.3/System.Threading.dll",
            "netcoreapp3.1": "lib/netstandard1.3/System.Threading.dll",
            "net5.0": "lib/netstandard1.3/System.Threading.dll",
        },
        core_deps = {
            "netcoreapp2.0": [
                "@paket2bazel.system.runtime//:lib",
                "@paket2bazel.system.threading.tasks//:lib",
            ],
            "netcoreapp2.1": [
                "@paket2bazel.system.runtime//:lib",
                "@paket2bazel.system.threading.tasks//:lib",
            ],
            "netcoreapp2.2": [
                "@paket2bazel.system.runtime//:lib",
                "@paket2bazel.system.threading.tasks//:lib",
            ],
            "netcoreapp3.0": [
                "@paket2bazel.system.runtime//:lib",
                "@paket2bazel.system.threading.tasks//:lib",
            ],
            "netcoreapp3.1": [
                "@paket2bazel.system.runtime//:lib",
                "@paket2bazel.system.threading.tasks//:lib",
            ],
            "net5.0": [
                "@paket2bazel.system.runtime//:lib",
                "@paket2bazel.system.threading.tasks//:lib",
            ],
        },
        core_files = {
            "netcoreapp2.0": [
                "lib/netstandard1.3/System.Threading.dll",
                "runtimes/aot/lib/netcore50/System.Threading.dll",
            ],
            "netcoreapp2.1": [
                "lib/netstandard1.3/System.Threading.dll",
                "runtimes/aot/lib/netcore50/System.Threading.dll",
            ],
            "netcoreapp2.2": [
                "lib/netstandard1.3/System.Threading.dll",
                "runtimes/aot/lib/netcore50/System.Threading.dll",
            ],
            "netcoreapp3.0": [
                "lib/netstandard1.3/System.Threading.dll",
                "runtimes/aot/lib/netcore50/System.Threading.dll",
            ],
            "netcoreapp3.1": [
                "lib/netstandard1.3/System.Threading.dll",
                "runtimes/aot/lib/netcore50/System.Threading.dll",
            ],
            "net5.0": [
                "lib/netstandard1.3/System.Threading.dll",
                "runtimes/aot/lib/netcore50/System.Threading.dll",
            ],
        },
    )
    nuget_package(
        name = "paket2bazel.system.threading.tasks",
        package = "system.threading.tasks",
        version = "4.3.0",
        sha256 = "679ad77c9d445e9dc6df620a646899ea4a0c8d1bb49fc0b5346af0a5d21e9f8c",
        core_deps = {
            "netcoreapp2.0": [
                "@paket2bazel.microsoft.netcore.platforms//:lib",
                "@paket2bazel.microsoft.netcore.targets//:lib",
                "@paket2bazel.system.runtime//:lib",
            ],
            "netcoreapp2.1": [
                "@paket2bazel.microsoft.netcore.platforms//:lib",
                "@paket2bazel.microsoft.netcore.targets//:lib",
                "@paket2bazel.system.runtime//:lib",
            ],
            "netcoreapp2.2": [
                "@paket2bazel.microsoft.netcore.platforms//:lib",
                "@paket2bazel.microsoft.netcore.targets//:lib",
                "@paket2bazel.system.runtime//:lib",
            ],
            "netcoreapp3.0": [
                "@paket2bazel.microsoft.netcore.platforms//:lib",
                "@paket2bazel.microsoft.netcore.targets//:lib",
                "@paket2bazel.system.runtime//:lib",
            ],
            "netcoreapp3.1": [
                "@paket2bazel.microsoft.netcore.platforms//:lib",
                "@paket2bazel.microsoft.netcore.targets//:lib",
                "@paket2bazel.system.runtime//:lib",
            ],
            "net5.0": [
                "@paket2bazel.microsoft.netcore.platforms//:lib",
                "@paket2bazel.microsoft.netcore.targets//:lib",
                "@paket2bazel.system.runtime//:lib",
            ],
        },
    )
    nuget_package(
        name = "paket2bazel.system.windows.extensions",
        package = "system.windows.extensions",
        version = "6.0.0",
        sha256 = "37eaa0d44e850c9f40f4be74c2656ddf13d057c671946d71797805bb13bec9f3",
        core_lib = {
            "netcoreapp3.1": "lib/netcoreapp3.1/System.Windows.Extensions.dll",
            "net5.0": "lib/netcoreapp3.1/System.Windows.Extensions.dll",
        },
        core_ref = {
            "netcoreapp3.1": "lib/netcoreapp3.1/System.Windows.Extensions.dll",
            "net5.0": "lib/netcoreapp3.1/System.Windows.Extensions.dll",
        },
        core_deps = {
            "netcoreapp3.1": [
                "@paket2bazel.system.drawing.common//:lib",
            ],
            "net5.0": [
                "@paket2bazel.system.drawing.common//:lib",
            ],
        },
        core_files = {
            "netcoreapp3.1": [
                "lib/netcoreapp3.1/System.Windows.Extensions.dll",
                "lib/netcoreapp3.1/System.Windows.Extensions.xml",
            ],
            "net5.0": [
                "lib/netcoreapp3.1/System.Windows.Extensions.dll",
                "lib/netcoreapp3.1/System.Windows.Extensions.xml",
            ],
        },
    )
