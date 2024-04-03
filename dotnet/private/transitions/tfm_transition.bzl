"A transition that transitions between compatible target frameworks"

load("@bazel_skylib//lib:dicts.bzl", "dicts")
load("@local_config_platform//:constraints.bzl", "HOST_CONSTRAINTS")
load(
    "//dotnet/private:common.bzl",
    "FRAMEWORK_COMPATIBILITY",
    "get_highest_compatible_target_framework",
)
load("//dotnet/private/sdk:rids.bzl", "RUNTIME_GRAPH")
load("//dotnet/private/transitions:common.bzl", "FRAMEWORK_COMPATABILITY_TRANSITION_OUTPUTS", "RID_COMPATABILITY_TRANSITION_OUTPUTS")

def _platform_to_rid():
    cpu_constraint = None
    os_constraint = None
    for platform in HOST_CONSTRAINTS:
        if platform.startswith("@platforms//cpu"):
            cpu_constraint = platform.split(":")[1]
        if platform.startswith("@platforms//os"):
            os_constraint = platform.split(":")[1]

    if cpu_constraint == None or os_constraint == None:
        fail("Could not determine the cpu or os constraint: {}/{}".format(cpu_constraint, os_constraint))

    rid_cpu = None
    rid_os = None
    if os_constraint == "windows":
        rid_os = "win"
    elif os_constraint == "linux":
        rid_os = "linux"
    elif os_constraint == "macos" or os_constraint == "osx":
        rid_os = "osx"

    if cpu_constraint == "x86_64":
        rid_cpu = "x64"
    elif cpu_constraint == "aarch64" or cpu_constraint == "arm64":
        rid_cpu = "arm64"

    if rid_cpu == None or rid_os == None:
        fail("Could not determine the rid from the cpu/os constraint: {}/{}".format(cpu_constraint, os_constraint))

    return "{}-{}".format(rid_os, rid_cpu)

def _impl(settings, attr):
    incoming_tfm = settings["//dotnet:target_framework"]

    if incoming_tfm not in FRAMEWORK_COMPATABILITY_TRANSITION_OUTPUTS:
        fail("Error setting //dotnet:target_framework: invalid value '" + incoming_tfm + "'. Allowed values are " + str(FRAMEWORK_COMPATIBILITY.keys()))

    target_frameworks = []
    if hasattr(attr, "target_framework"):
        target_frameworks.append(attr.target_framework)
    if hasattr(attr, "target_frameworks"):
        target_frameworks += attr.target_frameworks

    transitioned_tfm = get_highest_compatible_target_framework(incoming_tfm, target_frameworks)

    if transitioned_tfm == None:
        fail("Label {0} does not support the target framework: {1}".format(attr.name, incoming_tfm))

    runtime_identifier = settings["//dotnet:rid"]
    if hasattr(attr, "runtime_identifier") and attr.runtime_identifier != "":
        runtime_identifier = attr.runtime_identifier
    elif runtime_identifier == "base":
        # If the runtime_identifier attribute is not set and the incoming value is "base", we will use the platform to determine the rid since no upstream target has set the runtime identifier
        runtime_identifier = _platform_to_rid()

    return dicts.add({"//dotnet:target_framework": transitioned_tfm}, {"//dotnet:rid": runtime_identifier}, FRAMEWORK_COMPATABILITY_TRANSITION_OUTPUTS[transitioned_tfm], RID_COMPATABILITY_TRANSITION_OUTPUTS[runtime_identifier])

tfm_transition = transition(
    implementation = _impl,
    inputs = ["//dotnet:target_framework", "//dotnet:rid", "//command_line_option:cpu", "//command_line_option:platforms"],
    outputs = ["//dotnet:target_framework", "//dotnet:rid"] +
              ["//dotnet:framework_compatible_%s" % framework for framework in FRAMEWORK_COMPATIBILITY.keys()] +
              ["//dotnet:rid_compatible_%s" % rid for rid in RUNTIME_GRAPH.keys()],
)
