"""Asserts that a publish rejects two files that would take the same path."""

load("@bazel_skylib//lib:unittest.bzl", "analysistest", "asserts")

def _publish_conflict_test_impl(ctx):
    env = analysistest.begin(ctx)

    for fragment in ctx.attr.expected_message_fragments:
        asserts.expect_failure(env, fragment)

    return analysistest.end(env)

publish_conflict_test = analysistest.make(
    _publish_conflict_test_impl,
    doc = "Asserts that the publish under test fails with a message containing every fragment.",
    expect_failure = True,
    attrs = {
        "expected_message_fragments": attr.string_list(
            doc = "Substrings the failure message has to contain. Given in pieces " +
                  "because the message spells labels with their canonical repository " +
                  "prefix, which buildifier will not allow in a source string.",
            mandatory = True,
        ),
    },
)

def _publish_succeeds_test_impl(ctx):
    env = analysistest.begin(ctx)

    return analysistest.end(env)

publish_succeeds_test = analysistest.make(
    _publish_succeeds_test_impl,
    doc = "Asserts that the publish under test analyses without a path conflict.",
)
