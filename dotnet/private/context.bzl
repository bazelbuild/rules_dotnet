load(
    "//dotnet/private:providers.bzl",
    "DotnetLibraryInfo",
    "DotnetResourceInfo",
)

DotnetContextInfo = provider(
    doc = """Enriches standard context with additional fields used by rules.

    DotnetContextInfo is never returned by a rule, instead you build one using 
    [dotnet_context(ctx)](api.md#dotnet_context) in the top of any custom skylark rule that wants 
    to interact with the dotnet rules.
    It provides all the information needed to create dotnet actions, and create or interact with the 
    other dotnet providers.

    When you get a DotnetContextInfo from a context it exposes a number of fields and methods.

    All methods take the DotnetContextInfo as the only positional argument, all other arguments even if
    mandatory must be specified by name, to allow us to re-order and deprecate individual parameters
    over time.

    """,
    fields = {
        "label": "Rule's label.",
        "toolchain": "Toolchain selected for the rule.",
        "actions": "Copy of ctx.actions (legacy).",
        "assembly": "Toolchain's assembly function. See [emit_assembly_core](api.md#emit_assembly_core) for the function signature.",
        "resx": "Toolchain's resx function. See [emit_resx_core](api.md#emit_resx_core) for the function signature.",
        "stdlib_byname": "Helper function for locating stdlib by name.",
        "exe_extension": "The suffix to use for all executables in this build mode. Mostly used when generating the output filenames of binary rules.",
        "runner": "An executable to be used by SDK to launch .NET Core programs (dotnet(.exe)).",
        "mcs": "C# compiler.",
        "stdlib": "None. Not used.",
        "resgen": "None. Not used.",
        "tlbimp": "None. Not used.",
        "declare_file": "Helper function for declaring new file. This is the equivalent of ctx.actions.declare_file.",
        "new_library": "Function for creating new [DotnetLibraryInfo](api.md#dotnetlibraryinfo). See [new_library](api.md#new_library) for signature declaration.",
        "new_resource": "Function for creating new [DotnetResourceInfo](api.md#dotnetresourceinfo). See [new_resource](api.md#new_resource) for signature declaration.",
        "workspace_name": "Workspace name.",
        "libVersion": "Should not be used.",
        "framework": "Framework version as specified in dotnet/platform/list.bzl.",
        "lib": "Lib folder as declared in context_data.",
        "shared": "Shared folder as declared in context_data.",
        "debug": "True if debug compilation is requested.",
        "_ctx": "Original context.",
    },
)

def _declare_file(dotnet, path = None, ext = None, sibling = None):
    result = path if path else dotnet._ctx.label.name
    if ext:
        result += ext
    return dotnet.actions.declare_file(result, sibling = sibling)

def new_library(
        dotnet,
        name = None,
        deps = None,
        transitive = None,
        result = None,
        pdb = None,
        runfiles = None,
        version = None,
        ref = None):
    """This creates a new [DotnetLibraryInfo](api.md#dotnetlibraryinfo).

    Args:
        dotnet: [DotnetContextInfo](api.md#dotnetcontextinfo).
        name: name of the file to generate.
        deps: The direct dependencies of this library.
        transitive: The full set of transitive dependencies. This includes ``deps`` for this  library and all ``deps`` members transitively reachable through ``deps``.
        result: The result to include in [DotnetLibraryInfo](api.md#dotnetlibraryinfo) (used when importing external assemblies).
        pdb: If .pdb file for given library should be generated.
        runfiles: Runfiles for DotnetLibraryInfo
        version: version to use for the library
        ref: reference assembly for the library
    """
    return DotnetLibraryInfo(
        name = dotnet.label.name if not name else name,
        label = dotnet.label,
        deps = deps,
        transitive = transitive,
        result = result,
        pdb = pdb,
        runfiles = runfiles,
        version = version,
        ref = ref,
    )

def new_resource(dotnet, name, result, identifier = None, **kwargs):
    """This creates a new [DotnetLibraryInfo](api.md#dotnetlibraryinfo).

    Args:
        dotnet: [DotnetContextInfo](api.md#dotnetcontextinfo).
        name: name of the file to generate.
        result: The .resources file.
        identifier: Identifier passed to -resource flag of mcs compiler. If empty the basename of the result.
        **kwargs: Additional arguments to set in the result.
    """
    return DotnetResourceInfo(
        name = name,
        label = dotnet.label,
        result = result,
        identifier = result.basename if not identifier else identifier,
        **kwargs
    )

def dotnet_context(ctx):
    """Converts rule's context to [DotnetContextInfo](api.md#dotnetcontextinfo)

    It uses the attrbutes and the toolchains.

    It can only be used in the implementation of a rule that has the dotnet toolchain attached and
    the dotnet context data as an attribute.

    If you are writing a new rule that wants to use the Dotnet toolchain, you need to do a couple of things.
    First, you have to declare that you want to consume the toolchain on the rule declaration.

    ```python
    my_rule_core = rule(
      _my_rule_impl,
      attrs = {
          ...
        "dotnet_context_data": attr.label(default = Label("@io_bazel_rules_dotnet//:core_context_data"))
      },
      toolchains = ["@io_bazel_rules_dotnet//dotnet:toolchain_type_core"],
    )
    ```

    And then in the rule body, you need to get the toolchain itself and use it's action generators.

    ```python
    def _my_rule_impl(ctx):
        dotnet = dotnet_context(ctx)
    ```

    Args:
        ctx: The Bazel ctx object for the current rule.

    Returns:
        DotnetContextInfo: [DotnetContextInfo](api.md#dotnetcontextinfo) provider for ctx rule.
    """
    attr = ctx.attr

    context_data = attr.dotnet_context_data
    toolchain = ctx.toolchains[context_data._toolchain_type]

    ext = ""
    if toolchain.dotnetos == "windows":
        ext = ".exe"

    # Handle empty toolchain for .NET on linux and osx
    if toolchain.get_dotnet_runner == None:
        runner = None
        mcs = None
        stdlib = None
        resgen = None
        tlbimp = None
    else:
        runner = toolchain.get_dotnet_runner(context_data, ext)
        mcs = toolchain.get_dotnet_mcs(context_data)
        stdlib = toolchain.get_dotnet_stdlib(context_data)
        resgen = toolchain.get_dotnet_resgen(context_data)
        tlbimp = toolchain.get_dotnet_tlbimp(context_data)

    return DotnetContextInfo(
        label = ctx.label,
        toolchain = toolchain,
        actions = ctx.actions,
        assembly = toolchain.actions.assembly,
        resx = toolchain.actions.resx,
        stdlib_byname = toolchain.actions.stdlib_byname,
        exe_extension = ext,
        runner = runner,
        mcs = mcs,
        stdlib = stdlib,
        resgen = resgen,
        tlbimp = tlbimp,
        declare_file = _declare_file,
        new_library = new_library,
        new_resource = new_resource,
        workspace_name = ctx.workspace_name,
        libVersion = context_data._libVersion,
        framework = context_data._framework,
        lib = context_data._lib,
        shared = context_data._shared,
        debug = ctx.var["COMPILATION_MODE"] == "dbg",
        _ctx = ctx,
    )

def _dotnet_context_data(ctx):
    return struct(
        _mcs_bin = ctx.attr.mcs_bin,
        _mono_bin = ctx.attr.mono_bin,
        _lib = ctx.attr.lib,
        _tools = ctx.attr.tools,
        _shared = ctx.attr.shared,
        _host = ctx.attr.host,
        _libVersion = ctx.attr.libVersion,
        _toolchain_type = ctx.attr._toolchain_type,
        _framework = ctx.attr.framework,
        _runner = ctx.attr.runner,
        _csc = ctx.attr.csc,
        _runtime = ctx.attr.runtime,
    )

core_context_data = rule(
    _dotnet_context_data,
    attrs = {
        "mcs_bin": attr.label(
            allow_files = True,
        ),
        "mono_bin": attr.label(
            allow_files = True,
        ),
        "lib": attr.label(
            allow_files = True,
        ),
        "tools": attr.label(
            allow_files = True,
        ),
        "shared": attr.label(
            allow_files = True,
        ),
        "host": attr.label(
            allow_files = True,
        ),
        "runtime": attr.label(providers = [DotnetLibraryInfo], default = "@io_bazel_rules_dotnet//dotnet/stdlib.core:runtime"),
        "libVersion": attr.string(
            default = "",
        ),
        "framework": attr.string(
            default = "",
        ),
        "_toolchain_type": attr.string(
            default = "@io_bazel_rules_dotnet//dotnet:toolchain_type_core",
        ),
        "runner": attr.label(executable = True, cfg = "host", default = "@core_sdk//:runner"),
        #"csc": attr.label(executable = True, cfg = "host", default = "@core_sdk//:csc"),
        "csc": attr.label(executable = True, cfg = "host", default = "@io_bazel_rules_dotnet//dotnet/stdlib.core:csc.dll"),
    },
    toolchains = ["@io_bazel_rules_dotnet//dotnet:toolchain_type_core"],
)
