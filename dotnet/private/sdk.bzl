load("@io_bazel_rules_dotnet//dotnet/private:common.bzl", "executable_extension", "bat_extension", "paths")

# Mono for linux, windows and macos layouts fies differentely
# So we provide an implementation for each host
def _dotnet_host_sdk_impl_windows(ctx):
  mono, mcs = _detect_host_sdk(ctx)
  _sdk_build_file(ctx)
  bin = ctx.path(mcs).dirname
  ctx.symlink(bin, "mcs_bin")
  bin = ctx.path(mono).dirname
  ctx.symlink(bin, "mono_bin")
  lib = paths.join("{}".format(ctx.path(mcs).dirname), "../lib")
  ctx.symlink(lib, "lib")


# Mono launcher is on Linux usually placed in /usr/bin. Since the directory
# may contain forbidden file names ('[') we cannot link it in dotnet_sdk
# Instead we create a directory (named mono_bin) and put link to mono in it
def _dotnet_host_sdk_impl_linux(ctx):
  mono, mcs = _detect_host_sdk(ctx)
  _sdk_build_file(ctx)
  ctx.file("mono_bin/README.md",
    "Directory to hold link to mono executable",
    False
  )
  ctx.symlink(mono, "mono_bin/mono")
  monoroot = ctx.path("/usr/lib/mono/")
  if not monoroot.exists:
    fail("Can't find mono in /usr/lib/mono/")
  ctx.symlink(monoroot, "lib")
  bin = paths.join("{}".format(monoroot), "4.5")
  ctx.symlink(bin, "mcs_bin")

def _dotnet_host_sdk_impl_osx(ctx):
  mono, mcs = _detect_host_sdk(ctx)
  _sdk_build_file(ctx)
  ctx.file("mono_bin/README.md",
    "Directory to hold link to mono executable",
    False
  )
  ctx.symlink(mono, "mono_bin/mono")
  monoroot = ctx.path("/usr/local/Cellar/mono/5.4.1.6/lib/mono")
  if not monoroot.exists:
    current = ctx.path(mono).dirname
    monodir = paths.join("{}".format(current), "..", "lib", "mono")
    monoroot = ctx.path(monodir)
    if not monoroot.exists:
      fail("Can't find mono in /usr/local/Cellar/mono/5.4.1.6/lib/mono")
  ctx.symlink(monoroot, "lib")
  bin = paths.join("{}".format(monoroot), "4.5")
  ctx.symlink(bin, "mcs_bin")

def _dotnet_host_sdk_impl(ctx):
  if ctx.os.name == 'linux':
    _dotnet_host_sdk_impl_linux(ctx)
  elif ctx.os.name == 'mac os x':
    _dotnet_host_sdk_impl_osx(ctx)
  elif ctx.os.name.startswith('windows'):
    _dotnet_host_sdk_impl_windows(ctx)
  

dotnet_host_sdk = repository_rule(
    implementation = _dotnet_host_sdk_impl, 
    local=True,
)

def _dotnet_download_sdk_impl(ctx):
  if ctx.os.name == 'linux':
    host = "mono_linux_amd64"
  elif ctx.os.name == 'mac os x':
    host = "mono_darwin_amd64"
  elif ctx.os.name.startswith('windows'):
    host = "mono_windows_amd64"
  else:
    fail("Unsupported operating system: " + ctx.os.name)
  sdks = ctx.attr.sdks
  if host not in sdks: fail("Unsupported host {}".format(host))
  filename, sha256 = ctx.attr.sdks[host]
  _sdk_build_file(ctx)
  _remote_sdk(ctx, [filename], ctx.attr.strip_prefix, sha256)
  ctx.symlink("mono/lib/mono/4.5", "mcs_bin")
  ctx.symlink("mono/bin", "mono_bin")
  ctx.symlink("mono/lib/mono", "lib")


dotnet_download_sdk = repository_rule(
    _dotnet_download_sdk_impl,
    attrs = {
        "sdks": attr.string_list_dict(),
        "urls": attr.string_list(),
        "strip_prefix": attr.string(default = ""),
    },
)

def _dotnet_local_sdk_impl(ctx):
  _sdk_build_file(ctx)
  bin = paths.join(ctx.attr.path, "/bin")
  ctx.symlink(bin, "bin")
  lib = paths.join(ctx.attr.path, "/lib")
  ctx.symlink(lib, "lib")

dotnet_local_sdk = repository_rule(
    _dotnet_local_sdk_impl,
    attrs = {
        "path": attr.string(),
    },
)

"""See /dotnet/toolchains.rst#dotnet-sdk for full documentation."""

def _remote_sdk(ctx, urls, strip_prefix, sha256):
  ctx.download_and_extract(
      url = urls,
      stripPrefix = strip_prefix,
      sha256 = sha256,
  )
  
def _sdk_build_file(ctx):
  ctx.file("ROOT")
  ctx.template("BUILD.bazel",
      Label("@io_bazel_rules_dotnet//dotnet/private:BUILD.sdk.bazel"),
      executable = False,
  )


def _detect_host_sdk(ctx):
  mcs = ctx.which("mcs" + bat_extension(ctx))
  if not mcs:
    defmono = ctx.path("c:/program files/mono/bin")
    if defmono.exists:
      mcs = ctx.path("c:/program files/mono/bin/mcs")
    else:
      fail("Failed to find mcs")
  
  mono = ctx.which("mono" + executable_extension(ctx))
  if not mono:
    defmono = ctx.path("c:/program files/mono/bin")
    if defmono.exists:
      mono = ctx.path("c:/program files/mono/bin/mono.exe")
    else:
      fail("Failed to find mono")

  return (mono, mcs)

