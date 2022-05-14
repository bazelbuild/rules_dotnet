module PaketExample
open Argu
open System

type CliArguments =
    | [<Mandatory>] Print_This of path: string

    interface IArgParserTemplate with
        member s.Usage =
            match s with
            | Print_This _ -> "String to print"

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
    let stringToPrint = results.GetResult Print_This

    System.Console.WriteLine($"{stringToPrint}")
    0
