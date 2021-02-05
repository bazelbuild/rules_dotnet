load(
    "@io_bazel_rules_dotnet//dotnet/private:common.bzl",
    "as_iterable",
)
load(
    "@io_bazel_rules_dotnet//dotnet/private:providers.bzl",
    "DotnetLibrary",
)

def _make_runner_arglist(
        dotnet,
        guid,
        major_version,
        minor_version,
        lcid,
        platform,
        namespace,
        output):
    args = dotnet.actions.args()

    args.add(dotnet.tlbimp)
    args.add(guid)
    args.add(str(major_version))
    args.add(str(minor_version))
    args.add(str(lcid))
    args.add(platform)
    args.add(namespace)
    args.add(output, format = "%s")

    return args

def emit_com_ref_net(
        dotnet,
        name = "",
        guid = None,
        major_version = None,
        minor_version = None,
        lcid = None,
        platform = None,
        namespace = None,
        out = None):
    if name == "" and out == None:
        fail("either name or out must be set")

    if not out:
        result = dotnet.declare_file(dotnet, path = name + ".dll")
    else:
        result = dotnet.declare_file(dotnet, path = out)

    args = _make_runner_arglist(
        dotnet,
        guid,
        major_version,
        minor_version,
        lcid,
        platform,
        namespace,
        result,
    )

    command = r'''tlbimp=$1
guid=$2
major_version=$3
minor_version=$4
lcid=$5
platform=$6
namespace=$7
output=$8
query="HKCR\\TypeLib\\{${guid}}\\${major_version}.${minor_version}\\${lcid}\\${platform}\\"
cmd="$($SYSTEMROOT\\System32\\reg.exe query ${query})"
result="$(echo "$cmd" | tail -n 1 | awk '{print $3}')"
out="$(echo $output | sed 's/\//\\/g')"
params="${tlbimp} ${result/\%SystemRoot\%/C:\\Windows} /out:${out} /namespace:${namespace}"
$params'''

    dotnet.actions.run_shell(
        outputs = [result],
        command = command,
        arguments = [args],
        mnemonic = "NetComRefGen",
        progress_message = (
            "Generating com wrapper" + dotnet.label.package + ":" + dotnet.label.name
        ),
    )

    return result
