"""Reads the requirements out of a `paket.dependencies` file.

Everything needed to build comes from `paket.lock`. The dependencies file is
read to notice when it has been edited without re-running Paket, which would
otherwise surface much later as a missing package or a stale version.
"""

load("//dotnet/private/paket:lock.bzl", "MAIN_GROUP", "normalize_version")

# Version constraints, as opposed to an exact version. A constraint can resolve
# to anything, so only its package's presence in the lock file can be checked.
_CONSTRAINT_PREFIXES = ["~", ">", "<", "=", "!"]

def _parse_version(tokens):
    """Returns the exact version a `nuget` line pins, or "" if it does not."""
    if len(tokens) < 3:
        return ""

    version = tokens[2]

    # Trailing settings such as `framework: net45` or a bare `prerelease`.
    if version[0] in _CONSTRAINT_PREFIXES or not version[0].isdigit():
        return ""

    return normalize_version(version)

def parse_dependencies(content):
    """Parses the package requirements of a `paket.dependencies` file.

    Args:
      content: The contents of the `paket.dependencies` file.

    Returns:
      A dict of group name to a dict of package id to the exact version it is
      pinned at, or "" when it is declared without one. The implicit top group
      is called "Main" and is only present when packages are declared outside
      of any group.
    """
    groups = {}
    group = MAIN_GROUP

    for raw in content.replace("\r\n", "\n").split("\n"):
        line = raw.strip()
        if not line or line.startswith("#"):
            continue

        tokens = line.split(" ")
        tokens = [token for token in tokens if token]
        keyword = tokens[0].lower()

        if keyword == "group" and len(tokens) > 1:
            group = tokens[1]
        elif keyword == "nuget" and len(tokens) > 1:
            groups.setdefault(group, {})[tokens[1]] = _parse_version(tokens)

    return groups
