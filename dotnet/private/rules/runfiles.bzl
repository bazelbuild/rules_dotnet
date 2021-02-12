"Helper functions for runfiles"

def CopyRunfiles(ctx, runfiles, copy, symlink, executable, subdir):
    """Copies all runfile to the same directory and returns new runfiles 

    Args:
       ctx: [DotnetContext](api.md#DotnetContext)
       runfiles: depset(File) to copy to target directory of executable
       copy: target for utility copy tool
       symlink: target for utility symlink tool
       executable: [DotnetLibrary](api.md#DotnetLibrary) which directory is used as a base dir for the runfiles
       subdir: additional subdirectory to copy files to

    Returns:
       [runfiles](https://docs.bazel.build/versions/master/skylark/lib/runfiles.html)
    """
    copied = {}
    created = []
    nocopy_dir = executable.result.dirname
    for f in runfiles.files.to_list():
        found = copied.get(f.basename)
        if found:
            continue
        copied[f.basename] = True

        if f.basename == "mono" or f.basename == "mono.exe":
            newfile = ctx.actions.declare_file(subdir + f.basename)
            ctx.actions.run(
                outputs = [newfile],
                inputs = [f] + symlink.files.to_list(),
                executable = symlink.files.to_list()[0],
                arguments = [newfile.path, f.path],
                mnemonic = "LinkFile",
            )
            created.append(newfile)
        elif f.dirname != nocopy_dir:
            if f.basename.find("hostfxr") >= 0:
                version = f.path.split("/")
                newfile = ctx.actions.declare_file("{}/host/fxr/{}/{}".format(subdir, version[-2], version[-1]))
            else:
                newfile = ctx.actions.declare_file(subdir + f.basename)
            ctx.actions.run(
                outputs = [newfile],
                inputs = [f] + copy.files.to_list(),
                executable = copy.files.to_list()[0],
                arguments = [newfile.path, f.path],
                mnemonic = "CopyFile",
            )
            created.append(newfile)
        else:
            created.append(f)

    return ctx.runfiles(files = created)

def CopyDataWithDirs(dotnet, data_with_dirs, copy, subdir):
    """ Handles data targets provided with directories. Returns runfiles.

    Args:
      dotnet: DotnetContextInfo provider
      data_with_dirs: dict(Taret, string)
      copy: program to use for copying files
      subdir: subdirectory to use when placing provider data files

    Returns:
      [runfiles](https://docs.bazel.build/versions/master/skylark/lib/runfiles.html)

    """
    copied = {}
    created = []
    for (k, v) in data_with_dirs.items():
        for f in k.files.to_list():
            targetpath = subdir + "/" + v + "/" + f.basename
            found = copied.get(targetpath)
            if found:
                continue
            copied[targetpath] = True

            newfile = dotnet.actions.declare_file(targetpath)
            dotnet.actions.run(
                outputs = [newfile],
                inputs = [f] + copy.files.to_list(),
                executable = copy.files.to_list()[0],
                arguments = [newfile.path, f.path],
                mnemonic = "CopyFile",
            )
            created.append(newfile)

    return dotnet._ctx.runfiles(files = created)
