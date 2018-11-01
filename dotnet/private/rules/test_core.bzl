load(
    "@io_bazel_rules_dotnet//dotnet/private:rules/launcher_gen.bzl",
    "dotnet_launcher_gen",
)

load(
    "@io_bazel_rules_dotnet//dotnet/private:rules/library_core.bzl",
    "core_library",
)

 

def core_xunit_test(name, deps, srcs, data = [], defines = None, out = None, **kwargs):
    core_library(name = "%s_exe" % name, deps = deps, srcs = srcs, out = out, defines = defines)
    exe = ":%s_exe" % name
    dotnet_launcher_gen(name = "%s_launcher" % name, exe = exe, nunit=exe)

    native.cc_test(
        name=name, 
        srcs = [":%s_launcher" % name],
        deps = ["@io_bazel_rules_dotnet//dotnet/tools/runner_core", "@io_bazel_rules_dotnet//dotnet/tools/common"],
        data = [exe, "@xunit.runner.console//:core_tool"] + data,
        **kwargs
    )
