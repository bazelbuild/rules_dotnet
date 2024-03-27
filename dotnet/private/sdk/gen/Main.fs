module DotnetPacks.Main

open System.IO

[<EntryPoint>]
let main argv =
    let sdkFolder = argv.[0]

    // Get the supported SDKs and generate sdk_versions.bzl
    Sdk.generateSdks (Path.Combine(sdkFolder, "versions.bzl"))

    // // Generate the RID graph
    Sdk.generateRids (Path.Combine(sdkFolder, "rids.bzl"))


    // Generate the targeting pack targets
    let targetingPacksFile = Path.Combine(sdkFolder, "gen", "targeting-packs.json")
    TargetingPacks.updateTargetingPacks targetingPacksFile

    TargetingPacks.writeTargetingPackLookupTable
        targetingPacksFile
        (Path.Combine(sdkFolder, "targeting_packs", "targeting_pack_lookup_table.bzl"))

    TargetingPacks.generateTargetingPackTargets
        targetingPacksFile
        (Path.Combine(sdkFolder, "targeting_packs", "targeting_packs.bzl"))


    // Get the supported SDKs and generate sdk_versions.bzl
    // Sdk.generateSdks (Path.Combine(outputFolder, "sdk_versions.bzl"))

    // // Generate the RID graph
    // Sdk.generateRids (Path.Combine(outputFolder, "rids.bzl"))

    // Get all targeting packs from NuGet.org and generate the Bazel files that index them
    // TODO

    // Get all runtime packs from NuGet.org and generate the Bazel files that index them
    // TODO

    // Get all apphost packs from NuGet.org and generate the Bazel files that index them
    // TODO

    // let group = DotnetPacks.Packs.getAllPackages outputFolder
    // let groups = NugetRepo.Parsing.parseGroups [ group ]

    // NugetRepo.Gen.generateBazelFiles groups outputFolder "dotnet" None NugetRepo.Gen.NamingConvention.IdAndVersionAsName

    0 // return an integer exit
