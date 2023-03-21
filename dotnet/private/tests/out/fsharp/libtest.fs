module Tests

open Lib
open NUnit.Framework
open System.Linq

[<TestFixture>]
type LibTests() =
    [<Test>]
    member this.SomeTest() = Assert.AreEqual(true, Stuff.isTrue ())

    [<Test>]
    member this.SomeTestInternal() =
        Assert.AreEqual(true, Stuff.isTrueInternal ())
