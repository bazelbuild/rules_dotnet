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
