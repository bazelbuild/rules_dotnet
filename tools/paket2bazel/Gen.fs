module Paket2Bazel.Gen

open Paket
open System.Collections.Generic
open NuGet.Packaging
open NuGet.Frameworks
open FSharpx.Option
open FSharpx.Collections
open FSharpx
open System.IO
open System.Security.Cryptography
open System.Text
open Paket2Bazel.Models

let ridToPlatformConstraint rid =
    match rid with
    | "win-x64" ->
        "\"@platforms//cpu:x86_64\", \"@platforms//os:windows\""
    | "linux-x64" ->
        "\"@platforms//cpu:x86_64\", \"@platforms//os:linux\""
    | "osx-x64" ->
        "\"@platforms//cpu:x86_64\", \"@platforms//os:osx\""
    | "osx-arm64" ->
        "\"@platforms//cpu:aarch64\", \"@platforms//os:osx\""
    | _ ->
        failwith "Unsupported RID"

let generatePlatformConstraints (sb: StringBuilder) =
    sb.Append("load(\"@bazel_skylib//lib:selects.bzl\", \"selects\")\n") |> ignore
    sb.Append($"\n") |> ignore

    for rid in Models.supportedRids do
        sb.Append($"selects.config_setting_group(\n") |> ignore
        sb.Append($"    name = \"{rid}\",\n") |> ignore
        sb.Append($"    match_all = [{ridToPlatformConstraint rid}],\n") |> ignore
        sb.Append($")\n") |> ignore
        sb.Append($"\n") |> ignore

let generateTarget (tfms: FrameworkIdentifier list) (package: Package) =
    let i = "    "
    let sb = new StringBuilder()
    sb.Append($"{i}nuget_package(\n") |> ignore

    sb.Append($"{i}    name = \"{package.group.ToLower()}.{package.name.ToLower()}\",\n")
    |> ignore

    sb.Append($"{i}    package = \"{package.name}\",\n")
    |> ignore

    sb.Append($"{i}    version = \"{package.version}\",\n")
    |> ignore

    sb.Append($"{i}    sha256 = \"{package.sha256}\",\n")
    |> ignore

    sb.Append($"{i}    build_file_content = \"\"\"\n")
    |> ignore

    sb.Append($"load(\"@rules_dotnet//dotnet:defs.bzl\", \"import_library\", \"import_multiframework_library\")\n")
    |> ignore
    generatePlatformConstraints sb

    for frameworkIdentifier in tfms do
        let tfm = frameworkIdentifier.ToString()
        sb.Append($"import_library(\n") |> ignore
        sb.Append($"    name = \"{tfm}\",\n") |> ignore

        sb.Append($"    target_framework = \"{tfm}\",\n")
        |> ignore

        let libs = package.libs |> Map.findOrDefault (frameworkIdentifier) []

        sb.Append($"    dll = [\n") |> ignore
        
        for lib in libs do
            sb.Append($"        \"{lib}\",\n") |> ignore

        sb.Append($"    ],\n") |> ignore


        let refs = package.refs |> Map.findOrDefault (frameworkIdentifier) []

        sb.Append($"    refdll = [\n") |> ignore
        
        for ref in refs do
            sb.Append($"        \"{ref}\",\n") |> ignore

        sb.Append($"    ],\n") |> ignore

        let pdbs = package.pdbs |> Map.findOrDefault (frameworkIdentifier) []

        sb.Append($"    pdb = [\n") |> ignore
        
        for pdb in pdbs do
            sb.Append($"        \"{pdb}\",\n") |> ignore

        sb.Append($"    ],\n") |> ignore

        let deps = package.dependencies |> Map.findOrDefault (frameworkIdentifier) []

        sb.Append($"    deps = [\n") |> ignore
        
        for dep in deps do
            sb.Append($"        \"@{package.group.ToLower()}.{dep.ToLower()}//:lib\",\n") |> ignore

        sb.Append($"    ],\n") |> ignore

        let runtimeFiles = package.runtimeFiles |> Map.findOrDefault (frameworkIdentifier) Map.empty

        sb.Append($"    data = select({{\n") |> ignore
        
        runtimeFiles |> Map.iter (fun rid files ->
            // If the package does not have MacOS ARM specific native binaries
            // we use the x64 ones and hope that Rosetta does it's magic
            let mutable files = files
            if rid = "osx-arm64" && files.IsEmpty then
                files <- runtimeFiles |> Map.find "osx-x64"

            sb.Append($"        \":{rid}\": [\n") |> ignore
            for file in files do
                sb.Append($"            \"{file}\",\n") |> ignore
            sb.Append($"        ],\n") |> ignore)

        sb.Append($"    }}),\n") |> ignore

        
        sb.Append($")\n") |> ignore

    sb.Append($"import_multiframework_library(\n")
    |> ignore

    sb.Append($"    name = \"lib\",\n") |> ignore

    for tfm in tfms do
        let attrName = tfm.ToString().Replace(".", "_")

        sb.Append($"    {attrName} = \":{tfm.ToString()}\",\n")
        |> ignore

    sb.Append($"    visibility = [\"//visibility:public\"],\n")
    |> ignore

    sb.Append($")\n") |> ignore

    sb.Append($"\"\"\",\n") |> ignore

    sb.Append($"{i})\n") |> ignore
    sb.ToString()

let generateTargetWithOverride (buildFile: string) (package: Package) =
    let i = "    "
    let sb = new StringBuilder()
    sb.Append($"{i}nuget_package(\n") |> ignore

    sb.Append($"{i}    name = \"{package.group.ToLower()}.{package.name.ToLower()}\",\n")
    |> ignore

    sb.Append($"{i}    package = \"{package.name}\",\n")
    |> ignore

    sb.Append($"{i}    version = \"{package.version}\",\n")
    |> ignore

    sb.Append($"{i}    sha256 = \"{package.sha256}\",\n")
    |> ignore

    sb.Append($"{i}    build_file = \"{buildFile}\",\n")
    |> ignore

    sb.Append($"{i})\n") |> ignore

    sb.ToString()

let generateBazelFile (groups: Group list) =
    let sb = new StringBuilder()

    sb.Append($"\"Generated by paket2bazel\"\n")
    |> ignore

    sb.Append($"\n") |> ignore

    sb.Append("load(\"@rules_dotnet//dotnet:defs.bzl\", \"nuget_package\")")
    |> ignore

    sb.Append("\n") |> ignore
    sb.Append("\n") |> ignore
    sb.Append("def paket():") |> ignore
    sb.Append("\n") |> ignore
    sb.Append("    \"paket\"") |> ignore
    sb.Append("\n") |> ignore

    groups
    |> List.sortBy (fun i -> i.name)
    |> List.map (fun g ->
        g.packages
        |> List.sortBy(fun p -> p.name)
        |> List.map (fun p -> 
            match p.buildFileOverride with
            | Some (buildFile) -> generateTargetWithOverride buildFile p
            | None -> generateTarget g.tfms p))
    |> List.iter (fun i -> i |> List.iter (fun x -> sb.Append(x) |> ignore))

    sb.ToString()
