"""
Rules for compiling F# binaries.
"""

load("@aspect_bazel_lib//lib:copy_file.bzl", "copy_file_action")
load("//dotnet/private:providers.bzl", "DotnetAssemblyInfo", "DotnetBinaryInfo", "DotnetPublishBinaryInfo")
load("//dotnet/private:transitions/tfm_transition.bzl", "tfm_transition")
load("//dotnet/private:rids.bzl", "RUNTIME_GRAPH")

def _publish_binary_impl(ctx):
    publishing_pack = None
    if ctx.attr.self_contained == True:
        if ctx.attr.publishing_pack == None or len(ctx.attr.publishing_pack) == 0:
            fail("Can not publish self-contained binaries without a publishing pack")
        publishing_pack = depset(
            ctx.attr.publishing_pack[0][DotnetAssemblyInfo].lib +
            ctx.attr.publishing_pack[0][DotnetAssemblyInfo].native +
            ctx.attr.publishing_pack[0][DotnetAssemblyInfo].data,
            transitive = [ctx.attr.publishing_pack[0][DotnetAssemblyInfo].transitive_lib, ctx.attr.publishing_pack[0][DotnetAssemblyInfo].transitive_native, ctx.attr.publishing_pack[0][DotnetAssemblyInfo].transitive_data],
        )

    return [
        ctx.attr.binary[0][DotnetAssemblyInfo],
        ctx.attr.binary[0][DotnetBinaryInfo],
        DotnetPublishBinaryInfo(
            publishing_pack = publishing_pack,
            target_framework = ctx.attr.target_framework,
            self_contained = ctx.attr.self_contained,
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
            a publishing pack in the `publishing_pack` attribute. At some point the rules might
            resolve the publishing pack automatically.

            If false, the binary will be published as a non-self-contained. That means that to be
            able to run the binary you need to have a .Net runtime installed on the host system.
            """,
            default = False,
        ),
        "publishing_pack": attr.label(
            doc = """
            The publishing pack that should be used to publish the binary.
            Should only be declared if `self_contained` is true.

            The publishing pack is a NuGet package that contains the runtime that should be
            used to run the binary.

            Example publishing pack: https://www.nuget.org/packages/Microsoft.NETCore.App.Runtime.linux-x64/6.0.8
            """,
            providers = [DotnetAssemblyInfo],
            default = None,
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

def _to_manifest_path(ctx, file):
    if file.short_path.startswith("../"):
        return file.short_path[3:]
    else:
        return ctx.workspace_name + "/" + file.short_path

def _copy_to_publish(ctx, runtime_identifier, publish_binary_info, binary_info, assembly_info):
    is_windows = ctx.target_platform_has_constraint(ctx.attr._windows_constraint[platform_common.ConstraintValueInfo])
    inputs = [binary_info.app_host]
    app_host_copy = ctx.actions.declare_file(
        "{}/publish/{}/{}".format(ctx.label.name, runtime_identifier, binary_info.app_host.basename),
    )
    outputs = [app_host_copy]

    copy_file_action(ctx, binary_info.app_host, app_host_copy, is_windows = is_windows)

    # All managed DLLs are copied next to the app host in the publish directory
    for file in assembly_info.lib + assembly_info.transitive_lib.to_list():
        output = ctx.actions.declare_file(
            "{}/publish/{}/{}".format(ctx.label.name, runtime_identifier, file.basename),
        )
        outputs.append(output)
        inputs.append(file)
        copy_file_action(ctx, file, output, is_windows = is_windows)

    # When publishing a self-contained binary, we need to copy the native DLLs to the
    # publish directory as well. If the binary is not self-contained, we need to copy
    # the native files to a subfolder with the pattern `runtimes/<RID>/native/<file>`
    # or `runtimes/<RID>/<TFM>/<file>`.
    for file in assembly_info.native + assembly_info.transitive_native.to_list():
        # TODO: Do correct folder structure for non-self-contained publishing
        inputs.append(file)
        output = ctx.actions.declare_file(
            "{}/publish/{}/{}".format(ctx.label.name, runtime_identifier, file.basename),
        )
        outputs.append(output)
        copy_file_action(ctx, file, output, is_windows = is_windows)

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
    for file in assembly_info.data + assembly_info.transitive_data.to_list():
        inputs.append(file)
        manifest_path = _to_manifest_path(ctx, file)
        output = ctx.actions.declare_file(
            "{}/publish/{}/{}.runfiles/{}".format(ctx.label.name, runtime_identifier, binary_info.app_host.basename, manifest_path),
        )
        outputs.append(output)
        copy_file_action(ctx, file, output, is_windows = is_windows)

    # In case the publish is self-contained there needs to be a publishing pack available
    # with the runtime dependencies that are required for the targeted runtime.
    # The publishing pack contents should always be copied to the root of the publish folder
    if publish_binary_info.publishing_pack:
        for file in publish_binary_info.publishing_pack.to_list():
            output = ctx.actions.declare_file(file.basename, sibling = app_host_copy)
            outputs.append(output)
            inputs.append(file)
            copy_file_action(ctx, file, output, is_windows = is_windows)

    return (app_host_copy, outputs)

# TODO: Reuse this when we create the runtimeconfig.json in the csharp_binary/fsharp_binary rules
# For runtimeconfig.json spec see https://github.com/dotnet/sdk/blob/main/documentation/specs/runtime-configuration-file.md
def _generate_runtimeconfig(ctx, output, target_framework, is_self_contained, toolchain):
    runtime_version = toolchain.dotnetinfo.runtime_version
    base = {
        "runtimeOptions": {
            "tfm": target_framework,
        },
    }

    if is_self_contained:
        base["runtimeOptions"]["includedFrameworks"] = [{
            "name": "Microsoft.NETCore.App",
            "version": runtime_version,
        }]
    else:
        base["runtimeOptions"]["framework"] = {
            "name": "Microsoft.NETCore.App",
            "version": runtime_version,
        }

    ctx.actions.write(
        output = output,
        content = json.encode_indent(base),
    )

# TODO: Reuse this when we create the deps.json in the csharp_binary/fsharp_binary rules
# For deps.json spec see: https://github.com/dotnet/sdk/blob/main/documentation/specs/runtime-configuration-file.md
def _generate_depsjson(
        ctx,
        output,
        target_framework,
        is_self_contained,
        runtime_identifier = None,
        runtime_pack = None):
    runtime_target = ".NETCoreApp,Version=v{}".format(
        target_framework.replace("net", "") if not runtime_identifier else "{}/{}".format(
            target_framework.replace("net", ""),
            runtime_identifier,
        ),
    )
    base = {
        "runtimeTarget": {
            "name": runtime_target,
            "signature": "",
        },
        "compilationOptions": {},
        "targets": {
            ".NETCoreApp,Version=v{}".format(target_framework.replace("net", "")): {},
        },
    }
    base["targets"][runtime_target] = {}

    if runtime_identifier:
        if runtime_pack:
            # buildifier: disable=print
            print("TODO!")

        if is_self_contained:
            base["runtimes"] = {rid: RUNTIME_GRAPH[rid] for rid, supported_rids in RUNTIME_GRAPH.items() if runtime_identifier in supported_rids or runtime_identifier == rid}
    else:
        base["targets"][".NETCoreApp,Version=v{}".format(target_framework.replace("net", ""))] = {}

    ctx.actions.write(
        output = output,
        content = json.encode_indent(base),
    )

def _publish_binary_wrapper_impl(ctx):
    assembly_info = ctx.attr.wrapped_target[0][DotnetAssemblyInfo]
    binary_info = ctx.attr.wrapped_target[0][DotnetBinaryInfo]
    publish_binary_info = ctx.attr.wrapped_target[0][DotnetPublishBinaryInfo]
    runtime_identifier = ctx.attr.runtime_identifier
    target_framework = publish_binary_info.target_framework
    is_self_contained = publish_binary_info.self_contained
    dll_name = binary_info.dll.basename.replace(".dll", "")

    (executable, runfiles) = _copy_to_publish(
        ctx,
        runtime_identifier,
        publish_binary_info,
        binary_info,
        assembly_info,
    )

    runtimeconfig = ctx.actions.declare_file("{}/publish/{}/{}.runtimeconfig.json".format(
        ctx.label.name,
        runtime_identifier,
        dll_name,
    ))
    _generate_runtimeconfig(
        ctx,
        runtimeconfig,
        target_framework,
        is_self_contained,
        ctx.toolchains["@rules_dotnet//dotnet:toolchain_type"],
    )

    # The deps.json file is not really needed for self contained publishing
    # A warning will be printed if it's not present but that warning is being removed in .Net 7
    # https://github.com/dotnet/runtime/issues/64606
    # We can add proper support for generating fully fledged deps.json and runtimeconfig.json files later
    depsjson = []
    if not is_self_contained:
        depsjson_file = ctx.actions.declare_file("{}/publish/{}/{}.deps.json".format(ctx.label.name, runtime_identifier, dll_name))
        _generate_depsjson(
            ctx,
            depsjson_file,
            target_framework,
            is_self_contained,
            runtime_identifier,
        )
        depsjson.append(depsjson_file)

    return [
        ctx.attr.wrapped_target[0][DotnetPublishBinaryInfo],
        DefaultInfo(
            executable = executable,
            files = depset([executable, runtimeconfig] + runfiles + depsjson),
            runfiles = ctx.runfiles([executable, runtimeconfig] + runfiles + depsjson),
        ),
    ]

# This wrapper is only needed so that we can turn the incoming transition in `publish_binary`
# into an outgoing transition in the wrapper. This allows us to select on the runtime_identifier
# and publishing_pack attributes. We also need to have all the file copying in the wrapper rule
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
        "_runtimeconfig_self_contained_template": attr.label(
            doc = "A template file to use for generating runtimeconfig.json without the manifest loader",
            default = ":runtimeconfig_self_contained.json.tpl",
            allow_single_file = True,
        ),
        "_runtimeconfig_not_self_contained_template": attr.label(
            doc = "A template file to use for generating runtimeconfig.json without the manifest loader",
            default = ":runtimeconfig_not_self_contained.json.tpl",
            allow_single_file = True,
        ),
        "_allowlist_function_transition": attr.label(
            default = "@bazel_tools//tools/allowlists/function_transition_allowlist",
        ),
        "_windows_constraint": attr.label(default = "@platforms//os:windows"),
    },
    toolchains = [
        "@rules_dotnet//dotnet:toolchain_type",
    ],
    executable = True,
)
