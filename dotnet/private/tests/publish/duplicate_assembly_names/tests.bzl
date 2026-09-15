"""Asserts that a publish rejects two assemblies that share a file name."""

load("@bazel_skylib//lib:unittest.bzl", "analysistest", "asserts")

def _duplicate_assembly_names_test_impl(ctx):
    env = analysistest.begin(ctx)

    # Split so that neither half spells a canonical repository name, which
    # buildifier rejects. Between them they check that the message names both
    # targets at fault and the name they collide on.
    asserts.expect_failure(env, ":lib_one and ")
    asserts.expect_failure(env, ":lib_two are both published as \"lib.dll\".")

    return analysistest.end(env)

duplicate_assembly_names_test = analysistest.make(
    _duplicate_assembly_names_test_impl,
    expect_failure = True,
)
