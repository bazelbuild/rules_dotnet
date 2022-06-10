"""
Base rule for building .Net binaries
"""

load("//dotnet/private:providers.bzl", "DotnetAssemblyInfo")
load(
    "//dotnet/private:actions/misc.bzl",
    "write_depsjson",
    "write_runtimeconfig",
)
load(
    "//dotnet/private:common.bzl",
    "is_core_framework",
    "is_standard_framework",
)
load("@bazel_skylib//lib:paths.bzl", "paths")
load("@bazel_skylib//rules:common_settings.bzl", "BuildSettingInfo")

def _to_manifest_path(ctx, file):
    if file.short_path.startswith("../"):
        return file.short_path[3:]
    else:
        return ctx.workspace_name + "/" + file.short_path

def _create_shim_exe(ctx, dll):
    runtime = ctx.toolchains["@rules_dotnet//dotnet:toolchain_type"].runtime
    apphost = ctx.toolchains["@rules_dotnet//dotnet:toolchain_type"].apphost
    output = ctx.actions.declare_file(paths.replace_extension(dll.basename, ".exe"), sibling = dll)

    ctx.actions.run(
        executable = runtime.files_to_run,
        arguments = [ctx.executable._apphost_shimmer.path, apphost.path, dll.path],
        inputs = [apphost, dll, ctx.attr._apphost_shimmer.files_to_run.runfiles_manifest],
        tools = [ctx.attr._apphost_shimmer.files, ctx.attr._apphost_shimmer.default_runfiles.files],
        outputs = [output],
    )

    return output

def _create_launcher(ctx, runfiles, executable):
    runtime = ctx.toolchains["@rules_dotnet//dotnet:toolchain_type"].runtime
    windows_constraint = ctx.attr._windows_constraint[platform_common.ConstraintValueInfo]

    launcher = ctx.actions.declare_file(paths.replace_extension(executable.basename, ".bat" if ctx.target_platform_has_constraint(windows_constraint) else ".sh"), sibling = executable)

    if ctx.target_platform_has_constraint(windows_constraint):
        ctx.actions.expand_template(
            template = ctx.file._launcher_bat,
            output = launcher,
            substitutions = {
                "TEMPLATED_dotnet": _to_manifest_path(ctx, runtime.files_to_run.executable),
                "TEMPLATED_executable": _to_manifest_path(ctx, executable),
            },
            is_executable = True,
        )
        runfiles.append(ctx.file._bash_runfiles)
    else:
        ctx.actions.expand_template(
            template = ctx.file._launcher_sh,
            output = launcher,
            substitutions = {
                "TEMPLATED_dotnet": _to_manifest_path(ctx, runtime.files_to_run.executable),
                "TEMPLATED_executable": _to_manifest_path(ctx, executable),
            },
            is_executable = True,
        )
        runfiles.append(ctx.file._bash_runfiles)

    return launcher

def _symlink_manifest_loader(ctx, executable):
    loader = ctx.actions.declare_file("ManifestLoader.dll", sibling = executable)
    ctx.actions.symlink(output = loader, target_file = ctx.attr._manifest_loader[DotnetAssemblyInfo].libs[0])
    return loader

def build_binary(ctx, compile_action):
    """Builds a .Net binary from a compilation action

    Args:
        ctx: Bazel build ctx.
        compile_action: A compilation function
            Args:
                ctx: Bazel build ctx.
                tfm: Target framework string
                sdk: .Net project SDK label
                runtimeconfig: .Net runtimeconfig file
                depsjson: .Net depsjson file
            Returns:
                An DotnetAssemblyInfo provider
    Returns:
        A collection of the references, runfiles and native dlls.
    """
    tfm = ctx.attr._target_framework[BuildSettingInfo].value
    
    if is_standard_framework(tfm):
            fail("It doesn't make sense to build an executable for " + tfm)

    runtimeconfig = None
    depsjson = None
    if is_core_framework(tfm):
        runtimeconfig = write_runtimeconfig(
            ctx.actions,
            template = ctx.file.runtimeconfig_template,
            name = ctx.attr.name,
            tfm = tfm,
            runtime_version = ctx.toolchains["@rules_dotnet//dotnet:toolchain_type"].dotnetinfo.runtime_version,
        )
        depsjson = write_depsjson(
            ctx.actions,
            template = ctx.file.depsjson_template,
            name = ctx.attr.name,
            tfm = tfm,
        )

    result = compile_action(ctx, tfm, runtimeconfig, depsjson)
    executable = result.libs[0]
    data = result.data
    prefs = result.prefs[0] if len(result.prefs) >0 else None
    runtimeconfig = result.runtimeconfig
    depsjson = result.depsjson

    direct_runfiles = [executable] + data

    if runtimeconfig != None:
        direct_runfiles.append(runtimeconfig)
    if depsjson != None:
        direct_runfiles.append(depsjson)

    manifest_loader = _symlink_manifest_loader(ctx, executable)
    direct_runfiles.append(manifest_loader)

    files = [executable, prefs] + data
    if ctx.attr.use_apphost_shim:
        executable = _create_shim_exe(ctx, executable)
        direct_runfiles.append(executable)
        files = files.append(executable)
        executable = _create_launcher(ctx, direct_runfiles, executable)

    # TODO: Should we have separate flags for a standalone deployment and not?
    default_info = DefaultInfo(
        executable = executable,
        runfiles = ctx.runfiles(
            files = direct_runfiles,
            transitive_files = result.transitive_runfiles,
        ).merge(ctx.toolchains["@rules_dotnet//dotnet:toolchain_type"].runtime[DefaultInfo].default_runfiles),
        files = depset(files),
    )

    return [default_info, result]
