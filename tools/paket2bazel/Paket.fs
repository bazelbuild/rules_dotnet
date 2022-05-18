module Paket2Bazel.Paket

open Paket
open System.Collections.Generic
open FSharpx.Collections
open NuGet.Versioning
open Paket2Bazel.Models
open System

let getDependencies dependenciesFile (config: Config) (cache: Dictionary<string, Package>) =
    let maybeDeps = Dependencies.TryLocate(dependenciesFile)

    match maybeDeps with
    | Some (deps) ->
        deps.SimplePackagesRestore()

        let groups =
            deps.GetInstalledPackages()
            |> List.groupBy (fun (group, name, version) -> group)
            |> List.map (fun (group, packages) ->

                let packagesInGroup =
                    packages
                    |> List.map (fun (_, name, version) ->
                        let found, value = cache.TryGetValue(sprintf "%s-%s" group name)

                        let overrides =
                            config.packageOverrides
                            |> Option.bind (fun i -> i.GetValueOrDefault(name, None))

                        match found with
                        | true -> value
                        | false ->
                            let package =
                                { name = name
                                  version = NuGetVersion.Parse(version).ToFullString()
                                  buildFileOverride = overrides |> Option.map (fun o -> o.buildFile) }

                            cache.Add((sprintf "%s-%s" group name), package)
                            |> ignore

                            package)


                let frameworkRestrictions =
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
                        |> Seq.map (fun r -> r.Frameworks |> Seq.map (fun f -> f.ToString()))
                        |> Seq.concat
                        |> Seq.toList
                    | Paket.Requirements.AutoDetectFramework ->
                        failwith
                            "Framework auto detection is not supported by paket2bazel. Please specify framework restrictions in the paket.dependencies file."

                { name = group
                  packages = packagesInGroup
                  tfms = frameworkRestrictions })

        groups
    | None -> failwith "Failed to locate paket.dependencies file"
