load("@rules_dotnet//dotnet:defs.bzl", "import_library")

import_library(
    name = "FSharp.Data.DesignTime.dll",
    dll = "typeproviders/fsharp41/netstandard2.0/FSharp.Data.DesignTime.dll",
    target_framework = "net6.0",
)

import_library(
    name = "lib",
    target_framework = "net6.0",
    dll = "lib/netstandard2.0/FSharp.Data.dll",
    refdll = "lib/netstandard2.0/FSharp.Data.dll",
    deps = [
        "@main.fsharp.core//:lib",
        ":FSharp.Data.DesignTime.dll",
    ],
    data = [
        "lib/netstandard2.0/FSharp.Data.dll",
        "lib/netstandard2.0/FSharp.Data.xml",
        "typeproviders/fsharp41/netstandard2.0/FSharp.Data.DesignTime.deps.json",
        "typeproviders/fsharp41/netstandard2.0/FSharp.Data.DesignTime.dll",
    ],
    visibility = ["//visibility:public"],
)
