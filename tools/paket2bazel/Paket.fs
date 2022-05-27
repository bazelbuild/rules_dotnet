module Paket2Bazel.Paket

open Paket
open System.Collections.Generic
open FSharpx.Collections
open NuGet.Versioning
open Paket2Bazel.Models
open System.IO
open System.Security.Cryptography
open Paket.Requirements
open NuGet.Packaging
open NuGet.Frameworks


let getPackageFilePath (packageName: string) (packageVersion: string) =
    Paket.NuGetCache.GetTargetUserNupkg (Domain.PackageName packageName) (Paket.SemVer.Parse packageVersion)

let getPackageFolderPath (packageName: string) (packageVersion: string) =
    Paket.NuGetCache.GetTargetUserFolder (Domain.PackageName packageName) (Paket.SemVer.Parse packageVersion)

let getClosestFrameworkFiles (targetFramework: NuGetFramework) (frameworkItems: FrameworkSpecificGroup seq) =
    let frameworkReducer = FrameworkReducer()

    let nearest =
        frameworkReducer.GetNearest(
            targetFramework,
            (frameworkItems
             |> Seq.map (fun i -> i.TargetFramework))
        )

    let frameworkFileItems =
        frameworkItems
        |> Seq.filter (fun i -> i.TargetFramework = nearest)
        |> Seq.collect (fun group -> group.Items)

    frameworkFileItems

let frameworkRestrictionsToTFMs (frameworkRestrictions: FrameworkRestrictions) : FrameworkIdentifier seq =
    match frameworkRestrictions with
    | Paket.Requirements.ExplicitRestriction restriction ->
        restriction.RepresentedFrameworks
        |> Seq.map (fun r -> r.Frameworks)
        |> Seq.concat
    | Paket.Requirements.AutoDetectFramework ->
        failwith
            "Framework auto detection is not supported by paket2bazel. Please specify framework restrictions in the paket.dependencies file."

let getSha256 (packageName: string) (packageVersion: string) =
    let path = getPackageFilePath packageName packageVersion

    use stream = File.OpenRead(path)

    use sha256 = SHA256.Create()
    let bytes = sha256.ComputeHash(stream)
    let mutable result = ""

    for b in bytes do
        result <- result + b.ToString("x2")

    result

let getDependenciesPerTFM (tfms: NuGetFramework seq) (allDeps: string seq) (packageReader: PackageFolderReader) =
    let frameworkReducer = FrameworkReducer()
    let deps = packageReader.GetPackageDependencies()

    tfms
    |> Seq.map (fun targetFramework ->
        let nearest =
            frameworkReducer.GetNearest(targetFramework, (deps |> Seq.map (fun i -> i.TargetFramework)))

        let frameworkdeps =
            deps

            |> Seq.filter (fun i -> i.TargetFramework = nearest)
            |> Seq.collect (fun group -> group.Packages)
            // Only use deps that Paket has resolved
            // Paket does not resolve framework built in dependencies
            |> Seq.filter (fun i -> Seq.contains i.Id allDeps)
            |> Seq.map (fun i -> i.Id)

        (targetFramework.GetShortFolderName(), frameworkdeps))
    |> Map.ofSeq

let getLibsPerTFM (tfms: NuGetFramework seq) (packageReader: PackageFolderReader) =
    tfms
    |> Seq.map (fun tfm ->
        let items =
            packageReader.GetItems "build"
            |> Seq.append (packageReader.GetItems "lib")
            |> getClosestFrameworkFiles tfm
            |> Seq.filter (fun f -> f.EndsWith(".dll"))

        (tfm.GetShortFolderName(), items))
    |> Map.ofSeq

let getRefsPerTFM (tfms: NuGetFramework seq) (packageReader: PackageFolderReader) =
    tfms
    |> Seq.map (fun tfm ->
        let items =
            packageReader.GetItems "ref"
            |> getClosestFrameworkFiles tfm
            |> Seq.filter (fun f -> f.EndsWith(".dll"))

        (tfm.GetShortFolderName(), items))
    |> Map.ofSeq

let getPdbsPerTFM (tfms: NuGetFramework seq) (packageReader: PackageFolderReader) =
    tfms
    |> Seq.map (fun tfm ->
        let items =
            packageReader.GetItems "lib"
            |> getClosestFrameworkFiles tfm
            |> Seq.filter (fun f -> f.EndsWith(".pdb"))

        (tfm.GetShortFolderName(), items))
    |> Map.ofSeq

let getRuntimeDependenciesPerTFM (tfms: NuGetFramework seq) (packageReader: PackageFolderReader) =
    tfms
    |> Seq.map (fun tfm ->
        let items =
            packageReader.GetItems("runtimes")
            |> Seq.collect (fun group -> group.Items)

        (tfm.GetShortFolderName(), items))
    |> Seq.map (fun (tfm, files) ->
        (tfm,
         Models.supportedRids
         |> Seq.map (fun rid ->
             (rid,
              Seq.fold
                  (fun (state: string seq) (current: string) ->
                      if current.Contains(rid) then
                          Seq.append [ current ] state
                      else
                          state)
                  []
                  files))
         |> Map.ofSeq))
    |> Map.ofSeq


let getDependencies dependenciesFile (config: Config) (cache: Dictionary<string, Package>) =
    let maybeDeps = Dependencies.TryLocate(dependenciesFile)

    match maybeDeps with
    | Some (deps) ->
        deps.SimplePackagesRestore()

        let groups =
            deps.GetInstalledPackages()
            |> Seq.groupBy (fun (group, name, version) -> group)
            |> Seq.map (fun (group, packages) ->

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
                        |> Seq.map (fun r ->
                            r.Frameworks
                            |> Seq.map (fun f -> NuGetFramework.Parse(f.ToString())))
                        |> Seq.concat
                    | Paket.Requirements.AutoDetectFramework ->
                        failwith
                            "Framework auto detection is not supported by paket2bazel. Please specify framework restrictions in the paket.dependencies file."

                let packagesInGroup =
                    packages
                    |> Seq.map (fun (_, name, version) ->
                        let found, value = cache.TryGetValue(sprintf "%s-%s" group name)


                        match found with
                        | true -> value
                        | false ->
                            let packageReader = new PackageFolderReader(getPackageFolderPath name version)
                            let sha256 = getSha256 name version

                            let package =
                                { name = name
                                  group = group
                                  sha256 = sha256
                                  version = NuGetVersion.Parse(version).ToFullString()
                                  buildFileOverride =
                                    config.packageOverrides
                                    |> Option.bind (fun i -> i.GetValueOrDefault(name, None))
                                    |> Option.map (fun o -> o.buildFile)
                                  dependencies =
                                    getDependenciesPerTFM
                                        tfms
                                        (packages |> Seq.map (fun (_, name, _) -> name))
                                        packageReader
                                  libs = getLibsPerTFM tfms packageReader
                                  refs = getRefsPerTFM tfms packageReader
                                  pdbs = getPdbsPerTFM tfms packageReader
                                  runtimeFiles = getRuntimeDependenciesPerTFM tfms packageReader }

                            cache.Add((sprintf "%s-%s" group name), package)
                            |> ignore

                            package)

                { name = group
                  packages = packagesInGroup
                  tfms = tfms |> Seq.map (fun f -> f.GetShortFolderName()) })

        groups
    | None -> failwith "Failed to locate paket.dependencies file"
