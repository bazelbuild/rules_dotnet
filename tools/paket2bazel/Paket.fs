module Paket2Bazel.Paket

open Paket
open System.Collections.Generic
open FSharpx.Collections
open NuGet.Versioning
open Paket2Bazel.Models
open System

let getDependencies
    dependenciesFile
    (config: Dictionary<string, Override option>)
    (cache: Dictionary<string, Package>)
    =
    let maybeDeps = Dependencies.TryLocate(dependenciesFile)

    match maybeDeps with
    | Some (deps) ->
        // TODO: Make it fail if lockfile is not up to date
        deps.Install false

        deps.GetInstalledPackages()
        |> List.map
            (fun (group, name, version) ->
                let found, value =
                    cache.TryGetValue(sprintf "%s-%s" group name)

                let buildFileOverride =
                    config.GetValueOrDefault(name, None)
                    |> Option.map (fun i -> i.buildFile)

                match found with
                | true -> value
                | false ->
                    let package =
                        { name = name
                          group = group
                          version = NuGetVersion.Parse(version).ToFullString()
                          buildFileOverride = buildFileOverride }

                    cache.Add((sprintf "%s-%s" group name), package)
                    |> ignore

                    package)
    | None -> failwith "Failed to locate paket.dependencies file"
