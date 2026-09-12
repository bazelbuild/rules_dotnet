"""Declares the repositories that hold the SDK's targeting, runtime and apphost packs.

Each repository groups its packages behind targets named for what they provide
(`@dotnet.targeting_packs//default:net10.0`), so labels do not move when the
versions in `PACK_BANDS` change.
"""

load("@bazel_skylib//lib:collections.bzl", "collections")
load(
    "//dotnet/private:semver.bzl",
    "semver",
)
load(
    "//dotnet/private/paket:feed.bzl",
    "integrity_fact_key",
    "package_versions",
    "read_netrc_entries",
    "resolve_integrity_cached",
)
load(
    "//dotnet/private/rules/nuget:nuget_repo.bzl",
    "nuget_archive_name",
    "nuget_archives",
    "nuget_hub_repo",
    "nuget_package_label",
)
load(
    "//dotnet/private/sdk:packs.bzl",
    "APPHOST_PACK_REPO",
    "CROSSGEN2_PACK_REPO",
    "PROJECT_SDKS",
    "RUNTIME_PACK_REPO",
    "TARGETING_PACK_REPO",
    "apphost_pack",
    "band_is_movable",
    "crossgen2_host_rids",
    "crossgen2_pack",
    "runtime_pack_rids",
    "runtime_pack_tfms",
    "runtime_packs",
    "targeting_pack_tfms",
    "targeting_packs",
)
load("//dotnet/private/sdk:versions.bzl", "TOOL_VERSIONS")

NUGET_ORG = "https://api.nuget.org/v3/index.json"

_HEADER = """\
"GENERATED"

load("@rules_dotnet//dotnet/private/sdk/{kind}_packs:{kind}_pack.bzl", "{kind}_pack")

package(default_visibility = ["//visibility:public"])\
"""

def _retarget(packs, version):
    """Moves a band's packs onto `version`, or leaves them alone if None."""
    if version == None:
        return packs

    return [(id, version) for (id, _) in packs]

def _render(value):
    """Renders an attribute value, keeping `select` dicts as selects."""
    if type(value) == "dict":
        return "select({})".format(json.encode(value))

    return json.encode(value)

def _target(kind, attrs):
    return "{}_pack(\n{}\n)".format(kind, "\n".join([
        "    {} = {},".format(key, _render(attrs[key]))
        for key in sorted(attrs)
    ]))

def _build_file(kind, targets):
    return "\n\n".join([_HEADER.format(kind = kind)] + [_target(kind, a) for a in targets]) + "\n"

def _targeting(versions):
    packages = []
    build_files = {}

    for project_sdk in PROJECT_SDKS:
        targets = []

        for tfm in targeting_pack_tfms(project_sdk):
            packs = _retarget(targeting_packs(tfm, project_sdk), versions.get(tfm))
            packages += packs
            targets.append({
                "name": tfm,
                "packs": [nuget_package_label(id, version) for (id, version) in packs],
                "target_framework": tfm,
            })

        build_files["{}/BUILD.bazel".format(project_sdk)] = _build_file("targeting", targets)

    return struct(build_files = build_files, packages = collections.uniq(packages))

def _runtime(versions):
    packages = []
    build_files = {}

    for project_sdk in PROJECT_SDKS:
        for tfm in runtime_pack_tfms():
            targets = []

            for rid in runtime_pack_rids(tfm, project_sdk):
                packs = _retarget(runtime_packs(tfm, rid, project_sdk), versions.get(tfm))
                packages += packs
                targets.append({
                    "name": rid,
                    "packs": [nuget_package_label(id, version) for (id, version) in packs],
                    "runtime_identifier": rid,
                    "target_framework": tfm,
                })

            build_files["{}/{}/BUILD.bazel".format(project_sdk, tfm)] = _build_file("runtime", targets)

    return struct(build_files = build_files, packages = collections.uniq(packages))

def _apphost(versions):
    packages = []
    build_files = {}

    for tfm in runtime_pack_tfms():
        targets = []

        for rid in runtime_pack_rids(tfm):
            (id, version) = _retarget([apphost_pack(tfm, rid)], versions.get(tfm))[0]
            packages.append((id, version))
            targets.append({
                "name": rid,
                "pack": nuget_package_label(id, version),
                "runtime_identifier": rid,
                "target_framework": tfm,
            })

        build_files["{}/BUILD.bazel".format(tfm)] = _build_file("apphost", targets)

    return struct(build_files = build_files, packages = collections.uniq(packages))

def _crossgen2(versions):
    """One target per host runtime identifier, selecting its pack by framework.

    crossgen2 is chosen by the machine the build runs on while the framework
    comes from the configuration, and a rule attribute cannot select on both.
    """
    packages = []
    targets = []
    newest_tfm = runtime_pack_tfms()[-1]

    for rid in crossgen2_host_rids():
        by_tfm = {}

        for tfm in runtime_pack_tfms():
            pack = crossgen2_pack(tfm, rid)

            if pack == None:
                continue

            (id, version) = pack
            version = versions.get(tfm) or version
            packages.append((id, version))

            # crossgen2 is a native executable with its JIT libraries beside
            # it, none of which the package rules classify, so the pack reads
            # the archive's file list directly.
            files = "@{}//:files".format(nuget_archive_name(id, version))
            by_tfm["@rules_dotnet//dotnet:tfm_{}".format(tfm)] = files

            if tfm == newest_tfm:
                # Nothing sets a target framework outside a tfm transition, so
                # the target still has to resolve without one.
                by_tfm["//conditions:default"] = files

        targets.append({
            "name": rid,
            "pack_files": by_tfm,
        })

    return struct(
        # Not the root BUILD: the hub writes its own there.
        build_files = {"tool/BUILD.bazel": _build_file("crossgen2", targets)},
        packages = collections.uniq(packages),
    )

def _versions_for_registered_sdks(module_ctx, registrations, netrc_entries, indexes):
    """Returns the version each band's packs should move to, by target framework.

    Compiling against the reference pack that ships with the SDK in use is what
    MSBuild does. A band nobody registered an SDK for is left where the table
    puts it, as is one whose reference pack was never published for that patch.
    """
    remembered = getattr(module_ctx, "facts", {})
    wanted = {}

    for dotnet_version in registrations.values():
        sdk = TOOL_VERSIONS.get(dotnet_version)
        if sdk == None or not band_is_movable(sdk["runtimeTfm"]):
            continue

        tfm = sdk["runtimeTfm"]
        current = wanted.get(tfm)
        runtime_version = sdk["runtimeVersion"]

        if current == None or semver.to_comparable(runtime_version) > semver.to_comparable(current):
            wanted[tfm] = runtime_version

    versions = {}
    facts = {}

    for (tfm, runtime_version) in wanted.items():
        (ref_id, _) = targeting_packs(tfm)[0]
        key = "pack/v1:{}/{}".format(ref_id.lower(), runtime_version)
        published = remembered.get(key)

        if published == None:
            # The reference pack stops being serviced first, so it stands in
            # for the whole band.
            published = runtime_version in package_versions(
                module_ctx,
                NUGET_ORG,
                ref_id,
                netrc_entries,
                indexes,
            )

        facts[key] = published
        if published:
            versions[tfm] = runtime_version

    return struct(facts = facts, versions = versions)

def declare_pack_repos(module_ctx, registrations):
    """Declares the repositories holding the SDK's packs.

    Args:
      module_ctx: The module extension context.
      registrations: The registered .NET SDK versions, by toolchain name.

    Returns:
      The facts to hand back to Bazel, so that the versions and hashes looked
      up here are reused by later evaluations.
    """
    netrc_entries = read_netrc_entries(module_ctx, None)
    indexes = {}

    bands = _versions_for_registered_sdks(module_ctx, registrations, netrc_entries, indexes)
    kinds = [
        (TARGETING_PACK_REPO, _targeting(bands.versions)),
        (RUNTIME_PACK_REPO, _runtime(bands.versions)),
        (APPHOST_PACK_REPO, _apphost(bands.versions)),
        (CROSSGEN2_PACK_REPO, _crossgen2(bands.versions)),
    ]

    # The kinds cannot share a package: their ids end in `.Ref`,
    # `.Runtime.<rid>`, `.Host.<rid>` and `.Crossgen2.<rid>` respectively.
    packages = [pack for (_, kind) in kinds for pack in kind.packages]

    resolved = {}
    resolve_integrity_cached(
        module_ctx,
        [NUGET_ORG],
        [struct(id = id, version = version) for (id, version) in packages],
        netrc_entries,
        resolved,
        indexes,
    )

    declared = {}
    for (repo, kind) in kinds:
        hub = [
            {
                "id": id,
                "name": "{}.v{}".format(id.lower(), version),
                "sha512": resolved.get(integrity_fact_key(id, version), ""),
                "sources": [NUGET_ORG],
                "version": version,
            }
            for (id, version) in kind.packages
        ]
        nuget_archives(hub, declared)
        nuget_hub_repo(repo, hub, extra_build_files = kind.build_files)

    return bands.facts | resolved
