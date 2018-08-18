DOTNETIMPL = {
    "mono": None,
}

DOTNETOS = {
    "darwin": "@bazel_tools//platforms:osx",
    "linux": "@bazel_tools//platforms:linux",
    "windows": "@bazel_tools//platforms:windows",
}

DOTNETARCH = {
    "amd64": "@bazel_tools//platforms:x86_64",
}

DOTNETIMPL_OS_ARCH = (
    ("mono", "darwin", "amd64"),
    ("mono", "linux", "amd64"),
    ("mono", "windows", "amd64"),
)

def declare_config_settings():
  for impl in DOTNETIMPL:
    native.config_setting(
        name = impl,
        #constraint_values = ["//dotnet/toolchain:" + impl],
        values = {
            "compilation_mode": impl
        }
    )
  for os in DOTNETOS:
    native.config_setting(
        name = os,
        constraint_values = ["//dotnet/toolchain:" + os],
    )
  for arch in DOTNETARCH:
    native.config_setting(
        name = arch,
        constraint_values = ["//dotnet/toolchain:" + arch],
    )
  for arch, os, arch in DOTNETIMPL_OS_ARCH:
    native.config_setting(
        name = arch + "_" + os + "_" + arch,
        constraint_values = [
            "//dotnet/toolchain:" + os,
            "//dotnet/toolchain:" + arch,
            "//dotnet/toolchain:" + impl,
        ],
    )
