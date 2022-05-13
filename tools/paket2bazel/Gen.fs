module Paket2Bazel.Gen

open Paket
open System.Collections.Generic
open NuGet.Packaging
open NuGet.Frameworks
open FSharpx.Option
open FSharpx.Collections
open FSharpx
open System.IO
open System.Security.Cryptography
open System.Text
open Paket2Bazel.Models

let coreFrameworkTFMs =
    [ "netcoreapp2.0"
      "netcoreapp2.1"
      "netcoreapp2.2"
      "netcoreapp3.0"
      "netcoreapp3.1"
      "net5.0" ]
    |> List.map NuGetFramework.Parse

let getLibFile (packageName: string) (packageReader: PackageFolderReader) =
    let frameworkReducer = FrameworkReducer()
    let allLibItems = packageReader.GetLibItems()

    coreFrameworkTFMs
    |> List.map
        (fun targetFramework ->
            let nearest =
                frameworkReducer.GetNearest(
                    targetFramework,
                    (allLibItems
                     |> Seq.map (fun i -> i.TargetFramework))
                )

            let libItems =
                allLibItems
                |> Seq.filter (fun i -> i.TargetFramework = nearest)
                |> Seq.collect (fun group -> group.Items)
                |> Seq.filter (fun i -> i.EndsWith(".dll"))

            match libItems
                  |> Seq.tryFind
                      (fun i ->
                          i
                              .ToLower()
                              .Contains($"/{packageName.ToLower()}.dll")) with
            | Some (lib) -> Some((targetFramework.GetShortFolderName(), lib))
            | None ->
                match libItems |> Seq.tryHead with
                | Some (head) -> Some((targetFramework.GetShortFolderName(), head))
                | None -> None)
    |> List.choose id

let getRefItems (packageName: string) (packageReader: PackageFolderReader) =
    let frameworkReducer = FrameworkReducer()
    let allRefItems = packageReader.GetReferenceItems()

    coreFrameworkTFMs
    |> List.map
        (fun targetFramework ->
            let nearest =
                frameworkReducer.GetNearest(
                    targetFramework,
                    (allRefItems
                     |> Seq.map (fun i -> i.TargetFramework))
                )

            let refItems =
                allRefItems
                |> Seq.filter (fun i -> i.TargetFramework = nearest)
                |> Seq.collect (fun group -> group.Items)
                |> Seq.filter (fun i -> i.EndsWith(".dll"))

            match refItems
                  |> Seq.tryFind
                      (fun i ->
                          i
                              .ToLower()
                              .Contains($"/{packageName.ToLower()}.dll")) with
            | Some (lib) -> Some((targetFramework.GetShortFolderName(), lib))
            | None ->
                match refItems |> Seq.tryHead with
                | Some (head) -> Some((targetFramework.GetShortFolderName(), head))
                | None -> None)
    |> List.choose id

// TODO: Do something for tools
let getToolItems (packageName: string) (packageReader: PackageFolderReader) =
    let frameworkReducer = FrameworkReducer()
    let toolItems = packageReader.GetToolItems()

    coreFrameworkTFMs
    |> List.map
        (fun targetFramework ->
            let nearest =
                frameworkReducer.GetNearest(targetFramework, (toolItems |> Seq.map (fun i -> i.TargetFramework)))

            let toolItems =
                toolItems
                |> Seq.filter (fun i -> i.TargetFramework = nearest)
                |> Seq.collect (fun group -> group.Items)

            match toolItems
                  |> Seq.tryFind
                      (fun i ->
                          i
                              .ToLower()
                              .Contains($"/{packageName.ToLower()}.dll")) with
            | Some (lib) -> Some((targetFramework.GetShortFolderName(), lib))
            | None ->
                match toolItems |> Seq.tryHead with
                | Some (head) -> Some((targetFramework.GetShortFolderName(), head))
                | None -> None)
    |> List.choose id

let getItems folderName (packageReader: PackageFolderReader) =
    let frameworkReducer = FrameworkReducer()

    let fileItems = packageReader.GetItems(folderName)

    coreFrameworkTFMs
    |> List.map
        (fun targetFramework ->
            let nearest =
                frameworkReducer.GetNearest(targetFramework, (fileItems |> Seq.map (fun i -> i.TargetFramework)))

            let frameworkFileItems =
                fileItems
                |> Seq.filter (fun i -> i.TargetFramework = nearest)
                |> Seq.collect (fun group -> group.Items)
                |> Seq.toList

            (targetFramework.GetShortFolderName(), frameworkFileItems))

let getFiles (packageReader: PackageFolderReader) =
    let frameworkReducer = FrameworkReducer()

    let dict = Dictionary<string, string list>()

    getItems "lib" packageReader
    |> List.append (getItems "runtimes" packageReader)
    |> List.append (getItems "typeproviders" packageReader)
    |> List.append (getItems "tools" packageReader)
    |> List.iter
        (fun (x, y) ->
            if dict.ContainsKey(x) then
                let prev = dict.GetValueOrDefault(x, [])
                dict.Remove(x) |> ignore
                dict.Add(x, prev |> List.append y)
            else
                dict.Add(x, y))


    dict.ToFSharpList()
    |> List.map (fun i -> (i.Key, i.Value))

let getDependenciesPerFramework (group: string) (packageReader: PackageFolderReader) =
    let frameworkReducer = FrameworkReducer()

    let deps = packageReader.GetPackageDependencies()

    coreFrameworkTFMs
    |> List.map
        (fun targetFramework ->
            let nearest =
                frameworkReducer.GetNearest(targetFramework, (deps |> Seq.map (fun i -> i.TargetFramework)))

            let frameworkdeps =
                deps
                |> Seq.filter (fun i -> i.TargetFramework = nearest)
                |> Seq.collect (fun group -> group.Packages)
                |> Seq.map (fun i -> $"@{group.ToLower()}.{i.Id.ToLower()}//:lib")
                |> Seq.toList

            (targetFramework.GetShortFolderName(), frameworkdeps))

let getSha256 (packagesFolderPath: string) (packageName: string) (packageVersion: string) =
    use stream =
        File.OpenRead($"{packagesFolderPath}/{packageName}/{packageName.ToLower()}.{packageVersion}.nupkg")

    use sha256 = SHA256.Create()
    let bytes = sha256.ComputeHash(stream)
    let mutable result = ""

    for b in bytes do
        result <- result + b.ToString("x2")

    result

let processInstalledPackages (dependencies: Package list) paketDir : ProcessedPackage list =
    dependencies
    |> List.map
        (fun d ->
            let packageReader =
                new PackageFolderReader(if d.group = "main" then $"{paketDir}/packages/{d.name}" else $"{paketDir}/packages/{d.group}/{d.name}")

            maybe {
                let sha256 =
                    getSha256 (if d.group = "main" then $"{paketDir}/packages" else $"{paketDir}/packages/{d.group}") d.name d.version

                let libFile = getLibFile d.name packageReader
                let refItems = getRefItems d.name packageReader
                let toolItems = getToolItems d.name packageReader
                let fileItems = getFiles packageReader

                let deps =
                    getDependenciesPerFramework d.group packageReader

                return
                    { name = $"{d.group.ToLower()}.{d.name.ToLower()}"
                      package = d.name.ToLower()
                      group = d.group
                      version = d.version
                      buildFileOverride = d.buildFileOverride
                      sha256 = sha256
                      lib = libFile
                      deps = deps
                      toolItems = toolItems
                      refItems = refItems
                      fileItems = fileItems }
            })
    |> List.choose id

let generateTarget (package: ProcessedPackage) =
    let i = "    "
    let sb = new StringBuilder()
    sb.Append($"{i}nuget_package(\n") |> ignore

    sb.Append($"{i}    name = \"{package.name.ToLower()}\",\n")
    |> ignore

    sb.Append($"{i}    package = \"{package.package.ToLower()}\",\n")
    |> ignore

    sb.Append($"{i}    version = \"{package.version}\",\n")
    |> ignore

    sb.Append($"{i}    sha256 = \"{package.sha256}\",\n")
    |> ignore

    if package.lib.Length > 0 then
        sb.Append($"{i}    core_lib = {{\n") |> ignore

        for (key, value) in package.lib do
            sb.Append($"{i}        \"{key}\": \"{value}\",\n")
            |> ignore

        sb.Append($"{i}    }},\n") |> ignore

    if (package.refItems
        |> List.fold (fun s (x, y) -> s + y.Length) 0) > 0 then
        sb.Append($"{i}    core_ref = {{\n") |> ignore

        for (key, value) in package.refItems do
            sb.Append($"{i}        \"{key}\": \"{value}\",\n")
            |> ignore

        sb.Append($"{i}    }},\n") |> ignore

    if (package.toolItems
        |> List.fold (fun s (x, y) -> s + y.Length) 0) > 0 then
        sb.Append($"{i}    core_tool = {{\n") |> ignore

        for (key, value) in package.toolItems do
            sb.Append($"{i}        \"{key}\": \"{value}\",\n")
            |> ignore

        sb.Append($"{i}    }},\n") |> ignore

    if (package.deps
        |> List.fold (fun s (x, y) -> s + y.Length) 0) > 0 then
        sb.Append($"{i}    core_deps = {{\n") |> ignore

        for (key, value) in package.deps do
            if value.Length > 0 then
                sb.Append($"{i}        \"{key}\": [\n") |> ignore

                for v in value do
                    sb.Append($"{i}            \"{v}\",\n") |> ignore

                sb.Append($"{i}        ],\n") |> ignore

        sb.Append($"{i}    }},\n") |> ignore

    if (package.fileItems
        |> List.fold (fun s (x, y) -> s + y.Length) 0) > 0 then
        sb.Append($"{i}    core_files = {{\n") |> ignore

        for (key, value) in package.fileItems do
            if value.Length > 0 then
                sb.Append($"{i}        \"{key}\": [\n") |> ignore

                for v in value do
                    sb.Append($"{i}            \"{v}\",\n") |> ignore

                sb.Append($"{i}        ],\n") |> ignore

        sb.Append($"{i}    }},\n") |> ignore

    sb.Append($"{i})\n") |> ignore
    sb.ToString()

let generateTargetWithOverride (buildFile: string) package =
    let i = "    "
    let sb = new StringBuilder()
    sb.Append($"{i}dotnet_nuget_new(\n") |> ignore

    sb.Append($"{i}    name = \"{package.name.ToLower()}\",\n")
    |> ignore

    sb.Append($"{i}    package = \"{package.package.ToLower()}\",\n")
    |> ignore

    sb.Append($"{i}    version = \"{package.version}\",\n")
    |> ignore

    sb.Append($"{i}    sha256 = \"{package.sha256}\",\n")
    |> ignore

    sb.Append($"{i}    build_file = \"{buildFile}\",\n")
    |> ignore

    sb.Append($"{i})\n") |> ignore

    sb.ToString()

let generateBazelFile (packages: ProcessedPackage list) =
    let sb = new StringBuilder()

    sb.Append("load(\"@rules_dotnet//dotnet:defs.bzl\", \"dotnet_nuget_new\", \"nuget_package\")")
    |> ignore

    sb.Append("\n") |> ignore
    sb.Append("\n") |> ignore
    sb.Append("def paket():") |> ignore
    sb.Append("\n") |> ignore
    sb.Append("    \"paket\"") |> ignore
    sb.Append("\n") |> ignore

    packages
    |> List.sortBy (fun i -> i.name)
    |> List.map
        (fun i ->
            match i.buildFileOverride with
            | Some (buildFile) -> generateTargetWithOverride buildFile i
            | None -> generateTarget i)
    |> List.iter (fun i -> sb.Append(i) |> ignore)

    sb.ToString()
