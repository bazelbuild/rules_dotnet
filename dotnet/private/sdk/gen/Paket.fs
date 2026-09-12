/// Keeps the Paket CLI pinned to the newest release.
///
/// Paket is pinned in two places that must agree: the `paket_cli` group in
/// paket.dependencies and dotnet-tools.json. When they disagree, restore
/// silently produces a project.assets.json with no libraries.
module Paket

open System.IO
open System.Text.RegularExpressions

/// The newest stable Paket release on NuGet.
let private latestVersion () =
    NugetHelpers.getAllVersions "Paket"
    |> List.filter (fun v -> not v.IsPrerelease)
    |> List.max
    |> fun v -> v.ToNormalizedString()

let private updateFile (path: string) (pattern: string) (replacement: string) =
    let original = File.ReadAllText path
    let updated = Regex.Replace(original, pattern, replacement)

    if updated <> original then
        File.WriteAllText(path, updated)
        true
    else
        false

let updatePaket (repoRoot: string) =
    let version = latestVersion ()
    printfn $"Pinning Paket CLI to {version}"

    // The paket_cli group only; other groups pin Paket for unrelated reasons
    // (the dotnet_tool tests deliberately use an older one).
    let dependencies = Path.Combine(repoRoot, "paket.dependencies")

    let changedDependencies =
        updateFile
            dependencies
            @"(?<prefix>group paket_cli(?:.|\n)*?nuget Paket )(?<version>\S+)"
            $"${{prefix}}{version}"

    let tools = Path.Combine(repoRoot, "dotnet-tools.json")

    let changedTools =
        updateFile tools @"(?<prefix>""paket"":\s*\{\s*""version"":\s*"")(?<version>[^""]+)" $"${{prefix}}{version}"

    if changedDependencies then
        printfn $"  paket.dependencies updated -- run `bazel run @rules_dotnet//tools/paket -- install` to refresh paket.lock"

    if changedTools then
        printfn "  dotnet-tools.json updated"

    if not (changedDependencies || changedTools) then
        printfn "  already up to date"
