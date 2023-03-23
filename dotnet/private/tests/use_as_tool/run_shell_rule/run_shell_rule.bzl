"Test rule that uses ctx.actions.run"

def _run_shell_rule_impl(ctx):
    output = ctx.actions.declare_file("{}_out".format(ctx.label.name))
    (inputs, input_manifests) = ctx.resolve_tools(tools = [ctx.attr.tool])

    is_windows = ctx.target_platform_has_constraint(ctx.attr._windows_constraint[platform_common.ConstraintValueInfo])

    ctx.actions.run_shell(
        outputs = [output],
        inputs = inputs,
        input_manifests = input_manifests,
        command = "{} {}".format(ctx.executable.tool.path, output.path) if is_windows else "./{} {}".format(ctx.executable.tool.path, output.path),
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
        "_windows_constraint": attr.label(default = "@platforms//os:windows"),
    },
)
