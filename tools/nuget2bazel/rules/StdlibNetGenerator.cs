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
    class StdlibNetGenerator
    {
        private readonly string _configDir;
        private readonly string _rulesPath;

        public StdlibNetGenerator(string configDir, string rulesPath)
        {
            _configDir = configDir;
            _rulesPath = rulesPath;
        }

        public async Task Do()
        {
            foreach (var tfm in new[]
                {"net45", "net451", "net452", "net46", "net461", "net462", "net47", "net471", "net472", "net48"})
            {
                await HandleMetapackage(Path.Combine(_rulesPath, $"dotnet/stdlib.net/{tfm}/generated.bzl"),
                    $"Microsoft.NETFramework.ReferenceAssemblies.{tfm}", "1.0.0");
            }
        }

        private async Task HandleMetapackage(string outpath, string package, string version)
        {
            var packageDir = await PackageDownloader.DownloadPackageIfNedeed(_configDir, package, version);
            var libs = GetRefInfos(packageDir, package, version);
            await GenerateBazelFile(outpath, libs);
        }

        private List<RefInfo> GetRefInfos(string srcDir, string package, string version)
        {
            var brokenDependencies = new string[] { "system.xml", "system.configuration", "system.windows.forms",
                "system.runtime.remoting", "system.transactions", "system.design", "system.web", "presentationframework",
                "system.printing", "system.servicemodel", "system.data.services.design", "system.workflow.activities",
                "system.data"
            };

            var result = new List<RefInfo>();

            var packageDir = GetPackagePath(srcDir, package, version);
            var frameworkDir = GetRefsDir(srcDir, package, version);
            var facadeDir = Path.Combine(frameworkDir, "Facades");
            var relative = Path.GetRelativePath(packageDir, frameworkDir).Replace('\\', '/');
            var dlls = Directory.GetFiles(frameworkDir, "*.dll");
            var facades = Directory.Exists(facadeDir) ? Directory.GetFiles(facadeDir, "*.dll") : new string[] { };
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
                    var refname = facades.Contains(d) ? $"@{package}.{version}//:{relative}/Facades/{name}" : $"@{package}.{version}//:{relative}/{name}";

                    var refInfo = new RefInfo();
                    refInfo.Name = name.ToLower();
                    refInfo.Version = metadata.GetName().Version.ToString();
                    refInfo.Ref = refname;
                    refInfo.StdlibPath = refname;   // Real implementation assemblies are in GAC
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
            await f.WriteLineAsync($"load(\"@io_bazel_rules_dotnet//dotnet/private:rules/stdlib.bzl\", \"net_stdlib\")");
            await f.WriteLineAsync();
            await f.WriteLineAsync("def define_stdlib(context_data):");

            foreach (var d in libs)
            {
                var depsString = String.Join(", ", d.Deps);

                await f.WriteLineAsync($"    net_stdlib(");
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

        //private string GetStdlibPath(string sdk, string sdkVersion, string name, )
        //{
        //    var p = Path.Combine(sdk, "shared", "Microsoft.NETCore.App", version, name);
        //    if (File.Exists(p))
        //        return $"@core_sdk_{sdkVersion}//:core/shared/Microsoft.NETCore.App/{version}/{name}";

        //    return null;
        //}

        public string GetPackagePath(string srcdir, string package, string version)
        {
            var p = Path.Combine(srcdir, "packages", $"{package}.{version}");
            return p;
        }

        public string GetRefsDir(string srcdir, string package, string version)
        {
            var p = GetPackagePath(srcdir, package, version);
            var dir = Path.Combine(p, "build/.NETFramework");
            return Directory.GetDirectories(dir)[0];
        }
    }
}
