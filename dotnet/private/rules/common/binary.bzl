"""
Base rule for building .Net binaries
"""

load("//dotnet/private:providers.bzl", "DotnetBinaryInfo")
load(
    "//dotnet/private:common.bzl",
    "generate_depsjson",
    "generate_runtimeconfig",
    "is_core_framework",
    "is_standard_framework",
)
load("@bazel_skylib//lib:paths.bzl", "paths")
load("@bazel_skylib//rules:common_settings.bzl", "BuildSettingInfo")
load("@aspect_bazel_lib//lib:paths.bzl", "to_manifest_path")

def _create_shim_exe(ctx, dll):
    windows_constraint = ctx.attr._windows_constraint[platform_common.ConstraintValueInfo]

    apphost = ctx.toolchains["@rules_dotnet//dotnet:toolchain_type"].apphost
    output = ctx.actions.declare_file(paths.replace_extension(dll.basename, ".exe" if ctx.target_platform_has_constraint(windows_constraint) else ""), sibling = dll)

    ctx.actions.run(
        executable = ctx.attr.apphost_shimmer.files_to_run,
        arguments = [apphost.path, dll.path, output.path],
        inputs = depset([apphost, dll], transitive = [ctx.attr.apphost_shimmer.default_runfiles.files]),
        tools = [ctx.attr.apphost_shimmer.files, ctx.attr.apphost_shimmer.default_runfiles.files],
        outputs = [output],
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
                "TEMPLATED_dotnet": to_manifest_path(ctx, runtime.files_to_run.executable),
                "TEMPLATED_executable": to_manifest_path(ctx, executable),
            },
            is_executable = True,
        )
    else:
        ctx.actions.expand_template(
            template = ctx.file._launcher_sh,
            output = launcher,
            substitutions = {
                "TEMPLATED_dotnet": to_manifest_path(ctx, runtime.files_to_run.executable),
                "TEMPLATED_executable": to_manifest_path(ctx, executable),
            },
            is_executable = True,
        )
        runfiles.append(ctx.file._bash_runfiles)

    runfiles.extend(ctx.toolchains["@rules_dotnet//dotnet:toolchain_type"].dotnetinfo.runtime_files)

    return launcher

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

    app_host = None
    if ctx.attr.apphost_shimmer:
        app_host = _create_shim_exe(ctx, dll)
        direct_runfiles.append(app_host)
        default_info_files = default_info_files.append(app_host)

    launcher = _create_launcher(ctx, direct_runfiles, dll)

    runtimeconfig = None
    depsjson = None
    if is_core_framework(tfm):
        # Create the runtimeconfig.json for the binary
        runtimeconfig = ctx.actions.declare_file("bazelout/%s/%s.runtimeconfig.json" % (tfm, ctx.attr.out or ctx.attr.name))
        runtimeconfig_struct = generate_runtimeconfig(
            target_framework = tfm,
            project_sdk = ctx.attr.project_sdk,
            is_self_contained = False,
            toolchain = ctx.toolchains["@rules_dotnet//dotnet:toolchain_type"],
        )

        # Add additional lookup paths so that we can avoid copying all DLLs
        # into the output directory. The deps.json file will then contain
        # paths that are relative to the workspace root
        runtimeconfig_struct["runtimeOptions"]["additionalProbingPaths"] = [
            "./",
            "./external",
            "../",
            "../external",
            # This one is for when the binary target is used as an tool in e.g. a custom rule
            "{}.runfiles".format(launcher.path),
        ]
        ctx.actions.write(
            output = runtimeconfig,
            content = json.encode_indent(runtimeconfig_struct),
        )

        depsjson = ctx.actions.declare_file("bazelout/%s/%s.deps.json" % (tfm, ctx.attr.out or ctx.attr.name))
        depsjson_struct = generate_depsjson(
            ctx,
            target_framework = tfm,
            is_self_contained = False,
            assembly_info = result,
            runtime_identifier = ctx.attr.runtime_identifier,
            use_relative_paths = True,
        )

        ctx.actions.write(
            output = depsjson,
            content = json.encode_indent(depsjson_struct),
        )

    if runtimeconfig != None:
        direct_runfiles.append(runtimeconfig)

    if depsjson != None:
        direct_runfiles.append(depsjson)

    default_info = DefaultInfo(
        executable = launcher,
        runfiles = ctx.runfiles(
            files = direct_runfiles,
            transitive_files = depset(transitive = [result.transitive_libs, result.transitive_native, result.transitive_data]),
        ),
        files = depset(default_info_files),
    )

    dotnet_binary_info = DotnetBinaryInfo(
        dll = dll,
        app_host = app_host,
    )

    return [default_info, dotnet_binary_info, result]
