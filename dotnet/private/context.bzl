"DotnetContext declarations"

load(
    "@io_bazel_rules_dotnet//dotnet/private:providers.bzl",
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
        "assembly": "Toolchain's assembly function. See [emit_assembly_core_csharp](api.md#emit_assembly_core_csharp) and [emit_assembly_core_fsharp](api.md#emit_assembly_core_fsharp) for the function signature.",
        "resx": "Toolchain's resx function. See [emit_resx_core](api.md#emit_resx_core) for the function signature.",
        "stdlib_byname": "Helper function for locating stdlib by name.",
        "exe_extension": "The suffix to use for all executables in this build mode. Mostly used when generating the output filenames of binary rules.",
        "runner": "An executable to be used by SDK to launch .NET Core programs (dotnet(.exe)).",
        "mcs": "C# compiler.",
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

def dotnet_context(ctx, lang):
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
      toolchains = ["@io_bazel_rules_dotnet//dotnet:toolchain_type_csharp_core"],
    )
    ```

    And then in the rule body, you need to get the toolchain itself and use it's action generators.

    ```python
    def _my_rule_impl(ctx):
        dotnet = dotnet_context(ctx)
    ```

    Args:
        ctx: The Bazel ctx object for the current rule.
        lang: The proramming languge for the current rule.

    Returns:
        DotnetContextInfo: [DotnetContextInfo](api.md#dotnetcontextinfo) provider for ctx rule.
    """
    attr = ctx.attr

    if lang == "csharp":
        toolchain = ctx.toolchains["@io_bazel_rules_dotnet//dotnet:toolchain_type_csharp_core"]
    elif lang == "fsharp":
        toolchain = ctx.toolchains["@io_bazel_rules_dotnet//dotnet:toolchain_type_fsharp_core"]
    else:
        fail("Only C# and F# are supported")

    ext = ""
    if toolchain.os == "windows":
        ext = ".exe"

    return DotnetContextInfo(
        label = ctx.label,
        toolchain = toolchain,
        actions = ctx.actions,
        exe_extension = ext,
        debug = ctx.var["COMPILATION_MODE"] == "dbg",
        _ctx = ctx,
    )
