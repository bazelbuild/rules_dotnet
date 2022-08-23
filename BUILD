load("@bazel_gazelle//:def.bzl", "gazelle", "gazelle_binary")

package(default_visibility = ["//visibility:public"])

exports_files(["AUTHORS"])

gazelle_binary(
    name = "gazelle_bin",
    languages = ["@bazel_skylib//gazelle/bzl"],
)

gazelle(
    name = "gazelle",
    gazelle = "gazelle_bin",
)
