"NuGet Repo"

load("@bazel_tools//tools/build_defs/repo:utils.bzl", "maybe")
load("@rules_dotnet//dotnet/private/rules/nuget:nuget_archive.bzl", "nuget_archive")

_GLOBAL_NUGET_PREFIX = "nuget"

def _nuget_repo_impl(ctx):
    for package in ctx.attr.packages:
        package = json.decode(package)
        name = package["id"]
        version = package["version"]
        sha512 = package["sha512"]
        deps = package["dependencies"]

        # deps = []
        # for (tfm, tfm_deps) in dependencies.items():
        #     for dep in tfm_deps:
        #         if dep not in deps:
        #             deps.append(dep)

        targeting_pack_overrides = ctx.attr.targeting_pack_overrides[name.lower()]
        template = Label("@rules_dotnet//dotnet/private/rules/nuget:template.BUILD")

        ctx.template("{}/{}/BUILD.bazel".format(name.lower(), version), template, {
            "{PREFIX}": _GLOBAL_NUGET_PREFIX,
            "{NAME}": name,
            "{NAME_LOWER}": name.lower(),
            "{VERSION}": version,
            "{DEPS}": ",".join(["\n    \"@rules_dotnet//dotnet:tfm_{tfm}\": [{deps_list}]".format(tfm = tfm, deps_list = ",".join(["\"@{nuget_repo_name}//{dep_name}\"".format(dep_name = d.lower(), nuget_repo_name = ctx.name.lower()) for d in tfm_deps])) for (tfm, tfm_deps) in deps.items()]),
            "{TARGETING_PACK_OVERRIDES}": json.encode({override.lower().split("|")[0]: override.lower().split("|")[1] for override in targeting_pack_overrides}),
            "{SHA_512}": sha512,
        })

        # currently we only support one version of a package
        ctx.file("{}/BUILD.bazel".format(name.lower()), r"""package(default_visibility = ["//visibility:public"])
alias(name = "{name}", actual = "//{name}/{version}")
alias(name = "content_files", actual = "@{prefix}.{name}.v{version}//:content_files")
""".format(prefix = _GLOBAL_NUGET_PREFIX, name = name.lower(), version = version))

_nuget_repo = repository_rule(
    _nuget_repo_impl,
    attrs = {
        "packages": attr.string_list(
            mandatory = True,
            allow_empty = False,
        ),
        "targeting_pack_overrides": attr.string_list_dict(
            allow_empty = True,
            default = {},
        ),
    },
)

# buildifier: disable=function-docstring
def nuget_repo(name, packages):
    # TODO: Add docs
    # scaffold individual nuget archives
    for package in packages:
        package_name = package["id"].lower()
        version = package["version"].lower()

        # maybe another nuget_repo has the same nuget package dependency
        maybe(
            nuget_archive,
            name = "{}.{}.v{}".format(_GLOBAL_NUGET_PREFIX, package_name, version),
            sources = package["sources"],
            netrc = package.get("netrc", None),
            id = package_name,
            version = version,
            sha512 = package["sha512"],
        )

    # scaffold transitive @name// dependency tree
    _nuget_repo(
        name = name,
        packages = [json.encode(package) for package in packages],
        targeting_pack_overrides = {"{}".format(package["id"].lower()): package["targeting_pack_overrides"] for package in packages},
    )
