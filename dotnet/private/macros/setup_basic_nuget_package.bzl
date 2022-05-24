"""
Rules for interfacing with NuGet packages.
"""

load("//dotnet/private:providers.bzl", "DotnetAssemblyInfo")
load("//dotnet/private:rules/imports.bzl", "import_library", "import_multiframework_library")

# name is generated. This macro is not exported from this file.
# buildifier: disable=unnamed-macro
def _import_dll(lib_name, dlls_per_tfm, pdbs_per_tfm, imports):

    for (tfm, dlls) in dlls_per_tfm.items():
        # Ignore frameworks we don't support (like net35)
        if tfm not in DotnetAssemblyInfo:
            return

        target_name = "%s-%s" % (lib_name, tfm)

        if lib_name not in imports:
            imports[lib_name] = {tfm: target_name}
        else:
            imports[lib_name][tfm] = target_name

        import_library(
            name = target_name,
            target_framework = tfm,
            dll = dlls,
            pdb = pdbs_per_tfm[tfm],
        )
    

# There isn't a single logical target to name generated by this macro.
# (There may be multiple assemblies in a package).
# This macro is public, but isn't meant to be used directly by users.
# buildifier: disable=unnamed-macro
def setup_basic_nuget_package():
    """This macro gets used to implement the default NuGet BUILD file.

       We are limited by the fact that Bazel does not allow the analysis phase to
       read the contents of source files, e.g. to correctly configure deps. For
       more advanced usages a BUILD file will need to be generated outside of
       Bazel. See docs/UsingNuGetPackages.md for more info.

       This has to be public so that packages can call it but you probably
       shouldn't use it directly.
    """
    dlls = native.glob(["lib/*/*.dll"])
    pdbs = native.glob(["lib/*/*.pdb"])
    lib_name = dlls[0].split("/")[-1].rsplit(".", 1)[0]

    # Map from lib name to dict from tfm to target name
    imports = {}

    # Output import_library rules
    dlls_per_tfm = {tfm: [] for tfm in DotnetAssemblyInfo.keys()}
    for dll in dlls:
        path = dll.split("/")
        tfm = path[1]
        dlls_per_tfm[tfm] = dlls_per_tfm[tfm] + [dll]

    pdbs_per_tfm = {tfm: [] for tfm in DotnetAssemblyInfo.keys()}
    for pdb in pdbs:
        path = pdb.split("/")
        tfm = path[1]
        pdbs_per_tfm[tfm] = pdbs_per_tfm[tfm] + [pdb]
        
    _import_dll(lib_name, dlls_per_tfm, pdbs_per_tfm, imports)

    # Output import_multiframework_library rules
    for (name, tfms) in imports.items():
        print(imports)
        import_multiframework_library(
            name = name,
            visibility = ["//visibility:public"],

            # I don't know how to do this better.
            netstandard = tfms.get("netstandard"),
            netstandard1_0 = tfms.get("netstandard1.0"),
            netstandard1_1 = tfms.get("netstandard1.1"),
            netstandard1_2 = tfms.get("netstandard1.2"),
            netstandard1_3 = tfms.get("netstandard1.3"),
            netstandard1_4 = tfms.get("netstandard1.4"),
            netstandard1_5 = tfms.get("netstandard1.5"),
            netstandard1_6 = tfms.get("netstandard1.6"),
            netstandard2_0 = tfms.get("netstandard2.0"),
            netstandard2_1 = tfms.get("netstandard2.1"),
            net11 = tfms.get("net11"),
            net20 = tfms.get("net20"),
            net30 = tfms.get("net30"),
            net35 = tfms.get("net35"),
            net40 = tfms.get("net40"),
            net403 = tfms.get("net403"),
            net45 = tfms.get("net45"),
            net451 = tfms.get("net451"),
            net452 = tfms.get("net452"),
            net46 = tfms.get("net46"),
            net461 = tfms.get("net461"),
            net462 = tfms.get("net462"),
            net47 = tfms.get("net47"),
            net471 = tfms.get("net471"),
            net472 = tfms.get("net472"),
            net48 = tfms.get("net48"),
            netcoreapp1_0 = tfms.get("netcoreapp1.0"),
            netcoreapp1_1 = tfms.get("netcoreapp1.1"),
            netcoreapp2_0 = tfms.get("netcoreapp2.0"),
            netcoreapp2_1 = tfms.get("netcoreapp2.1"),
            netcoreapp2_2 = tfms.get("netcoreapp2.2"),
            netcoreapp3_0 = tfms.get("netcoreapp3.0"),
            netcoreapp3_1 = tfms.get("netcoreapp3.1"),
            net5_0 = tfms.get("net5.0"),
            net6_0 = tfms.get("net6.0"),
        )
