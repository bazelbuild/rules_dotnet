load("@io_bazel_rules_dotnet//dotnet/private:deps/nuget.bzl", "dotnet_repositories_nuget")
load("@io_bazel_rules_dotnet//dotnet/private:deps/nuget2.bzl", "dotnet_repositories_nuget2")
load("@io_bazel_rules_dotnet//dotnet/private:rules/nuget.bzl", "dotnet_nuget_new")
load("@bazel_tools//tools/build_defs/repo:http.bzl", "http_archive")

def dotnet_repositories_nugets():
    """Loads nugets used by dotnet_rules itself."""

    dotnet_repositories_nuget()
    dotnet_repositories_nuget2()

    dotnet_nuget_new(
        name = "Microsoft.NETFramework.ReferenceAssemblies.net45.1.0.0",
        package = "Microsoft.NETFramework.ReferenceAssemblies.net45",
        version = "1.0.0",
        sha256 = "9b9e76d6497bfc6d0328528eb50f5fcc886a3eba4f47cdabd3df66f94174eac6",
        build_file_content = """exports_files(glob(["build/.NETFramework/v4.5/**/*.dll"]), visibility = ["//visibility:public"])""",
    )

    dotnet_nuget_new(
        name = "Microsoft.NETFramework.ReferenceAssemblies.net451.1.0.0",
        package = "Microsoft.NETFramework.ReferenceAssemblies.net451",
        version = "1.0.0",
        sha256 = "706278539689d45219715ff3fa19ff459127fc90104102eefcc236c1550f71e7",
        build_file_content = """exports_files(glob(["build/.NETFramework/v4.5.1/**/*.dll"]), visibility = ["//visibility:public"])""",
    )

    dotnet_nuget_new(
        name = "Microsoft.NETFramework.ReferenceAssemblies.net452.1.0.0",
        package = "Microsoft.NETFramework.ReferenceAssemblies.net452",
        version = "1.0.0",
        sha256 = "e8a90f1699d9b542e1bd6fdbc9f60f36acf420b95cace59e23d6be376dc61bb8",
        build_file_content = """exports_files(glob(["build/.NETFramework/v4.5.2/**/*.dll"]), visibility = ["//visibility:public"])""",
    )

    dotnet_nuget_new(
        name = "Microsoft.NETFramework.ReferenceAssemblies.net46.1.0.0",
        package = "Microsoft.NETFramework.ReferenceAssemblies.net46",
        version = "1.0.0",
        sha256 = "514e991aaacd84759f01b2933e6f4aa44a7d4caa39599f7d6c0a454b630286fa",
        build_file_content = """exports_files(glob(["build/.NETFramework/v4.6/**/*.dll"]), visibility = ["//visibility:public"])""",
    )

    dotnet_nuget_new(
        name = "Microsoft.NETFramework.ReferenceAssemblies.net461.1.0.0",
        package = "Microsoft.NETFramework.ReferenceAssemblies.net461",
        version = "1.0.0",
        sha256 = "a12eec50ccca0642e686082a6c8e9e06a6f538f022a47d130d36836818b17303",
        build_file_content = """exports_files(glob(["build/.NETFramework/v4.6.1/**/*.dll"]), visibility = ["//visibility:public"])""",
    )

    dotnet_nuget_new(
        name = "Microsoft.NETFramework.ReferenceAssemblies.net462.1.0.0",
        package = "Microsoft.NETFramework.ReferenceAssemblies.net462",
        version = "1.0.0",
        sha256 = "c4115c862f5ca778dc3fb649f455d38c095dfd10a1dc116b687944111462734d",
        build_file_content = """exports_files(glob(["build/.NETFramework/v4.6.2/**/*.dll"]), visibility = ["//visibility:public"])""",
    )

    dotnet_nuget_new(
        name = "Microsoft.NETFramework.ReferenceAssemblies.net47.1.0.0",
        package = "Microsoft.NETFramework.ReferenceAssemblies.net47",
        version = "1.0.0",
        sha256 = "261e3476e6be010a525064ce0901b8f77b09cdb7ea1fec88832a00ebe0356503",
        build_file_content = """exports_files(glob(["build/.NETFramework/v4.7/**/*.dll"]), visibility = ["//visibility:public"])""",
    )

    dotnet_nuget_new(
        name = "Microsoft.NETFramework.ReferenceAssemblies.net471.1.0.0",
        package = "Microsoft.NETFramework.ReferenceAssemblies.net471",
        version = "1.0.0",
        sha256 = "554c9305a9f064086861ae7db57b407147ec0850de2dfc5d86adabfa35b33180",
        build_file_content = """exports_files(glob(["build/.NETFramework/v4.7.1/**/*.dll"]), visibility = ["//visibility:public"])""",
    )

    dotnet_nuget_new(
        name = "Microsoft.NETFramework.ReferenceAssemblies.net472.1.0.0",
        package = "Microsoft.NETFramework.ReferenceAssemblies.net472",
        version = "1.0.0",
        sha256 = "2c8fd79ea19bd03cece40ed92b7bafde024f87c73abcebe3eff8da6e05b611af",
        build_file_content = """exports_files(glob(["build/.NETFramework/v4.7.2/**/*.dll"]), visibility = ["//visibility:public"])""",
    )

    dotnet_nuget_new(
        name = "Microsoft.NETFramework.ReferenceAssemblies.net48.1.0.0",
        package = "Microsoft.NETFramework.ReferenceAssemblies.net48",
        version = "1.0.0",
        sha256 = "fd0ba0a0c5ccce36e104abd055d2f4bf596ff3afc0dbc1f201d6cf9a50b783ce",
        build_file_content = """exports_files(glob(["build/.NETFramework/v4.8/**/*.dll"]), visibility = ["//visibility:public"])""",
    )

    dotnet_nuget_new(
        name = "Microsoft.NETCore.App.2.0.7",
        package = "Microsoft.NETCore.App",
        version = "2.0.7",
        sha256 = "9f1f0d5c98b5819ea89ef86aeecd5ce8750ae03bd471113601e20a1cdab651f2",
        build_file_content = """exports_files(glob(["ref/netcoreapp2.0/*.dll"]), visibility = ["//visibility:public"])""",
    )

    dotnet_nuget_new(
        name = "Microsoft.NETCore.App.2.1.6",
        package = "Microsoft.NETCore.App",
        version = "2.1.6",
        sha256 = "6648eb1432cac1996560a6c2fbf29a9b731e351a86e4c822b740916838fc8f98",
        build_file_content = """exports_files(glob(["ref/netcoreapp2.1/*.dll"]), visibility = ["//visibility:public"])""",
    )

    dotnet_nuget_new(
        name = "Microsoft.NETCore.App.2.1.7",
        package = "Microsoft.NETCore.App",
        version = "2.1.7",
        sha256 = "d7b3716f5f8f600ca7aff52bdacb2633d95920614749a4cc76c9a504f86a15c3",
        build_file_content = """exports_files(glob(["ref/netcoreapp2.1/*.dll"]), visibility = ["//visibility:public"])""",
    )

    dotnet_nuget_new(
        name = "Microsoft.NETCore.App.2.2.0",
        package = "Microsoft.NETCore.App",
        version = "2.2.0",
        sha256 = "73a6bcc97f02eebef0335ace25adcdd6e204dac83430706737a453f0330b8b6f",
        build_file_content = """exports_files(glob(["ref/netcoreapp2.2/*.dll"]), visibility = ["//visibility:public"])""",
    )

    dotnet_nuget_new(
        name = "Microsoft.NETCore.App.2.2.7",
        package = "Microsoft.NETCore.App",
        version = "2.2.7",
        sha256 = "a4f166be783dedac38def8e9357ac74a4739119611635ac520b5fdd96645835e",
        build_file_content = """exports_files(glob(["ref/netcoreapp2.2/*.dll"]), visibility = ["//visibility:public"])""",
    )

    dotnet_nuget_new(
        name = "Mono.ReferenceAssemblies.v4.5",
        package = "Mono.ReferenceAssemblies.v4.5",
        version = "1.0.0",
        sha256 = "dc73a56713f8448681d90dbfd09e6ec80568926925b7f93619cf733ff2a2c96c",
        build_file_content = """exports_files(glob(["build/.NETFramework/v4.5/**/*.dll"]), visibility = ["//visibility:public"])""",
    )

    dotnet_nuget_new(
        name = "NUnit3TestAdapter",
        package = "NUnit3TestAdapter",
        version = "3.16.1",
        sha256 = "0913e56087ab02a2cc91b4f2e8756f5a3bf269fe23cb7fd477faebe6aeaaf0df",
        build_file_content = """filegroup(name = "extension", srcs = glob(["build/netcoreapp2.1/*.dll", "build/netcoreapp2.1/*.pdb"]), visibility = ["//visibility:public"])""",
    )

    dotnet_nuget_new(
        name = "JunitXml.TestLogger",
        package = "JunitXml.TestLogger",
        version = "2.1.15",
        sha256 = "8c340bdd24f118d7046c18099c3f5994b85cd35ec0cf6528c04e57e5352b588c",
        build_file_content = """filegroup(name = "extension", srcs = glob(["build/_common/*.dll"]), visibility = ["//visibility:public"])""",
    )

    http_archive(
        name = "vstest",
        build_file = "@io_bazel_rules_dotnet//3rd_party/vstest:repo.bzl",
        sha256 = "9a3e1cec6a841a82001b443878ea5dff5ac54247bcb5ad86136c365b308a91ac",
        strip_prefix = "vstest-16.5.0",
        urls = ["https://github.com/microsoft/vstest/archive/v16.5.0.tar.gz"],
        patches = ["@io_bazel_rules_dotnet//3rd_party/vstest:000.patch"],
    )
