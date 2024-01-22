"""
Rules for compiling F# binaries.
"""

load("@bazel_skylib//lib:shell.bzl", "shell")
load("//dotnet/private:common.bzl", "generate_depsjson", "generate_runtimeconfig", "to_rlocation_path")
load("//dotnet/private:providers.bzl", "DotnetAssemblyCompileInfo", "DotnetAssemblyRuntimeInfo", "DotnetBinaryInfo", "DotnetPublishBinaryInfo")
load("//dotnet/private/transitions:tfm_transition.bzl", "tfm_transition")

def _publish_binary_impl(ctx):
    runtime_pack_infos = []
    if ctx.attr.self_contained == True:
        if len(ctx.attr.runtime_packs) == 0:
            fail("Can not publish self-contained binaries without a runtime pack")

        for runtime_pack in ctx.attr.runtime_packs:
            runtime_pack_infos.append(runtime_pack[DotnetAssemblyRuntimeInfo])
    elif len(ctx.attr.runtime_packs) > 0:
        fail("Can not do a framework dependent publish with a runtime pack")

    repo_mapping_file = ctx.attr.binary[0][DefaultInfo].files_to_run.repo_mapping_manifest if ctx.attr.binary[0][DefaultInfo].files_to_run else None

    return [
        ctx.attr.binary[0][DotnetAssemblyCompileInfo],
        ctx.attr.binary[0][DotnetAssemblyRuntimeInfo],
        ctx.attr.binary[0][DotnetBinaryInfo],
        DotnetPublishBinaryInfo(
            runtime_packs = runtime_pack_infos,
            target_framework = ctx.attr.target_framework,
            self_contained = ctx.attr.self_contained,
            repo_mapping_manifest = repo_mapping_file,
        ),
    ]

publish_binary = rule(
    _publish_binary_impl,
    doc = """Publish a .Net binary""",
    attrs = {
        "binary": attr.label(
            doc = "The .Net binary that is being published",
            providers = [DotnetBinaryInfo],
            cfg = tfm_transition,
            mandatory = True,
        ),
        "target_framework": attr.string(
            doc = "The target framework that should be published",
            mandatory = True,
        ),
        "self_contained": attr.bool(
            doc = """
            Whether the binary should be self-contained.
            
            If true, the binary will be published as a self-contained but you need to provide
            a runtime pack in the `runtime_packs` attribute. At some point the rules might
            resolve the runtime pack automatically.

            If false, the binary will be published as a non-self-contained. That means that to be
            able to run the binary you need to have a .Net runtime installed on the host system.
            """,
            default = False,
        ),
        "runtime_packs": attr.label_list(
            doc = """
            The runtime packs that should be used to publish the binary.
            Should only be declared if `self_contained` is true.

            A runtime pack is a NuGet package that contains the runtime that should be
            used to run the binary. There can be multiple runtime packs for a given
            publish e.g. when a AspNetCore application is published you need the base
            runtime pack and the AspNetCore runtime pack.

            Example runtime pack: https://www.nuget.org/packages/Microsoft.NETCore.App.Runtime.linux-x64/6.0.8
            """,
            providers = [DotnetAssemblyRuntimeInfo],
            default = [],
            cfg = tfm_transition,
        ),
        # TODO:
        # "ready_2_run": attr.bool(
        #     doc = """
        #     Wether or not to publish the binary as Ready2Run.
        #     See: https://docs.microsoft.com/en-us/dotnet/core/deploying/ready-to-run
        #     """,
        #     default = False,
        # ),
        # "single_file": attr.bool(
        #     doc = """
        #     Wether or not to publish the binary as a single file.
        #     See: https://docs.microsoft.com/en-us/dotnet/core/deploying/single-file/overview
        #     """,
        #     default = False,
        # ),
        "_allowlist_function_transition": attr.label(
            default = "@bazel_tools//tools/allowlists/function_transition_allowlist",
        ),
    },
    cfg = tfm_transition,
)

def _copy_file(script_body, src, dst, is_windows):
    if is_windows:
        script_body.append("if not exist \"{dir}\" @mkdir \"{dir}\" >NUL".format(dir = dst.dirname.replace("/", "\\")))
        script_body.append("@copy /Y \"{src}\" \"{dst}\" >NUL".format(src = src.path.replace("/", "\\"), dst = dst.path.replace("/", "\\")))
    else:
        script_body.append("mkdir -p {dir} && cp -f {src} {dst}".format(dir = shell.quote(dst.dirname), src = shell.quote(src.path), dst = shell.quote(dst.path)))

def _get_assembly_files(assembly_info, transitive_runtime_deps):
    libs = [] + assembly_info.libs
    native = [] + assembly_info.native
    data = [] + assembly_info.data
    for dep in transitive_runtime_deps:
        libs += dep.libs
        native += dep.native
        data += dep.data
    return (libs, native, data)

def _copy_to_publish(ctx, runtime_identifier, publish_binary_info, binary_info, assembly_info, transitive_runtime_deps, repo_mapping_manifest):
    is_windows = ctx.target_platform_has_constraint(ctx.attr._windows_constraint[platform_common.ConstraintValueInfo])
    inputs = [binary_info.app_host]
    app_host_copy = ctx.actions.declare_file(
        "{}/publish/{}/{}".format(ctx.label.name, runtime_identifier, binary_info.app_host.basename),
    )
    outputs = [app_host_copy]
    script_body = ["@echo off"] if is_windows else ["#! /usr/bin/env bash", "set -eou pipefail"]

    _copy_file(script_body, binary_info.app_host, app_host_copy, is_windows = is_windows)

    (libs, native, data) = _get_assembly_files(assembly_info, transitive_runtime_deps)

    # All managed DLLs are copied next to the app host in the publish directory
    for file in libs:
        output = ctx.actions.declare_file(
            "{}/publish/{}/{}".format(ctx.label.name, runtime_identifier, file.basename),
        )
        outputs.append(output)
        inputs.append(file)
        _copy_file(script_body, file, output, is_windows = is_windows)

    # When publishing a self-contained binary, we need to copy the native DLLs to the
    # publish directory as well.
    for file in native:
        inputs.append(file)
        output = ctx.actions.declare_file(
            "{}/publish/{}/{}".format(ctx.label.name, runtime_identifier, file.basename),
        )
        outputs.append(output)
        _copy_file(script_body, file, output, is_windows = is_windows)

    # The data files put into the publish folder in a structure that works with
    # the runfiles lib. End users should not expect files in the `data` attribute
    # to be resolvable by relative paths. They need to use the runfiles lib.
    #
    # Since we want the published binary and all it's files to be easily extracted
    # into e.g. a tar/zip/docker we manually create the runfiles structure because
    # there are many sharp edges with extracting runfiles from Bazel. By manually
    # creating the runfiles structure the runfiles are just normal files in the
    # DefaultInfo provider and can thus be easily forwarded to filegroups/tars/containers.
    #
    # The runfiles library follows the spec and tries to find a `<DLL>.runfiles` directory
    # next to the the DLL based on argv0 of the running process if
    # RUNFILES_DIR/RUNFILES_MANIFEST_FILE/RUNFILES_MANIFEST_ONLY is not set).
    for file in data:
        inputs.append(file)
        manifest_path = to_rlocation_path(ctx, file)
        output = ctx.actions.declare_file(
            "{}/publish/{}/{}.runfiles/{}".format(ctx.label.name, runtime_identifier, binary_info.app_host.basename, manifest_path),
        )
        outputs.append(output)
        _copy_file(script_body, file, output, is_windows = is_windows)

    # The repo mapping manifest is not part of the runfiles by default so we
    # copy it to the runfiles directory manually.
    if repo_mapping_manifest:
        inputs.append(repo_mapping_manifest)
        output = ctx.actions.declare_file(
            "{}/publish/{}/{}.runfiles/_repo_mapping".format(ctx.label.name, runtime_identifier, binary_info.app_host.basename),
        )
        outputs.append(output)
        _copy_file(script_body, repo_mapping_manifest, output, is_windows = is_windows)

    # In case the publish is self-contained there needs to be a runtime pack available
    # with the runtime dependencies that are required for the targeted runtime.
    # The runtime pack contents should always be copied to the root of the publish folder
    if len(publish_binary_info.runtime_packs) > 0:
        for runtime_pack in publish_binary_info.runtime_packs:
            runtime_pack_files = depset(
                runtime_pack.libs +
                runtime_pack.native +
                runtime_pack.data,
            )
            for file in runtime_pack_files.to_list():
                output = ctx.actions.declare_file(file.basename, sibling = app_host_copy)
                outputs.append(output)
                inputs.append(file)
                _copy_file(script_body, file, output, is_windows = is_windows)

    copy_script = ctx.actions.declare_file(ctx.label.name + ".copy.bat" if is_windows else ctx.label.name + ".copy.sh")
    ctx.actions.write(
        output = copy_script,
        content = "\r\n".join(script_body) if is_windows else "\n".join(script_body),
        is_executable = True,
    )

    ctx.actions.run(
        outputs = outputs,
        inputs = inputs,
        executable = copy_script,
        tools = [copy_script],
    )

    return (app_host_copy, outputs)

def _generate_runtimeconfig(ctx, output, target_framework, project_sdk, is_self_contained, toolchain):
    runtimeconfig_struct = generate_runtimeconfig(target_framework, project_sdk, is_self_contained, toolchain)

    ctx.actions.write(
        output = output,
        content = json.encode_indent(runtimeconfig_struct),
    )

def _generate_depsjson(
        ctx,
        output,
        target_framework,
        is_self_contained,
        assembly_info,
        transitive_runtime_deps,
        runtime_identifier,
        runtime_pack_infos):
    depsjson_struct = generate_depsjson(ctx, target_framework, is_self_contained, assembly_info, transitive_runtime_deps, runtime_identifier, runtime_pack_infos)

    ctx.actions.write(
        output = output,
        content = json.encode_indent(depsjson_struct),
    )

def _publish_binary_wrapper_impl(ctx):
    assembly_compile_info = ctx.attr.wrapped_target[0][DotnetAssemblyCompileInfo]
    assembly_runtime_info = ctx.attr.wrapped_target[0][DotnetAssemblyRuntimeInfo]
    binary_info = ctx.attr.wrapped_target[0][DotnetBinaryInfo]
    publish_binary_info = ctx.attr.wrapped_target[0][DotnetPublishBinaryInfo]
    repo_mapping_manifest = ctx.attr.wrapped_target[0][DotnetPublishBinaryInfo].repo_mapping_manifest
    transitive_runtime_deps = binary_info.transitive_runtime_deps
    runtime_identifier = ctx.attr.runtime_identifier
    target_framework = publish_binary_info.target_framework
    is_self_contained = publish_binary_info.self_contained
    assembly_name = assembly_runtime_info.name

    (executable, runfiles) = _copy_to_publish(
        ctx,
        runtime_identifier,
        publish_binary_info,
        binary_info,
        assembly_runtime_info,
        transitive_runtime_deps,
        repo_mapping_manifest,
    )

    runtimeconfig = ctx.actions.declare_file("{}/publish/{}/{}.runtimeconfig.json".format(
        ctx.label.name,
        runtime_identifier,
        assembly_name,
    ))
    _generate_runtimeconfig(
        ctx,
        runtimeconfig,
        target_framework,
        assembly_compile_info.project_sdk,
        is_self_contained,
        ctx.toolchains["//dotnet:toolchain_type"],
    )

    depsjson = ctx.actions.declare_file("{}/publish/{}/{}.deps.json".format(ctx.label.name, runtime_identifier, assembly_name))
    _generate_depsjson(
        ctx,
        depsjson,
        target_framework,
        is_self_contained,
        assembly_runtime_info,
        transitive_runtime_deps,
        runtime_identifier,
        publish_binary_info.runtime_packs,
    )

    return [
        ctx.attr.wrapped_target[0][DotnetPublishBinaryInfo],
        DefaultInfo(
            executable = executable,
            files = depset([executable, runtimeconfig, depsjson] + runfiles),
            runfiles = ctx.runfiles(files = [executable, runtimeconfig, depsjson] + runfiles),
        ),
    ]

# This wrapper is only needed so that we can turn the incoming transition in `publish_binary`
# into an outgoing transition in the wrapper. This allows us to select on the runtime_identifier
# and runtime_packs attributes. We also need to have all the file copying in the wrapper rule
# because Bazel does not allow forwarding executable files as they have to be created by the wrapper rule.
publish_binary_wrapper = rule(
    _publish_binary_wrapper_impl,
    doc = """Publish a .Net binary""",
    attrs = {
        "wrapped_target": attr.label(
            doc = "The wrapped publish_binary target",
            cfg = tfm_transition,
            mandatory = True,
        ),
        "target_framework": attr.string(
            doc = "The target framework that should be published",
            mandatory = True,
        ),
        "runtime_identifier": attr.string(
            doc = "The runtime identifier that is being targeted. " +
                  "See https://docs.microsoft.com/en-us/dotnet/core/rid-catalog",
            mandatory = True,
        ),
        "_allowlist_function_transition": attr.label(
            default = "@bazel_tools//tools/allowlists/function_transition_allowlist",
        ),
        "_windows_constraint": attr.label(default = "@platforms//os:windows"),
    },
    toolchains = [
        "//dotnet:toolchain_type",
    ],
    executable = True,
)
