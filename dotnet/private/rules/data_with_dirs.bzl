def CopyDataWithDirs(dotnet, data_with_dirs, copy, subdir):
    """ Handles data targets provided with directories. Returns runfiles.

    Args:
      dotnet: DotnetContextInfo provider
      data_with_dirs: dict(Taret, string)
      copy: program to use for copying files
      subdir: subdirectory to use when placing provider data files

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

            newfile = dotnet.declare_file(dotnet, path = targetpath)
            dotnet.actions.run(
                outputs = [newfile],
                inputs = [f] + copy.files.to_list(),
                executable = copy.files.to_list()[0],
                arguments = [newfile.path, f.path],
                mnemonic = "CopyFile",
            )
            created.append(newfile)

    return dotnet._ctx.runfiles(files = created)
