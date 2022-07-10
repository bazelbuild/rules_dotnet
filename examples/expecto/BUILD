load(
    "@rules_dotnet//dotnet:defs.bzl",
    "fsharp_binary",
    "fsharp_test",
)

fsharp_test(
    name = "expecto_example",
    srcs = [
        # keep order
        "test.fs",
        "main.fs",
    ],
    target_frameworks = ["net6.0"],
    deps = [
        "@example_deps//expecto",
        "@example_deps//fsharp.core",
        "@example_deps//microsoft.netcore.app.ref",
    ],
)

fsharp_binary(
    name = "bin",
    srcs = [
        # keep order
        "test.fs",
        "main.fs",
    ],
    target_frameworks = ["net6.0"],
    deps = [
        "@example_deps//expecto",
        "@example_deps//fsharp.core",
        "@example_deps//microsoft.netcore.app.ref",
    ],
)
