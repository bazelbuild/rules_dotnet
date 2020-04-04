load("@io_bazel_rules_dotnet//dotnet/private:deps/nunitv2.bzl", "dotnet_repositories_nunitv2")
load("@io_bazel_rules_dotnet//dotnet/private:deps/nuget.bzl", "dotnet_repositories_nuget")
load("@io_bazel_rules_dotnet//dotnet/private:deps/xunit.bzl", "dotnet_repositories_xunit")
load("@io_bazel_rules_dotnet//dotnet/private:deps/nunit.bzl", "dotnet_repositories_nunit")
load("@io_bazel_rules_dotnet//dotnet/private:rules/nuget.bzl", "dotnet_nuget_new")

def dotnet_repositories_nugets():
    dotnet_repositories_nunitv2()
    dotnet_repositories_nuget()
    dotnet_repositories_xunit()
    dotnet_repositories_nunit()

    dotnet_nuget_new(
        name = "Microsoft.NETFramework.ReferenceAssemblies.net45",
        package = "Microsoft.NETFramework.ReferenceAssemblies.net45",
        version = "1.0.0",
        sha256 = "9b9e76d6497bfc6d0328528eb50f5fcc886a3eba4f47cdabd3df66f94174eac6",
        build_file_content = """exports_files(glob(["build/.NETFramework/v4.5/**/*.dll"]), visibility = ["//visibility:public"])""",
    )

    dotnet_nuget_new(
        name = "Microsoft.NETFramework.ReferenceAssemblies.net451",
        package = "Microsoft.NETFramework.ReferenceAssemblies.net451",
        version = "1.0.0",
        sha256 = "706278539689d45219715ff3fa19ff459127fc90104102eefcc236c1550f71e7",
        build_file_content = """exports_files(glob(["build/.NETFramework/v4.5.1/**/*.dll"]), visibility = ["//visibility:public"])""",
    )

    dotnet_nuget_new(
        name = "Microsoft.NETFramework.ReferenceAssemblies.net452",
        package = "Microsoft.NETFramework.ReferenceAssemblies.net452",
        version = "1.0.0",
        sha256 = "e8a90f1699d9b542e1bd6fdbc9f60f36acf420b95cace59e23d6be376dc61bb8",
        build_file_content = """exports_files(glob(["build/.NETFramework/v4.5.2/**/*.dll"]), visibility = ["//visibility:public"])""",
    )

    dotnet_nuget_new(
        name = "Microsoft.NETFramework.ReferenceAssemblies.net46",
        package = "Microsoft.NETFramework.ReferenceAssemblies.net46",
        version = "1.0.0",
        sha256 = "514e991aaacd84759f01b2933e6f4aa44a7d4caa39599f7d6c0a454b630286fa",
        build_file_content = """exports_files(glob(["build/.NETFramework/v4.6/**/*.dll"]), visibility = ["//visibility:public"])""",
    )

    dotnet_nuget_new(
        name = "Microsoft.NETFramework.ReferenceAssemblies.net461",
        package = "Microsoft.NETFramework.ReferenceAssemblies.net461",
        version = "1.0.0",
        sha256 = "a12eec50ccca0642e686082a6c8e9e06a6f538f022a47d130d36836818b17303",
        build_file_content = """exports_files(glob(["build/.NETFramework/v4.6.1/**/*.dll"]), visibility = ["//visibility:public"])""",
    )

    dotnet_nuget_new(
        name = "Microsoft.NETFramework.ReferenceAssemblies.net462",
        package = "Microsoft.NETFramework.ReferenceAssemblies.net462",
        version = "1.0.0",
        sha256 = "c4115c862f5ca778dc3fb649f455d38c095dfd10a1dc116b687944111462734d",
        build_file_content = """exports_files(glob(["build/.NETFramework/v4.6.2/**/*.dll"]), visibility = ["//visibility:public"])""",
    )

    dotnet_nuget_new(
        name = "Microsoft.NETFramework.ReferenceAssemblies.net47",
        package = "Microsoft.NETFramework.ReferenceAssemblies.net47",
        version = "1.0.0",
        sha256 = "261e3476e6be010a525064ce0901b8f77b09cdb7ea1fec88832a00ebe0356503",
        build_file_content = """exports_files(glob(["build/.NETFramework/v4.7/**/*.dll"]), visibility = ["//visibility:public"])""",
    )

    dotnet_nuget_new(
        name = "Microsoft.NETFramework.ReferenceAssemblies.net471",
        package = "Microsoft.NETFramework.ReferenceAssemblies.net471",
        version = "1.0.0",
        sha256 = "554c9305a9f064086861ae7db57b407147ec0850de2dfc5d86adabfa35b33180",
        build_file_content = """exports_files(glob(["build/.NETFramework/v4.7.1/**/*.dll"]), visibility = ["//visibility:public"])""",
    )

    dotnet_nuget_new(
        name = "Microsoft.NETFramework.ReferenceAssemblies.net472",
        package = "Microsoft.NETFramework.ReferenceAssemblies.net472",
        version = "1.0.0",
        sha256 = "2c8fd79ea19bd03cece40ed92b7bafde024f87c73abcebe3eff8da6e05b611af",
        build_file_content = """exports_files(glob(["build/.NETFramework/v4.7.2/**/*.dll"]), visibility = ["//visibility:public"])""",
    )

    dotnet_nuget_new(
        name = "Microsoft.NETFramework.ReferenceAssemblies.net48",
        package = "Microsoft.NETFramework.ReferenceAssemblies.net48",
        version = "1.0.0",
        sha256 = "fd0ba0a0c5ccce36e104abd055d2f4bf596ff3afc0dbc1f201d6cf9a50b783ce",
        build_file_content = """exports_files(glob(["build/.NETFramework/v4.8/**/*.dll"]), visibility = ["//visibility:public"])""",
    )
