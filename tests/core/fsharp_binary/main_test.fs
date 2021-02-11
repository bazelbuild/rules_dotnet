module example_test

open System
open System.IO

open Xunit

[<Fact>]
let ``MyTest`` () = Assert.True("bar" = "bar")