using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Reflection;
using System.Text;
using System.Threading.Tasks;
using NuGet.PackageManagement;

namespace nuget2bazel.rules
{
    class StdlibMonoGenerator
    {
        private readonly string _configDir;
        private readonly string _rulesPath;

        public StdlibMonoGenerator(string configDir, string rulesPath)
        {
            _configDir = configDir;
            _rulesPath = rulesPath;
        }

        public async Task Do()
        {
            var outpath = Path.Combine(_rulesPath, "dotnet/stdlib/generated.bzl");
            var srcDir = "c:/temp/reference-assemblies/v4.5";
            var libs = GetRefInfos(srcDir);
            await GenerateBazelFile(outpath, libs);
        }

        private List<RefInfo> GetRefInfos(string srcDir)
        {
            var brokenDependencies = new string[] { "system.xml", "system.configuration", "system.windows.forms",
                "system.runtime.remoting", "system.transactions", "system.design", "system.web", "presentationframework",
                "system.printing", "system.servicemodel", "system.data.services.design", "system.workflow.activities",
                "system.data"
            };

            var result = new List<RefInfo>();

            var dlls = Directory.GetFiles(srcDir, "*.dll");
            var facades = Directory.GetFiles(Path.Combine(srcDir, "Facades"), "*.dll");
            var allDlls = dlls.Union(facades);

            var resolver = new PathAssemblyResolver(allDlls);
            using var lc = new MetadataLoadContext(resolver);
            var known = allDlls.Select(x => Path.GetFileNameWithoutExtension(x).ToLower()).ToArray();
            foreach (var d in allDlls)
            {
                try
                {
                    var metadata = lc.LoadFromAssemblyPath(d);
                    var deps = metadata.GetReferencedAssemblies();
                    var depNames = deps
                        .Where(y => !brokenDependencies.Contains(y.Name.ToLower()) && known.Contains(y.Name.ToLower()))
                        .Select(x => $"\":{x.Name.ToLower()}.dll\"");
                    var name = Path.GetFileName(d);
                    var refname = facades.Contains(d) ? $"@Mono.ReferenceAssemblies.v4.5//:build/.NETFramework/v4.5/Facades/{name}"
                        : $"@Mono.ReferenceAssemblies.v4.5//:build/.NETFramework/v4.5/{name}";

                    var refInfo = new RefInfo();
                    refInfo.Name = name.ToLower();
                    refInfo.Version = metadata.GetName().Version.ToString();
                    refInfo.Ref = refname;
                    refInfo.Deps.AddRange(depNames);
                    result.Add(refInfo);
                }
                catch (Exception)
                {
                }
            }

            return result;
        }

        private async Task GenerateBazelFile(string outpath, List<RefInfo> libs)
        {
            await using var f = new StreamWriter(outpath);
            await f.WriteLineAsync($"load(\"@io_bazel_rules_dotnet//dotnet/private:rules/stdlib.bzl\", \"dotnet_stdlib\")");
            await f.WriteLineAsync();
            await f.WriteLineAsync("def define_stdlib(context_data):");

            foreach (var d in libs)
            {
                var depsString = String.Join(", ", d.Deps);

                await f.WriteLineAsync($"    dotnet_stdlib(");
                await f.WriteLineAsync($"        name = \"{d.Name}\",");
                await f.WriteLineAsync($"        version = \"{d.Version}\",");
                await f.WriteLineAsync($"        dotnet_context_data = context_data,");
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
