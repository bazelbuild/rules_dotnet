# How to Contribute

Want to contribute? Great! First, read this page!

## Before you contribute

**Before we can use your code, you must sign the
[Google Individual Contributor License Agreement](https://developers.google.com/open-source/cla/individual?csw=1)
(CLA)**, which you can do online.

The CLA is necessary mainly because you own the copyright to your changes,
even after your contribution becomes part of our codebase, so we need your
permission to use and distribute your code. We also need to be sure of
various other things — for instance that you'll tell us if you know that
your code infringes on other people's patents. You don't have to sign
the CLA until after you've submitted your code for review and a member has
approved it, but you must do it before we can put your code into our codebase.

Before you start working on a larger contribution, you should get in touch
with us first. Use the issue tracker to explain your idea so we can help and
possibly guide you.

### The small print

Contributions made by corporations are covered by a different agreement than
the one above, the
[Software Grant and Corporate Contributor License Agreement](https://cla.developers.google.com/about/google-corporate).

## Formatting

Starlark files should be formatted by buildifier.
We suggest using a pre-commit hook to automate this.
First [install pre-commit](https://pre-commit.com/#installation),
then run

```shell
pre-commit install
```

Otherwise later tooling on CI may yell at you about formatting/linting violations.

## Updating BUILD files

Some targets are generated from sources.
Currently this is just the `bzl_library` targets.
Run `bazel run //:gazelle` to keep them up-to-date.

## Using this as a development dependency of other rules

You'll commonly find that you develop in another WORKSPACE, such as
some other ruleset that depends on rules_dotnet, or in a nested
WORKSPACE in the integration_tests folder.

To always tell Bazel to use this directory rather than some release
artifact or a version fetched from the internet, run this from this
directory:

```sh
OVERRIDE="--override_repository=rules_dotnet=$(pwd)/rules_dotnet"
echo "common $OVERRIDE" >> ~/.bazelrc
```

This means that any usage of `@rules_dotnet` on your system will point to this folder.

## Running tests

To run and build all tests simply run `bazel test //...`
To build and test all lexamples run `cd examples && bazel test //...`

## Releasing

1. Determine the next release version, following semver (could automate in the future from changelog)
1. Tag the repo and push it (or create a tag in GH UI)
1. Watch the automation run on GitHub actions
