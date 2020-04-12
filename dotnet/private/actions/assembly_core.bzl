load("@io_bazel_rules_dotnet//dotnet/private:actions/assembly_common.bzl", "emit_assembly_common")

def emit_assembly_core(
        dotnet,
        name,
        srcs,
        deps = None,
        out = None,
        resources = None,
        executable = True,
        defines = None,
        unsafe = False,
        data = None,
        keyfile = None,
        subdir = "./",
        target_framework = "",
        nowarn = None):
    return emit_assembly_common(
        kind = "core",
        dotnet = dotnet,
        name = name,
        srcs = srcs,
        deps = deps,
        out = out,
        resources = resources,
        executable = executable,
        defines = defines,
        unsafe = unsafe,
        data = data,
        keyfile = keyfile,
        subdir = subdir,
        target_framework = target_framework,
        nowarn = nowarn,
    )
