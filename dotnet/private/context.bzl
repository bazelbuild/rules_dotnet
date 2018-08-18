load(
    "@io_bazel_rules_dotnet//dotnet/private:providers.bzl",
    "DotnetLibrary",
    "DotnetResource",
)

load(
    "@io_bazel_rules_dotnet//dotnet/private:common.bzl",
    "paths",
)


DotnetContext = provider()

def _get_dotnet_runner(context_data, ext):
  for f in context_data._mono_bin.files:
    basename = paths.basename(f.path)
    if basename != "mono" + ext:
      continue
    return f
  fail("Could not find mono executable in dotnet_sdk (mono_bin)")

def _get_dotnet_mcs(context_data):
  for f in context_data._mcs_bin.files:
    basename = paths.basename(f.path)
    if basename != "mcs.exe":
      continue
    return f

  for f in context_data._lib.files:
    basename = paths.basename(f.path)
    if basename != "mcs.exe":
      continue
    return f
  fail("Could not find mcs.exe in dotnet_sdk (mcs_bin, lib)")

def _get_dotnet_resgen(context_data):
  for f in context_data._mcs_bin.files:
    basename = paths.basename(f.path)
    if basename != "resgen.exe":
      continue
    return f

  for f in context_data._lib.files:
    basename = paths.basename(f.path)
    if basename != "resgen.exe":
      continue
    return f

  fail("Could not find resgen.exe in dotnet_sdk (mcs_bin, lib)")

def _get_dotnet_stdlib(context_data):
  for f in context_data._lib.files:
    basename = paths.basename(f.path)
    if basename != "mscorlib.dll":
      continue
    dirname = paths.dirname(f.path)
    if dirname.find(context_data._libVersion)==-1:
      continue
    return f
  fail("Could not find mscorlib in dotnet_sdk (lib, %s)" % context_data._libVersion)

def _declare_file(dotnet, path = None, ext = None):
  result = path if path else dotnet._ctx.label.name
  if ext:
    result += ext
  return dotnet.actions.declare_file(result)


def _new_library(dotnet, name=None, deps=None, transitive=None, **kwargs):
  return DotnetLibrary(
      name = dotnet.label.name if not name else name,
      label = dotnet.label,
      deps = deps,
      transitive = transitive,
      **kwargs
  )

def _new_resource(dotnet, name, result, identifier=None, **kwargs):
  return DotnetResource(
      name = name,
      label = dotnet.label,
      result = result,
      identifier = result.basename if not identifier else identifier,
      **kwargs
  )

def dotnet_context(ctx, attr=None):
  toolchain = ctx.toolchains["@io_bazel_rules_dotnet//dotnet:toolchain"]

  if not attr:
    attr = ctx.attr

  context_data = attr._dotnet_context_data 
  ext = ""
  if toolchain.default_dotnetos == "windows":
    ext = ".exe"
  runner = _get_dotnet_runner(context_data, ext)
  mcs = _get_dotnet_mcs(context_data)
  stdlib = _get_dotnet_stdlib(context_data)
  resgen = _get_dotnet_resgen(context_data)

  return DotnetContext(
      # Fields
      label = ctx.label,
      toolchain = toolchain,
      actions = ctx.actions,
      binary = toolchain.actions.binary,  
      library = toolchain.actions.library,
      resx = toolchain.actions.resx,
      exe_extension = ext,
      runner = runner,
      mcs = mcs,
      stdlib = stdlib,
      resgen = resgen,
      declare_file = _declare_file,
      new_library = _new_library,
      new_resource = _new_resource,
      workspace_name = ctx.workspace_name,
      libVersion = context_data._libVersion,
      lib = context_data._lib,
      _ctx = ctx
  )

def _dotnet_context_data(ctx):
  return struct(
      _mcs_bin = ctx.attr._mcs_bin,
      _mono_bin = ctx.attr._mono_bin,
      _lib = ctx.attr._lib,
      _libVersion = ctx.attr._libVersion,
  )

dotnet_context_data = rule(
    _dotnet_context_data,
    attrs = {
        "_mcs_bin": attr.label(
            allow_files = True,
            default="@dotnet_sdk//:mcs_bin",
        ),
        "_mono_bin": attr.label(
            allow_files = True,
            default="@dotnet_sdk//:mono_bin",
        ),
        "_lib": attr.label(
            allow_files = True,
            default="@dotnet_sdk//:lib",
        ),
        "_libVersion": attr.string(
            default="4.5",
        ),
    },
)
  
