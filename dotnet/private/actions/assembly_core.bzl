load(
    "@io_bazel_rules_dotnet//dotnet/private:common.bzl",
    "as_iterable",
    "sets"
)

load(
    "@io_bazel_rules_dotnet//dotnet/private:providers.bzl",
    "DotnetLibrary",
    "DotnetResource",
)


def _map_dep(deps):
  return [d[DotnetLibrary].result for d in deps]

def _map_resource(resources):
  return [d[DotnetResource].result.path + "," + d[DotnetResource].identifier for d in resources]

def _make_runner_arglist(dotnet, deps, resources, output, pdb, executable, defines, unsafe):
  args = dotnet.actions.args()

  # /out:<file>
  args.add(output.path, format="/out:%s")

  if executable:
    target = "exe"
  else:
    target = "library"

  # /target (exe for binary, library for lib, module for module)
  args.add(target, format="/target:%s")

  args.add("/fullpaths")
  args.add("/nostdlib")
  args.add("/langversion:latest")
  args.add("/nologo")

  if pdb:
    args.add("-debug:full")
    args.add("-pdb:" + pdb.path)

  # /warn
  #args.add(format="/warn:%s", value=str(ctx.attr.warn))

  # /modulename:<string> only used for modules
  #libdirs = _get_libdirs(depinfo.dlls)
  #libdirs = _get_libdirs(depinfo.transitive_dlls, libdirs)

  # /lib:dir1,[dir1]
  #if libdirs:
  #  args.add(format="/lib:%s", value=libdirs)

  if deps and len(deps)>0:
    args.add(deps, format="/reference:%s", map_fn=_map_dep)

  args.add(dotnet.stdlib, format="/reference:%s")

  if defines and len(defines)>0:
    args.add(defines, format="/define:%s")

  if unsafe:
    args.add("/unsafe")

  # /debug
  #debug = ctx.var.get("BINMODE", "") == "-dbg"
  #if debug:
  #  args.add("/debug")

  # /warnaserror
  # TODO(jeremy): /define:name[;name2]

  if resources and len(resources)>0:
    args.add(resources, format="/resource:%s", map_fn=_map_resource)

  # TODO(jeremy): /resource:filename[,identifier[,accesibility-modifier]]

  # /main:class
  #if hasattr(ctx.attr, "main_class") and ctx.attr.main_class:
  #  args.add(format="/main:%s", value=ctx.attr.main_class)

  #args.add(format="/resource:%s", value=ctx.files.resources)

  # TODO(jwall): /parallel

  return args

def emit_assembly_core(dotnet,
    name = "",
    srcs = None,
    deps = None,
    out = None,
    resources = None,
    executable = True,
    defines = None,
    unsafe = False,
    data = None):
  """See dotnet/toolchains.rst#binary for full documentation."""

  if name == "" and out == None:
    fail("either name or out must be set")

  if not out:
    if executable:
      extension = ".exe"
    else:
      extension = ".dll"
    result = dotnet.declare_file(dotnet, path=name+extension)
  else:
    result = dotnet.declare_file(dotnet, path=out)  
    extension = ""
    
  if dotnet.debug:
    pdb = dotnet.declare_file(dotnet, path=name+".pdb")
  else:
    pdb = None

  deps_libraries = [d[DotnetLibrary] for d in deps]  
  transitive = depset(direct = deps, transitive = [d[DotnetLibrary].transitive for d in deps])

  runner_args = _make_runner_arglist(dotnet, transitive.to_list(), resources, result, pdb, executable, defines, unsafe)

  attr_srcs = [f for t in srcs for f in as_iterable(t.files)]
  runner_args.add(attr_srcs)

  runner_args.set_param_file_format("multiline")

  paramfilepath = name+extension+".param"
  paramfile = dotnet.declare_file(dotnet, path=paramfilepath)

  dotnet.actions.write(output = paramfile, content = runner_args)

  deps_files = _map_dep(deps)
  dotnet.actions.run(
      inputs = attr_srcs + [paramfile] + deps_files + [dotnet.stdlib] + [r[DotnetResource].result for r in resources],
      outputs = [result] + ([pdb] if pdb else []),
      executable = dotnet.runner,
      arguments = [dotnet.mcs.path, "@"+paramfile.path],
      mnemonic = "CoreCompile",
      progress_message = (
          "Compiling " + dotnet.label.package + ":" + dotnet.label.name))

  extra = depset(direct = [result] + [dotnet.stdlib] + ([pdb] if pdb else []), transitive = [t.files for t in data] if data else [])
  direct = extra.to_list()   
  runfiles = depset(direct = direct, transitive = [a[DotnetLibrary].runfiles for a in deps])

  return dotnet.new_library(
    dotnet = dotnet, 
    name = name, 
    deps = deps, 
    transitive = transitive,
    result = result,
    pdb = pdb,
    runfiles=runfiles)

