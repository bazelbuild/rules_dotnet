module TargetingPacks

open System.Collections.Generic

// .Net Standard packs are not tied to a specific runtime version so we can just
// use the latest version of each pack.
// .Net Standard up until 2.0 can use the NETStandard.Library metapackage
let netStandard = ("NETStandard.Library", "2.0.3")
// .Net Standard 2.1 uses the NETStandard.Library.Ref targeting pack
let netStandard21 = ("NETStandard.Library.Ref", "2.1.0")

// Legacy .Net Framework packs (.Net 4.8 and lower) can use the metapackage Microsoft.NETFramework.ReferenceAssemblies
// The metapackage supports .Net Framework versions 2.0 to 4.8.1
let netFramework = ("Microsoft.NETFramework.ReferenceAssemblies", "1.0.3")

// .Net Core 1.0 - 2.2 use the targeting pack Microsoft.NETCore.App and each version is tied to a specific runtime version
// We fetch all available versions for each targeting pack since the end user can select which SDK version to use.
let netcore1And2TargetingPacks =
    [ "Microsoft.NETCore.App"; "Microsoft.AspNetCore.App" ]


// .Net Core 3 and above targeting packs are tied to a specific runtime version so we fetch all available versions
// for each targeting pack since the end user can select which SDK version to use.
let netcore3AndAboveTargetingPacks =
    [ "Microsoft.NETCore.App.Ref"; "Microsoft.AspNetCore.App.Ref" ]

// Targeting packs can have dependencie but they are undeclared in the NuGet package
// E.g. in the case of an ASP.NET Core app we need to add a dependency on the .Net Core targeting pack
let targetingPackDeps = Dictionary<string, string seq>()
targetingPackDeps.Add("Microsoft.AspNetCore.App.Ref", [ "Microsoft.NETCore.App.Ref" ])

let generateTargetingPacks output =
    let netcoreTargetingPacks =
        netcore1And2TargetingPacks @ netcore3AndAboveTargetingPacks
        |> List.collect NugetHelpers.getAllVersions

    let allTargetingPacks =
        netFramework :: netStandard :: netStandard21 :: netcoreTargetingPacks

    allTargetingPacks
    |> List.map (fun (name, version) -> NugetHelpers.getPackageInfo name version "https://api.nuget.org/v3/index.json")
    |> List.map (fun package -> { NugetRepo.NugetRepoPackage.id = package.id })
