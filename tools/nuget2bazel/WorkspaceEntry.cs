using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using CommandLine;
using NuGet.Frameworks;
using NuGet.Packaging;
using NuGet.Packaging.Core;
using NuGet.ProjectManagement;

namespace nuget2bazel
{
    public class WorkspaceEntry
    {
        private readonly bool _skipSha;

        public WorkspaceEntry()
        {
        }
        public WorkspaceEntry(PackageIdentity identity, string sha256, IEnumerable<PackageDependencyGroup> deps,
            IEnumerable<FrameworkSpecificGroup> libs, IEnumerable<FrameworkSpecificGroup> tools, IEnumerable<FrameworkSpecificGroup> references,
            string mainFile, bool skipSHA)
        {
            _skipSha = skipSHA;
            var netFrameworkTFMs = new string[]
            {
                "net45", "net451", "net452", "net46", "net461", "net462", "net47", "net471", "net472", "netstandard1.0",
                "netstandard1.1", "netstandard1.2", "netstandard1.3",
                "netstandard1.4", "netstandard1.5", "netstandard1.6", "netstandard2.0",
            };
            PackageIdentity = identity;
            Sha256 = sha256;

            var coreFramework = NuGetFramework.Parse("netcoreapp5.0");
            var netFrameworks = netFrameworkTFMs.Select(x => NuGetFramework.Parse(x));
            var monoFramework = NuGetFramework.Parse("net70");

            Core_Files = GetFiles(coreFramework, libs, tools);
            Net_Files = GetFiles(netFrameworks, libs, tools);
            Mono_Files = GetFiles(monoFramework, libs, tools);

            var depConverted = deps.Select(x =>
                new FrameworkSpecificGroup(x.TargetFramework, x.Packages.Select(y => y.Id.ToLower())));
            Core_Deps = MSBuildNuGetProjectSystemUtility.GetMostCompatibleGroup(coreFramework, depConverted)?.Items?.Select(x => ToRefCore(x));
            Net_Deps = GetDeps(netFrameworks, depConverted);
            Mono_Deps = MSBuildNuGetProjectSystemUtility.GetMostCompatibleGroup(monoFramework, depConverted)?.Items?.Select(x => ToRefMono(x));

            CoreLib = GetMostCompatibleItem(coreFramework, references, libs, mainFile);
            NetLib = new Dictionary<string, string>();
            foreach (var framework in netFrameworks)
            {
                var lib = GetMostCompatibleItem(framework, references, libs, mainFile);
                if (lib != null)
                    NetLib.Add(framework.GetShortFolderName(), lib);
            }
            MonoLib = GetMostCompatibleItem(monoFramework, references, mainFile);

            CoreTool = GetMostCompatibleItem(coreFramework, tools, mainFile);
            NetTool = new Dictionary<string, string>();
            foreach (var framework in netFrameworks)
            {
                var tool = GetMostCompatibleItem(framework, tools, mainFile);
                if (tool != null)
                    NetTool.Add(framework.GetShortFolderName(), tool);
            }
            MonoTool = GetMostCompatibleItem(monoFramework, tools, mainFile);

            if (CoreLib == null)
                CoreLib = Core_Files?.FirstOrDefault(x => Path.GetExtension(x) == ".dll");
            if (NetLib == null || !NetLib.Any())
                NetLib = Net_Files?.ToDictionary(key => key.Key, val => val.Value.FirstOrDefault(z => Path.GetExtension(z) == ".dll"));
            if (CoreLib == null)
                CoreLib = NetLib.Values.FirstOrDefault();

            if (MonoLib == null)
                MonoLib = Mono_Files?.FirstOrDefault(x => Path.GetExtension(x) == ".dll");
        }

        private IDictionary<string, IEnumerable<string>> GetDeps(IEnumerable<NuGetFramework> frameworks, IEnumerable<FrameworkSpecificGroup> groups)
        {
            var result = new Dictionary<string, IEnumerable<string>>();
            foreach (var framework in frameworks)
            {
                var deps = MSBuildNuGetProjectSystemUtility.GetMostCompatibleGroup(framework, groups)?.Items?.Select(x => ToRefNet(x, framework))?.Where(y => y!=null);
                if (deps != null)
                    result.Add(framework.GetShortFolderName(), deps);
            }

            return result;
        }

        private IEnumerable<string> GetFiles(NuGetFramework framework, IEnumerable<FrameworkSpecificGroup> libs,
            IEnumerable<FrameworkSpecificGroup> tools)
        {
            var result = new List<string>();
            var items = MSBuildNuGetProjectSystemUtility.GetMostCompatibleGroup(framework, libs)?.Items;
            if (items != null)
                result.AddRange(items);
            items = MSBuildNuGetProjectSystemUtility.GetMostCompatibleGroup(framework, tools)?.Items;
            if (items != null)
                result.AddRange(items);

            return result;
        }
        private IDictionary<string, IEnumerable<string>> GetFiles(IEnumerable<NuGetFramework> frameworks, IEnumerable<FrameworkSpecificGroup> libs,
            IEnumerable<FrameworkSpecificGroup> tools)
        {
            var result = new Dictionary<string, IEnumerable<string>>();
            foreach (var framework in frameworks)
            {
                var files = GetFiles(framework, libs, tools);
                if (files != null && files.Any())
                    result.Add(framework.GetShortFolderName(), files);

            }

            return result;
        }

        private string GetMostCompatibleItem(NuGetFramework framework, IEnumerable<FrameworkSpecificGroup> items, string mainFile)
        {
            var compatibleItems = MSBuildNuGetProjectSystemUtility.GetMostCompatibleGroup(framework, items)?.Items;
            if (compatibleItems == null)
                return null;

            if (mainFile != null)
            {
                var f = compatibleItems.FirstOrDefault(x => String.Equals(Path.GetFileName(x), mainFile+".exe", StringComparison.CurrentCultureIgnoreCase));
                if (f != null)
                    return f;
                f = compatibleItems.FirstOrDefault(x => String.Equals(Path.GetFileName(x), mainFile + ".dll", StringComparison.CurrentCultureIgnoreCase));
                if (f != null)
                    return f;
            }

            return compatibleItems.FirstOrDefault(x => Path.GetExtension(x) == ".dll");
        }

        private string GetMostCompatibleItem(NuGetFramework framework, IEnumerable<FrameworkSpecificGroup> refs, IEnumerable<FrameworkSpecificGroup> libs,
            string mainFile)
        {
            var result = GetMostCompatibleItem(framework, refs, mainFile);
            if (result != null) return result;

            result = GetMostCompatibleItem(framework, libs, mainFile);
            return result;
        }

        public string Generate()
        {
            var sb = new StringBuilder();
            sb.Append($"nuget_package(\n");
            sb.Append($"    name = \"{PackageIdentity.Id.ToLower()}\",\n");
            sb.Append($"    package = \"{PackageIdentity.Id.ToLower()}\",\n");
            sb.Append($"    version = \"{PackageIdentity.Version}\",\n");
            if (!String.IsNullOrEmpty(Sha256)) 
                sb.Append($"    sha256 = \"{Sha256}\",\n");
            if (!String.IsNullOrEmpty(CoreLib))
                sb.Append($"    core_lib = \"{CoreLib}\",\n");
            if (!String.IsNullOrEmpty(NetLib))
                sb.Append($"    net_lib = \"{NetLib}\",\n");
            if (!String.IsNullOrEmpty(MonoLib))
                sb.Append($"    mono_lib = \"{MonoLib}\",\n");
            if (!String.IsNullOrEmpty(CoreTool))
                sb.Append($"    core_tool = \"{CoreTool}\",\n");
            if (NetTool != null && NetTool.Sum(x => x.Value.Count())> 0)
            {
                sb.Append("   net_tool = {\n");
                foreach (var pair in NetTool)
                    sb.Append($"       \"{pair.Key}\": \"{pair.Value}\",\n");
                sb.Append("   },\n");
            }
            if (!String.IsNullOrEmpty(MonoTool))
                sb.Append($"    mono_tool = \"{MonoTool}\",\n");

            if (Core_Deps != null && Core_Deps.Any())
            {
                sb.Append($"    core_deps = [\n");
                foreach (var s in Core_Deps)
                    sb.Append($"        \"{s}\",\n");
                sb.Append($"    ],\n");
            }

            if (Net_Deps != null && Net_Deps.Sum(x => x.Value.Count())>0)
            {
                sb.Append("    net_deps = {\n");
                foreach (var pair in Net_Deps)
                {
                    if (!pair.Value.Any())
                        continue;

                    sb.Append($"        \"{pair.Key}\": [\n");
                    foreach (var s in pair.Value)
                        sb.Append($"           \"{s}\",\n");
                    sb.Append("        ],\n");
                }
                sb.Append("    },\n");
            }

            if (Mono_Deps != null && Mono_Deps.Any())
            {
                sb.Append($"    mono_deps = [\n");
                foreach (var s in Mono_Deps)
                    sb.Append($"        \"{s}\",\n");
                sb.Append($"    ],\n");
            }

            if (Core_Files != null && Core_Files.Any())
            {
                sb.Append($"    core_files = [\n");
                foreach (var s in Core_Files)
                    sb.Append($"        \"{s}\",\n");
                sb.Append($"    ],\n");
            }

            if (Net_Files != null && Net_Files.Sum(x => x.Value.Count()) > 0)
            {
                sb.Append("    net_files = {\n");
                foreach (var pair in Net_Files)
                {
                    if (!pair.Value.Any())
                        continue;

                    sb.Append($"        \"{pair.Key}\": [\n");
                    foreach (var s in pair.Value)
                        sb.Append($"           \"{s}\",\n");
                    sb.Append("        ],\n");
                }
                sb.Append("    },\n");
            }

            if (Mono_Files != null && Mono_Files.Any())
            {
                sb.Append($"    mono_files = [\n");
                foreach (var s in Mono_Files)
                    sb.Append($"        \"{s}\",\n");
                sb.Append($"    ],\n");
            }
            sb.Append($")\n");
            return sb.ToString();
        }

        private string ToRefCore(string id)
        {
            if (SdkList.Dlls.Contains(id.ToLower()))
                return $"@io_bazel_rules_dotnet//dotnet/stdlib.core:{id.ToLower()}.dll";

            return $"@{id.ToLower()}//:core";
        }

        private string ToRefMono(string id)
        {
            if (SdkList.Dlls.Contains(id.ToLower()))
                return $"@io_bazel_rules_dotnet//dotnet/stdlib:{id.ToLower()}.dll";

            return $"@{id.ToLower()}//:mono";
        }

        private string ToRefNet(string id, NuGetFramework framework)
        {
            // netstandard.library must be manually handled
            if (id == "netstandard.library")
                return null;

            if (SdkList.Dlls.Contains(id.ToLower()))
            {
                if (framework.Framework == ".NETFramework")
                    return $"@io_bazel_rules_dotnet//dotnet/stdlib.net:{framework.GetShortFolderName()}_{id.ToLower()}.dll";
                // ".NETStandard"
                return null;
            }

            return $"@{id.ToLower()}//:{framework.GetShortFolderName()}_net";
        }

        public PackageIdentity PackageIdentity { get; set; }
        public string Sha256 { get; set; }
        public string CoreLib { get; set; }
        public IDictionary<string, string> NetLib { get; set; }
        public string MonoLib { get; set; }
        public string CoreTool { get; set; }
        public IDictionary<string, string> NetTool { get; set; }
        public string MonoTool { get; set; }
        public IEnumerable<string> Core_Deps { get; set; }
        public IDictionary<string, IEnumerable<string>> Net_Deps { get; set; }
        public IEnumerable<string> Mono_Deps { get; set; }
        public IEnumerable<string> Core_Files { get; set; }
        public IDictionary<string, IEnumerable<string>> Net_Files { get; set; }
        public IEnumerable<string> Mono_Files { get; set; }
    }
}
