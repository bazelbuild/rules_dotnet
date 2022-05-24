module Paket2Bazel.Paket

open Paket
open System.Collections.Generic
open FSharpx.Collections
open NuGet.Versioning
open Paket2Bazel.Models
open System.IO
open System.Security.Cryptography
open Paket.Requirements


let frameworkRestrictionsToTFMs (frameworkRestrictions: FrameworkRestrictions) : FrameworkIdentifier list =
    match frameworkRestrictions with
    | Paket.Requirements.ExplicitRestriction restriction ->
        restriction.RepresentedFrameworks
        |> Seq.map (fun r -> r.Frameworks)
        |> Seq.concat
        |> Seq.toList
    | Paket.Requirements.AutoDetectFramework ->
        failwith
            "Framework auto detection is not supported by paket2bazel. Please specify framework restrictions in the paket.dependencies file."

let getSha256 (packageName: string) (packageVersion: string) =
    let path =
        Paket.NuGetCache.GetTargetUserNupkg (Domain.PackageName packageName) (Paket.SemVer.Parse packageVersion)

    use stream = File.OpenRead(path)

    use sha256 = SHA256.Create()
    let bytes = sha256.ComputeHash(stream)
    let mutable result = ""

    for b in bytes do
        result <- result + b.ToString("x2")

    result

let getDependenciesPerTFM (packageName: string) (packageVersion: string) =
    let path =
        Paket.NuGetCache.GetTargetUserNupkg (Domain.PackageName packageName) (Paket.SemVer.Parse packageVersion)
        |> Path.GetDirectoryName

    let nuspec = Paket.NuGet.GetContent path

    // TODO: Filter out framework references
    nuspec.Value.Spec.Dependencies.Value
    |> List.map (fun (name, _versionRestrictions, frameworkRestrictions) ->
        frameworkRestrictionsToTFMs frameworkRestrictions
        |> List.map (fun identifier -> (identifier, name.Name)))
    |> List.concat
    |> List.groupBy (fun (frameworkIdentifier, name) -> frameworkIdentifier)
    |> List.map (fun (frameworkIdentifier, packages) ->
        (frameworkIdentifier, packages |> List.map (fun (_, name) -> name)))
    |> Map.ofSeq

let getLibsPerTFM (tfms: FrameworkIdentifier list) (installModel: InstallModel) =
    tfms
    |> Seq.map (fun tfm ->
        let targetPlatform = TargetProfile.SinglePlatform tfm
        (tfm,
         installModel.GetCompileReferences targetPlatform
         |> Seq.choose (fun library ->
             if library.PathWithinPackage.StartsWith("lib") then
                 (Some library.PathWithinPackage)
             else
                 None)
         |> Seq.toList))
    |> Map.ofSeq

let getRefsPerTFM (tfms: FrameworkIdentifier list) (installModel: InstallModel) =
    tfms
    |> Seq.map (fun tfm ->
        let targetPlatform = TargetProfile.SinglePlatform tfm

        (tfm,
         installModel.GetCompileReferences targetPlatform
         |> Seq.choose (fun library ->
             if library.PathWithinPackage.StartsWith("ref") then
                 (Some library.PathWithinPackage)
             else
                 None)
         |> Seq.toList))
    |> Map.ofSeq

let getPdbsPerTFM (tfms: FrameworkIdentifier list) packageName packageVersion =
    // let content =
    //     Paket.NuGetCache.GetTargetUserNupkg packageName packageVersion
    //     |> Path.GetDirectoryName
    //     |> NuGet.GetContent
    //     |> (fun c -> c.Force())

    // NuGet.tryFindFile
    // let libFiles =
    //     NuGet.tryFindFolder "lib" content
    //     |> Option.defaultValue []

    // tfms
    // |> List.map (fun tfm ->
    //     let targetPlatform = TargetProfile.SinglePlatform tfm
    //     targetPlatform.SupportedPlatformsTransitive |> Seq.iter (fun p -> System.Console.WriteLine($"%A{p.}"))
        
    //     let files =
    //         libFiles
    //         |> List.map (fun f -> f.PathWithinPackage)
    //         |> List.filter (fun f -> f.StartsWith($"lib/{tfm}"))
    //     (tfm, files))
    // |> Map.ofSeq
    Map.empty

let getRuntimeDependenciesPerTFM (tfms: FrameworkIdentifier list) (installModel: InstallModel) =
    tfms
        |> Seq.map (fun tfm ->
            let targetPlatform = TargetProfile.SinglePlatform tfm

            let byRids =
                Models.supportedRids
                |> List.map (fun rid -> 
                    let libraries = installModel.GetRuntimeLibraries RuntimeGraph.Empty (Rid.Of rid) targetPlatform
                    (rid, libraries |> Seq.map (fun library -> library.Library.PathWithinPackage) |> Seq.toList)) |> Map.ofSeq
            (tfm, byRids))
        |> Map.ofSeq

let getDependencies dependenciesFile (config: Config) (cache: Dictionary<string, Package>) =
    let maybeDeps = Dependencies.TryLocate(dependenciesFile)

    match maybeDeps with
    | Some (deps) ->
        deps.SimplePackagesRestore()

        let groups =
            deps.GetInstalledPackages()
            |> List.groupBy (fun (group, name, version) -> group)
            |> List.map (fun (group, packages) ->

                let tfms =
                    match
                        deps.GetDependenciesFile()
                            .Groups
                            .Item(Domain.GroupName group)
                            .Options
                            .Settings
                            .FrameworkRestrictions
                        with
                    | Paket.Requirements.ExplicitRestriction restriction ->
                        restriction.RepresentedFrameworks
                        |> Seq.map (fun r -> r.Frameworks |> Seq.map (fun f -> f))
                        |> Seq.concat
                        |> Seq.toList
                    | Paket.Requirements.AutoDetectFramework ->
                        failwith
                            "Framework auto detection is not supported by paket2bazel. Please specify framework restrictions in the paket.dependencies file."

                let packagesInGroup =
                    packages
                    |> List.map (fun (_, name, version) ->
                        let found, value = cache.TryGetValue(sprintf "%s-%s" group name)
                        let installModel = deps.GetInstalledPackageModel((Some group), name)
                        let sha256 = getSha256 name version

                        let dependencies = getDependenciesPerTFM name version

                        let overrides =
                            config.packageOverrides
                            |> Option.bind (fun i -> i.GetValueOrDefault(name, None))

                        match found with
                        | true -> value
                        | false ->
                            let package =
                                { name = name
                                  group = group
                                  sha256 = sha256
                                  version = NuGetVersion.Parse(version).ToFullString()
                                  buildFileOverride = overrides |> Option.map (fun o -> o.buildFile)
                                  dependencies = dependencies
                                  libs = getLibsPerTFM tfms installModel
                                  refs = getRefsPerTFM tfms installModel
                                  pdbs = getPdbsPerTFM tfms (Domain.PackageName name) (Paket.SemVer.Parse version)
                                  runtimeFiles = getRuntimeDependenciesPerTFM tfms installModel }

                            cache.Add((sprintf "%s-%s" group name), package)
                            |> ignore

                            package)

                { name = group
                  packages = packagesInGroup
                  tfms = tfms })

        groups
    | None -> failwith "Failed to locate paket.dependencies file"
