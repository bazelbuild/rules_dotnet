load(
    "@rules_dotnet//dotnet:defs.bzl",
    "fsharp_binary",
    "fsharp_library",
    "fsharp_nunit_test",
)

fsharp_binary(
    name = "hello",
    srcs = ["hello.fs"],
    private_deps = [
        "@example_deps//microsoft.netcore.app.ref",
    ],
    target_frameworks = ["net6.0"],
    deps = [
        ":lib",
        "@example_deps//fsharp.core",
    ],
)

fsharp_nunit_test(
    name = "lib_test",
    srcs = ["libtest.fs"],
    private_deps = [
        "@example_deps//microsoft.netcore.app.ref",
    ],
    target_frameworks = ["net6.0"],
    deps = [
        ":lib",
        "@example_deps//fsharp.core",
    ],
)

fsharp_library(
    name = "lib",
    srcs = ["lib.fs"],
    internals_visible_to = ["lib_test"],
    private_deps = [
        "@example_deps//microsoft.netcore.app.ref",
    ],
    target_frameworks = ["net6.0"],
    deps = [
        "@example_deps//fsharp.core",
    ],
)
