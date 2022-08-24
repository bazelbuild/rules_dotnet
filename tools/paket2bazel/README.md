# paket2bazel

`paket2bazel` is a tool for parsing [Paket](https://fsprojects.github.io/Paket/) dependencies files

Paket fits well with Bazel because it generates a `paket.lock` file that can be used
to deterministically generate Bazel targets for NuGet packages.

## How to use

First you need to set up your paket.dependencies and paket.lock file. See the [Paket docs](https://fsprojects.github.io/Paket/) on how to get started with Paket.

Next you will have to add the following to your `WORKSPACE` file:

```python
load("@rules_dotnet//dotnet:paket2bazel_dependencies.bzl", "paket2bazel_dependencies")

paket2bazel_dependencies()
```

Then you needs to run `paket2bazel` to generate the `paket.bzl` file which will be
loaded in your `WORKSPACE` file.

```sh
bazel run @rules_dotnet//tools/paket2bazel:paket2bazel.exe -- --dependencies-file $(pwd)/paket.dependencies  --output-folder $(pwd)/deps
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
