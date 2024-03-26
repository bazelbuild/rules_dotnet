module DotnetPacks.Packs

open NuGet.Common
open NuGet.Protocol.Core.Types
open NuGet.Configuration
open System
open System.Collections.Generic
open System.Threading
open Paket
open Paket.PackageResolver
open System.Text
open System.IO

type NuGetLogger() =
    interface ILogger with
        member this.LogDebug(message) = printf "%s" message
        member this.LogVerbose(message) = printfn "%s" message
        member this.LogInformation(message) = printfn "%s" message
        member this.LogMinimal(message) = printfn "%s" message
        member this.LogWarning(message) = printfn "%s" message
        member this.LogError(message) = printfn "%s" message
        member this.Log(level: LogLevel, message: string) : unit = printfn "%s" message
        member this.Log(message: ILogMessage) : unit = printfn "%s" message.Message
        member this.LogAsync(level: LogLevel, message: string) : Tasks.Task = task { printfn "%s" message }
        member this.LogAsync(message: ILogMessage) : Tasks.Task = task { printfn "%s" message.Message }
        member this.LogInformationSummary(message: string) : unit = printfn "%s" message

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

// Runtime packs and app host packs are also tied to a specific runtime version but they are also tied to a spcific
// RID. We fetch all available versions for each runtime pack since the end user can select which
// SDK version to use and which RID to target when publishing.
// We need fetch the runtime packs for the platforms we support. They can be found in toolchains_repo.bzl
let runtimePacks =
    [ "Microsoft.NETCore.App.Runtime.win-x64"
      "Microsoft.NETCore.App.Runtime.win-arm64"
      "Microsoft.NETCore.App.Runtime.linux-x64"
      "Microsoft.NETCore.App.Runtime.linux-arm64"
      "Microsoft.NETCore.App.Runtime.osx-x64"
      "Microsoft.NETCore.App.Runtime.osx-arm64"
      "Microsoft.AspNetCore.App.Runtime.win-x64"
      "Microsoft.AspNetCore.App.Runtime.win-arm64"
      "Microsoft.AspNetCore.App.Runtime.linux-x64"
      "Microsoft.AspNetCore.App.Runtime.linux-arm64"
      "Microsoft.AspNetCore.App.Runtime.osx-x64"
      "Microsoft.AspNetCore.App.Runtime.osx-arm64" ]

let appHostPacks =
    [ "Microsoft.NETCore.App.Host.win-x64"
      "Microsoft.NETCore.App.Host.win-arm64"
      "Microsoft.NETCore.App.Host.linux-x64"
      "Microsoft.NETCore.App.Host.linux-arm64"
      "Microsoft.NETCore.App.Host.osx-x64"
      "Microsoft.NETCore.App.Host.osx-arm64" ]

let fetchVersions packageId =
    let logger = NuGetLogger()
    let providers = new List<Lazy<INuGetResourceProvider>>()
    providers.AddRange(Repository.Provider.GetCoreV3()) // Add v3 API support
    let packageSource = new PackageSource("https://api.nuget.org/v3/index.json")
    let sourceRepository = new SourceRepository(packageSource, providers)
    let cache = new SourceCacheContext()

    let packageSearchResource = sourceRepository.GetResource<FindPackageByIdResource>()


    let result =
        packageSearchResource.GetAllVersionsAsync(packageId, cache, logger, CancellationToken.None)

    let versions =
        result.Result |> Seq.map (fun v -> (packageId, v.ToFullString())) |> Seq.toList

    versions
    |> Seq.map (fun (packageName, packageVersion) ->
        async {
            return!
                Paket.NuGet.DownloadAndExtractPackage(
                    None,
                    "",
                    false,
                    PackagesFolderGroupConfig.NoPackagesFolder,
                    PackageSources.PackageSource.NuGetV3Source "https://api.nuget.org/v3/index.json",
                    [],
                    Domain.GroupName "wat",
                    Domain.PackageName packageName,
                    SemVer.Parse packageVersion,
                    ResolvedPackageKind.Package,
                    false,
                    false,
                    false,
                    true
                )
        })
    |> (fun x -> Async.Parallel(x, maxDegreeOfParallelism = Environment.ProcessorCount))
    |> Async.RunSynchronously
    |> ignore

    versions

let generateTargetingPackTargets (targetingPacks: (string * string) seq) outputFolder =
    let sb = new StringBuilder()

    sb.AppendLine("\"Generated\"") |> ignore
    sb.AppendLine() |> ignore

    sb.AppendLine("load(\"//dotnet/private/packs/targeting:targeting_pack.bzl\", \"targeting_pack\")")
    |> ignore

    sb.AppendLine() |> ignore
    sb.AppendLine("def targeting_packs():") |> ignore
    sb.AppendLine("    \"\"\"Targeting packs\"\"\"") |> ignore
    sb.AppendLine() |> ignore

    for (packageName, packageVersion) in targetingPacks do
        let deps =
            if targetingPackDeps.ContainsKey(packageName) then
                targetingPackDeps.[packageName]
            else
                []

        let packs =
            [ packageName ] @ (deps |> List.ofSeq)
            |> List.map (fun p -> $"\"@dotnet.packs//{p.ToLower()}.v{packageVersion}\"")
            |> String.concat ", "


        sb.AppendLine($"    targeting_pack(name = \"{packageName.ToLower()}.v{packageVersion}\", packs = [{packs}])")
        |> ignore

    sb.AppendLine() |> ignore

    File.WriteAllText($"{outputFolder}/targeting_packs.bzl", sb.ToString())


let getAllPackages outputFolder =
    let fle =
        [ netFramework; netStandard; netStandard21 ]
        |> List.map (fun (name, _) -> name)
        |> List.collect fetchVersions

    let targetingPackVersions =
        netcore1And2TargetingPacks @ netcore3AndAboveTargetingPacks
        |> List.collect fetchVersions

    let runtimePackVersions = runtimePacks |> List.collect fetchVersions

    let appHostPackVersions = appHostPacks |> List.collect fetchVersions

    generateTargetingPackTargets (netFramework :: netStandard :: netStandard21 :: targetingPackVersions) outputFolder

    let allPackages =
        netFramework :: netStandard :: netStandard21 :: targetingPackVersions
        @ runtimePackVersions
        @ appHostPackVersions

    ("packs", [ "https://api.nuget.org/v3/index.json" ] |> Seq.ofList, allPackages |> Seq.ofList)
