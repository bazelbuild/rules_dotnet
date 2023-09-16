module Paket2Bazel.Main

open Paket
open Argu
open System
open System.Collections.Generic
open System.IO
open Paket2Bazel.Gen
open Paket2Bazel.Models

type CliArguments =
    | [<Mandatory>] Dependencies_File of path: string
    | [<Mandatory>] Output_Folder of path: string
    | Put_Groups_Into_Separate_Files
    | Netrc_File_Label of path: string option

    interface IArgParserTemplate with
        member s.Usage =
            match s with
            | Dependencies_File _ -> "Path to paket.dependencies file"
            | Output_Folder _ -> "Folder where the output will be generated in"
            | Put_Groups_Into_Separate_Files ->
                "If enabled each Paket group will be put into a file with the same name as the group. The default group will always be put into the `paket.bzl` file"
            | Netrc_File_Label _ -> "A Bazel label pointing to a netrc file"

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

    let dependenciesFile = Path.GetFullPath(results.GetResult Dependencies_File)

    let outputFolder = results.GetResult Output_Folder

    let cache = Dictionary<string, Package>()

    let groups = getDependencies dependenciesFile cache

    let separateFiles = results.Contains Put_Groups_Into_Separate_Files

    let netrcLabel =
        results.TryGetResult Netrc_File_Label
        |> Option.bind (fun x -> x)

    generateBazelFiles groups separateFiles outputFolder netrcLabel

    0 // return an integer exit
