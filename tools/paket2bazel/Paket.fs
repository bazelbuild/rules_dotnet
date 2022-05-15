module Paket2Bazel.Paket

open Paket
open System.Collections.Generic
open FSharpx.Collections
open NuGet.Versioning
open Paket2Bazel.Models
open System

let getDependencies
    dependenciesFile
    (config: Config)
    (cache: Dictionary<string, Package>)
    =
    let maybeDeps = Dependencies.TryLocate(dependenciesFile)

    match maybeDeps with
    | Some (deps) ->
        // TODO: Make it fail if lockfile is not up to date
        deps.SimplePackagesRestore ()

        deps.GetInstalledPackages() 
        |> List.map
            (fun (group, name, version) ->
                let found, value =
                    cache.TryGetValue(sprintf "%s-%s" group name)

                let overrides = 
                    config.packageOverrides
                    |> Option.bind (fun i -> i.GetValueOrDefault(name, None))

                match found with
                | true -> value
                | false ->
                    let package =
                        { name = name
                          group = group
                          version = NuGetVersion.Parse(version).ToFullString()
                          buildFileOverride = overrides |> Option.map (fun o -> o.buildFile) }

                    cache.Add((sprintf "%s-%s" group name), package)
                    |> ignore

                    package)
    | None -> failwith "Failed to locate paket.dependencies file"
