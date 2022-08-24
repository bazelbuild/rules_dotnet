# BazelDotnet

This tool is used in conjunction with [AFASResearch/rules_dotnet](https://github.com/AFASResearch/rules_dotnet).

## Commands

### repository

Generate the external nuget_repository in the current working directory.

```
BazelDotnet.exe repository [path to]/nuget.config [-p [path to]/Packages.Props, ...] [--tfm=net5.0]
```

TODO

- allow speccing output dir
- make nuget.config optional
- document --imports

### projects

Globs all `.csproj` files and generates an accompanying `BUILD` file.

```
BazelDotnet.exe projects
```

TODO

- document features
- migrate to Gazelle
