load("@io_bazel_rules_dotnet//dotnet:defs.bzl", "DOTNET_CORE_FRAMEWORKS", "core_binary", "core_library", "core_resx")

def buildall(framework):
    context = "@io_bazel_rules_dotnet//:core_context_data_{}".format(framework)
    core_resx(
        name = "core_resource".format(framework),
        src = "testfx/src/TestFramework/MSTest.Core/Resources/FrameworkMessages.resx",
        identifier = "Microsoft.VisualStudio.TestTools.UnitTesting.Resources.FrameworkMessages.resources",
        dotnet_context_data = context,
        simpleresgen = "@io_bazel_rules_dotnet//tools/simpleresgen:{}_simpleresgen".format(framework),
    )

    core_library(
        name = "MSTest.Core".format(framework),
        srcs = native.glob(["testfx/src/TestFramework/MSTest.Core/**/*.cs"]) +
               native.glob(["testfx/src/TestFramework/Extension.Shared/**/*.cs"]) +
               ["//testfx:Friends.cs"],
        visibility = ["//visibility:public"],
        defines = [
        ],
        deps = [
            "@io_bazel_rules_dotnet//dotnet/stdlib.core/{}:system.runtime.dll".format(framework),
            "@io_bazel_rules_dotnet//dotnet/stdlib.core/{}:system.private.corelib.dll".format(framework),
            "@io_bazel_rules_dotnet//dotnet/stdlib.core/{}:system.diagnostics.process.dll".format(framework),
            "@io_bazel_rules_dotnet//dotnet/stdlib.core/{}:system.diagnostics.textwritertracelistener.dll".format(framework),
            "@io_bazel_rules_dotnet//dotnet/stdlib.core/{}:system.diagnostics.tracesource.dll".format(framework),
            "@io_bazel_rules_dotnet//dotnet/stdlib.core/{}:system.runtime.interopservices.runtimeinformation.dll".format(framework),
            "@io_bazel_rules_dotnet//dotnet/stdlib.core/{}:system.runtime.loader.dll".format(framework),
            ":Extension.Core",
        ],
        resources = [":core_resource"],
        keyfile = "//testfx:testfx.snk",
        dotnet_context_data = context,
    )

    core_library(
        name = "Extension.Core",
        srcs = native.glob(["testfx/src/TestFramework/Extension.Core/**/*.cs"]),
        visibility = ["//visibility:public"],
        defines = [
        ],
        deps = [
            "@io_bazel_rules_dotnet//dotnet/stdlib.core/{}:system.runtime.dll".format(framework),
            "@io_bazel_rules_dotnet//dotnet/stdlib.core/{}:system.private.corelib.dll".format(framework),
            "@io_bazel_rules_dotnet//dotnet/stdlib.core/{}:system.diagnostics.process.dll".format(framework),
            "@io_bazel_rules_dotnet//dotnet/stdlib.core/{}:system.diagnostics.textwritertracelistener.dll".format(framework),
            "@io_bazel_rules_dotnet//dotnet/stdlib.core/{}:system.diagnostics.tracesource.dll".format(framework),
            "@io_bazel_rules_dotnet//dotnet/stdlib.core/{}:system.runtime.interopservices.runtimeinformation.dll".format(framework),
            "@io_bazel_rules_dotnet//dotnet/stdlib.core/{}:system.runtime.loader.dll".format(framework),
        ],
        keyfile = "//testfx:testfx.snk",
        dotnet_context_data = context,
    )

    core_library(
        name = "PlatformServices.Interface".format(framework),
        srcs = native.glob(["testfx/src/Adapter/PlatformServices.Interface/**/*.cs"]),
        visibility = ["//visibility:public"],
        defines = [
        ],
        deps = [
            "@io_bazel_rules_dotnet//dotnet/stdlib.core/{}:system.xml.dll".format(framework),
            ":MSTest.Core",
            ":Extension.Core",
            "//vstest:Microsoft.VisualStudio.TestPlatform.ObjectModel",
        ],
        keyfile = "//testfx:testfx.snk",
        dotnet_context_data = context,
    )

    core_library(
        name = "PlatformServices.Portable",
        srcs = native.glob(["testfx/src/Adapter/PlatformServices.Portable/**/*.cs"]) +
               native.glob(["testfx/src/Adapter/PlatformServices.Shared/netstandard1.0/Services/**/*.cs"]) +
               ["testfx/src/Adapter/PlatformServices.Shared/netstandard1.0/Constants.cs"],
        visibility = ["//visibility:public"],
        defines = [
        ],
        deps = [
            ":PlatformServices.Interface",
        ],
        keyfile = "//testfx:testfx.snk",
        dotnet_context_data = context,
    )

    core_resx(
        name = "adapter_resource",
        src = "testfx/src/Adapter/MSTest.CoreAdapter/Resources/Resource.resx",
        identifier = "Microsoft.VisualStudio.TestPlatform.MSTest.TestAdapter.Resources.Resource.resources",
        dotnet_context_data = context,
        simpleresgen = "@io_bazel_rules_dotnet//tools/simpleresgen:{}_simpleresgen".format(framework),
    )

    core_library(
        name = "Microsoft.VisualStudio.TestPlatform.MSTest.TestAdapter",
        srcs = native.glob(["testfx/src/Adapter/MSTest.CoreAdapter/**/*.cs"], exclude = ["testfx/src/Adapter/MSTest.CoreAdapter/Execution/TestContextImpl.cs"]),
        visibility = ["//visibility:public"],
        defines = [
        ],
        deps = [
            ":PlatformServices.Portable",
        ],
        resources = [
            ":adapter_resource",
        ],
        keyfile = "//testfx:testfx.snk",
        dotnet_context_data = context,
    )
