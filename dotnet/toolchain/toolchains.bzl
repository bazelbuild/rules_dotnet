load(
    "//dotnet/private:dotnet_toolchain.bzl",
    "dotnet_toolchain",
)
load(
    "//dotnet/private:sdk.bzl",
    "dotnet_download_sdk",
    "dotnet_host_sdk",
    "dotnet_local_sdk",
)
load(
    "//dotnet/platform:list.bzl",
    "DOTNETARCH",
    "DOTNETOS",
    "DOTNETIMPL",
    "DOTNETIMPL_OS_ARCH",
)

DEFAULT_VERSION = "4.2.3"

SDK_REPOSITORIES = {
    "4.2.3": {
        "mono_darwin_amd64":      ("http://bazel-mirror.storage.googleapis.com/download.mono-project.com/archive/4.2.3/macos-10-x86/MonoFramework-MDK-4.2.3.4.macos10.xamarin.x86.tar.gz", 
                                "a7afb92d4a81f17664a040c8f36147e57a46bb3c33314b73ec737ad73608e08b"),
    },
}

def _generate_toolchains():
  # Use all the above information to generate all the possible toolchains we might support
  toolchains = []
  for impl, os, arch in DOTNETIMPL_OS_ARCH:
    host = "{}_{}_{}".format(impl, os, arch)
    toolchain_name = "dotnet_{}".format(host)
    csc_flags = []
    toolchains.append(dict(
        name = toolchain_name,
        host = host,
        csc_flags = csc_flags,
    ))
  return toolchains

_toolchains = _generate_toolchains()


_label_prefix = "@io_bazel_rules_dotnet//dotnet/toolchain:"

def dotnet_register_toolchains(dotnet_version=DEFAULT_VERSION):
  """See /dotnet/toolchains.rst#dostnet-register-toolchains for full documentation."""
  if "dotnet_download_sdk" not in native.existing_rules() and "dotnet_host_sdk" not in native.existing_rules() and "dotnet_local_sdk" not in native.existing_rules():
    if dotnet_version in SDK_REPOSITORIES:
      dotnet_download_sdk(
          name = "dotnet_sdk",
          sdks = SDK_REPOSITORIES[dotnet_version],
      )
    elif dotnet_version == "host":
      dotnet_host_sdk(
          name = "dotnet_sdk"
      )
    else:
      fail("Unknown dotnet version {}".format(dotnet_version))

  # Use the final dictionaries to register all the toolchains
  for toolchain in _toolchains:
    name = _label_prefix + toolchain["name"]
    native.register_toolchains(name)


def declare_constraints():
  for os, constraint in DOTNETOS.items():
    if constraint:
      native.alias(
          name = os,
          actual = constraint,
      )
    else:
      native.constraint_value(
          name = os,
          constraint_setting = "@bazel_tools//platforms:os",
      )
  for arch, constraint in DOTNETARCH.items():
    if constraint:
      native.alias(
          name = arch,
          actual = constraint,
      )
    else:
      native.constraint_value(
          name = arch,
          constraint_setting = "@bazel_tools//platforms:cpu",
      )
  native.constraint_setting(name = "dotnetimpl")
  for impl, constraint in DOTNETIMPL.items():
      native.constraint_value(
          name = impl,
          constraint_setting = ":dotnetimpl",
      )


  for impl, os, arch in DOTNETIMPL_OS_ARCH:
    native.platform(
        name = impl + "_" + os + "_" + arch,
        constraint_values = [
            ":" + impl,
            ":" + os,
            ":" + arch,
        ],
    )
def declare_toolchains():
  # Use the final dictionaries to create all the toolchains
  for toolchain in _toolchains:
    dotnet_toolchain(
        # Required fields
        name = toolchain["name"],
        host = toolchain["host"],
    )
