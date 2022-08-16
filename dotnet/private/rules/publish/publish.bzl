"""
Rules for compiling F# binaries.
"""

load("//dotnet/private:providers.bzl", "DotnetAssemblyInfo", "DotnetBinaryInfo", "DotnetPublishBinaryInfo")
load("//dotnet/private:transitions/tfm_transition.bzl", "tfm_transition")

def _copy_to_publish(ctx, runtime_identifier, app_host, dll, runfiles, publishing_pack):
    app_host_copy = ctx.actions.declare_file("publish/{}/{}".format(runtime_identifier, app_host.basename))
    dll_copy = ctx.actions.declare_file("publish/{}/{}".format(runtime_identifier, dll.basename))

    runfiles = runfiles.files.to_list()
    inputs = [app_host, dll] + runfiles

    runfiles_copy = [dll_copy]
    for file in runfiles:
        runfiles_copy.append(ctx.actions.declare_file("publish/{}/{}".format(runtime_identifier, file.basename)))

    if publishing_pack:
        for file in publishing_pack.to_list():
            runfiles_copy.append(ctx.actions.declare_file("publish/{}/{}".format(runtime_identifier, file.basename)))
            inputs.append(file)

    args = ctx.actions.args()
    args.add_all(inputs)
    ctx.actions.run_shell(
        outputs = [app_host_copy, dll_copy] + runfiles_copy,
        inputs = inputs,
        arguments = [args],
        command = "mkdir publish && for f in $@; do cp $f {}/$(basename $f); done".format(app_host_copy.dirname),
    )

    return (app_host_copy, runfiles_copy)

def _publish_binary_impl(ctx):
    binary = ctx.attr.binary[0][DotnetBinaryInfo]

    publishing_pack = None
    if ctx.attr.self_contained == True:
        if ctx.attr.publishing_pack == None or len(ctx.attr.publishing_pack) == 0:
            fail("Can not publish self-contained binaries without a publishing pack")
        publishing_pack = depset(
            ctx.attr.publishing_pack[0][DotnetAssemblyInfo].lib + ctx.attr.publishing_pack[0][DotnetAssemblyInfo].data,
            transitive = [ctx.attr.publishing_pack[0][DotnetAssemblyInfo].transitive_runfiles],
        )

    return [
        DotnetPublishBinaryInfo(
            binary_info = binary,
            publishing_pack = publishing_pack,
            target_framework = ctx.attr.target_framework,
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

def _publish_binary_wrapper_impl(ctx):
    binary = ctx.attr.wrapped_target[0][DotnetPublishBinaryInfo].binary_info
    target_framework = ctx.attr.wrapped_target[0][DotnetPublishBinaryInfo].target_framework
    publishing_pack = ctx.attr.wrapped_target[0][DotnetPublishBinaryInfo].publishing_pack
    dll_name = binary.dll.basename.replace(".dll", "")

    (executable, runfiles) = _copy_to_publish(ctx, ctx.attr.runtime_identifier, binary.app_host, binary.dll, binary.runfiles, publishing_pack)

    runtimeconfig = ctx.actions.declare_file("publish/{}/{}.runtimeconfig.json".format(ctx.attr.runtime_identifier, dll_name))
    ctx.actions.expand_template(
        template = ctx.file._runtimeconfig_template,
        output = runtimeconfig,
        substitutions = {
            "{RUNTIME_TFM}": target_framework,
            "{RUNTIME_FRAMEWORK_VERSION}": ctx.toolchains["@rules_dotnet//dotnet:toolchain_type"].dotnetinfo.runtime_version,
        },
    )

    return [
        ctx.attr.wrapped_target[0][DotnetPublishBinaryInfo],
        DefaultInfo(
            runfiles = ctx.runfiles(
                files = runfiles + [runtimeconfig],
            ),
            executable = executable,
            files = depset([executable, runtimeconfig] + runfiles),
        ),
    ]

# This wrapper is only needed so that we can turn the incoming transition in `publish_binary` into a
# outgoing transition in the wrapper. This allows us to select on the runtime_identifier and publishing_pack attributes.
# We also need to have all the file copying in the wrapper rule because Bazel does not allow forwarding executable files
# as they have to be created by the wrapper rule.
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
        "_runtimeconfig_template": attr.label(
            doc = "A template file to use for generating runtimeconfig.json without the manifest loader",
            default = ":runtimeconfig_without_loader.json.tpl",
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
