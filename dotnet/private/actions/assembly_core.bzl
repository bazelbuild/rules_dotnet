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
        nowarn = None,
        langversion = "latest",
        version = (0, 0, 0, 0, "")):
    """ Emits actions and creates [DotnetLibraryInfo](api.md#dotnetlibraryinfo) for assembly compilation.

    Args:
        dotnet: [DotnetContextInfo](api.md#dotnetcontextinfo)
        name: name of the assembly
        srcs: source files (as passed from rules: list of lables/targets)
        deps: list of [DotnetLibraryInfo](api.md#dotnetlibraryinfo). Dependencies as passed from rules.
        out: output file name if provided. Otherwise name is used.
        resources: list of [DotnetResourceListInfo](api.md#dotnetresourceinfolist) providers.
        executable: bool. True for executable assembly, False otherwise.
        defines: list of string. Defines to pass to a compiler.
        unsafe: /unsafe flag (False - default - /unsafe-, otherwise /unsafe+).
        data: list of targets (as passed from rules). Additional depdendencies of the target.
        keyfile: File to be used for signing (if provided).
        subdir: specific subdirectory to be used for target location. Default ./
        target_framework: target framework to define via System.Runtime.Versioning.TargetFramework
        nowarn: list of warnings to ignore
        langversion: version of the language to use (see https://docs.microsoft.com/en-us/dotnet/csharp/language-reference/configure-language-version)
        version: Version to set for the generated assembly
    """
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
        langversion = langversion,
        version = version,
    )
