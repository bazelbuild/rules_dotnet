"""Tests for the portable runtime identifier subset.

`rids.bzl` is regenerated from upstream, so the two properties that make
configuring on the portable RIDs alone safe are checked rather than assumed.
"""

load("@bazel_skylib//lib:unittest.bzl", "asserts", "unittest")

# buildifier: disable=bzl-visibility
load("//dotnet/private:portable_rids.bzl", "PORTABLE_RUNTIME_GRAPH", "to_portable_rid")

# buildifier: disable=bzl-visibility
load("//dotnet/private/sdk:rids.bzl", "RUNTIME_GRAPH")

def _closed_under_compatibility_test_impl(ctx):
    """No portable RID may be compatible with a version-qualified one.

    Otherwise narrowing the configured set changes what a configuration matches.
    """
    env = unittest.begin(ctx)

    leaks = []
    for (rid, compatible) in PORTABLE_RUNTIME_GRAPH.items():
        for candidate in compatible:
            if candidate not in PORTABLE_RUNTIME_GRAPH:
                leaks.append("{} -> {}".format(rid, candidate))

    asserts.equals(
        env,
        [],
        leaks,
        "portable RIDs must not be compatible with version-qualified ones",
    )
    return unittest.end(env)

def _every_rid_maps_test_impl(ctx):
    """Every RID in the full graph has a portable RID to fold onto.

    A RID without one would drop the assets a package ships under it.
    """
    env = unittest.begin(ctx)

    unmapped = [rid for rid in RUNTIME_GRAPH if to_portable_rid(rid) == None]

    asserts.equals(env, [], unmapped, "every RID must fold onto a portable one")
    return unittest.end(env)

def _mapping_test_impl(ctx):
    env = unittest.begin(ctx)

    # A portable RID is its own mapping.
    asserts.equals(env, "linux-x64", to_portable_rid("linux-x64"))
    asserts.equals(env, "win-arm64", to_portable_rid("win-arm64"))
    asserts.equals(env, "base", to_portable_rid("base"))

    # A version-qualified RID folds onto its nearest portable ancestor, which is
    # the distribution without the release, not the bare platform.
    asserts.equals(env, "ubuntu-x64", to_portable_rid("ubuntu.16.04-x64"))
    asserts.equals(env, "alpine-x64", to_portable_rid("alpine.3.10-x64"))
    asserts.equals(env, "centos-x64", to_portable_rid("centos.7-x64"))
    asserts.equals(env, "opensuse-x64", to_portable_rid("opensuse.42.1-x64"))

    # Something that is not a RID at all has no mapping.
    asserts.equals(env, None, to_portable_rid("not-a-rid"))
    return unittest.end(env)

closed_under_compatibility_test = unittest.make(_closed_under_compatibility_test_impl)
every_rid_maps_test = unittest.make(_every_rid_maps_test_impl)
mapping_test = unittest.make(_mapping_test_impl)

def portable_rids_test_suite(name):
    unittest.suite(
        name,
        closed_under_compatibility_test,
        every_rid_maps_test,
        mapping_test,
    )
