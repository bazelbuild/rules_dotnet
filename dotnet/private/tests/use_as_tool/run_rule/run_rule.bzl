"Test rule that uses ctx.actions.run"

def _run_rule_impl(ctx):
    output = ctx.actions.declare_file("{}_out".format(ctx.label.name))
    (inputs, input_manifests) = ctx.resolve_tools(tools = [ctx.attr.tool])

    ctx.actions.run(
        outputs = [output],
        arguments = [output.path],
        inputs = inputs,
        input_manifests = input_manifests,
        executable = ctx.executable.tool,
    )

    return [DefaultInfo(files = depset([output]))]

run_rule = rule(
    implementation = _run_rule_impl,
    attrs = {
        "tool": attr.label(
            executable = True,
            cfg = "exec",
            mandatory = True,
        ),
    },
)
