"""Resolves NuGet package hashes from the feeds a lock file points at.

Paket does not record package hashes, so there is nothing in `paket.lock` to
pin a download against. NuGet V3 feeds publish the hash of every package as
part of their registration metadata, so the extension looks it up once and
hands it back to Bazel as a fact, which keeps it in `MODULE.bazel.lock` for
every later build to reuse and for reviewers to see.

Feeds that do not serve registration metadata simply yield no hash. The
packages are still pinned to an exact version by the lock file; they are just
not verified against a recorded digest.
"""

load(
    "@bazel_tools//tools/build_defs/repo:utils.bzl",
    "read_netrc",
    "read_user_netrc",
    "use_netrc",
)

# Bump when the shape of a fact changes so that stale entries are ignored
# rather than misread.
_FACT_VERSION = "v1"

# Registration resources in order of preference. Only the SemVer 2.0.0
# flavours list packages whose versions carry build metadata or dotted
# pre-release identifiers, which rules out the older resources for some feeds.
_REGISTRATION_RESOURCES = [
    "RegistrationsBaseUrl/3.6.0",
    "RegistrationsBaseUrl/Versioned",
    "RegistrationsBaseUrl/3.4.0",
    "RegistrationsBaseUrl/3.0.0-rc",
    "RegistrationsBaseUrl/3.0.0-beta",
    "RegistrationsBaseUrl",
]

def integrity_fact_key(id, version):
    """Returns the key a package's hash is remembered under.

    A package version is downloaded once and shared by every dependency group
    that resolves it, so the feed it came from is not part of its identity.

    Args:
      id: The package id.
      version: The normalized package version.

    Returns:
      The fact key.
    """
    return "sha512/{}:{}/{}".format(_FACT_VERSION, id.lower(), version.lower())

def read_netrc_entries(module_ctx, netrc):
    """Reads a netrc file once, for repeated `auth_for` calls.

    Args:
      module_ctx: The module extension context.
      netrc: A label pointing at a netrc file, or None to use the user's.

    Returns:
      The parsed netrc entries.
    """
    return read_netrc(module_ctx, netrc) if netrc else read_user_netrc(module_ctx)

def _auth(netrc_entries, urls):
    return use_netrc(netrc_entries, urls, {
        "type": "basic",
        "login": "<login>",
        "password": "<password>",
    })

def _read_json(module_ctx, path):
    content = module_ctx.read(path)

    # A feed that mis-declares compression leaves us holding bytes that are not
    # JSON, which is not worth failing a build over.
    if not content.startswith("{"):
        return None

    return json.decode(content)

def _download_all(module_ctx, requests, auth, directory):
    """Downloads `requests` concurrently and returns the parsed JSON bodies.

    Args:
      module_ctx: The module extension context.
      requests: A list of (key, url) pairs.
      auth: The auth dict to use.
      directory: Where to stage the downloaded files.

    Returns:
      A dict of key to parsed JSON, omitting anything that failed.
    """
    pending = []

    for (index, (key, url)) in enumerate(requests):
        path = "{}/{}.json".format(directory, index)
        pending.append((key, path, module_ctx.download(
            url = url,
            output = path,
            allow_fail = True,
            block = False,
            auth = auth,
        )))

    results = {}
    for (key, path, token) in pending:
        if not token.wait().success:
            continue

        body = _read_json(module_ctx, path)
        if body != None:
            results[key] = body

    return results

def _registration_base(module_ctx, source, auth):
    """Returns the registration base URL of a V3 feed, or "" if it has none.

    Fails if the feed should have one but could not be asked, so that a
    misconfigured or unreachable feed is not mistaken for one that simply does
    not publish hashes.
    """
    if not source.endswith("index.json"):
        # A V2 feed. Its metadata is OData rather than JSON and does not
        # expose package hashes.
        return ""

    result = module_ctx.download(
        url = source,
        output = "service_index.json",
        allow_fail = True,
        auth = auth,
    )
    if not result.success:
        fail(
            "Could not read the service index of {} to verify package hashes.".format(source) +
            " Check the feed and its credentials, or set verify_integrity = False on paket.parse.",
        )

    index = _read_json(module_ctx, "service_index.json")
    if index == None:
        fail("The service index of {} is not valid JSON.".format(source))

    resources = {}
    for resource in index.get("resources", []):
        resources.setdefault(resource.get("@type", ""), resource.get("@id", ""))

    for name in _REGISTRATION_RESOURCES:
        base = resources.get(name)
        if base:
            return base if base.endswith("/") else base + "/"

    return ""

def _package_hash(catalog_entry):
    if catalog_entry.get("packageHashAlgorithm") != "SHA512":
        return None

    hash = catalog_entry.get("packageHash")

    return "sha512-" + hash if hash else None

def resolve_integrity(module_ctx, source, packages, netrc_entries, bases):
    """Looks up the subresource integrity of each package on a feed.

    Args:
      module_ctx: The module extension context.
      source: The feed to query.
      packages: Structs with `id` and `version` fields.
      netrc_entries: Parsed netrc entries, from `read_netrc_entries`.
      bases: A cache of source URL to registration base, which this call adds
        to. Pass the same dict across feeds so that a feed shared by several
        dependency groups is only asked once.

    Returns:
      A dict of "<lower id>/<lower version>" to an integrity string, holding
      only the packages the feed published a SHA512 for.
    """
    if not packages:
        return {}

    if source not in bases:
        bases[source] = _registration_base(module_ctx, source, _auth(netrc_entries, [source]))

    base = bases[source]
    if not base:
        return {}

    auth = _auth(netrc_entries, [base])

    leaves = _download_all(
        module_ctx,
        [
            (
                "{}/{}".format(package.id.lower(), package.version.lower()),
                "{}{}/{}.json".format(base, package.id.lower(), package.version.lower()),
            )
            for package in packages
        ],
        auth,
        "registration",
    )

    # The hash lives on the catalog entry, which a registration leaf links to.
    # Feeds that inline the entry instead do not carry a hash in it.
    catalog_requests = [
        (key, leaf["catalogEntry"])
        for (key, leaf) in leaves.items()
        if type(leaf.get("catalogEntry")) == "string" and leaf["catalogEntry"]
    ]

    integrity = {}
    for (key, entry) in _download_all(module_ctx, catalog_requests, auth, "catalog").items():
        hash = _package_hash(entry)
        if hash:
            integrity[key] = hash

    return integrity
