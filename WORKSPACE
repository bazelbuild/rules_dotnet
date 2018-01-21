workspace(name = "io_bazel_rules_dotnet")

http_archive(
  name = "bazel_skylib",
  url = "https://github.com/bazelbuild/bazel-skylib/archive/ff23a62c57d2912c3073a69c12f42c3d6e58a957.zip",
  strip_prefix = "bazel-skylib-ff23a62c57d2912c3073a69c12f42c3d6e58a957",
  sha256 = "ccf83f162e4a265b3aa09445c84fbc470215e392b250c86f0ce00536c99d5c17",
)

load("//dotnet:csharp.bzl", "csharp_repositories")
csharp_repositories()
