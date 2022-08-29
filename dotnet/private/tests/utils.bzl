"Test utilities"

load("@bazel_skylib//lib:unittest.bzl", "analysistest")

ACTION_ARGS_TEST_ARGS = {
    "action_mnemonic": attr.string(),
    "expected_partial_args": attr.string_list(),
}

# We also expose the implementation so that it can be used for testing
# with config flags
# buildifier: disable=function-docstring
def action_args_test_impl(ctx):
    env = analysistest.begin(ctx)

    action_under_test = None
    for action in analysistest.target_actions(env):
        if action.mnemonic == ctx.attr.action_mnemonic:
            if action_under_test == None:
                action_under_test = action
            else:
                fail("Multiple actions with mnemonic: {}".format(ctx.attr.action_mnemonic))

    if action_under_test == None:
        fail("No action with mnemonic: {}".format(ctx.attr.action_mnemonic))

    for expected_arg in ctx.attr.expected_partial_args:
        found_arg = None
        for actual_arg in action_under_test.argv:
            if actual_arg == expected_arg:
                if found_arg == None:
                    found_arg = actual_arg
                else:
                    fail("Multiple matches for arg: {}".format(expected_arg))

        if found_arg == None:
            fail("No match for arg: {}".format(expected_arg))

    return analysistest.end(env)

action_args_test = analysistest.make(
    action_args_test_impl,
    attrs = ACTION_ARGS_TEST_ARGS,
)
