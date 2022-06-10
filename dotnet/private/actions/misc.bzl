"""
Actions for generating various files.
"""

def write_runtimeconfig(actions, template, name, tfm, runtime_version):
    """Create a *.runtimeconfig.json file.

    This file is necessary when running a .NET Core binary.

    Args:
      actions: An actions module, usually from ctx.actions.
      template: A template file.
      name: The name of the executable.
      tfm: The target framework moniker for the exe being built.
      runtime_version: The runtime version of the current SDK
    """

    output = actions.declare_file("bazelout/%s/%s.runtimeconfig.json" % (tfm, name))

    # We're doing this as a template rather than a static file to allow users
    # to customize this if they wish.
    actions.expand_template(
        template = template,
        output = output,
        substitutions = {
            "{RUNTIME_TFM}": tfm,
            "{RUNTIME_FRAMEWORK_VERSION}": runtime_version,
        },
    )

    return output

def write_depsjson(actions, template, name, tfm):
    """Create a *.deps.json file.

    This file is necessary when running a .NET Core binary.

    Args:
      actions: An actions module, usually from ctx.actions.
      template: A template file.
      name: The name of the executable.
      tfm: The target framework moniker for the exe being built.
    """
    output = actions.declare_file("bazelout/%s/%s.deps.json" % (tfm, name))

    # We're doing this as a template rather than a static file to allow users
    # to customize this if they wish.
    actions.expand_template(
        template = template,
        output = output,
        substitutions = {
            "{RUNTIME_TFM}": tfm.replace("net", ""),
        },
    )

    return output

def write_internals_visible_to_csharp(actions, name, others):
    """Write a .cs file containing InternalsVisibleTo attributes.

    Letting Bazel see which assemblies we are going to have InternalsVisibleTo
    allows for more robust caching of compiles.

    Args:
      actions: An actions module, usually from ctx.actions.
      name: The assembly name.
      others: The names of other assemblies.

    Returns:
      A File object for a generated .cs file
    """

    if len(others) == 0:
        return None

    attrs = actions.args()
    attrs.set_param_file_format(format = "multiline")

    attrs.add_all(
        others,
        format_each = "[assembly: System.Runtime.CompilerServices.InternalsVisibleTo(\"%s\")]",
    )

    output = actions.declare_file("bazelout/%s/internalsvisibleto.cs" % name)

    actions.write(output, attrs)

    return output

def write_internals_visible_to_fsharp(actions, name, others):
    """Write a .fs file containing InternalsVisibleTo attributes.

    Letting Bazel see which assemblies we are going to have InternalsVisibleTo
    allows for more robust caching of compiles.

    Args:
      actions: An actions module, usually from ctx.actions.
      name: The assembly name.
      others: The names of other assemblies.

    Returns:
      A File object for a generated .fs file
    """

    if len(others) == 0:
        return None

    content = """
module AssemblyInfo

"""
    for other in others:
        content += """
[<assembly: System.Runtime.CompilerServices.InternalsVisibleTo(\"%s\")>]
do()

""" % other

    output = actions.declare_file("bazelout/%s/internalsvisibleto.fs" % name)
    actions.write(output, content)

    return output

def framework_preprocessor_symbols(tfm):
    """Gets the standard preprocessor symbols for the target framework.

    See https://docs.microsoft.com/en-us/dotnet/csharp/language-reference/preprocessor-directives/preprocessor-if#remarks
    for the official list.

    Args:
        tfm: The target framework moniker target being built.
    Returns:
        A list of preprocessor symbols.
    """
    # TODO: All built in preprocessor directives: https://docs.microsoft.com/en-us/dotnet/csharp/language-reference/preprocessor-directives

    specific = tfm.upper().replace(".", "_")

    if tfm.startswith("netstandard"):
        return ["NETSTANDARD", specific]
    elif tfm.startswith("netcoreapp"):
        return ["NETCOREAPP", specific]
    else:
        return ["NETFRAMEWORK", specific]
