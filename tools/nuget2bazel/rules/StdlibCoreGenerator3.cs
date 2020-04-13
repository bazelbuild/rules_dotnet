using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Reflection;
using System.Threading.Tasks;

namespace nuget2bazel.rules
{
    class StdlibCoreGenerator3
    {
        private readonly string _configDir;
        private readonly string _rulesPath;

        public StdlibCoreGenerator3(string configDir, string rulesPath)
        {
            _configDir = configDir;
            _rulesPath = rulesPath;
        }

        public async Task Do()
        {
            var defSdk = new Tuple<string, string, string, string[]>("3.1.0", "v3.1.100",
                    "https://download.visualstudio.microsoft.com/download/pr/28a2c4ff-6154-473b-bd51-c62c76171551/ea47eab2219f323596c039b3b679c3d6/dotnet-sdk-3.1.100-win-x64.zip",
                    new[] { "Microsoft.AspNetCore.App.Ref", "Microsoft.NETCore.App.Ref", "NETStandard.Library.Ref" });

            foreach (var tfm in new[]
            {
                new Tuple<string, string, string, string[]>("3.0.0", "v3.0.100",
                    "https://download.visualstudio.microsoft.com/download/pr/a24f4f34-ada1-433a-a437-5bc85fc2576a/7e886d06729949c15c96fe7e70faa8ae/dotnet-sdk-3.0.100-win-x64.zip",
                    new []{"Microsoft.AspNetCore.App.Ref", "Microsoft.NETCore.App.Ref", "NETStandard.Library.Ref"}),
                defSdk
            })
            {
                await Handle(Path.Combine(_rulesPath, $"dotnet/stdlib.core/{tfm.Item2}/generated.bzl"),
                     tfm.Item1, tfm.Item2, tfm.Item3, tfm.Item4);
            }

            await Handle(Path.Combine(_rulesPath, $"dotnet/stdlib.core/generated.bzl"),
                defSdk.Item1, defSdk.Item2, defSdk.Item3, defSdk.Item4, true);
            await GenerateSdkList(Path.Combine(_rulesPath, $"tools/nuget2bazel/SdkList.cs"),
                defSdk.Item1, defSdk.Item2, defSdk.Item3, defSdk.Item4);
        }

        private async Task GenerateSdkList(string outpath, string version, string sdkVersion, string sdk, string[] packs)
        {
            var sdkList = new List<string>();
            var sdkDir = await ZipDownloader.DownloadIfNedeed(_configDir, sdk);
            foreach (var pack in packs)
            {
                var refs = GetRefInfos(sdkDir, version, sdkVersion, pack);
                sdkList = sdkList.Union(refs.Select(x => x.Name.Replace(".dll", ""))).ToList();
            }
            await using var f = new StreamWriter(outpath);
            await f.WriteLineAsync("namespace nuget2bazel");
            await f.WriteLineAsync("{");
            await f.WriteLineAsync("   public static class SdkList");
            await f.WriteLineAsync("   {");
            await f.WriteLineAsync("        public static string[] Dlls = {");
            foreach (var s in sdkList)
                await f.WriteLineAsync($"            \"{s}\",");
            await f.WriteLineAsync("        };");
            await f.WriteLineAsync("   }");
            await f.WriteLineAsync("}");
        }

        private async Task Handle(string outpath, string version, string sdkVersion, string sdk, string[] packs, bool useDefault = false)
        {
            var sdkDir = await ZipDownloader.DownloadIfNedeed(_configDir, sdk);
            var packRefs = new Dictionary<string, List<RefInfo>>();
            foreach (var pack in packs)
            {
                var refs = GetRefInfos(sdkDir, version, sdkVersion, pack);
                packRefs.Add(pack, refs);

                if (useDefault)
                    foreach (var r in refs)
                    {
                        r.Ref = r.Ref?.Replace($"_{sdkVersion}", "");
                        r.StdlibPath = r.StdlibPath?.Replace($"_{sdkVersion}", "");
                    }
            }
            await GenerateBazelFile(outpath, packRefs);
        }

        private List<RefInfo> GetRefInfos(string sdk, string version, string sdkVersion, string pack)
        {
            var brokenDependencies = new[] { "system.printing", "presentationframework" };

            var result = new List<RefInfo>();

            var refDir = GetRefsDir(sdk, pack);
            var relative = Path.GetRelativePath(sdk, refDir).Replace('\\', '/');
            var dlls = Directory.GetFiles(refDir, "*.dll");

            PathAssemblyResolver resolver = null;
            if (dlls.All(x => Path.GetFileName(x) != "mscorlib.dll"))
            {
                // Locate mscorlib require for MetadataLoadContext
                var mscorlibDir = GetRefsDir(sdk, "Microsoft.NETCore.App.Ref");
                resolver = new PathAssemblyResolver(dlls.Union(new[] { Path.Combine(mscorlibDir, "mscorlib.dll") }));
            }
            else
                resolver = new PathAssemblyResolver(dlls);

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
                    var refname = $"@core_sdk_{sdkVersion}//:core/{relative}/{name}";
                    var stdlibname = GetStdlibPath(sdk, name, pack, version, sdkVersion);

                    var refInfo = new RefInfo();
                    refInfo.Name = name.ToLower();
                    refInfo.Ref = refname;
                    refInfo.StdlibPath = stdlibname;
                    refInfo.Deps.AddRange(depNames);
                    result.Add(refInfo);
                }
                catch (Exception)
                {
                }
            }

            return result;
        }

        private async Task GenerateBazelFile(string outpath, Dictionary<string, List<RefInfo>> packRefs)
        {
            await using var f = new StreamWriter(outpath);
            await f.WriteLineAsync("load(\"@io_bazel_rules_dotnet//dotnet/private:rules/stdlib.bzl\", \"core_stdlib\")");
            await f.WriteLineAsync("load(\"@io_bazel_rules_dotnet//dotnet/private:rules/libraryset.bzl\", \"core_libraryset\")");
            await f.WriteLineAsync();
            await f.WriteLineAsync("def define_stdlib(context_data):");

            int cnt = 0;
            foreach (var p in packRefs)
            {
                await f.WriteLineAsync("    core_libraryset(");
                if (p.Key == "Microsoft.NETCore.App.Ref")
                    await f.WriteLineAsync("        name = \"libraryset\",");
                else
                    await f.WriteLineAsync($"        name = \"{p.Key.Replace(".Ref", "")}\",");

                await f.WriteLineAsync("        dotnet_context_data = context_data,");
                await f.WriteLineAsync("        deps = [");
                foreach (var d in p.Value)
                {
                    await f.WriteLineAsync($"            \":p{cnt}_{d.Name}\",");
                }
                await f.WriteLineAsync("        ],");
                await f.WriteLineAsync("    )");

                foreach (var d in p.Value)
                {
                    await f.WriteLineAsync($"    core_stdlib(");
                    await f.WriteLineAsync($"        name = \"p{cnt}_{d.Name}\",");
                    await f.WriteLineAsync($"        dotnet_context_data = context_data,");
                    if (d.Ref != null)
                        await f.WriteLineAsync($"        ref = \"{d.Ref}\",");
                    if (d.StdlibPath != null)
                        await f.WriteLineAsync($"        stdlib_path = \"{d.StdlibPath}\",");
                    await f.WriteLineAsync($"        deps = [");
                    foreach (var dep in d.Deps)
                    {
                        var n = dep.Replace(":", $":p{cnt}_");
                        await f.WriteLineAsync($"            {n},");
                    }
                    await f.WriteLineAsync($"        ]");
                    await f.WriteLineAsync($"    )");
                }


                ++cnt;
            }
        }

        private string GetStdlibPath(string sdk, string name, string pack, string version, string sdkVersion)
        {
            var p = Path.Combine(sdk, "shared", pack.Replace(".Ref", ""), version, name);
            if (File.Exists(p))
                return $"@core_sdk_{sdkVersion}//:core/shared/{pack.Replace(".Ref", "")}/{version}/{name}";

            p = Path.Combine(sdk, "shared");
            foreach (var d in Directory.GetDirectories(p))
            {
                p = Path.Combine(d, version, name);
                if (File.Exists(p))
                    return $"@core_sdk_{sdkVersion}//:core/shared/{Path.GetFileName(d)}/{version}/{name}";
            }

            return null;
        }

        private string GetRefsDir(string sdk, string pack)
        {
            var p = Path.Combine(sdk, "packs", pack);
            var versionDir = Directory.GetDirectories(p).OrderByDescending(x => x).First();
            var refDir = Path.Combine(versionDir, "ref");
            return Directory.GetDirectories(refDir).OrderByDescending(x => x).First();
        }
    }
}
