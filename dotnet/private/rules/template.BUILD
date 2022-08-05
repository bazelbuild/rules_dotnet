load("@rules_dotnet//dotnet:defs.bzl", "import_library")

package(default_visibility = ["//visibility:public"])

import_library(
    name = "VERSION",
    analyzers = ["@PREFIX.NAME.vVERSION//:analyzers"],
    data = ["@PREFIX.NAME.vVERSION//:data"],
    library_name = "NAME",
    libs = ["@PREFIX.NAME.vVERSION//:libs"],
    refs = ["@PREFIX.NAME.vVERSION//:refs"],
    targeting_pack_overrides = TARGETING_PACK_OVERRIDES,
    version = "VERSION",
    deps = [DEPS],
)
