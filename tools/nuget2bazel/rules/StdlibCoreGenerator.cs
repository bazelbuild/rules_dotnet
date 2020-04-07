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
            foreach (var tfm in new[]
            {
                new Tuple<string, string, string>("2.0.7", "v2.1.200", "https://download.microsoft.com/download/3/7/1/37189942-C91D-46E9-907B-CF2B2DE584C7/dotnet-sdk-2.1.200-win-x64.zip")
            })
            {
                await Handle(Path.Combine(_rulesPath, $"dotnet/stdlib.core/{tfm.Item2}/generated.bzl"),
                    "Microsoft.NETCore.App", tfm.Item1, tfm.Item3);
            }
        }

        private async Task Handle(string outpath, string package, string version, string sdk)
        {
            var packageDir = await PackageDownloader.DownloadPackageIfNedeed(_configDir, package, version);
            var sdkDir = await ZipDownloader.DownloadIfNedeed(_configDir, sdk);
            var refs = GetRefInfos(packageDir, package, version);
            var sdks = GetSdkInfos(sdkDir, package, version);
            var combined = Combine(refs, sdks);
            await GenerateBazelFile(outpath, combined);
        }

        private List<RefInfo> Combine(List<RefInfo> refs, List<RefInfo> sdks)
        {
            var result = new List<RefInfo>();
            result.AddRange(refs);
            //foreach (var r in refs)
            //{
            //    var s = sdks.FirstOrDefault(x => x.Name == r.Name);
            //    if (s != null)
            //        r.Deps = r.Deps.Union(s.Deps).ToList();
            //    result.Add(r);
            //}

            foreach (var s in sdks)
            {
                if (result.All(x => x.Name != s.Name))
                    result.Add(s);
            }

            return result;
        }

        private List<RefInfo> GetRefInfos(string srcDir, string package, string version)
        {
            var brokenDependencies = new string[] { "netstandard" };

            var result = new List<RefInfo>();

            var packageDir = GetPackagePath(srcDir, package, version);
            var frameworkDir = GetRefsDir(srcDir, package, version);
            var relative = Path.GetRelativePath(packageDir, frameworkDir).Replace('\\', '/');
            var dlls = Directory.GetFiles(frameworkDir, "*.dll");

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
                    var refname = $"@{package}.{version}//:{relative}/{name}";

                    var refInfo = new RefInfo();
                    refInfo.Name = name.ToLower();
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

        private List<RefInfo> GetSdkInfos(string sdk, string package, string version)
        {
            var brokenDependencies = new string[] { };

            var result = new List<RefInfo>();

            var sdkDir = Path.Combine(sdk, "shared", package, version);
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
            await f.WriteLineAsync("load(\"@io_bazel_rules_dotnet//dotnet/private:rules/stdlib.bzl\", \"core_stdlib\")");
            await f.WriteLineAsync();
            await f.WriteLineAsync("def define_stdlib(context_data):");

            foreach (var d in libs)
            {
                var depsString = String.Join(", ", d.Deps);
                var refstring = d.Ref != null ? $"ref = \"{d.Ref}\"," : "";

                await f.WriteLineAsync(
                    $"    core_stdlib(name = \"{d.Name}\", dotnet_context_data = context_data,{refstring} deps = [{depsString}])");
            }
        }
        public string GetPackagePath(string srcdir, string package, string version)
        {
            var p = Path.Combine(srcdir, "packages", $"{package}.{version}");
            return p;
        }

        public string GetRefsDir(string srcdir, string package, string version)
        {
            var p = GetPackagePath(srcdir, package, version);
            var dir = Path.Combine(p, "ref");
            return Directory.GetDirectories(dir).OrderByDescending(x => x).First();
        }
    }
}
