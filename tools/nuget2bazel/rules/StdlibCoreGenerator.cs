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
                new Tuple<string, string, string>("2.0.7", "v2.1.200", "https://download.microsoft.com/download/3/7/1/37189942-C91D-46E9-907B-CF2B2DE584C7/dotnet-sdk-2.1.200-win-x64.zip"),
                new Tuple<string, string, string>("2.1.6", "v2.1.502", "https://download.visualstudio.microsoft.com/download/pr/c88b53e5-121c-4bc9-af5d-47a9d154ea64/e62eff84357c48dc8052a9c6ce5dfb8a/dotnet-sdk-2.1.502-win-x64.zip"),
                new Tuple<string, string, string>("2.1.7", "v2.1.503", "https://download.visualstudio.microsoft.com/download/pr/81e18dc2-7747-4b2d-9912-3be0f83050f1/5bc41cb27df3da63378df2d051be4b7f/dotnet-sdk-2.1.503-win-x64.zip"),
                new Tuple<string, string, string>("2.2.0", "v2.2.101", "https://download.visualstudio.microsoft.com/download/pr/25d4104d-1776-41cb-b96e-dff9e9bf1542/b878c013de90f0e6c91f6f3c98a2d592/dotnet-sdk-2.2.101-win-x64.zip"),
                new Tuple<string, string, string>("2.2.7", "v2.2.402", "https://download.visualstudio.microsoft.com/download/pr/8ac3e8b7-9918-4e0c-b1be-5aa3e6afd00f/0be99c6ab9362b3c47050cdd50cba846/dotnet-sdk-2.2.402-win-x64.zip"),
            })
            {
                await Handle(Path.Combine(_rulesPath, $"dotnet/stdlib.core/{tfm.Item2}/generated.bzl"),
                    "Microsoft.NETCore.App", tfm.Item1, tfm.Item2, tfm.Item3);
            }
        }

        private async Task Handle(string outpath, string package, string version, string sdkVersion, string sdk)
        {
            var packageDir = await PackageDownloader.DownloadPackageIfNedeed(_configDir, package, version);
            var sdkDir = await ZipDownloader.DownloadIfNedeed(_configDir, sdk);
            var refs = GetRefInfos(packageDir, package, version, sdkDir, sdkVersion);
            await GenerateBazelFile(outpath, refs);
        }

        private List<RefInfo> GetRefInfos(string srcDir, string package, string version, string sdkDir, string sdkVersion)
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
                    var stdlibpath = GetStdlibPath(sdkDir, name, version, sdkVersion);

                    var refInfo = new RefInfo();
                    refInfo.Name = name.ToLower();
                    refInfo.Version = metadata.GetName().Version.ToString();
                    refInfo.Ref = refname;
                    refInfo.StdlibPath = stdlibpath;
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
                    refInfo.Version = metadata.GetName().Version.ToString();
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
            await f.WriteLineAsync("load(\"@io_bazel_rules_dotnet//dotnet/private:rules/libraryset.bzl\", \"core_libraryset\")");
            await f.WriteLineAsync();
            await f.WriteLineAsync("def define_stdlib(context_data):");

            await f.WriteLineAsync("    core_libraryset(");
            await f.WriteLineAsync("        name = \"libraryset\",");
            await f.WriteLineAsync("        dotnet_context_data = context_data,");
            await f.WriteLineAsync("        deps = [");
            foreach (var d in libs)
            {
                await f.WriteLineAsync($"            \":{d.Name}\",");
            }
            await f.WriteLineAsync("        ],");
            await f.WriteLineAsync("    )");

            foreach (var d in libs)
            {
                await f.WriteLineAsync($"    core_stdlib(");
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

        private string GetStdlibPath(string sdk, string name, string version, string sdkVersion)
        {
            var p = Path.Combine(sdk, "shared", "Microsoft.NETCore.App", version, name);
            if (File.Exists(p))
                return $"@core_sdk_{sdkVersion}//:core/shared/Microsoft.NETCore.App/{version}/{name}";

            return null;
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
