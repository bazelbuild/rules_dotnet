load(
    "@io_bazel_rules_dotnet//dotnet/private:skylib/lib/paths.bzl",
    "paths",
)

def CopyRunfiles(dotnet, runfiles, copy, symlink, executable, subdir):
    created = []
    for f in runfiles.files.to_list():
        if f.basename == "mono" or f.basename == "mono.exe":
            newfile = dotnet.declare_file(dotnet, path = subdir + f.basename)
            dotnet.actions.run(
                outputs = [newfile],
                inputs = [f],
                executable = symlink.files.to_list()[0],
                arguments = [newfile.path, f.path],
                mnemonic = "LinkFile",
            )
            created.append(newfile)
        elif f.basename != executable.result.basename:
            if f.basename.find("hostfxr") >= 0:
                version = f.path.split("/")
                newfile = dotnet.declare_file(dotnet, path = "{}/host/fxr/{}/{}".format(subdir, version[-2], version[-1]))
            else:
                newfile = dotnet.declare_file(dotnet, path = subdir + f.basename)
            dotnet.actions.run(
                outputs = [newfile],
                inputs = [f],
                executable = copy.files.to_list()[0],
                arguments = [newfile.path, f.path],
                mnemonic = "CopyFile",
            )
            created.append(newfile)

    return dotnet._ctx.runfiles(files = created)
