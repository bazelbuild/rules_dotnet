load("@io_bazel_rules_dotnet//dotnet:defs.bzl", "core_library", "core_binary", "core_resx","DOTNET_CORE_FRAMEWORKS")

[core_resx(
    name = "{}_core_resource".format(framework),
    src = "testfx/src/TestFramework/MSTest.Core/Resources/FrameworkMessages.resx",
    identifier="Microsoft.VisualStudio.TestTools.UnitTesting.Resources.FrameworkMessages.resources",
    dotnet_context_data = "@io_bazel_rules_dotnet//:core_context_data_{}".format(framework),
    simpleresgen  ="@io_bazel_rules_dotnet//tools/simpleresgen:{}_simpleresgen".format(framework),
) for framework in DOTNET_CORE_FRAMEWORKS]

[core_library(
    name = "{}_MSTest.Core".format(framework),
    srcs = glob(["testfx/src/TestFramework/MSTest.Core/**/*.cs"]) 
            + glob(["testfx/src/TestFramework/Extension.Shared/**/*.cs"])
            + ["//testfx:Friends.cs"],
    visibility = ["//visibility:public"],
    defines = [
    ],
    deps = [
        "@io_bazel_rules_dotnet//dotnet/stdlib.core:{}_system.runtime.dll".format(framework),
        "@io_bazel_rules_dotnet//dotnet/stdlib.core:{}_system.private.corelib.dll".format(framework),
        "@io_bazel_rules_dotnet//dotnet/stdlib.core:{}_system.diagnostics.process.dll".format(framework),
        "@io_bazel_rules_dotnet//dotnet/stdlib.core:{}_system.diagnostics.textwritertracelistener.dll".format(framework),
        "@io_bazel_rules_dotnet//dotnet/stdlib.core:{}_system.diagnostics.tracesource.dll".format(framework),
        "@io_bazel_rules_dotnet//dotnet/stdlib.core:{}_system.runtime.interopservices.runtimeinformation.dll".format(framework),
        "@io_bazel_rules_dotnet//dotnet/stdlib.core:{}_system.runtime.loader.dll".format(framework),
        ":{}_Extension.Core".format(framework),
    ],
    resources = [":{}_core_resource".format(framework)],
    keyfile = "//testfx:testfx.snk",
    dotnet_context_data = "@io_bazel_rules_dotnet//:core_context_data_{}".format(framework),
) for framework in DOTNET_CORE_FRAMEWORKS]

[core_library(
    name = "{}_Extension.Core".format(framework),
    srcs = glob(["testfx/src/TestFramework/Extension.Core/**/*.cs"]),
    visibility = ["//visibility:public"],
    defines = [
    ],
    deps = [
        "@io_bazel_rules_dotnet//dotnet/stdlib.core:{}_system.runtime.dll".format(framework),
        "@io_bazel_rules_dotnet//dotnet/stdlib.core:{}_system.private.corelib.dll".format(framework),
        "@io_bazel_rules_dotnet//dotnet/stdlib.core:{}_system.diagnostics.process.dll".format(framework),
        "@io_bazel_rules_dotnet//dotnet/stdlib.core:{}_system.diagnostics.textwritertracelistener.dll".format(framework),
        "@io_bazel_rules_dotnet//dotnet/stdlib.core:{}_system.diagnostics.tracesource.dll".format(framework),
        "@io_bazel_rules_dotnet//dotnet/stdlib.core:{}_system.runtime.interopservices.runtimeinformation.dll".format(framework),
        "@io_bazel_rules_dotnet//dotnet/stdlib.core:{}_system.runtime.loader.dll".format(framework),
    ],
    keyfile = "//testfx:testfx.snk",
    dotnet_context_data = "@io_bazel_rules_dotnet//:core_context_data_{}".format(framework),
) for framework in DOTNET_CORE_FRAMEWORKS]

[core_library(
    name = "{}_PlatformServices.Interface".format(framework),
    srcs = glob(["testfx/src/Adapter/PlatformServices.Interface/**/*.cs"]),
    visibility = ["//visibility:public"],
    defines = [
    ],
    deps = [
        "@io_bazel_rules_dotnet//dotnet/stdlib.core:{}_system.xml.dll".format(framework),
        ":{}_MSTest.Core".format(framework),
        ":{}_Extension.Core".format(framework),
        "//vstest:{}_Microsoft.VisualStudio.TestPlatform.ObjectModel".format(framework),
    ],
    keyfile = "//testfx:testfx.snk",
    dotnet_context_data = "@io_bazel_rules_dotnet//:core_context_data_{}".format(framework),
) for framework in DOTNET_CORE_FRAMEWORKS]

[core_library(
    name = "{}_PlatformServices.Portable".format(framework),
    srcs = glob(["testfx/src/Adapter/PlatformServices.Portable/**/*.cs"]) 
        + glob(["testfx/src/Adapter/PlatformServices.Shared/netstandard1.0/Services/**/*.cs"])
        + ["testfx/src/Adapter/PlatformServices.Shared/netstandard1.0/Constants.cs"],
    visibility = ["//visibility:public"],
    defines = [
    ],
    deps = [
        ":{}_PlatformServices.Interface".format(framework),
    ],
    keyfile = "//testfx:testfx.snk",
    dotnet_context_data = "@io_bazel_rules_dotnet//:core_context_data_{}".format(framework),
) for framework in DOTNET_CORE_FRAMEWORKS]

[core_resx(
    name = "{}_adapter_resource".format(framework),
    src = "testfx/src/Adapter/MSTest.CoreAdapter/Resources/Resource.resx",
    identifier="Microsoft.VisualStudio.TestPlatform.MSTest.TestAdapter.Resources.Resource.resources",
    dotnet_context_data = "@io_bazel_rules_dotnet//:core_context_data_{}".format(framework),
    simpleresgen  ="@io_bazel_rules_dotnet//tools/simpleresgen:{}_simpleresgen".format(framework),
) for framework in DOTNET_CORE_FRAMEWORKS]

[core_library(
    name = "{}_Microsoft.VisualStudio.TestPlatform.MSTest.TestAdapter".format(framework),
    srcs = glob(["testfx/src/Adapter/MSTest.CoreAdapter/**/*.cs"], exclude=["testfx/src/Adapter/MSTest.CoreAdapter/Execution/TestContextImpl.cs"]),
    visibility = ["//visibility:public"],
    defines = [
    ],
    deps = [
        ":{}_PlatformServices.Portable".format(framework),
    ],
    resources = [
        ":{}_adapter_resource".format(framework),
    ],
    keyfile = "//testfx:testfx.snk",
    dotnet_context_data = "@io_bazel_rules_dotnet//:core_context_data_{}".format(framework),
) for framework in DOTNET_CORE_FRAMEWORKS]

