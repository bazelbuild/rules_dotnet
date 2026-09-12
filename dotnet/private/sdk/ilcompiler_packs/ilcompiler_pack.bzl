".Net ILCompiler Pack"

load("//dotnet/private:common.bzl", "copy_files_to_dir")
load("//dotnet/private:providers.bzl", "DotnetIlcompilerPackInfo")

_ILC = ["ilc", "ilc.exe"]

def _ilcompiler_pack_impl(ctx):
    is_windows = ctx.target_platform_has_constraint(
        ctx.attr._windows_constraint[platform_common.ConstraintValueInfo],
    )

    # ilc loads its JIT libraries from its own directory, so the whole tools
    # directory moves together.
    files = copy_files_to_dir(
        ctx.label.name,
        ctx.actions,
        is_windows,
        [f for f in ctx.attr.pack_files.files.to_list() if "/tools/" in f.path],
        ctx.label.name,
        executables = _ILC,
    )

    ilc = None
    for file in files:
        if file.basename in _ILC:
            ilc = file

    if ilc == None:
        fail("ilc executable not found in ILCompiler pack")

    return [DotnetIlcompilerPackInfo(
        ilc = ilc,
        files = depset(files),
    )]

ilcompiler_pack = rule(
    _ilcompiler_pack_impl,
    doc = """.Net ILCompiler Pack""",
    attrs = {
        "pack_files": attr.label(
            doc = "Every file in the ILCompiler nuget package",
        ),
        "_windows_constraint": attr.label(default = "@platforms//os:windows"),
    },
)
