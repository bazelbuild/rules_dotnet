module FSharpTypeProvider

open Lib
open NUnit.Framework
open System.Linq

[<TestFixture>]
type LibTests() =
    [<Test>]
    member this.Test() =
        let json = "{ \"foo\": [ 1, 2, 3 ] }"
        let p = Lib.FooJson.Parse json
        let list = Array.toSeq p.Foo
        Assert.AreEqual([ 1; 2; 3 ], list)
