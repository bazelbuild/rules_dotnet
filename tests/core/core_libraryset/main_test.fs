module example_test

open System
open System.IO
open System.Reflection

open Xunit

[<Fact>]
let ``MyTest2`` () =
    let src =
        Path.Combine(Path.GetDirectoryName(Assembly.GetExecutingAssembly().Location), "test.txt")

    Assert.True(File.Exists(src))