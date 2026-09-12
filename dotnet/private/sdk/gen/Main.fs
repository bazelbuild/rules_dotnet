module DotnetPacks.Main

open System.IO

[<EntryPoint>]
let main argv =
    let sdkFolder = argv.[0]

    // Get the supported SDKs and generate sdk_versions.bzl
    Sdk.generateSdks (Path.Combine(sdkFolder, "versions.bzl"))

    // // Generate the RID graph
    Sdk.generateRids (Path.Combine(sdkFolder, "rids.bzl"))


    Packs.generatePackBands (Path.Combine(sdkFolder, "pack_bands.bzl"))

    0
