open System
open System.IO
open Lib

[<EntryPoint>]
let main args =
    File.WriteAllText(args[0], Lib.Stuff.helloWorld ())
    0
