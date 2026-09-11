[<RequireQualifiedAccess>]
module NugetHelpers

open NuGet.Common
open System.Threading
open NuGet.Protocol.Core.Types
open NuGet.Configuration
open System
open System.Collections.Generic
open Paket
open Paket.PackageResolver
open System.IO
open System.Security.Cryptography
open System.Collections.Concurrent
open NuGet.Versioning

type private NuGetLogger() =
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

type Package =
    { id: string
      version: string
      sha512sri: string
      sources: string seq }


let private logger = NuGetLogger()
let packageCache = ConcurrentDictionary<string, Package>()

let nugetV3Feed = "https://api.nuget.org/v3/index.json"

let getAllVersions packageId =
    let providers = new List<Lazy<INuGetResourceProvider>>()
    providers.AddRange(Repository.Provider.GetCoreV3()) // Add v3 API support
    let packageSource = new PackageSource("https://api.nuget.org/v3/index.json")
    let sourceRepository = new SourceRepository(packageSource, providers)
    let cache = new SourceCacheContext()

    let packageSearchResource = sourceRepository.GetResource<FindPackageByIdResource>()


    let result =
        packageSearchResource.GetAllVersionsAsync(packageId, cache, logger, CancellationToken.None)

    result.Result |> Seq.map (fun v -> v) |> Seq.toList

let downloadPackage packageId version =
    Paket.NuGet.DownloadAndExtractPackage(
        None,
        "",
        false,
        PackagesFolderGroupConfig.NoPackagesFolder,
        PackageSources.PackageSource.NuGetV3Source "https://api.nuget.org/v3/index.json",
        [],
        Domain.GroupName "wat",
        Domain.PackageName packageId,
        SemVer.Parse version,
        ResolvedPackageKind.Package,
        false,
        false,
        false,
        true
    )

let private getPackageFilePath (packageName: string) (packageVersion: string) =
    Paket.NuGetCache.GetTargetUserNupkg (Domain.PackageName packageName) (Paket.SemVer.Parse packageVersion)

let private getSha512Sri (packageName: string) (packageVersion: string) =
    let path = getPackageFilePath packageName packageVersion

    use stream = File.OpenRead(path)

    use sha512Hash = SHA512.Create()
    let base64 = Convert.ToBase64String(sha512Hash.ComputeHash(stream))

    $"sha512-{base64}"


let getPackageInfo id version source =
    let found, value = packageCache.TryGetValue(sprintf "%s-%s" id version)

    match found with
    | true -> value
    | false ->
        downloadPackage id version |> Async.RunSynchronously |> ignore

        let package =
            { id = id
              sha512sri = getSha512Sri id version
              sources = [ source ]
              version = NuGetVersion.Parse(version).ToFullString() }

        packageCache.TryAdd((sprintf "%s-%s" id version), package) |> ignore

        package
