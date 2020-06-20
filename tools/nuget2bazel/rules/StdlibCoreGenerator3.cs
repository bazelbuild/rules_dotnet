using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Reflection;
using System.Runtime.Serialization;
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
            var defSdk = SdkInfos.Sdks.First(x => x.DefaultSdk);

            foreach (var tfm in SdkInfos.Sdks.Where(x => x.Packs != null))
            {
                var refs = await tfm.GetRefInfos(_configDir);
                await GenerateBazelFile(Path.Combine(_rulesPath, $"dotnet/stdlib.core/{tfm.Version}/generated.bzl"),
                     refs);
            }

            var refsDef = await defSdk.GetRefInfos(_configDir);
            foreach (var r in refsDef)
            {
                r.Ref = r.Ref?.Replace($"_{defSdk.Version}", "");
                r.StdlibPath = r.StdlibPath?.Replace($"_{defSdk.Version}", "");
            }

            await GenerateBazelFile(Path.Combine(_rulesPath, $"dotnet/stdlib.core/generated.bzl"),
                refsDef);
        }


        private async Task GenerateBazelFile(string outpath, List<RefInfo> packRefs)
        {
            await using var f = new StreamWriter(outpath);
            await f.WriteLineAsync("load(\"@io_bazel_rules_dotnet//dotnet/private:rules/stdlib.bzl\", \"core_stdlib_internal\")");
            await f.WriteLineAsync("load(\"@io_bazel_rules_dotnet//dotnet/private:rules/libraryset.bzl\", \"core_libraryset\")");
            await f.WriteLineAsync();
            await f.WriteLineAsync("def define_stdlib(context_data):");

            int cnt = 0;
            foreach (var p in packRefs.Select(x => x.Pack).Distinct())
            {
                var pfx = cnt == 0 ? "" : $"p{cnt}_";
                await f.WriteLineAsync("    core_libraryset(");
                if (p == "Microsoft.NETCore.App.Ref")
                    await f.WriteLineAsync("        name = \"libraryset\",");
                else
                    await f.WriteLineAsync($"        name = \"{p.Replace(".Ref", "")}\",");

                await f.WriteLineAsync("        deps = [");
                foreach (var d in packRefs.Where(x => x.Pack == p))
                {
                    await f.WriteLineAsync($"            \":{pfx}{d.Name}\",");
                }
                await f.WriteLineAsync("        ],");
                await f.WriteLineAsync("    )");

                foreach (var d in packRefs.Where(x => x.Pack == p))
                {
                    await f.WriteLineAsync($"    core_stdlib_internal(");
                    await f.WriteLineAsync($"        name = \"{pfx}{d.Name}\",");
                    await f.WriteLineAsync($"        version = \"{d.Version}\",");
                    if (d.Ref != null)
                        await f.WriteLineAsync($"        ref = \"{d.Ref}\",");
                    if (d.StdlibPath != null)
                        await f.WriteLineAsync($"        stdlib_path = \"{d.StdlibPath}\",");
                    await f.WriteLineAsync($"        deps = [");
                    foreach (var dep in d.Deps)
                    {
                        var n = dep.Replace(":", $":{pfx}");
                        await f.WriteLineAsync($"            {n},");
                    }
                    await f.WriteLineAsync($"        ]");
                    await f.WriteLineAsync($"    )");
                }

                ++cnt;
            }
        }
    }
}
