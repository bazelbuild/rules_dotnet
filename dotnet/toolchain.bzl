"""
Rules to configure the .NET toolchain of rules_dotnet.
"""

DotnetInfo = provider(
    doc = "Information about the dotnet toolchain",
    fields = {
        "runtime_path": "Path to the dotnet executable",
        "runtime_files": """Files required in runfiles to make the dotnet executable available.

May be empty if the runtime_path points to a locally installed tool binary.""",
        "csharp_compiler_path": "Path to the C# compiler executable",
        "csharp_compiler_files": """Files required in runfiles to make the C# compiler executable available.

May be empty if the csharp_compiler_path points to a locally installed tool binary.""",
        "fsharp_compiler_path": "Path to the F# compiler executable",
        "fsharp_compiler_files": """Files required in runfiles to make the F# compiler executable available.

May be empty if the fsharp_compiler_path points to a locally installed tool binary.""",
        "apphost_path": "Path to the apphost executable",
        "apphost_files": """Files required in runfiles to make the apphost executable available.

May be empty if the apphost_path points to a locally installed tool binary.""",
        "sdk_version": "Version of the dotnet SDK",
        "runtime_version": "Version of the dotnet runtime",
        "runtime_tfm": "The target framework moniker for the current SDK",
        "csharp_default_version": "Default version of the C# language",
        "fsharp_default_version": "Default version of the F# language",
    },
)

# Avoid using non-normalized paths (workspace/../other_workspace/path)
def _to_manifest_path(ctx, file):
    if file.short_path.startswith("../"):
        return "external/" + file.short_path[3:]
    else:
        return ctx.workspace_name + "/" + file.short_path

def _dotnet_toolchain_impl(ctx):
    if ctx.attr.runtime and ctx.attr.runtime_path:
        fail("Can only set one of runtime or runtime_path but both were set.")
    if not ctx.attr.runtime and not ctx.attr.runtime_path:
        fail("Must set one of runtime or runtime_path.")

    if ctx.attr.csharp_compiler and ctx.attr.csharp_compiler_path:
        fail("Can only set one of csharp_compiler or csharp_compiler_path but both were set.")
    if not ctx.attr.csharp_compiler and not ctx.attr.csharp_compiler_path:
        fail("Must set one of csharp_compiler or csharp_compiler_path.")

    if ctx.attr.fsharp_compiler and ctx.attr.fsharp_compiler_path:
        fail("Can only set one of fsharp_compiler or fsharp_compiler_path but both were set.")
    if not ctx.attr.fsharp_compiler and not ctx.attr.fsharp_compiler_path:
        fail("Must set one of fsharp_compiler or fsharp_compiler_path.")

    if ctx.attr.apphost and ctx.attr.apphost_path:
        fail("Can only set one of apphost or apphost_path but both were set.")
    if not ctx.attr.apphost and not ctx.attr.apphost_path:
        fail("Must set one of apphost or apphost_path.")

    runtime_files = []
    runtime_path = ctx.attr.runtime_path

    csharp_compiler_files = []
    csharp_compiler_path = ctx.attr.csharp_compiler_path

    fsharp_compiler_files = []
    fsharp_compiler_path = ctx.attr.fsharp_compiler_path

    apphost_files = []
    apphost_path = ctx.attr.apphost_path

    if ctx.attr.runtime:
        runtime_files = ctx.attr.runtime.files.to_list()
        runtime_path = _to_manifest_path(ctx, runtime_files[0])

    if ctx.attr.csharp_compiler:
        csharp_compiler_files = ctx.attr.csharp_compiler.files.to_list()
        csharp_compiler_path = _to_manifest_path(ctx, csharp_compiler_files[0])

    if ctx.attr.fsharp_compiler:
        fsharp_compiler_files = ctx.attr.fsharp_compiler.files.to_list()
        fsharp_compiler_path = _to_manifest_path(ctx, fsharp_compiler_files[0])

    if ctx.attr.apphost:
        apphost_files = ctx.attr.apphost.files.to_list()
        apphost_path = _to_manifest_path(ctx, apphost_files[0])

    # Make the $(tool_BIN) variable available in places like genrules.
    # See https://docs.bazel.build/versions/main/be/make-variables.html#custom_variables
    template_variables = platform_common.TemplateVariableInfo({
        "DOTNET_BIN": runtime_path,
        "CSC_BIN": csharp_compiler_path,
        "FSC_BIN": fsharp_compiler_path,
        "DOTNET_SDK_VERSION": ctx.attr.sdk_version,
        "DOTNET_RUNTIME_VERSION": ctx.attr.runtime_version,
        "DOTNET_RUNTIME_TFM": ctx.attr.runtime_tfm,
    })

    dotnetinfo = DotnetInfo(
        runtime_path = runtime_path,
        runtime_files = runtime_files,
        csharp_compiler_path = csharp_compiler_path,
        csharp_compiler_files = csharp_compiler_files,
        fsharp_compiler_path = fsharp_compiler_path,
        fsharp_compiler_files = fsharp_compiler_files,
        apphost_path = apphost_path,
        apphost_files = apphost_files,
        sdk_version = ctx.attr.sdk_version,
        runtime_version = ctx.attr.runtime_version,
        runtime_tfm = ctx.attr.runtime_tfm,
        csharp_default_version = ctx.attr.csharp_default_version,
        fsharp_default_version = ctx.attr.fsharp_default_version,
    )

    # Export all the providers inside our ToolchainInfo
    # so the resolved_toolchain rule can grab and re-export them.
    toolchain_info = platform_common.ToolchainInfo(
        dotnetinfo = dotnetinfo,
        template_variables = template_variables,
        runtime = ctx.attr.runtime,
        csharp_compiler = ctx.file.csharp_compiler,
        fsharp_compiler = ctx.file.fsharp_compiler,
        apphost = ctx.file.apphost,
        strict_deps = ctx.attr.strict_deps,
    )
    return [
        toolchain_info,
        template_variables,
    ]

dotnet_toolchain = rule(
    implementation = _dotnet_toolchain_impl,
    attrs = {
        "runtime": attr.label(
            doc = "A hermetically downloaded executable target for the target platform.",
            mandatory = False,
            allow_single_file = True,
        ),
        "runtime_path": attr.string(
            doc = "Path to an existing executable for the target platform.",
            mandatory = False,
        ),
        "csharp_compiler": attr.label(
            doc = "A hermetically downloaded executable target for the target platform.",
            mandatory = False,
            allow_single_file = True,
        ),
        "csharp_compiler_path": attr.string(
            doc = "Path to an existing executable for the target platform.",
            mandatory = False,
        ),
        "fsharp_compiler": attr.label(
            doc = "A hermetically downloaded executable target for the target platform.",
            mandatory = False,
            allow_single_file = True,
        ),
        "fsharp_compiler_path": attr.string(
            doc = "Path to an existing executable for the target platform.",
            mandatory = False,
        ),
        "apphost": attr.label(
            doc = "A hermetically downloaded executable target for the target platform.",
            mandatory = False,
            allow_single_file = True,
        ),
        "apphost_path": attr.string(
            doc = "Path to an existing executable for the target platform.",
            mandatory = False,
        ),
        "sdk_version": attr.string(
            doc = "The SDK version of the current dotnet SDK",
            mandatory = True,
        ),
        "runtime_version": attr.string(
            doc = "The runtime version of the current dotnet SDK",
            mandatory = True,
        ),
        "runtime_tfm": attr.string(
            doc = "The runtime target framework moniker of the current dotnet SDK",
            mandatory = True,
        ),
        "csharp_default_version": attr.string(
            doc = "The default C# version used by the current dotnet SDK",
            mandatory = True,
        ),
        "fsharp_default_version": attr.string(
            doc = "The default F# version used by the current dotnet SDK",
            mandatory = True,
        ),
        "strict_deps": attr.bool(
            doc = "Whether to use strict deps or not",
            mandatory = True,
        ),
    },
    doc = """Defines a dotnet compiler/runtime toolchain.

For usage see https://docs.bazel.build/versions/main/toolchains.html#defining-toolchains.
""",
)
