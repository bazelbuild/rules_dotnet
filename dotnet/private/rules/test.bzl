load(
    "@io_bazel_rules_dotnet//dotnet/private:context.bzl",
    "dotnet_context",
)

load(
    "@io_bazel_rules_dotnet//dotnet/private:providers.bzl",
    "DotnetLibrary",
    "DotnetResource",
)

load(
    "@io_bazel_rules_dotnet//dotnet/private:rules/launcher_gen.bzl",
    "dotnet_launcher_gen",
)

load(
    "@io_bazel_rules_dotnet//dotnet/private:rules/library.bzl",
    "dotnet_library",
)
 

def dotnet_nunit_test(name, deps, srcs, data = [], defines = None, out = None, **kwargs):
    dotnet_library(name = "%s_exe" % name, deps = deps, srcs = srcs, out = out, defines = defines)
    exe = ":%s_exe" % name
    dotnet_launcher_gen(name = "%s_launcher" % name, exe = exe, nunit="@nunit2//:nunit-console-runner-exe_exe")

    native.cc_test(
        name=name, 
        srcs = [":%s_launcher" % name],
        deps = ["@io_bazel_rules_dotnet//dotnet/tools/runner", "@io_bazel_rules_dotnet//dotnet/tools/common"],
        data = [exe, "@nunit2//:nunit-console-runner-exe_exe"] + data,
        **kwargs
    )