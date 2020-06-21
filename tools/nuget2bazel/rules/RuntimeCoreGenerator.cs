using System;
using System.Collections.Generic;
using System.Diagnostics;
using System.IO;
using System.Linq;
using System.Reflection;
using System.Threading.Tasks;

namespace nuget2bazel.rules
{
    class RuntimeCoreGenerator
    {
        private readonly string _configDir;
        private readonly string _rulesPath;

        public RuntimeCoreGenerator(string configDir, string rulesPath)
        {
            _configDir = configDir;
            _rulesPath = rulesPath;
        }

        public async Task Do()
        {
            foreach (var tfm in SdkInfos.Sdks)
            {
                await using var f = new StreamWriter(Path.Combine(_rulesPath, $"dotnet/stdlib.core/{tfm.Version}/generated2.bzl"));

                await Handle(f, tfm, false);
            }

            var defSdk = SdkInfos.Sdks.First(x => x.DefaultSdk);
            await using var fd = new StreamWriter(Path.Combine(_rulesPath, $"dotnet/stdlib.core/generated2.bzl"));
            await Handle(fd, defSdk, true);
        }

        private async Task Handle(StreamWriter f, Sdk sdk, bool defaultSdk)
        {
            var sdkDirWin = await ZipDownloader.DownloadIfNedeed(_configDir, sdk.WindowsUrl);
            var sdkDirLinux = await ZipDownloader.DownloadIfNedeed(_configDir, sdk.LinuxUrl);
            var sdkDirOsx = await ZipDownloader.DownloadIfNedeed(_configDir, sdk.DarwinUrl);

            await f.WriteLineAsync("load(\"@io_bazel_rules_dotnet//dotnet/private:rules/stdlib.bzl\", \"core_stdlib_internal\")");
            await f.WriteLineAsync("load(\"@io_bazel_rules_dotnet//dotnet/private:rules/libraryset.bzl\", \"core_libraryset\")");
            await f.WriteLineAsync();
            await f.WriteLineAsync("def define_runtime(context_data):");

            if (sdk.Packs != null)
            {
                await f.WriteLineAsync("    native.alias(name=\"system.security.accesscontrol.dll\", actual=\":p1_system.security.accesscontrol.dll\")");
                await f.WriteLineAsync("    native.alias(name=\"system.security.principal.windows.dll\", actual=\":p1_system.security.principal.windows.dll\")");
                await f.WriteLineAsync("    native.alias(name=\"microsoft.win32.registry.dll\", actual=\":p1_microsoft.win32.registry.dll\")");
                await f.WriteLineAsync("    native.alias(name=\"system.security.cryptography.cng.dll\", actual=\":p1_system.security.cryptography.cng.dll\")");
            }

            var infosWindows = await ProcessDirectory(f, $"windows_runtime_deps", sdkDirWin, sdk, defaultSdk);
            var infosLinux = await ProcessDirectory(f, $"linux_runtime_deps", sdkDirLinux, sdk, defaultSdk);
            var infosDarwin = await ProcessDirectory(f, $"darwin_runtime_deps", sdkDirOsx, sdk, defaultSdk);

            await f.WriteLineAsync();
            await f.WriteLineAsync($"    core_libraryset(");
            await f.WriteLineAsync($"        name = \"runtime\",");
            await f.WriteLineAsync($"        deps = select({{");
            await f.WriteLineAsync($"            \"@bazel_tools//src/conditions:windows\": [");
            foreach (var i in infosWindows.Item1)
                await f.WriteLineAsync($"                \":{i.Name}\",");
            await f.WriteLineAsync($"            ],");
            await f.WriteLineAsync($"            \"@bazel_tools//src/conditions:darwin\": [");
            foreach (var i in infosDarwin.Item1)
                await f.WriteLineAsync($"                \":{i.Name}\",");
            await f.WriteLineAsync($"            ],");
            await f.WriteLineAsync($"            \"//conditions:default\": [");
            foreach (var i in infosLinux.Item1)
                await f.WriteLineAsync($"                \":{i.Name}\",");
            await f.WriteLineAsync($"            ],");
            await f.WriteLineAsync($"        }}),");
            await f.WriteLineAsync($"        data = select({{");
            await f.WriteLineAsync($"            \"@bazel_tools//src/conditions:windows\": [");
            foreach (var i in infosWindows.Item2)
                await f.WriteLineAsync($"                \"{i}\",");
            await f.WriteLineAsync($"            ],");
            await f.WriteLineAsync($"            \"@bazel_tools//src/conditions:darwin\": [");
            foreach (var i in infosDarwin.Item2)
                await f.WriteLineAsync($"                \"{i}\",");
            await f.WriteLineAsync($"            ],");
            await f.WriteLineAsync($"            \"//conditions:default\": [");
            foreach (var i in infosLinux.Item2)
                await f.WriteLineAsync($"                \"{i}\",");
            await f.WriteLineAsync($"            ],");
            await f.WriteLineAsync($"        }}),");
            await f.WriteLineAsync($"    )");
        }

        private async Task<Tuple<List<RefInfo>, List<string>>> ProcessDirectory(StreamWriter f, string varname, string sdkDir, Sdk sdk, bool defaultSdk)
        {
            var pack = "Microsoft.NETCore.App";
            var infos = GetSdkInfos(sdkDir, pack, sdk);
            var alreadyDefined = (await sdk.GetRefInfos(_configDir)).Select(x => x.Name);
            var infosMissing = infos.Where(x => !alreadyDefined.Contains(x.Name)).ToList();

            var coreSdkPrefix = defaultSdk ? "@core_sdk" : $"@core_sdk_{sdk.Version}";
            if (defaultSdk)
                foreach (var d in infosMissing)
                {
                    d.Ref = d.Ref.Replace($"@core_sdk_{sdk.Version}", "@core_sdk");
                    d.StdlibPath = d.StdlibPath.Replace($"@core_sdk_{sdk.Version}", "@core_sdk");
                }

            if (varname == "windows_runtime_deps")
                foreach (var d in infosMissing)
                {
                    await f.WriteLineAsync($"    core_stdlib_internal(");
                    await f.WriteLineAsync($"        name = \"{d.Name}\",");
                    await f.WriteLineAsync($"        version = \"{d.Version}\",");
                    if (d.Ref != null)
                        await f.WriteLineAsync($"        ref = \"{d.Ref}\",");
                    if (d.StdlibPath != null)
                        await f.WriteLineAsync($"        stdlib_path = \"{d.StdlibPath}\",");
                    await f.WriteLineAsync($"        deps = [");
                    foreach (var dep in d.Deps)
                        await f.WriteLineAsync($"            {dep},");
                    await f.WriteLineAsync($"        ]");
                    await f.WriteLineAsync($"    )");
                }

            var native = Directory.GetFiles(Path.Combine(sdkDir, "shared", pack, sdk.InternalVersionFolder))
                .Select(y => Path.GetFileName(y))
                .Where(z => !infos.Select(x => x.Name).Contains(z.ToLower()));

            var nativePaths = native.Select(x =>
                $"{coreSdkPrefix}//:core/shared/Microsoft.NETCore.App/{sdk.InternalVersionFolder}/{x}");

            var hostfxr = Directory.GetFiles(Path.Combine(sdkDir, "host", "fxr", sdk.InternalVersionFolder))
                .Select(y => Path.GetFileName(y));
            var hostfxrPaths = hostfxr.Select(x =>
                $"{coreSdkPrefix}//:core/host/fxr/{sdk.InternalVersionFolder}/{x}");

            return new Tuple<List<RefInfo>, List<string>>(infos, nativePaths.Union(hostfxrPaths).ToList());
        }

        public static List<RefInfo> GetSdkInfos(string sdkd, string package, Sdk sdk)
        {
            var brokenDependencies = new string[] { };

            var result = new List<RefInfo>();

            var sdkDir = Path.Combine(sdkd, "shared", package, sdk.InternalVersionFolder);
            var dlls = Directory.GetFiles(sdkDir, "*.dll");

            var resolver = new PathAssemblyResolver(dlls);
            using var lc = new MetadataLoadContext(resolver);
            var known = dlls.Select(x => Path.GetFileNameWithoutExtension(x).ToLower()).ToArray();
            foreach (var d in dlls)
            {
                try
                {
                    var metadata = lc.LoadFromAssemblyPath(d);
                    var deps = metadata.GetReferencedAssemblies();
                    var depNames = deps
                        .Where(y => !brokenDependencies.Contains(y.Name.ToLower()) && known.Contains(y.Name.ToLower()))
                        .Select(x => $"\":{x.Name.ToLower()}.dll\"");
                    var name = Path.GetFileName(d);

                    var refInfo = new RefInfo();
                    refInfo.Name = name.ToLower();
                    refInfo.Version = metadata.GetName().Version.ToString();
                    refInfo.StdlibPath =
                        $"@core_sdk_{sdk.Version}//:core/shared/Microsoft.NETCore.App/{sdk.InternalVersionFolder}/{name}";
                    refInfo.Ref =
                        $"@core_sdk_{sdk.Version}//:core/shared/Microsoft.NETCore.App/{sdk.InternalVersionFolder}/{name}";
                    refInfo.Deps.AddRange(depNames);
                    result.Add(refInfo);
                }
                catch (Exception)
                {
                }
            }

            return result;
        }

    }
}
