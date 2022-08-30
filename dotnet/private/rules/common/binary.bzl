"""
Base rule for building .Net binaries
"""

load("//dotnet/private:providers.bzl", "DotnetAssemblyInfo", "DotnetBinaryInfo")
load(
    "//dotnet/private:common.bzl",
    "generate_depsjson",
    "generate_runtimeconfig",
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
    windows_constraint = ctx.attr._windows_constraint[platform_common.ConstraintValueInfo]

    runtime = ctx.toolchains["@rules_dotnet//dotnet:toolchain_type"].runtime
    apphost = ctx.toolchains["@rules_dotnet//dotnet:toolchain_type"].apphost
    output = ctx.actions.declare_file(paths.replace_extension(dll.basename, ".exe" if ctx.target_platform_has_constraint(windows_constraint) else ""), sibling = dll)

    ctx.actions.run(
        executable = runtime.files_to_run,
        arguments = [ctx.executable.apphost_shimmer.path, apphost.path, dll.path, output.path],
        inputs = [apphost, dll, ctx.attr.apphost_shimmer.files_to_run.runfiles_manifest],
        tools = [ctx.attr.apphost_shimmer.files, ctx.attr.apphost_shimmer.default_runfiles.files],
        outputs = [output],
        env = {
            "DOTNET_CLI_HOME": runtime.files_to_run.executable.dirname,
            # Set so that compilations work on remote execution workers that don't have ICU installed
            # ICU should not be required during compliation but only at runtime
            "DOTNET_SYSTEM_GLOBALIZATION_INVARIANT": "1",
        },
    )

    return output

def _create_launcher(ctx, runfiles, executable):
    runtime = ctx.toolchains["@rules_dotnet//dotnet:toolchain_type"].runtime
    windows_constraint = ctx.attr._windows_constraint[platform_common.ConstraintValueInfo]

    launcher = ctx.actions.declare_file("{}.{}".format(executable.basename, "bat" if ctx.target_platform_has_constraint(windows_constraint) else "sh"), sibling = executable)

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
            Returns:
                An DotnetAssemblyInfo provider
    Returns:
        A collection of the references, runfiles and native dlls.
    """
    tfm = ctx.attr._target_framework[BuildSettingInfo].value

    if is_standard_framework(tfm):
        fail("It doesn't make sense to build an executable for " + tfm)

    result = compile_action(ctx, tfm)
    dll = result.libs[0]
    default_info_files = [dll]
    direct_runfiles = [dll] + result.data

    runtimeconfig = None
    depsjson = None
    if is_core_framework(tfm):
        # Create the runtimeconfig.json for the binary
        runtimeconfig = ctx.actions.declare_file("bazelout/%s/%s.runtimeconfig.json" % (tfm, ctx.attr.name))
        runtimeconfig_struct = generate_runtimeconfig(
            target_framework = tfm,
            is_self_contained = False,
            toolchain = ctx.toolchains["@rules_dotnet//dotnet:toolchain_type"],
        )

        # Add the manifest loader as a startup hook
        runtimeconfig_struct["runtimeOptions"]["configProperties"] = {
            "STARTUP_HOOKS": "ManifestLoader",
        }

        ctx.actions.write(
            output = runtimeconfig,
            content = json.encode_indent(runtimeconfig_struct),
        )

        # We create a special deps.json for the binary rules because we use the manifest loader
        # to look up DLLS. This is to avoid the need to copy the DLLs into same folder as the
        # binary.
        depsjson = ctx.actions.declare_file("bazelout/%s/%s.deps.json" % (tfm, ctx.attr.name))
        depsjson_struct = generate_depsjson(
            target_framework = tfm,
            is_self_contained = False,
            runtime_deps = result.runtime_deps,
            transitive_runtime_deps = result.transitive_runtime_deps,
            runtime_identifier = ctx.attr.runtime_identifier,
        )

        # Add the manifest loader to the deps.json so that its loaded correctly
        depsjson_struct["targets"][depsjson_struct["targets"].keys()[0]] = {
            "ManifestLoader": {
                "runtime": {"ManifestLoader.dll": {"assemblyVersion": "1.0.0.0", "fileVersion": "1.0.0.0"}},
            },
        }
        depsjson_struct["libraries"] = {
            "ManifestLoader": {
                "type": "package",
                "serviceable": True,
                "sha512": "",
                "path": "",
            },
        }
        ctx.actions.write(
            output = depsjson,
            content = json.encode_indent(depsjson_struct),
        )

    if runtimeconfig != None:
        direct_runfiles.append(runtimeconfig)

    if depsjson != None:
        direct_runfiles.append(depsjson)

    manifest_loader = _symlink_manifest_loader(ctx, dll)
    direct_runfiles.append(manifest_loader)

    app_host = None
    launcher = None
    if ctx.attr.apphost_shimmer:
        app_host = _create_shim_exe(ctx, dll)
        direct_runfiles.append(app_host)
        default_info_files = default_info_files.append(app_host)
        launcher = _create_launcher(ctx, direct_runfiles, app_host)

    default_info = DefaultInfo(
        executable = launcher if launcher != None else dll,
        runfiles = ctx.runfiles(
            files = direct_runfiles,
            transitive_files = depset(transitive = [result.transitive_libs, result.transitive_native, result.transitive_data]),
        ).merge(ctx.toolchains["@rules_dotnet//dotnet:toolchain_type"].runtime[DefaultInfo].default_runfiles),
        files = depset(default_info_files),
    )

    dotnet_binary_info = DotnetBinaryInfo(
        dll = dll,
        app_host = app_host,
    )

    return [default_info, dotnet_binary_info, result]
