using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Reflection;
using System.Threading.Tasks;

namespace nuget2bazel.rules
{
    class StdlibCoreGenerator
    {
        private readonly string _configDir;
        private readonly string _rulesPath;

        public StdlibCoreGenerator(string configDir, string rulesPath)
        {
            _configDir = configDir;
            _rulesPath = rulesPath;
        }

        public async Task Do()
        {
            foreach (var tfm in SdkInfos.Sdks.Where(x => x.Packs == null))
            {
                var refs = await tfm.GetRefInfos(_configDir);
                await GenerateBazelFile(Path.Combine(_rulesPath, $"dotnet/stdlib.core/{tfm.Version}/generated.bzl"),
                    refs);
            }
        }

        private async Task GenerateBazelFile(string outpath, List<RefInfo> libs)
        {
            await using var f = new StreamWriter(outpath);
            await f.WriteLineAsync("load(\"@io_bazel_rules_dotnet//dotnet/private:rules/stdlib.bzl\", \"core_stdlib_internal\")");
            await f.WriteLineAsync("load(\"@io_bazel_rules_dotnet//dotnet/private:rules/libraryset.bzl\", \"core_libraryset\")");
            await f.WriteLineAsync();
            await f.WriteLineAsync("def define_stdlib(context_data):");

            await f.WriteLineAsync("    core_libraryset(");
            await f.WriteLineAsync("        name = \"libraryset\",");
            await f.WriteLineAsync("        deps = [");
            foreach (var d in libs)
            {
                await f.WriteLineAsync($"            \":{d.Name}\",");
            }
            await f.WriteLineAsync("        ],");
            await f.WriteLineAsync("    )");

            foreach (var d in libs)
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
        }
    }
}
