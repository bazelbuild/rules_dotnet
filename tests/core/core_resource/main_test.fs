module example_test

open System
open System.IO
open System.Reflection
open System.Text

open Xunit


[<Fact>]
let ``CheckData1`` () =
    use stream =
        Assembly
            .GetExecutingAssembly()
            .GetManifestResourceStream("example_test.data1.txt")

    use reader = new StreamReader(stream, Encoding.UTF8)
    let txt = reader.ReadToEnd()
    Assert.Equal("data1", txt)


[<Fact>]
let ``CheckDataMulti1`` () =
    use stream =
        Assembly
            .GetExecutingAssembly()
            .GetManifestResourceStream("example_test2.data1.txt")

    use reader = new StreamReader(stream, Encoding.UTF8)
    let txt = reader.ReadToEnd()
    Assert.Equal("data1", txt)

[<Fact>]
let ``CheckDataMulti2`` () =
    use stream =
        Assembly
            .GetExecutingAssembly()
            .GetManifestResourceStream("example_test2.data2.txt")

    use reader = new StreamReader(stream, Encoding.UTF8)
    let txt = reader.ReadToEnd()
    Assert.Equal("data2", txt)