load("@io_bazel_rules_dotnet//dotnet:defs.bzl", "core_library", "core_binary", "core_resx")

core_resx(
    name = "core_resource",
    src = "testfx/src/TestFramework/MSTest.Core/Resources/FrameworkMessages.resx",
    identifier="Microsoft.VisualStudio.TestTools.UnitTesting.Resources.FrameworkMessages.resources",
)

core_library(
    name = "MSTest.Core",
    srcs = glob(["testfx/src/TestFramework/MSTest.Core/**/*.cs"]) 
            + glob(["testfx/src/TestFramework/Extension.Shared/**/*.cs"])
            + ["//testfx:Friends.cs"],
    visibility = ["//visibility:public"],
    defines = [
    ],
    deps = [
        "@io_bazel_rules_dotnet//dotnet/stdlib.core:system.runtime.dll",
        "@io_bazel_rules_dotnet//dotnet/stdlib.core:system.private.corelib.dll",
        "@io_bazel_rules_dotnet//dotnet/stdlib.core:system.diagnostics.process.dll",
        "@io_bazel_rules_dotnet//dotnet/stdlib.core:system.diagnostics.textwritertracelistener.dll",
        "@io_bazel_rules_dotnet//dotnet/stdlib.core:system.diagnostics.tracesource.dll",
        "@io_bazel_rules_dotnet//dotnet/stdlib.core:system.runtime.interopservices.runtimeinformation.dll",
        "@io_bazel_rules_dotnet//dotnet/stdlib.core:system.runtime.loader.dll",
        ":Extension.Core",
    ],
    resources = [":core_resource"],
    keyfile = "//testfx:testfx.snk",
)

core_library(
    name = "Extension.Core",
    srcs = glob(["testfx/src/TestFramework/Extension.Core/**/*.cs"]),
    visibility = ["//visibility:public"],
    defines = [
    ],
    deps = [
        "@io_bazel_rules_dotnet//dotnet/stdlib.core:system.runtime.dll",
        "@io_bazel_rules_dotnet//dotnet/stdlib.core:system.private.corelib.dll",
        "@io_bazel_rules_dotnet//dotnet/stdlib.core:system.diagnostics.process.dll",
        "@io_bazel_rules_dotnet//dotnet/stdlib.core:system.diagnostics.textwritertracelistener.dll",
        "@io_bazel_rules_dotnet//dotnet/stdlib.core:system.diagnostics.tracesource.dll",
        "@io_bazel_rules_dotnet//dotnet/stdlib.core:system.runtime.interopservices.runtimeinformation.dll",
        "@io_bazel_rules_dotnet//dotnet/stdlib.core:system.runtime.loader.dll",
    ],
    keyfile = "//testfx:testfx.snk",
)

core_library(
    name = "PlatformServices.Interface",
    srcs = glob(["testfx/src/Adapter/PlatformServices.Interface/**/*.cs"]),
    visibility = ["//visibility:public"],
    defines = [
    ],
    deps = [
        "@io_bazel_rules_dotnet//dotnet/stdlib.core:system.xml.dll",
        ":MSTest.Core",
        ":Extension.Core",
        "//vstest:Microsoft.VisualStudio.TestPlatform.ObjectModel",
    ],
    keyfile = "//testfx:testfx.snk",
)

core_library(
    name = "PlatformServices.Portable",
    srcs = glob(["testfx/src/Adapter/PlatformServices.Portable/**/*.cs"]) 
        + glob(["testfx/src/Adapter/PlatformServices.Shared/netstandard1.0/Services/**/*.cs"])
        + ["testfx/src/Adapter/PlatformServices.Shared/netstandard1.0/Constants.cs"],
    visibility = ["//visibility:public"],
    defines = [
    ],
    deps = [
        ":PlatformServices.Interface",
    ],
    keyfile = "//testfx:testfx.snk",
)

core_resx(
    name = "adapter_resource",
    src = "testfx/src/Adapter/MSTest.CoreAdapter/Resources/Resource.resx",
    identifier="Microsoft.VisualStudio.TestPlatform.MSTest.TestAdapter.Resources.Resource.resources",
)

core_library(
    name = "Microsoft.VisualStudio.TestPlatform.MSTest.TestAdapter",
    srcs = glob(["testfx/src/Adapter/MSTest.CoreAdapter/**/*.cs"], exclude=["testfx/src/Adapter/MSTest.CoreAdapter/Execution/TestContextImpl.cs"]),
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
)

