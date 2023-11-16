module RunfilesExample

open NUnit.Framework
open System.Linq
open Bazel
open System.IO

[<TestFixture>]
type RunfilesTest () =
    [<Test>]
    member this.ShouldBeAbleToReadDataFile() =
        let runfiles = Runfiles.Create()
        let dataFilePath = runfiles.Rlocation("rules_dotnet_examples/runfiles_fsharp/data-file")
        let data = File.ReadAllLines(dataFilePath)[0]
        Assert.AreEqual("SOME CRAZY DATA!", data)
