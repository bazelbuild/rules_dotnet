load("@bazel_tools//tools/build_defs/repo:utils.bzl", "maybe")
load("@rules_dotnet//dotnet/private:rules/nuget_archive.bzl", "nuget_archive")

_GLOBAL_NUGET_PREFIX = "nuget"

def _nuget_repo_impl(ctx):
  for (name_version, deps) in ctx.attr.packages.items():
    [name, version] = name_version.lower().split('/')

    # check for framwork overrides

    # todo overrides
    overrides = {}
    template = Label("@rules_dotnet//dotnet/private:rules/override.BUILD") if name in overrides else Label("@rules_dotnet//dotnet/private:rules/template.BUILD")

    ctx.template("{}/{}/BUILD.bazel".format(name, version), template, {
      "PREFIX": _GLOBAL_NUGET_PREFIX,
      "NAME": name,
      "VERSION": version,
      "DEPS": ",".join(["\n    \"@{}//{}\"".format(ctx.name, d.lower()) for d in deps]),
    })

    # currently we only support one version of a package
    ctx.file("{}/BUILD.bazel".format(name), r"""package(default_visibility = ["//visibility:public"])
alias(name = "{name}", actual = "//{name}/{version}")
alias(name = "content_files", actual = "@{prefix}.{name}.{version}//:content_files")
""".format(prefix = _GLOBAL_NUGET_PREFIX, name = name, version = version))

_nuget_repo = repository_rule(
  _nuget_repo_impl,
  attrs = {
      "packages": attr.string_list_dict()
  }
)

def nuget_repo(name, packages):
    # overrides = dict([o.split('|') for o in overrides_string.lower().splitlines()])

    # scaffold individual nuget archives
    for (package_name, version, hash, deps) in packages:
        package_name = package_name.lower()
        version = version.lower()
        # maybe another nuget_repo has the same nuget package dependency
        maybe(
            nuget_archive,
            name = "{}.{}.{}".format(_GLOBAL_NUGET_PREFIX, package_name, version),
            id = package_name,
            version = version,
            hash = hash,
        )

    # scaffold transitive @name// dependency tree
    _nuget_repo(
        name = name,
        packages = { "{}/{}".format(name, version): deps for (name, version, _, deps) in packages }
    )
