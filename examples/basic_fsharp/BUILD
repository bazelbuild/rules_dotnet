load(
    "@rules_dotnet//dotnet:defs.bzl",
    "fsharp_binary",
    "fsharp_library",
    "fsharp_nunit_test",
)

fsharp_binary(
    name = "hello",
    srcs = ["hello.fs"],
    target_frameworks = ["net6.0"],
    deps = [
        ":lib",
        "@example_deps//fsharp.core",
        "@example_deps//microsoft.netcore.app.ref",
    ],
)

fsharp_nunit_test(
    name = "lib_test",
    srcs = ["libtest.fs"],
    target_frameworks = ["net6.0"],
    deps = [
        ":lib",
        "@example_deps//fsharp.core",
        "@example_deps//microsoft.netcore.app.ref",
    ],
)

fsharp_library(
    name = "lib",
    srcs = ["lib.fs"],
    internals_visible_to = ["lib_test"],
    target_frameworks = ["net6.0"],
    deps = [
        "@example_deps//fsharp.core",
        "@example_deps//microsoft.netcore.app.ref",
    ],
)
