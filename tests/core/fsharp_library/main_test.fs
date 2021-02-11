module example_test

open System
open System.IO
open System.Reflection

open Xunit

[<Fact>]
let ``MyTest`` () = Assert.True("bar" = "bar")

[<Fact>]
let ``CheckVersion`` () =
    let version =
        Assembly.GetExecutingAssembly().GetName().Version

    Assert.Equal(1, version.Major)
    Assert.Equal(0, version.Minor)