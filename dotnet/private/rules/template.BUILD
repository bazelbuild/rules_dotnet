package(default_visibility = ["//visibility:public"])
load("@rules_dotnet//dotnet:defs.bzl", "import_library")

import_library(
  name = "VERSION",
  version = "VERSION",
  libs = ["@PREFIX.NAME.vVERSION//:libs"],
  refs = ["@PREFIX.NAME.vVERSION//:refs"],
  analyzers = ["@PREFIX.NAME.vVERSION//:analyzers"],
  data = ["@PREFIX.NAME.vVERSION//:data"],
  deps = [DEPS],
  targeting_pack_overrides = TARGETING_PACK_OVERRIDES
)
