"NuGet Repo"

load("@bazel_tools//tools/build_defs/repo:utils.bzl", "maybe")
load("@rules_dotnet//dotnet/private/rules/nuget:nuget_archive.bzl", "nuget_archive")

_GLOBAL_NUGET_PREFIX = "nuget"

def _nuget_repo_impl(ctx):
    for (name_version, deps) in ctx.attr.packages.items():
        [name, version, sha512] = name_version.split("|")

        targeting_pack_overrides = ctx.attr.targeting_pack_overrides[name.lower()]
        template = Label("@rules_dotnet//dotnet/private/rules/nuget:template.BUILD")

        ctx.template("{}/{}/BUILD.bazel".format(name.lower(), version), template, {
            "{PREFIX}": _GLOBAL_NUGET_PREFIX,
            "{NAME}": name,
            "{NAME_LOWER}": name.lower(),
            "{VERSION}": version,
            "{DEPS}": ",".join(["\n    \"@{}//{}\"".format(ctx.name.lower(), d.lower()) for d in deps]),
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
        "packages": attr.string_list_dict(
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
    for (package_name, version, sha512, sources, netrc, _deps, _targeting_pack_overrides) in packages:
        package_name = package_name.lower()
        version = version.lower()

        # maybe another nuget_repo has the same nuget package dependency
        maybe(
            nuget_archive,
            name = "{}.{}.v{}".format(_GLOBAL_NUGET_PREFIX, package_name, version),
            sources = sources,
            netrc = netrc,
            id = package_name,
            version = version,
            sha512 = sha512,
        )

    # scaffold transitive @name// dependency tree
    _nuget_repo(
        name = name,
        packages = {"{}|{}|{}".format(name, version, sha512): deps for (name, version, sha512, _sources, _netrc, deps, _) in packages},
        targeting_pack_overrides = {"{}".format(name.lower()): targeting_pack_overrides for (name, _, _, _, _, _, targeting_pack_overrides) in packages},
    )
