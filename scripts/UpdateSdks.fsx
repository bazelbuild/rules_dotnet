open System.Net
open System.IO
open System.Text.Json.Serialization
open System.Text.Json
open System.Text
open System

let supportedChannels = [ "6.0"; "7.0" ]

type File =
    { [<JsonPropertyName "name">]
      Name: string
      [<JsonPropertyName "rid">]
      Rid: string
      [<JsonPropertyName "url">]
      Url: string
      [<JsonPropertyName "hash">]
      Hash: string }

type Sdk =
    { [<JsonPropertyName "version">]
      Version: string
      [<JsonPropertyName "runtime-version">]
      RuntimeVersion: string
      [<JsonPropertyName "files">]
      Files: File seq
      [<JsonPropertyName "csharp-version">]
      CSharpVersion: string
      [<JsonPropertyName "fsharp-version">]
      FSharpVersion: string }

type Release =
    { [<JsonPropertyName "sdks">]
      Sdks: Sdk seq }

type Channel =
    { [<JsonPropertyName "channel-version">]
      ChannelVersion: string
      [<JsonPropertyName "releases">]
      Releases: Release seq }

let releaseJsonUrl channel =
    $"https://dotnetcli.blob.core.windows.net/dotnet/release-metadata/{channel}/releases.json"


let downloadReleaseInfoForChannel channel =
    let webClient = new WebClient()
    let url = releaseJsonUrl channel

    let json = webClient.DownloadString(url)
    JsonSerializer.Deserialize<Channel>(json)

let filterSdkFiles (sdk: Sdk) =
    let files = 
        sdk.Files
        |> Seq.filter (fun f ->
            match f.Rid with
            | "linux-x64" -> true
            | "osx-arm64" -> true
            | "osx-x64" -> true
            | "win-x64" -> true
            | _ -> false )
        |> Seq.filter
            (fun f ->
                // We are only intersted in the compressed artifacts, not exe or pkg or similar artifacts
                f.Name.EndsWith(".zip")
                || f.Name.EndsWith(".tar.gz"))
        |> Seq.filter
            (fun f ->
                // Some releases have .zip and .tar.gz artifacts for linux so we remove the .zip artifacts
                not (f.Rid = "linux-x64" && f.Name.EndsWith(".zip")))
        |> Seq.filter
            (fun f ->
                // There were some incorrect preview releases which had arm binaries released as x64 binaries, removing those
                not (f.Rid = "osx-x64" && f.Name.EndsWith("arm64.tar.gz")))

    // If there is no MacOS arm version of in the release then we add an entry where we use the x64
    // version since that can be run with Rosetta
    if not (Seq.exists(fun f -> f.Rid = "osx-arm64") files) then
        let x64 = Seq.find (fun f -> f.Rid = "osx-x64") files
        Seq.append [{ x64 with Rid = "osx-arm64"}] files
    else
        files
    |> Seq.sortBy (fun f -> f.Rid)

let convertRid rid =
    match rid with
    | "linux-x64" -> "x86_64-unknown-linux-gnu"
    | "osx-arm64" -> "aarch64-apple-darwin"
    | "osx-x64" -> "x86_64-apple-darwin"
    | "win-x64" -> "x86_64-pc-windows-msvc"
    | _ -> failwith "Unsupported platform"

let base64Encode (input: string) =
    System.Convert.ToBase64String(System.Convert.FromHexString(input))

let generateVersionsBzl (channels: Channel seq) =
    let sb = StringBuilder()

    sb.AppendLine("\"\"\"Mirror of release info\"\"\"")
    |> ignore

    sb.AppendLine() |> ignore
    sb.AppendLine("TOOL_VERSIONS = {") |> ignore

    for channel in channels |> Seq.sortBy (fun c -> c.ChannelVersion) do
        for release in channel.Releases do
            for sdk in release.Sdks |> Seq.sortBy (fun s -> s.Version) do
                sb.AppendLine((sprintf "    \"%s\": {" sdk.Version))
                |> ignore

                sb.AppendLine((sprintf "        \"runtimeVersion\": \"%s\"," sdk.RuntimeVersion)) |>ignore
                sb.AppendLine((sprintf "        \"runtimeTfm\": \"%s\"," $"net{channel.ChannelVersion}")) |>ignore
                sb.AppendLine((sprintf "        \"csharpDefaultVersion\": \"%s\"," sdk.CSharpVersion)) |>ignore
                sb.AppendLine((sprintf "        \"fsharpDefaultVersion\": \"%s\"," sdk.FSharpVersion)) |>ignore
                for file in filterSdkFiles sdk do
                    sb.AppendLine(
                        (sprintf
                            "        \"%s\": {\"hash\": \"sha512-%s\", \"url\": \"%s\"},"
                            (convertRid file.Rid)
                            (base64Encode file.Hash)
                            file.Url)
                    )
                    |> ignore

                sb.AppendLine("    },") |> ignore

    sb.AppendLine("}") |> ignore
    
    File.WriteAllText("dotnet/private/versions.bzl", sb.ToString())
    
supportedChannels
|> Seq.map downloadReleaseInfoForChannel
|> generateVersionsBzl

// sha512-Utcg6Qz7iJqS1gXWTm0OkLliCeG9fqsA2rHVZwF9elpP9K28Va/0z/zqSxv5K7jTUYWdANjrZQWe7F5EmIbJOA==
