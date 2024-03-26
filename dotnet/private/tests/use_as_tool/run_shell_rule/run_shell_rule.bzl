"Test rule that uses ctx.actions.run"

def _run_shell_rule_impl(ctx):
    output = ctx.actions.declare_file("{}_out".format(ctx.label.name))

    ctx.actions.run_shell(
        outputs = [output],
        command = "./{} {}".format(ctx.executable.tool.path, output.path),
        tools = [ctx.executable.tool],
    )

    return [DefaultInfo(files = depset([output]))]

run_shell_rule = rule(
    implementation = _run_shell_rule_impl,
    attrs = {
        "tool": attr.label(
            executable = True,
            cfg = "exec",
            mandatory = True,
        ),
    },
)
