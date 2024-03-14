module NugetRepo.Gen

open Paket
open FSharpx.Collections
open System.Text
open NugetRepo.Models
open System.IO
open System.Collections.Generic
open System.Text.Json
open System.Text.Json.Serialization
open System.Text.Encodings.Web

type NamingConvention =
    | IdAsName
    | IdAndVersionAsName

type NugetRepoPackage =
    { name: string
      id: string
      version: string
      sha512: string
      sources: string seq
      netrc: string option
      dependencies: Dictionary<string, string seq>
      targeting_pack_overrides: string seq
      framework_list: string seq }

type NugetRepo = { packages: NugetRepoPackage seq }

let generateTarget (nugetRepo: NugetRepo) (repoName: string) (netrcLabel: string option) =
    let jsonOptions = JsonSerializerOptions()
    jsonOptions.DefaultIgnoreCondition <- JsonIgnoreCondition.WhenWritingNull
    jsonOptions.Encoder <- JavaScriptEncoder.UnsafeRelaxedJsonEscaping

    let i = "    "
    let sb = new StringBuilder()
    sb.Append($"{i}nuget_repo(\n") |> ignore

    sb.Append($"{i}    name = \"{repoName}\",\n") |> ignore

    sb.Append($"{i}    packages = [\n") |> ignore

    for package in nugetRepo.packages do
        sb.Append($"{i}        ") |> ignore

        sb.Append(
            JsonSerializer
                .Serialize(package, jsonOptions)
                // The replacements are so that the Bazel formatter does not have anything to format
                .Replace("\":\"", "\": \"")
                .Replace("\",\"", "\", \"")
                .Replace("\":[", "\": [")
                .Replace("],", "], ")
                .Replace("\":{", "\": {")
                .Replace("},", "}, ")
        )
        |> ignore

        sb.Append(",\n") |> ignore


    sb.Append($"{i}    ],\n") |> ignore
    sb.Append($"{i})\n") |> ignore

    sb.ToString()

let addFileHeaderContent (sb: StringBuilder) (fileName: string) =
    sb.Append($"\"Generated\"\n") |> ignore

    sb.Append($"\n") |> ignore

    sb.Append("load(\"@rules_dotnet//dotnet:defs.bzl\", \"nuget_repo\")") |> ignore

    sb.Append("\n") |> ignore
    sb.Append("\n") |> ignore
    sb.Append($"def {fileName}():") |> ignore
    sb.Append("\n") |> ignore
    sb.Append($"    \"{fileName}\"") |> ignore
    sb.Append("\n") |> ignore

let addExtensionFileContent (sb: StringBuilder) (groupName: string) (prefix: string) =
    sb.Append($"\"Generated\"\n") |> ignore

    sb.Append($"\n") |> ignore

    sb.Append($"load(\":{prefix}.{groupName}.bzl\", _{groupName} = \"{groupName}\")")
    |> ignore

    sb.Append("\n") |> ignore
    sb.Append("\n") |> ignore
    sb.Append($"def _{groupName}_impl(_ctx):") |> ignore
    sb.Append("\n") |> ignore
    sb.Append($"    _{groupName}()") |> ignore
    sb.Append("\n") |> ignore
    sb.Append("\n") |> ignore
    sb.Append($"{groupName}_extension = module_extension(") |> ignore
    sb.Append("\n") |> ignore
    sb.Append($"    implementation = _{groupName}_impl,") |> ignore
    sb.Append("\n") |> ignore
    sb.Append(")") |> ignore
    sb.Append("\n") |> ignore

let groupToNugetRepo (group: Group) (namingConvention: NamingConvention) =
    let repoPackages =
        group.packages
        |> Seq.map (fun p ->
            let name =
                match namingConvention with
                | IdAsName -> p.name
                | IdAndVersionAsName -> $"{p.name}.v{p.version}"

            { name = name
              id = p.name
              version = p.version
              sha512 = p.sha512sri
              sources = p.sources
              netrc = None
              dependencies = Dictionary(p.dependencies)
              targeting_pack_overrides = p.overrides
              framework_list = p.frameworkList })

    { packages = repoPackages }

let addGroupToFileContent
    (sb: StringBuilder)
    (group: Group)
    (repoNamePrefix: string option)
    (netrcLabel: string option)
    (namingConvention: NamingConvention)
    =
    let repoName =
        match repoNamePrefix with
        | Some(prefix) -> $"{prefix}.{group.name.ToLower()}"
        | None -> group.name.ToLower()

    sb.Append(generateTarget (groupToNugetRepo group namingConvention) repoName netrcLabel)
    |> ignore

let generateBazelFiles
    (groups: Group seq)
    (outputFolder: string)
    (prefix: string)
    (netrcLabel: string option)
    (namingConvention: NamingConvention)
    =
    groups
    |> Seq.iter (fun group ->
        let sb = new StringBuilder()
        addFileHeaderContent sb (group.name.ToLower())
        addGroupToFileContent sb group (Some prefix) netrcLabel namingConvention
        File.WriteAllText($"{outputFolder}/{prefix}.{group.name.ToLower()}.bzl", sb.ToString())

        let extensionSb = new StringBuilder()
        addExtensionFileContent extensionSb (group.name.ToLower()) prefix
        File.WriteAllText($"{outputFolder}/{prefix}.{group.name.ToLower()}_extension.bzl", extensionSb.ToString()))
