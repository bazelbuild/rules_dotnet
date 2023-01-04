load(
    "@rules_dotnet//dotnet:defs.bzl",
    "csharp_binary",
    "csharp_library",
    "csharp_nunit_test",
)

# bazel run //examples:hello
csharp_binary(
    name = "hello",
    srcs = ["hello.cs"],
    private_deps = [
        "@example_deps//microsoft.netcore.app.ref",
    ],
    target_frameworks = ["net6.0"],
    deps = [
        ":lib",
    ],
)

# bazel test //examples:lib_test
# NOTE: this doesn't work yet because we aren't setting up the runfiles
# correctly. If you copy out all the dlls/exes to a common folder it does
# though.
csharp_nunit_test(
    name = "lib_test",
    srcs = ["libtest.cs"],
    private_deps = [
        "@example_deps//microsoft.netcore.app.ref",
    ],
    target_frameworks = ["net6.0"],
    deps = [
        ":lib",
    ],
)

csharp_library(
    name = "lib",
    srcs = ["lib.cs"],
    internals_visible_to = ["lib_test"],
    private_deps = [
        "@example_deps//microsoft.netcore.app.ref",
    ],
    target_frameworks = ["net6.0"],
    deps = [],
)
