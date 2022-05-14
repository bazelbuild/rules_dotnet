# paket2bazel

`paket2bazel` is a tool for parsing [Paket](https://fsprojects.github.io/Paket/) dependencies files

Paket fits well with Bazel because it generates a `paket.lock` file that can be used
to deterministically generate Bazel targets for NuGet packages.

## How to use
First you need to set up your paket.dependencies and paket.lock file. See the [Paket docs](https://fsprojects.github.io/Paket/) on how to get started with Paket.
Note that the `storage: none` feature of Paket is not supported currently because `paket2bazel` needs to read the contents of the `packages` folder that Paket generates.

Next you will have to add the following to your `WORKSPACE` file:
```python
load("@rules_dotnet//dotnet:repositories.bzl", "paket2bazel_repositories")

paket2bazel_repositories()
```

Then you needs to run `paket2bazel` to generate the `paket.bzl` file which will be
loaded in your `WORKSPACE` file.

```sh
bazel run @rules_dotnet//tools/paket2bazel:paket2bazel.exe -- --dependencies-file $(pwd)/paket.dependencies  --output-folder $(pwd)/deps --config $(pwd)/paket2bazel.config.json
```
Next you need to add the following to your `WORKSPACE` file

```python
load("//OUTPUT_FOLDER:paket.bzl", "paket")
paket()
```

Once you have this set up you can reference each package with the following format:

If you only have the main Paket group in `paket.dependencies` file:
```
@main.package.name//:lib
```

If you are using groups in your `paket.dependencies` file:
```
@groupname.package.name//:lib
```

Full examples can be seen in the `examples/paket` directory in this repository.

## Config file
`paket2bazel` supports a config file that allows overriding the generated BUILD file
for the NuGet packages. This can be very useful when you have NuGet packages that have
unique folder structures.

The schema of the config file looks like this:
```json
{
    "packageOverrides": {
        "FSharp.Data": {
            "buildFile": "@workspace_name//3rdparty/nuget/custom_build_files:fsharp.data.BUILD"
        },
        "prometheus-net": {
            "buildFile": "@workspace_name//3rdparty/nuget/custom_build_files:prometheus-net.BUILD"
        }
    }
}
```
