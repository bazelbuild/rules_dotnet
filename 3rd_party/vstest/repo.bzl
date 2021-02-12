" vstest build from source. Source version v16.5.0"

load("@io_bazel_rules_dotnet//dotnet:defs.bzl", "core_resx", "csharp_binary", "csharp_library")

csharp_library(
    name = "Microsoft.TestPlatform.PlatformAbstractions.dll",
    srcs = glob(["src/Microsoft.TestPlatform.PlatformAbstractions/Interfaces/**/*.cs"]) + glob([
        "src/Microsoft.TestPlatform.PlatformAbstractions/netcore/**/*.cs",
    ]) + glob([
        "src/Microsoft.TestPlatform.PlatformAbstractions/common/**/*.cs",
    ]),
    defines = [
        "TRACE",
        "NETSTANDARD2_0",
    ],
    keyfile = "@io_bazel_rules_dotnet//3rd_party/vstest:vstest.snk",
    visibility = ["//visibility:public"],
    deps = [
        "@core_sdk_stdlib//:libraryset",
    ],
)

core_resx(
    name = "coreutilities_resource",
    src = "src/Microsoft.TestPlatform.CoreUtilities/Resources/Resources.resx",
    identifier = "Microsoft.VisualStudio.TestPlatform.CoreUtilities.Resources.Resources.resources",
)

csharp_library(
    name = "Microsoft.TestPlatform.CoreUtilities.dll",
    srcs = glob(["src/Microsoft.TestPlatform.CoreUtilities/**/*.cs"]),
    defines = [
        "NETSTANDARD2_0",
        "TRACE",
    ],
    keyfile = "@io_bazel_rules_dotnet//3rd_party/vstest:vstest.snk",
    resources = [
        ":coreutilities_resource",
    ],
    visibility = ["//visibility:public"],
    deps = [
        ":Microsoft.TestPlatform.PlatformAbstractions.dll",
        "@core_sdk_stdlib//:libraryset",
    ],
)

core_resx(
    name = "objectmodel_resource1",
    src = "src/Microsoft.TestPlatform.ObjectModel/Resources/Resources.resx",
    identifier = "Microsoft.VisualStudio.TestPlatform.ObjectModel.Resources.Resources.resources",
)

core_resx(
    name = "objectmodel_resource2",
    src = "src/Microsoft.TestPlatform.ObjectModel/Resources/CommonResources.resx",
    identifier = "Microsoft.VisualStudio.TestPlatform.ObjectModel.Resources.CommonResources.resx",
)

csharp_library(
    name = "Microsoft.VisualStudio.TestPlatform.ObjectModel.dll",
    srcs = glob(
        ["src/Microsoft.TestPlatform.ObjectModel/**/*.cs"],
        exclude = ["**/Friends.cs"],
    ) + ["@io_bazel_rules_dotnet//3rd_party/vstest:ObjectModel_Friends.cs"],
    defines = [
        "TRACE",
        "NETSTANDARD2_0",
    ],
    keyfile = "@io_bazel_rules_dotnet//3rd_party/vstest:vstest.snk",
    resources = [
        ":objectmodel_resource1",
        ":objectmodel_resource2",
    ],
    visibility = ["//visibility:public"],
    deps = [
        ":Microsoft.TestPlatform.CoreUtilities.dll",
        ":Microsoft.TestPlatform.PlatformAbstractions.dll",
        "@nuget.frameworks//:lib",
        "@core_sdk_stdlib//:libraryset",
    ],
)

core_resx(
    name = "utilities_resource",
    src = "src/Microsoft.TestPlatform.Utilities/Resources/Resources.resx",
    identifier = "Microsoft.VisualStudio.TestPlatform.Utilities.Resources.Resources.resources",
)

csharp_library(
    name = "Microsoft.TestPlatform.Utilities.dll",
    srcs = glob(["src/Microsoft.TestPlatform.Utilities/**/*.cs"]),
    defines = [
        "TRACE",
        "NETSTANDARD2_0",
    ],
    keyfile = "@io_bazel_rules_dotnet//3rd_party/vstest:vstest.snk",
    resources = [
        ":utilities_resource",
    ],
    visibility = ["//visibility:public"],
    deps = [
        ":Microsoft.TestPlatform.CoreUtilities.dll",
        ":Microsoft.VisualStudio.TestPlatform.ObjectModel.dll",
    ],
)

core_resx(
    name = "common_resource",
    src = "src/Microsoft.TestPlatform.Common/Resources/Resources.resx",
    identifier = "Microsoft.VisualStudio.TestPlatform.Common.Resources.Resources.resources",
)

csharp_library(
    name = "Microsoft.VisualStudio.TestPlatform.Common.dll",
    srcs = glob(
        ["src/Microsoft.TestPlatform.Common/**/*.cs"],
        exclude = ["**/Friends.cs"],
    ) + ["@io_bazel_rules_dotnet//3rd_party/vstest:Common_Friends.cs"],
    defines = [
        "TRACE",
        "NETSTANDARD2_0",
    ],
    keyfile = "@io_bazel_rules_dotnet//3rd_party/vstest:vstest.snk",
    resources = [
        ":common_resource",
    ],
    visibility = ["//visibility:public"],
    deps = [
        ":Microsoft.TestPlatform.CoreUtilities.dll",
        ":Microsoft.TestPlatform.Utilities.dll",
        ":Microsoft.VisualStudio.TestPlatform.ObjectModel.dll",
    ],
)

core_resx(
    name = "communicationutilities_resource",
    src = "src/Microsoft.TestPlatform.CommunicationUtilities/Resources/Resources.resx",
    identifier = "Microsoft.VisualStudio.TestPlatform.CommunicationUtilities.Resources.Resources.resources",
)

csharp_library(
    name = "Microsoft.TestPlatform.CommunicationUtilities.dll",
    srcs = glob(
        ["src/Microsoft.TestPlatform.CommunicationUtilities/**/*.cs"],
        exclude = ["**/Friends.cs"],
    ) + ["@io_bazel_rules_dotnet//3rd_party/vstest:CommunicationUtilities_Friends.cs"],
    defines = [
        "TRACE",
        "NETSTANDARD2_0",
    ],
    keyfile = "@io_bazel_rules_dotnet//3rd_party/vstest:vstest.snk",
    resources = [
        ":communicationutilities_resource",
    ],
    visibility = ["//visibility:public"],
    deps = [
        ":Microsoft.TestPlatform.CoreUtilities.dll",
        ":Microsoft.VisualStudio.TestPlatform.Common.dll",
        ":Microsoft.VisualStudio.TestPlatform.ObjectModel.dll",
        "@newtonsoft.json//:lib",
    ],
)

core_resx(
    name = "crossplatengine_resource",
    src = "src/Microsoft.TestPlatform.CrossPlatEngine/Resources/Resources.resx",
    identifier = "Microsoft.VisualStudio.TestPlatform.CrossPlatEngine.Resources.Resources.resources",
)

csharp_library(
    name = "Microsoft.TestPlatform.CrossPlatEngine.dll",
    srcs = glob(["src/Microsoft.TestPlatform.CrossPlatEngine/**/*.cs"]),
    defines = [
        "TRACE",
        "NETSTANDARD2_0",
    ],
    keyfile = "@io_bazel_rules_dotnet//3rd_party/vstest:vstest.snk",
    resources = [
        ":crossplatengine_resource",
    ],
    visibility = ["//visibility:public"],
    deps = [
        ":Microsoft.TestPlatform.CommunicationUtilities.dll",
        ":Microsoft.TestPlatform.CoreUtilities.dll",
        ":Microsoft.VisualStudio.TestPlatform.Common.dll",
        ":Microsoft.VisualStudio.TestPlatform.ObjectModel.dll",
    ],
)

core_resx(
    name = "client_resource",
    src = "src/Microsoft.TestPlatform.Client/Resources/Resources.resx",
    identifier = "Microsoft.VisualStudio.TestPlatform.Client.Resources.Resources.resources",
)

csharp_library(
    name = "Microsoft.VisualStudio.TestPlatform.Client.dll",
    srcs = glob(["src/Microsoft.TestPlatform.Client/**/*.cs"]),
    defines = [
        "TRACE",
        "NETSTANDARD2_0",
    ],
    keyfile = "@io_bazel_rules_dotnet//3rd_party/vstest:vstest.snk",
    resources = [
        ":client_resource",
    ],
    visibility = ["//visibility:public"],
    deps = [
        ":Microsoft.TestPlatform.CrossPlatEngine.dll",
    ],
)

core_resx(
    name = "console_resource",
    src = "src/vstest.console/Resources/Resources.resx",
    identifier = "vstest.console.Resources.Resources.resources",
)

csharp_binary(
    name = "vstest.console.exe",
    srcs = glob(["src/vstest.console/**/*.cs"]),
    defines = [
        "TRACE",
        "NETSTANDARD2_0",
    ],
    keyfile = "@io_bazel_rules_dotnet//3rd_party/vstest:vstest.snk",
    resources = [
        ":console_resource",
    ],
    visibility = ["//visibility:public"],
    deps = [
        #":Microsoft.TestPlatform.Extensions.TrxLogger.dll",
        "@microsoft.extensions.filesystemglobbing//:lib",
        ":Microsoft.TestPlatform.TestHostRuntimeProvider.dll",
        ":Microsoft.VisualStudio.TestPlatform.Client.dll",
        ":testhost.dll",
        # "//nunit3-vs-adapter:NUnitTestAdapter.TestAdapter.dll",
        # "//testfx:Microsoft.VisualStudio.TestPlatform.MSTest.TestAdapter.dll",
        # "//vstest-junit-logger:AlexKosau.BuildTools.JUnitLogger.dll",
    ],
)

# core_resx(
#     name = "trxlogger_resource",
#     src = "src/Microsoft.TestPlatform.Extensions.TrxLogger/Resources/TrxResource.resx",
#     identifier = "Microsoft.VisualStudio.TestPlatform.Extensions.TrxLogger.Resources.TrxResource.resources",
# )

# # csharp_library(
# #     name = "Microsoft.TestPlatform.Extensions.TrxLogger.dll",
# #     srcs = glob(["src/Microsoft.TestPlatform.Extensions.TrxLogger/**/*.cs"]),
# #     defines = [
# #         "TRACE",
# #     ],
# #     keyfile = "@io_bazel_rules_dotnet//3rd_party/vstest:vstest.snk",
# #     resources = [
# #         ":trxlogger_resource",
# #     ],
# #     visibility = ["//visibility:public"],
# #     deps = [
# #         ":Microsoft.VisualStudio.TestPlatform.ObjectModel.dll",
# #     ],
# # )

# # core_vstest_test(
# #     name = "Microsoft.TestPlatform.CoreUtilities.UnitTests",
# #     srcs = glob(["test/Microsoft.TestPlatform.CoreUtilities.UnitTests/**/*.cs"]),
# #     visibility = ["//visibility:public"],
# #     defines = [
# #         "TRACE",
# #     ],
# #     deps = [
# #         ":Microsoft.TestPlatform.CoreUtilities",
# #         "//testfx:MSTest.Core",
# #         "//moq4:Moq",
# #     ],
# #     testlauncher = ":vstest.console",
# #     keyfile = "@io_bazel_rules_dotnet//3rd_party/vstest:vstest.snk",
# # )

core_resx(
    name = "testhostprovider_resource",
    src = "src/Microsoft.TestPlatform.TestHostProvider/Resources/Resources.resx",
    identifier = "Microsoft.TestPlatform.TestHostProvider.Resources.Resources.resources",
)

csharp_library(
    name = "Microsoft.TestPlatform.TestHostRuntimeProvider.dll",
    srcs = glob(["src/Microsoft.TestPlatform.TestHostProvider/**/*.cs"]),
    defines = [
        "TRACE",
        "NETSTANDARD2_0",
    ],
    keyfile = "@io_bazel_rules_dotnet//3rd_party/vstest:vstest.snk",
    resources = [
        ":testhostprovider_resource",
    ],
    visibility = ["//visibility:public"],
    deps = [
        ":Microsoft.VisualStudio.TestPlatform.ObjectModel.dll",
        "@newtonsoft.json//:lib",
        "@core_sdk_stdlib//:libraryset",
        "@microsoft.extensions.dependencymodel//:lib",
    ],
)

csharp_binary(
    name = "testhost.dll",
    srcs = [
        ":src/testhost.x86/AppDomainEngineInvoker.cs",
        ":src/testhost.x86/DefaultEngineInvoker.cs",
        ":src/testhost.x86/Friends.cs",
        ":src/testhost.x86/IEngineInvoker.cs",
        ":src/testhost.x86/Program.cs",
        ":src/testhost.x86/UnitTestClient.cs",
    ],
    defines = [
        "TRACE",
        "NETSTANDARD2_0",
    ],
    keyfile = "@io_bazel_rules_dotnet//3rd_party/vstest:vstest.snk",
    visibility = ["//visibility:public"],
    deps = [
        ":Microsoft.TestPlatform.CommunicationUtilities.dll",
        ":Microsoft.TestPlatform.CrossPlatEngine.dll",
        ":Microsoft.VisualStudio.TestPlatform.ObjectModel.dll",
    ],
)
