load(
    "@rules_dotnet//dotnet:defs.bzl",
    "csharp_binary",
    "publish_binary",
)

csharp_binary(
    name = "hello",
    srcs = ["hello.cs"],
    private_deps = [
        "@example_deps//microsoft.netcore.app.ref",
    ],
    target_frameworks = ["net6.0"],
    deps = [
    ],
)

publish_binary(
    name = "publish_self_contained",
    binary = ":hello",
    runtime_pack = select({
        "@rules_dotnet//dotnet:rid_linux-x64": "@example_deps//microsoft.netcore.app.runtime.linux-x64",
        "@rules_dotnet//dotnet:rid_osx-x64": "@example_deps//microsoft.netcore.app.runtime.osx-x64",
        "@rules_dotnet//dotnet:rid_win-x64": "@example_deps//microsoft.netcore.app.runtime.win-x64",
    }),
    self_contained = True,
    target_framework = "net6.0",
)
