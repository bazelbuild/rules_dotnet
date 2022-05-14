module Paket2Bazel.Main

open Paket
open Argu
open System
open System.Collections.Generic
open System.IO
open Paket2Bazel.Paket
open Paket2Bazel.Gen
open Paket2Bazel.Models
open System.Text.Json
open System.Text.Json.Serialization

type CliArguments =
    | [<Mandatory>] Dependencies_File of path: string
    | [<Mandatory>] Output_Folder of path: string
    | Config of path: string

    interface IArgParserTemplate with
        member s.Usage =
            match s with
            | Dependencies_File _ -> "Path to paket.dependencies file"
            | Output_Folder _ -> "Folder where the output will be generated in"
            | Config _ -> "Configuration file in JSON format for per dependency overrides"

let getConfig (results: ParseResults<CliArguments>) =
    let options : JsonSerializerOptions =
        let options = JsonSerializerOptions()
        options.Converters.Add(JsonFSharpConverter())
        options.PropertyNamingPolicy <- JsonNamingPolicy.CamelCase
        options

    let json =
        Path.GetFullPath(results.GetResult Config)
        |> File.ReadAllText

    JsonSerializer.Deserialize<Config>(json, options)

[<EntryPoint>]
let main argv =
    let errorHandler =
        ProcessExiter(
            colorizer =
                function
                | ErrorCode.HelpText -> None
                | _ -> Some ConsoleColor.Red
        )

    let parser =
        ArgumentParser.Create<CliArguments>(programName = "paket2bazel", errorHandler = errorHandler)

    let results = parser.ParseCommandLine argv

    let dependenciesFile =
        Path.GetFullPath(results.GetResult Dependencies_File)

    let paketDir = Path.GetDirectoryName(dependenciesFile)

    let lockFile = paketDir + "/paket.lock"

    let outputFolder = results.GetResult Output_Folder

    let config = getConfig results

    let cache = Dictionary<string, Package>()

    let dependencies =
        getDependencies dependenciesFile config cache

    let processedPackages =
        processInstalledPackages dependencies paketDir

    let bazelFile = generateBazelFile processedPackages

    File.WriteAllText($"{outputFolder}/BUILD.bazel", "")
    File.WriteAllText($"{outputFolder}/paket.bzl", bazelFile)

    0 // return an integer exit
