load(
    "@io_bazel_rules_dotnet//dotnet:defs.bzl",
    "DOTNET_CORE_FRAMEWORKS",
    "DOTNET_NET_FRAMEWORKS",
    "core_binary",
    "dotnet_binary",
    "net_binary",
    "net_com_library",
)

dotnet_binary(
    name = "hello.exe",
    srcs = [
        "Program.cs",
        "Properties/AssemblyInfo.cs",
    ],
    deps = [
        "//tests/examples/example_lib:MyClass.dll",
        "@newtonsoft.json//:mono",
    ],
)

[core_binary(
    name = "{}_hello-core.exe".format(framework),
    srcs = [
        "Program.cs",
    ],
    dotnet_context_data = "@io_bazel_rules_dotnet//:core_context_data_{}".format(framework),
    deps = [
        "//tests/examples/example_lib:{}_MyClass-core.dll".format(framework),
        "@io_bazel_rules_dotnet//dotnet/stdlib.core/{}:libraryset".format(framework),
        "@newtonsoft.json//:netcoreapp2.1_core",
    ],
) for framework in DOTNET_CORE_FRAMEWORKS]

[net_binary(
    name = "hello-net_{}.exe".format(framework),
    srcs = [
        "Program.cs",
    ],
    dotnet_context_data = "@io_bazel_rules_dotnet//:net_context_data_{}".format(framework),
    deps = [
        "//tests/examples/example_lib:MyClass-net_{}.dll".format(framework),
        "@newtonsoft.json//:{}_net".format(framework),
    ],
) for framework in DOTNET_NET_FRAMEWORKS]

[net_com_library(
    name = "{}_com-ref-shell32.dll".format(framework),
    out = "{}_shell32.dll".format(framework),
    dotnet_context_data = "@io_bazel_rules_dotnet//:net_context_data_{}".format(framework),
    guid = "50A7E9B0-70EF-11D1-B75A-00A0C90564FE",
    lcid = 0,
    major_version = 1,
    minor_version = 0,
    namespace = "Shell32",
    platform = "win32",
) for framework in [
    "net45",
    "net451",
    "net452",
    "net46",
    "net461",
    "net462",
    "net47",
    "net471",
    "net472",
]]

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
