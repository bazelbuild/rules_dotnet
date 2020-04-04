using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Reflection;
using System.Runtime.InteropServices.ComTypes;
using System.Text;
using System.Threading;
using System.Threading.Tasks;
using NuGet.Configuration;
using NuGet.PackageManagement;
using NuGet.Packaging.Core;
using NuGet.ProjectManagement;
using NuGet.Protocol;
using NuGet.Protocol.Core.Types;
using NuGet.Resolver;
using NuGet.Versioning;

namespace nuget2bazel
{
    public class RulesCommand
    {
        private string _configDir;
        public RulesCommand()
        {
            _configDir = Path.Combine(Path.GetTempPath(), "nuget2bazel");
        }
        public async Task Do(string path)
        {
            //await HandleMetapackage("NETStandard.Library", "1.6.0");
            await DoNetFramework(path);
        }

        private async Task DoNetFramework(string path)
        {
            foreach (var tfm in new string[]
                {"net45", "net451", "net452", "net46", "net461", "net462", "net47", "net471", "net472", "net48"})
            {
                await HandleMetapackage(Path.Combine(path, $"dotnet/stdlib.net/{tfm}/generated.bzl"),
                    $"Microsoft.NETFramework.ReferenceAssemblies.{tfm}", "1.0.0");
            }
        }

        private async Task<string> DownloadPackageIfNedeed(string package, string version)
        {
            var dir = Path.Combine(_configDir, package);
            if (Directory.Exists(Path.Combine(dir, "packages")))
                return dir;

            var prjConfig = new ProjectBazelConfig(dir);
            Directory.CreateDirectory(dir);
            var cmd = new AddCommand();
            await cmd.Do(prjConfig, package, version, null, true, false, null);

            return dir;
        }

        private async Task HandleMetapackage(string outpath, string package, string version)
        {
            var packageDir = await DownloadPackageIfNedeed(package, version);
            await GenerateNetFramework(outpath, packageDir, package);
        }

        private async Task GenerateNetFramework(string outpath, string srcDir, string package)
        {
            var brokenDependencies = new string[] { "system.xml", "system.configuration", "system.windows.forms",
                "system.runtime.remoting", "system.transactions", "system.design", "system.web", "presentationframework",
                "system.printing", "system.servicemodel", "system.data.services.design", "system.workflow.activities",
                "system.data"
            };
            await using var f = new StreamWriter(outpath);
            await f.WriteLineAsync("load(\"@io_bazel_rules_dotnet//dotnet/private:rules/stdlib.bzl\", \"net_stdlib\")");
            await f.WriteLineAsync();
            await f.WriteLineAsync("def define_stdlib(context_data):");

            var packageDir = GetPackagePath(srcDir);
            var frameworkDir = GetFrameworkDir(srcDir);
            var facadeDir = Path.Combine(frameworkDir, "Facades");
            var relative = Path.GetRelativePath(packageDir, frameworkDir).Replace('\\', '/');
            var dlls = Directory.GetFiles(frameworkDir, "*.dll");
            var facades = Directory.GetFiles(facadeDir, "*.dll");
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
                    var depsString = String.Join(", ", depNames);
                    var name = Path.GetFileName(d);
                    var refname = facades.Contains(d) ? $"@{package}//:{relative}/Facades/{name}" : $"@{package}//:{relative}/{name}";
                    await f.WriteLineAsync(
                        $"    net_stdlib(name = \"{name.ToLower()}\", dotnet_context_data = context_data, ref = \"{refname}\", deps = [{depsString}])");
                }
                catch (Exception)
                {
                }
            }
        }

        private string GetPackagePath(string srcdir)
        {
            var p = Path.Combine(srcdir, "packages");
            return Directory.GetDirectories(p)[0];
        }
        private string GetFrameworkDir(string srcdir)
        {
            var p = GetPackagePath(srcdir);
            var dir = Path.Combine(p, "build/.NETFramework");
            return Directory.GetDirectories(dir)[0];
        }
    }
}