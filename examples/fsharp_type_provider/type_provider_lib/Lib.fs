module Lib

open FSharp.Data

type FooJson =
    // NOTE: The file is resolved relative to the WORKSPACE root!
    JsonProvider<"./fsharp_type_provider/type_provider_lib/foo.json", SampleIsList=false, InferTypesFromValues=true>
