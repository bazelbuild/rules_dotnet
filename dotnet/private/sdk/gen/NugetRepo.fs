module NugetRepo

open Paket
open FSharpx.Collections
open System.Text
open System.IO
open System.Collections.Generic
open System.Text.Json
open System.Text.Json.Serialization
open System.Text.Encodings.Web

type NugetRepoPackage =
    { name: string
      id: string
      version: string
      sha512: string
      sources: string seq
      dependencies: Dictionary<string, string seq>
      targeting_pack_overrides: string seq
      framework_list: string seq }

let generateTarget (packages: NugetRepoPackage seq) (repoName: string) =
    let jsonOptions = JsonSerializerOptions()
    jsonOptions.DefaultIgnoreCondition <- JsonIgnoreCondition.WhenWritingNull
    jsonOptions.Encoder <- JavaScriptEncoder.UnsafeRelaxedJsonEscaping

    let i = "    "
    let sb = new StringBuilder()
    sb.Append($"{i}nuget_repo(\n") |> ignore

    sb.Append($"{i}    name = \"{repoName}\",\n") |> ignore

    sb.Append($"{i}    packages = [\n") |> ignore

    for package in packages do
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

let addExtensionFileContent (sb: StringBuilder) (repoName: string) =
    sb.Append($"\"Generated\"\n") |> ignore

    sb.Append($"\n") |> ignore

    sb.Append($"load(\":{repoName}.bzl\", _{repoName} = \"{repoName}\")") |> ignore

    sb.Append("\n") |> ignore
    sb.Append("\n") |> ignore
    sb.Append($"def _{repoName}_impl(_ctx):") |> ignore
    sb.Append("\n") |> ignore
    sb.Append($"    _{repoName}()") |> ignore
    sb.Append("\n") |> ignore
    sb.Append("\n") |> ignore
    sb.Append($"{repoName}_extension = module_extension(") |> ignore
    sb.Append("\n") |> ignore
    sb.Append($"    implementation = _{repoName}_impl,") |> ignore
    sb.Append("\n") |> ignore
    sb.Append(")") |> ignore
    sb.Append("\n") |> ignore


let addGroupToFileContent (sb: StringBuilder) (repoName: string) (packages: NugetRepoPackage seq) =

    sb.Append(generateTarget packages repoName) |> ignore

let generateBazelFiles (repoName: string) (packages: NugetRepoPackage seq) (outputFolder: string) =
    let sb = new StringBuilder()
    addFileHeaderContent sb (repoName)
    addGroupToFileContent sb repoName packages
    File.WriteAllText($"{outputFolder}/{repoName}.bzl", sb.ToString())

    let extensionSb = new StringBuilder()
    addExtensionFileContent extensionSb (repoName)
    File.WriteAllText($"{outputFolder}/{repoName}_extension.bzl", extensionSb.ToString())
