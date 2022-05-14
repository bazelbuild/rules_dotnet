module PaketExample
open Argu
open System
open FSharp.Data

type CliArguments =
    | [<Mandatory>] Print_This of path: string

    interface IArgParserTemplate with
        member s.Usage =
            match s with
            | Print_This _ -> "String to print"

type Numbers = JsonProvider<""" [1, 2, 3, 3.14] """> 


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

    let data = WorldBankData.GetDataContext()

    let gdp =
        data
            .Countries.``United Kingdom``
            .Indicators.``Gross capital formation (% of GDP)``
            |> Seq.maxBy fst

    System.Console.WriteLine($"{gdp}")

    0
