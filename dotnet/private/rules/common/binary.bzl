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
load("@bazel_skylib//lib:dicts.bzl", "dicts")
load("@bazel_skylib//rules:common_settings.bzl", "BuildSettingInfo")
load("@aspect_bazel_lib//lib:paths.bzl", "BASH_RLOCATION_FUNCTION", "to_output_relative_path")
load("@aspect_bazel_lib//lib:expand_make_vars.bzl", "expand_locations", "expand_variables")
load("//dotnet/private/rules/common:helpers.bzl", "envs_for_log_level")
load("@aspect_bazel_lib//lib:windows_utils.bzl", "create_windows_native_launcher_script")

_ENV_SET = """export {var}=\"{value}\""""
_ENV_SET_IFF_NOT_SET = """if [[ -z "${{{var}:-}}" ]]; then export {var}=\"{value}\"; fi"""

def _target_tool_short_path(path):
    return ("../" + path[len("external/"):]) if path.startswith("external/") else path

# TODO: Just move this to the publish_binary rule since we use `dotnet` to run
def _create_shim_exe(ctx, dll):
    windows_constraint = ctx.attr._windows_constraint[platform_common.ConstraintValueInfo]

    apphost = ctx.toolchains["@rules_dotnet//dotnet:toolchain_type"].apphost
    output = ctx.actions.declare_file(paths.replace_extension(dll.basename, ".exe" if ctx.target_platform_has_constraint(windows_constraint) else ""), sibling = dll)

    ctx.actions.run(
        executable = ctx.attr.apphost_shimmer.files_to_run,
        arguments = [to_output_relative_path(apphost), to_output_relative_path(dll), output.short_path],
        inputs = depset([apphost, dll], transitive = [ctx.attr.apphost_shimmer.default_runfiles.files]),
        tools = [ctx.attr.apphost_shimmer.files, ctx.attr.apphost_shimmer.default_runfiles.files],
        outputs = [output],
        env = dicts.add({
            # Set so that compilations work on remote execution workers that don't have ICU installed
            # ICU should not be required during compliation but only at runtime
            "DOTNET_SYSTEM_GLOBALIZATION_INVARIANT": "1",
            "BAZEL_BINDIR": ctx.bin_dir.path,
        }, {k: "1" for k in envs_for_log_level(ctx.attr.log_level)}),
    )

    return output

def _bash_launcher(ctx, entry_point_path, fixed_env, is_windows):
    envs = []
    for (key, value) in dicts.add(fixed_env, ctx.attr.env).items():
        envs.append(_ENV_SET.format(
            var = key,
            value = " ".join([expand_variables(ctx, exp, attribute_name = "env") for exp in expand_locations(ctx, value, ctx.attr.data).split(" ")]),
        ))

    # Automatically add common and useful make variables to the environment
    builtin_envs = {
        "DOTNET_BINARY__BINDIR": "$(BINDIR)",
        "DOTNET_BINARY__BUILD_FILE_PATH": "$(BUILD_FILE_PATH)",
        "DOTNET_BINARY__COMPILATION_MODE": "$(COMPILATION_MODE)",
        "DOTNET_BINARY__TARGET_CPU": "$(TARGET_CPU)",
        "DOTNET_BINARY__TARGET": "$(TARGET)",
        "DOTNET_BINARY__WORKSPACE": "$(WORKSPACE)",
    }

    for (key, value) in builtin_envs.items():
        envs.append(_ENV_SET.format(
            var = key,
            value = " ".join([expand_variables(ctx, exp, attribute_name = "env") for exp in expand_locations(ctx, value, ctx.attr.data).split(" ")]),
        ))

    if ctx.attr.expected_exit_code:
        envs.append(_ENV_SET.format(
            var = "JS_BINARY__EXPECTED_EXIT_CODE",
            value = str(ctx.attr.expected_exit_code),
        ))

    # Set log envs iff is has not already been set
    for env in envs_for_log_level(ctx.attr.log_level):
        envs.append(_ENV_SET_IFF_NOT_SET.format(var = env, value = "1"))

    if is_windows:
        dotnet_wrapper = ctx.actions.declare_file("%s_dotnet_wrapper/dotnet.bat" % ctx.label.name)
        ctx.actions.expand_template(
            template = ctx.file._dotnet_wrapper_bat,
            output = dotnet_wrapper,
            substitutions = {},
            is_executable = True,
        )
    else:
        dotnet_wrapper = ctx.actions.declare_file("%s_dotnet_wrapper/dotnet" % ctx.label.name)
        ctx.actions.expand_template(
            template = ctx.file._dotnet_wrapper_sh,
            output = dotnet_wrapper,
            substitutions = {},
            is_executable = True,
        )

    launcher_subst = {
        "{{entry_point_path}}": entry_point_path,
        "{{envs}}": "\n".join(envs),
        "{{log_prefix_rule_set}}": "rules_dotnet",
        "{{log_prefix_rule}}": "binary",
        "{{dotnet_wrapper}}": dotnet_wrapper.short_path,
        "{{dotnet}}": _target_tool_short_path(ctx.toolchains["@rules_dotnet//dotnet:toolchain_type"].dotnetinfo.runtime_path),
        "{{rlocation_function}}": BASH_RLOCATION_FUNCTION,
        "{{workspace_name}}": ctx.workspace_name,
    }

    launcher = ctx.actions.declare_file("%s.sh" % ctx.label.name)
    ctx.actions.expand_template(
        template = ctx.file._launcher_template,
        output = launcher,
        substitutions = launcher_subst,
        is_executable = True,
    )

    return launcher, dotnet_wrapper

def _create_launcher(ctx, entry_point, direct_runfiles, fixed_env = {}):
    is_windows = ctx.target_platform_has_constraint(ctx.attr._windows_constraint[platform_common.ConstraintValueInfo])

    if is_windows and not ctx.attr.enable_runfiles:
        fail("need --enable_runfiles on Windows for to support rules_dotnet")

    entry_point_path = entry_point.short_path
    bash_launcher, dotnet_wrapper = _bash_launcher(ctx, entry_point_path, fixed_env, is_windows)
    launcher = create_windows_native_launcher_script(ctx, bash_launcher) if is_windows else bash_launcher

    direct_runfiles.append(bash_launcher)
    direct_runfiles.append(dotnet_wrapper)
    direct_runfiles.append(entry_point)
    direct_runfiles.extend(ctx.files._runfiles_lib)
    direct_runfiles.extend(ctx.toolchains["@rules_dotnet//dotnet:toolchain_type"].dotnetinfo.runtime_files)

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

        # Add additional lookup paths so that we can avoid copying all DLLs
        # into the output directory. The deps.json file will then contain
        # paths that are relative to the workspace root
        runtimeconfig_struct["runtimeOptions"]["additionalProbingPaths"] = ["./", "../", "../../../", "../../../external"]

        ctx.actions.write(
            output = runtimeconfig,
            content = json.encode_indent(runtimeconfig_struct),
        )

        # We create a special deps.json for the binary rules because we use the manifest loader
        # to look up DLLS. This is to avoid the need to copy the DLLs into same folder as the
        # binary.
        depsjson = ctx.actions.declare_file("bazelout/%s/%s.deps.json" % (tfm, ctx.attr.name))
        depsjson_struct = generate_depsjson(
            ctx,
            target_framework = tfm,
            is_self_contained = False,
            runtime_deps = result.runtime_deps,
            transitive_runtime_deps = result.transitive_runtime_deps,
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

    app_host = None
    if ctx.attr.apphost_shimmer:
        app_host = _create_shim_exe(ctx, dll)
        direct_runfiles.append(app_host)
        default_info_files = default_info_files.append(app_host)

    launcher = _create_launcher(ctx, dll, direct_runfiles)

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
