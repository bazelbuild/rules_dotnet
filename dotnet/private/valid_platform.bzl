"Utilities for determining if a generated platform is valid."

def valid_platform(os, arch, sdk_version):
    """Checks a generated platform tuple to determine if it corresponds to a .NET release.

    Args:
        os: the operating system name (windows, darwin, linux)
        arch: the system architecture (amd64, arm64)
        sdk_version: the dotnet SDK version

    Returns:
        True if the provided platform combination is valid.
    """
    [major_version, minor_version, patch_version] = [int(ver) for ver in sdk_version.split(".")]
    if arch == "arm64" and os == "darwin" and major_version < 6:
        return False
    return True
