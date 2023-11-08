load("@rules_dotnet//dotnet:defs.bzl", "import_library")

package(default_visibility = ["//visibility:public"])

import_library(
    name = "{VERSION}",
    analyzers = ["@{PREFIX}.{NAME_LOWER}.v{VERSION}//:analyzers"],
    data = ["@{PREFIX}.{NAME_LOWER}.v{VERSION}//:data"],
    framework_list = {FRAMEWORK_LIST},
    library_name = "{NAME}",
    libs = ["@{PREFIX}.{NAME_LOWER}.v{VERSION}//:libs"],
    native = ["@{PREFIX}.{NAME_LOWER}.v{VERSION}//:native"],
    nupkg = "@{PREFIX}.{NAME_LOWER}.v{VERSION}//:{NAME_LOWER}.{VERSION}.nupkg",
    refs = ["@{PREFIX}.{NAME_LOWER}.v{VERSION}//:refs"],
    sha512 = "{SHA_512}",
    targeting_pack_overrides = {TARGETING_PACK_OVERRIDES},
    version = "{VERSION}",
    deps = select({
        {DEPS},
    }),
)
