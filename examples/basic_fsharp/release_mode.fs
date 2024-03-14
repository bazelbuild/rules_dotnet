open System

#if DEBUG
let debug = true
#else
let debug = false
#endif

#if RELEASE
let release = true
#else
let release = false
#endif

[<EntryPoint>]
let main args =
    printfn $"DEBUG = %b{debug}"
    printfn $"RELEASE = %b{release}"

    0
