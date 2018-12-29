load(
    "@io_bazel_rules_dotnet//dotnet:defs.bzl",
    "core_binary",
    "dotnet_binary",
    "net_binary",
    "net_com_library",
    "DOTNET_NET_FRAMEWORKS",
    "DOTNET_CORE_FRAMEWORKS",
)

dotnet_binary(
    name = "hello",
    srcs = [
        "Program.cs",
        "Properties/AssemblyInfo.cs",
    ],
    deps = [
        "//tests/examples/example_lib:MyClass",
        "@newtonsoft.json//:mono",
    ],
)

[core_binary(
    name = "{}_hello-core".format(framework),
    srcs = [
        "Program.cs",
    ],
    deps = [
        "//tests/examples/example_lib:{}_MyClass-core".format(framework),
        "@io_bazel_rules_dotnet//dotnet/stdlib.core/{}:system.console.dll".format(framework),
        "@io_bazel_rules_dotnet//dotnet/stdlib.core/{}:system.private.corelib.dll".format(framework),
        "@io_bazel_rules_dotnet//dotnet/stdlib.core/{}:system.runtime.dll".format(framework),
        "@newtonsoft.json//:netcoreapp2.1_core",
    ],
    dotnet_context_data = "@io_bazel_rules_dotnet//:core_context_data_{}".format(framework),
    native_deps = "@core_sdk_{}//:native_deps".format(framework),
) for framework in DOTNET_CORE_FRAMEWORKS]

[net_binary(
    name = "hello-net_{}".format(framework),
    srcs = [
        "Program.cs",
    ],
    deps = [
        "//tests/examples/example_lib:MyClass-net_{}".format(framework),
        "@newtonsoft.json//:{}_net".format(framework),
    ],
    dotnet_context_data = "@io_bazel_rules_dotnet//:net_context_data_{}".format(framework),
    native_deps = "@net_sdk_{}//:native_deps".format(framework),
) for framework in DOTNET_NET_FRAMEWORKS]

[net_com_library(
    name = "{}_com-ref-shell32".format(framework),
    out = "{}_shell32.dll".format(framework),
    guid = "50A7E9B0-70EF-11D1-B75A-00A0C90564FE",
    lcid = 0,
    major_version = 1,
    minor_version = 0,
    namespace = "Shell32",
    platform = "win32",
    dotnet_context_data = "@io_bazel_rules_dotnet//:net_context_data_{}".format(framework),
) for framework in DOTNET_NET_FRAMEWORKS]

# The rule is left as an example. It is commented out, because our CI server doesn't have VS2017 installed
#net_binary(
#    name = "shell-com-example",
#    srcs = [
#        "ShellComExample.cs",
#    ],
#    deps = [
#        ":com-ref-shell32",
#        "@Microsoft.Build.Framework//:lib",
#        "@System.ComponentModel.DataAnnotations//:GAC_MSIL",
#        "@vs2017_ref//:vs/v2.0/Microsoft.VisualStudio.QualityTools.UnitTestFramework"
#    ]
#)
