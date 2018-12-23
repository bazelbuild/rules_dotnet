load("@io_bazel_rules_dotnet//dotnet:defs.bzl", "core_library", "core_binary", "core_resource", "core_xunit_test")

filegroup(
  name = "core_common",
  srcs = [
    ":src/common/ExceptionExtensions.cs",
    ":src/common/Guard.cs",
    ":src/common/TestMethodDisplay.cs",
    ":src/common/TestMethodDisplayOptions.cs",
    "@io_bazel_rules_dotnet//3rd_party:xunit/GlobalAssemblyInfo.cs",
  ] + ["@xunit_assert//:common_files"]
)

core_resource(
    name = "xunit_core_resource",
    src = "src/xunit.core/Resources/xunit.core.rd.xml",
    identifier="Xunit.Resources.xunit.core.rd.xml",
)

core_library(
    name = "xunit.core",
    srcs = [":core_common"] + glob(["src/xunit.core/**/*.cs"]),
    defines = [
        "XUNIT_FRAMEWORK",
    ],
    visibility = ["//visibility:public"],
    deps = [
        "@io_bazel_rules_dotnet//dotnet/stdlib.core:system.runtime.dll",
        "@io_bazel_rules_dotnet//dotnet/stdlib.core:system.private.corelib.dll",
        "@io_bazel_rules_dotnet//dotnet/stdlib.core:system.linq.dll",
        "@io_bazel_rules_dotnet//dotnet/stdlib.core:system.io.filesystem.dll",
        "@xunit_abstractions//:abstractions.xunit",
    ],
    resources = [":xunit_core_resource"],
    data = [
        ":src/xunit.core/xunit.core.dll.tdnet"
    ]
)

filegroup(
  name = "execution_common",
  srcs = [
    ":src/common/AssemblyExtensions.cs",
    ":src/common/CommonTasks.cs",
    ":src/common/DictionaryExtensions.cs",
    ":src/common/ExceptionExtensions.cs",
    ":src/common/ExceptionUtility.cs",
    ":src/common/ExecutionHelper.cs",
    ":src/common/Guard.cs",
    ":src/common/LongLivedMarshalByRefObject.cs",
    ":src/common/NewReflectionExtensions.cs",
    ":src/common/NullMessageSink.cs",
    ":src/common/SerializationHelper.cs",
    ":src/common/SourceInformation.cs",
    ":src/common/TestOptionsNames.cs",
    ":src/common/XunitSerializationInfo.cs",
    ":src/common/XunitWorkerThread.cs",
    "@io_bazel_rules_dotnet//3rd_party:xunit/GlobalAssemblyInfo.cs",
  ] + glob(["src/messages/**/*.cs"]) + ["@xunit_assert//:common_files"]
)

core_library(
    name = "xunit.execution.dotnet",
    srcs = [":execution_common"] + glob(["src/xunit.execution/**/*.cs"]),
    defines = [
        "XUNIT_FRAMEWORK",
        "NETSTANDARD",
    ],
    visibility = ["//visibility:public"],
    deps = [
        "@io_bazel_rules_dotnet//dotnet/stdlib.core:system.runtime.dll",
        "@io_bazel_rules_dotnet//dotnet/stdlib.core:system.private.corelib.dll",
        "@io_bazel_rules_dotnet//dotnet/stdlib.core:system.linq.dll",
        "@io_bazel_rules_dotnet//dotnet/stdlib.core:system.linq.expressions.dll",
        "@io_bazel_rules_dotnet//dotnet/stdlib.core:system.io.filesystem.dll",
        "@io_bazel_rules_dotnet//dotnet/stdlib.core:system.collections.concurrent.dll",
        "@io_bazel_rules_dotnet//dotnet/stdlib.core:system.threading.thread.dll",
        ":xunit.core",
    ],
)

filegroup(
  name = "runner_utility_common",
  srcs = [
    ":src/common/AssemblyExtensions.cs",
    ":src/common/CommonTasks.cs",
    ":src/common/ConcurrentDictionary.cs",
    ":src/common/ConsoleHelper.cs",
    ":src/common/DictionaryExtensions.cs",
    ":src/common/ExceptionExtensions.cs",
    ":src/common/ExceptionUtility.cs",
    ":src/common/Guard.cs",
    ":src/common/Json.cs",
    ":src/common/LongLivedMarshalByRefObject.cs",
    ":src/common/NewReflectionExtensions.cs",
    ":src/common/NullMessageSink.cs",
    ":src/common/SerializationHelper.cs",
    ":src/common/SourceInformation.cs",
    ":src/common/TestMethodDisplay.cs",
    ":src/common/TestMethodDisplayOptions.cs",
    ":src/common/TestOptionsNames.cs",
    ":src/common/XunitSerializationInfo.cs",
    ":src/common/XunitWorkerThread.cs",
    ":src/common/AssemblyResolution/AssemblyHelper_Desktop.cs",
    ":src/common/AssemblyResolution/_DiagnosticMessage.cs",
    "@io_bazel_rules_dotnet//3rd_party:xunit/GlobalAssemblyInfo.cs",
  ] + glob(["src/messages/**/*.cs"])
)

core_library(
    name = "xunit.runner.utility",
    srcs = [":runner_utility_common"] + glob(["src/xunit.runner.utility/**/*.cs"]),
    defines = [
        "NETSTANDARD2_0",
        "NETSTANDARD",
        "NETCOREAPP",
    ],
    visibility = ["//visibility:public"],
    deps = [
        "@io_bazel_rules_dotnet//dotnet/stdlib.core:system.runtime.dll",
        "@io_bazel_rules_dotnet//dotnet/stdlib.core:system.private.corelib.dll",
        "@io_bazel_rules_dotnet//dotnet/stdlib.core:system.linq.dll",
        "@io_bazel_rules_dotnet//dotnet/stdlib.core:system.linq.expressions.dll",
        "@io_bazel_rules_dotnet//dotnet/stdlib.core:system.io.filesystem.dll",
        "@io_bazel_rules_dotnet//dotnet/stdlib.core:system.collections.concurrent.dll",
        "@io_bazel_rules_dotnet//dotnet/stdlib.core:system.threading.thread.dll",
        "@io_bazel_rules_dotnet//dotnet/stdlib.core:system.text.regularexpressions.dll",
        "@io_bazel_rules_dotnet//dotnet/stdlib.core:system.xml.xdocument.dll",
        "@io_bazel_rules_dotnet//dotnet/stdlib.core:system.runtime.interopservices.runtimeinformation.dll",
        "@xunit_abstractions//:abstractions.xunit",
  ],
)


filegroup(
  name = "runner_reporters_common",
  srcs = [
    ":src/common/Json.cs",
    ":src/common/XunitWorkerThread.cs",
    "@io_bazel_rules_dotnet//3rd_party:xunit/GlobalAssemblyInfo.cs",
  ]
)

core_library(
    name = "xunit.runner.reporters",
    srcs = [":runner_reporters_common"] + glob(["src/xunit.runner.reporters/**/*.cs"]),
    defines = [
        "NETSTANDARD2_0",
        "NETSTANDARD",
    ],
    visibility = ["//visibility:public"],
    deps = [
        "@io_bazel_rules_dotnet//dotnet/stdlib.core:system.runtime.dll",
        "@io_bazel_rules_dotnet//dotnet/stdlib.core:system.private.corelib.dll",
        "@io_bazel_rules_dotnet//dotnet/stdlib.core:system.linq.dll",
        "@io_bazel_rules_dotnet//dotnet/stdlib.core:system.linq.expressions.dll",
        "@io_bazel_rules_dotnet//dotnet/stdlib.core:system.io.filesystem.dll",
        "@io_bazel_rules_dotnet//dotnet/stdlib.core:system.collections.concurrent.dll",
        "@io_bazel_rules_dotnet//dotnet/stdlib.core:system.threading.thread.dll",
        "@xunit_abstractions//:abstractions.xunit",
        ":xunit.runner.utility",
  ],
)

filegroup(
  name = "console_common",
  srcs = [
    ":src/common/AssemblyExtensions.cs",
    ":src/common/ConsoleHelper.cs",
    ":src/common/DictionaryExtensions.cs",
    ":src/common/Guard.cs",
    ":src/common/Json.cs",
    "@io_bazel_rules_dotnet//3rd_party:xunit/GlobalAssemblyInfo.cs",
  ] + glob(["src/common/AssemblyResolution/**/*.cs"])
)

core_resource(
    name = "HTML_xslt",
    src = "src/xunit.console/HTML.xslt",
    identifier="Xunit.ConsoleClient.HTML.xslt",
)

core_resource(
    name = "NUnitXml_xslt",
    src = "src/xunit.console/NUnitXml.xslt",
    identifier="Xunit.ConsoleClient.NUnitXml.xslt",
)

core_resource(
    name = "xUnit1_xslt",
    src = "src/xunit.console/xUnit1.xslt",
    identifier="Xunit.ConsoleClient.xUnit1.xslt",
)

core_resource(
    name = "JUnitXml_xslt",
    src = "src/xunit.console/JUnitXml.xslt",
    identifier="Xunit.ConsoleClient.JUnitXml.xslt",
)

core_binary(
    name = "xunit.console",
    srcs = [":console_common"] + glob(["src/xunit.console/**/*.cs"]),
    defines = [
        "NETSTANDARD2_0",
        "NETSTANDARD",
        "NETCOREAPP",
        "NETCOREAPP2_0",
    ],
    visibility = ["//visibility:public"],
    deps = [
        ":xunit.runner.reporters",
        ":xunit.execution.dotnet",
    ],
    resources = [
        ":HTML_xslt",
        ":NUnitXml_xslt",
        ":xUnit1_xslt",
        ":JUnitXml_xslt",
    ],
    unsafe = True,
)

filegroup(
  name = "test_utility_common",
  srcs = [
    ":src/common/AssemblyExtensions.cs",
    ":src/common/DictionaryExtensions.cs",
    ":src/common/ExceptionExtensions.cs", 
    ":src/common/ExecutionHelper.cs",
    ":src/common/TestOptionsNames.cs",
  ]
)
