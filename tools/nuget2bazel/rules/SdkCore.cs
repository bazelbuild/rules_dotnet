using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Reflection;
using System.Text;
using System.Threading.Tasks;

namespace nuget2bazel.rules
{
    public class SdkCorePre3 : Sdk
    {
        public SdkCorePre3(string internalVersionFolder, string version, string windowsUrl, string linuxUrl,
            string darwinUrl, string darwinArmUrl, string[] packs = null) : base(internalVersionFolder, version, windowsUrl, linuxUrl,
            darwinUrl, darwinArmUrl, packs)
        {
        }

        public override async Task<List<RefInfo>> GetRefInfos(string configDir)
        {
            var package = await PackageDownloader.DownloadPackageIfNedeed(configDir, "Microsoft.NETCore.App", InternalVersionFolder);
            var sdkDir = await ZipDownloader.DownloadIfNeeded(configDir, GetDownloadUrl());

            var brokenDependencies = new string[] { "netstandard" };

            var result = new List<RefInfo>();

            var packageDir = Path.Combine(package, "packages", $"Microsoft.NETCore.App.{InternalVersionFolder}");
            var frameworkDir = Path.Combine(packageDir, "ref");
            frameworkDir = Directory.GetDirectories(frameworkDir).OrderByDescending(x => x).First();

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
                    var refname = $"@Microsoft.NETCore.App.{InternalVersionFolder}//:{relative}/{name}";
                    var stdlibpath = GetStdlibPath(sdkDir, name, InternalVersionFolder, Version);

                    var refInfo = new RefInfo();
                    refInfo.Name = name.ToLower();
                    refInfo.Version = metadata.GetName().Version.ToString();
                    refInfo.Ref = refname;
                    refInfo.StdlibPath = stdlibpath;
                    refInfo.Pack = null;
                    refInfo.Deps.AddRange(depNames);
                    result.Add(refInfo);
                }
                catch (Exception)
                {
                }
            }
            return result;
        }
        public static string GetStdlibPath(string sdk, string name, string version, string sdkVersion)
        {
            var p = Path.Combine(sdk, "shared", "Microsoft.NETCore.App", version, name);
            if (File.Exists(p))
                return $":core/shared/Microsoft.NETCore.App/{version}/{name}";

            return null;
        }
    }

    public class SdkCorePost3 : Sdk
    {
        public SdkCorePost3(string internalVersionFolder, string version, string windowsUrl, string linuxUrl,
            string darwinUrl, string darwinArmUrl = null, string[] packs = null, bool defaultSdk = false) : base(internalVersionFolder, version, windowsUrl, linuxUrl,
            darwinUrl, darwinArmUrl, packs, defaultSdk)
        {
        }

        public override async Task<List<RefInfo>> GetRefInfos(string configDir)
        {
            var result = new List<RefInfo>();
            foreach (var p in Packs)
                result.AddRange(await GetRefInfosImpl(configDir, p));

            return result;
        }

        protected async Task<List<RefInfo>> GetRefInfosImpl(string configDir, string pack)
        {
            var sdk = await ZipDownloader.DownloadIfNeeded(configDir, GetDownloadUrl());

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
                    var refname = $":core/{relative}/{name}";
                    var stdlibname = GetStdlibPath(sdk, name, pack, InternalVersionFolder, Version);

                    var refInfo = new RefInfo();
                    refInfo.Name = name.ToLower();
                    refInfo.Version = metadata.GetName().Version.ToString();
                    refInfo.Ref = refname;
                    refInfo.StdlibPath = stdlibname;
                    refInfo.Pack = pack;
                    refInfo.Deps.AddRange(depNames);
                    if (stdlibname != null)
                        result.Add(refInfo);
                }
                catch (Exception)
                {
                }
            }

            return result;
        }

        private string GetStdlibPath(string sdk, string name, string pack, string version, string sdkVersion)
        {
            var p = Path.Combine(sdk, "shared", pack.Replace(".Ref", ""), version, name);
            if (File.Exists(p))
                return $":core/shared/{pack.Replace(".Ref", "")}/{version}/{name}";

            p = Path.Combine(sdk, "shared");
            foreach (var d in Directory.GetDirectories(p))
            {
                p = Path.Combine(d, version, name);
                if (File.Exists(p))
                    return $":core/shared/{Path.GetFileName(d)}/{version}/{name}";
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
