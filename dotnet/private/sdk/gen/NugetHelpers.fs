[<RequireQualifiedAccess>]
module NugetHelpers

open NuGet.Common
open System.Threading
open NuGet.Protocol.Core.Types
open NuGet.Configuration
open System
open System.Collections.Generic

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

let private logger = NuGetLogger()

let nugetV3Feed = "https://api.nuget.org/v3/index.json"

let getAllVersions packageId =
    let providers = new List<Lazy<INuGetResourceProvider>>()
    providers.AddRange(Repository.Provider.GetCoreV3())
    let packageSource = new PackageSource(nugetV3Feed)
    let sourceRepository = new SourceRepository(packageSource, providers)
    let cache = new SourceCacheContext()

    let packageSearchResource = sourceRepository.GetResource<FindPackageByIdResource>()

    let result =
        packageSearchResource.GetAllVersionsAsync(packageId, cache, logger, CancellationToken.None)

    result.Result |> Seq.toList
