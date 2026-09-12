".Net crossgen2 Pack"

load("//dotnet/private:common.bzl", "copy_files_to_dir")
load("//dotnet/private:providers.bzl", "DotnetCrossgen2PackInfo")

_CROSSGEN2 = ["crossgen2", "crossgen2.exe"]

def _crossgen2_pack_impl(ctx):
    is_windows = ctx.target_platform_has_constraint(
        ctx.attr._windows_constraint[platform_common.ConstraintValueInfo],
    )

    # crossgen2 loads its JIT libraries from its own directory, so the whole
    # tools directory moves together.
    files = copy_files_to_dir(
        ctx.label.name,
        ctx.actions,
        is_windows,
        [f for f in ctx.attr.pack_files.files.to_list() if "/tools/" in f.path],
        ctx.label.name,
        executables = _CROSSGEN2,
    )

    crossgen2 = None
    for file in files:
        if file.basename in _CROSSGEN2:
            crossgen2 = file

    if crossgen2 == None:
        fail("crossgen2 executable not found in crossgen2 pack")

    return [DotnetCrossgen2PackInfo(
        crossgen2 = crossgen2,
        files = depset(files),
    )]

crossgen2_pack = rule(
    _crossgen2_pack_impl,
    doc = """.Net crossgen2 Pack""",
    attrs = {
        "pack_files": attr.label(
            doc = "Every file in the crossgen2 nuget package",
        ),
        "_windows_constraint": attr.label(default = "@platforms//os:windows"),
    },
)
