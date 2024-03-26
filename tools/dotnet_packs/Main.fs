module DotnetPacks.Main

[<EntryPoint>]
let main argv =
    let outputFolder = argv.[0]
    let group = DotnetPacks.Packs.getAllPackages outputFolder
    let groups = NugetRepo.Parsing.parseGroups [ group ]

    NugetRepo.Gen.generateBazelFiles groups outputFolder "dotnet" None NugetRepo.Gen.NamingConvention.IdAndVersionAsName

    0 // return an integer exit
