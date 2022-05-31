package(default_visibility = ["//visibility:public"])
load("@rules_dotnet//dotnet:defs.bzl", "import_library")

import_library(
  name = "VERSION",
  version = "VERSION",
  libs = ["@PREFIX.NAME.VERSION//:libs"],
  refs = ["@PREFIX.NAME.VERSION//:refs"],
  analyzers = ["@PREFIX.NAME.VERSION//:analyzers"],
  data = ["@PREFIX.NAME.VERSION//:data"],
  deps = [DEPS],
)
