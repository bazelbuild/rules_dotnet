"""
Rules for compiling F# binaries.
"""

load("//dotnet/private:providers.bzl", "DotnetAssemblyInfo", "DotnetBinaryInfo", "DotnetPublishBinaryInfo")
load("//dotnet/private:transitions/tfm_transition.bzl", "tfm_transition")
load("//dotnet/private:rids.bzl", "RUNTIME_GRAPH")

def _publish_binary_impl(ctx):
    binary = ctx.attr.binary[0][DotnetBinaryInfo]

    publishing_pack = None
    if ctx.attr.self_contained == True:
        if ctx.attr.publishing_pack == None or len(ctx.attr.publishing_pack) == 0:
            fail("Can not publish self-contained binaries without a publishing pack")
        publishing_pack = depset(
            ctx.attr.publishing_pack[0][DotnetAssemblyInfo].lib +
            ctx.attr.publishing_pack[0][DotnetAssemblyInfo].data,
            transitive = [ctx.attr.publishing_pack[0][DotnetAssemblyInfo].transitive_runfiles],
        )

    return [
        DotnetPublishBinaryInfo(
            binary_info = binary,
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

def _copy_to_publish(ctx, runtime_identifier, app_host, runfiles, publishing_pack):
    app_host_copy = ctx.actions.declare_file(
        "{}/publish/{}/{}".format(ctx.label.name, runtime_identifier, app_host.basename),
    )
    runfiles = runfiles.files.to_list()
    inputs = [app_host]

    runfiles_copy = []
    for file in runfiles:
        inputs.append(file)
        runfiles_copy.append(
            ctx.actions.declare_file(
                "{}/publish/{}/{}".format(ctx.label.name, runtime_identifier, file.basename),
            ),
        )

    if publishing_pack:
        for file in publishing_pack.to_list():
            runfiles_copy.append(ctx.actions.declare_file(file.basename, sibling = app_host_copy))
            inputs.append(file)

    args = ctx.actions.args()
    args.add_all(inputs)
    ctx.actions.run_shell(
        outputs = [app_host_copy] + runfiles_copy,
        inputs = inputs,
        arguments = [args],
        # TODO: Windows version of this script
        command = "set -euo pipefail && mkdir publish && for f in $@; do cp $f {}/$(basename $f); done".format(
            app_host_copy.dirname,
        ),
    )

    return (app_host_copy, runfiles_copy)

# TODO: Reuse this when we create the runtimeconfig.json in the csharp_binary/fsharp_binary rules
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
    binary = ctx.attr.wrapped_target[0][DotnetPublishBinaryInfo].binary_info
    target_framework = ctx.attr.wrapped_target[0][DotnetPublishBinaryInfo].target_framework
    runtime_identifier = ctx.attr.runtime_identifier
    publishing_pack = ctx.attr.wrapped_target[0][DotnetPublishBinaryInfo].publishing_pack
    is_self_contained = ctx.attr.wrapped_target[0][DotnetPublishBinaryInfo].self_contained
    dll_name = binary.dll.basename.replace(".dll", "")

    (executable, runfiles) = _copy_to_publish(
        ctx,
        runtime_identifier,
        binary.app_host,
        binary.runfiles,
        publishing_pack,
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
    },
    toolchains = [
        "@rules_dotnet//dotnet:toolchain_type",
    ],
    executable = True,
)
