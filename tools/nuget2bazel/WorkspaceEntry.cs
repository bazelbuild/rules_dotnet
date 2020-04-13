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
        public WorkspaceEntry()
        {
        }
        public WorkspaceEntry(PackageIdentity identity, string sha256, IEnumerable<PackageDependencyGroup> deps,
            IEnumerable<FrameworkSpecificGroup> libs, IEnumerable<FrameworkSpecificGroup> tools,
            IEnumerable<FrameworkSpecificGroup> references, IEnumerable<FrameworkSpecificGroup> buildFiles,
            string mainFile, string variable)
        {
            var netFrameworkTFMs = new string[]
            {
                "net45", "net451", "net452", "net46", "net461", "net462", "net47", "net471", "net472", "net48", "netstandard1.0",
                "netstandard1.1", "netstandard1.2", "netstandard1.3",
                "netstandard1.4", "netstandard1.5", "netstandard1.6", "netstandard2.0", "netstandard2.1",
            };
            var coreFrameworkTFMs = new string[]
            {
                "netcoreapp2.0", "netcoreapp2.1", "netcoreapp3.0", "netcoreapp3.1",
            };
            PackageIdentity = identity;
            Sha256 = sha256;
            Variable = variable;
            var coreFrameworks = coreFrameworkTFMs.Select(x => NuGetFramework.Parse(x));
            var netFrameworks = netFrameworkTFMs.Select(x => NuGetFramework.Parse(x));
            var monoFramework = NuGetFramework.Parse("net70");

            Core_Files = GetFiles(coreFrameworks, libs, tools, buildFiles);
            Net_Files = GetFiles(netFrameworks, libs, tools, buildFiles);
            Mono_Files = GetFiles(monoFramework, libs, tools, buildFiles);

            var depConverted = deps.Select(x =>
                new FrameworkSpecificGroup(x.TargetFramework, x.Packages.Select(y => y.Id.ToLower())));
            Core_Deps = GetDepsCore(coreFrameworks, depConverted);
            Net_Deps = GetDepsNet(netFrameworks, depConverted);
            Mono_Deps = MSBuildNuGetProjectSystemUtility.GetMostCompatibleGroup(monoFramework, depConverted)?.Items?.Select(x => ToRefMono(x));

            CoreLib = new Dictionary<string, string>();
            foreach (var framework in coreFrameworks)
            {
                var lib = GetMostCompatibleItem(framework, references, libs, mainFile);
                if (lib != null)
                    CoreLib.Add(framework.GetShortFolderName(), lib);
            }
            NetLib = new Dictionary<string, string>();
            foreach (var framework in netFrameworks)
            {
                var lib = GetMostCompatibleItem(framework, references, libs, mainFile);
                if (lib != null)
                    NetLib.Add(framework.GetShortFolderName(), lib);
            }
            MonoLib = GetMostCompatibleItem(monoFramework, references, mainFile);

            CoreTool = new Dictionary<string, string>();
            foreach (var framework in coreFrameworks)
            {
                var tool = GetMostCompatibleItem(framework, tools, mainFile);
                if (tool != null)
                    CoreTool.Add(framework.GetShortFolderName(), tool);
            }
            NetTool = new Dictionary<string, string>();
            foreach (var framework in netFrameworks)
            {
                var tool = GetMostCompatibleItem(framework, tools, mainFile);
                if (tool != null)
                    NetTool.Add(framework.GetShortFolderName(), tool);
            }
            MonoTool = GetMostCompatibleItem(monoFramework, tools, mainFile);

            if (CoreLib == null)
                CoreLib = Core_Files?.ToDictionary(key => key.Key, val => val.Value.FirstOrDefault(z => Path.GetExtension(z) == ".dll"));
            if (NetLib == null || !NetLib.Any())
                NetLib = Net_Files?.ToDictionary(key => key.Key, val => val.Value.FirstOrDefault(z => Path.GetExtension(z) == ".dll"));
            if (CoreLib == null || !CoreLib.Any())
                CoreLib = Core_Files?.ToDictionary(key => key.Key, val => val.Value.FirstOrDefault(z => Path.GetExtension(z) == ".dll"));

            if (MonoLib == null)
                MonoLib = Mono_Files?.FirstOrDefault(x => Path.GetExtension(x) == ".dll");
        }

        private IDictionary<string, IEnumerable<string>> GetDepsNet(IEnumerable<NuGetFramework> frameworks, IEnumerable<FrameworkSpecificGroup> groups)
        {
            var result = new Dictionary<string, IEnumerable<string>>();
            foreach (var framework in frameworks)
            {
                var deps = MSBuildNuGetProjectSystemUtility.GetMostCompatibleGroup(framework, groups)?.Items?.Select(x => ToRefNet(x, framework))?.Where(y => y != null);
                if (deps != null)
                    result.Add(framework.GetShortFolderName(), deps);
            }

            return result;
        }

        private IDictionary<string, IEnumerable<string>> GetDepsCore(IEnumerable<NuGetFramework> frameworks, IEnumerable<FrameworkSpecificGroup> groups)
        {
            var result = new Dictionary<string, IEnumerable<string>>();
            foreach (var framework in frameworks)
            {
                var deps = MSBuildNuGetProjectSystemUtility.GetMostCompatibleGroup(framework, groups)?.Items?.Select(x => ToRefCore(x, framework))?.Where(y => y != null);
                if (deps != null)
                    result.Add(framework.GetShortFolderName(), deps);
            }

            return result;
        }

        private IEnumerable<string> GetFiles(NuGetFramework framework,
            IEnumerable<FrameworkSpecificGroup> libs,
            IEnumerable<FrameworkSpecificGroup> tools, IEnumerable<FrameworkSpecificGroup> buildFiles)
        {
            var result = new List<string>();
            var items = MSBuildNuGetProjectSystemUtility.GetMostCompatibleGroup(framework, libs)?.Items;
            if (items != null)
                result.AddRange(items);
            items = MSBuildNuGetProjectSystemUtility.GetMostCompatibleGroup(framework, tools)?.Items;
            if (items != null)
                result.AddRange(items);
            items = MSBuildNuGetProjectSystemUtility.GetMostCompatibleGroup(framework, buildFiles)?.Items;
            if (items != null)
                result.AddRange(items);

            return result;
        }
        private IDictionary<string, IEnumerable<string>> GetFiles(IEnumerable<NuGetFramework> frameworks, IEnumerable<FrameworkSpecificGroup> libs,
            IEnumerable<FrameworkSpecificGroup> tools, IEnumerable<FrameworkSpecificGroup> buildFiles)
        {
            var result = new Dictionary<string, IEnumerable<string>>();
            foreach (var framework in frameworks)
            {
                var files = GetFiles(framework, libs, tools, buildFiles);
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
                var f = compatibleItems.FirstOrDefault(x => String.Equals(Path.GetFileName(x), mainFile, StringComparison.CurrentCultureIgnoreCase));
                if (f != null)
                    return f;
                f = compatibleItems.FirstOrDefault(x => String.Equals(Path.GetFileName(x), mainFile + ".exe", StringComparison.CurrentCultureIgnoreCase));
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

        public string Generate(bool indent)
        {
            var i = indent ? "    " : "";
            var sb = new StringBuilder();
            sb.Append($"{i}nuget_package(\n");
            if (Variable == null)
                sb.Append($"{i}    name = \"{PackageIdentity.Id.ToLower()}\",\n");
            else
                sb.Append($"{i}    name = {Variable},\n");

            sb.Append($"{i}    package = \"{PackageIdentity.Id.ToLower()}\",\n");
            sb.Append($"{i}    version = \"{PackageIdentity.Version}\",\n");
            if (!String.IsNullOrEmpty(Sha256))
                sb.Append($"{i}    sha256 = \"{Sha256}\",\n");
            if (CoreLib != null && CoreLib.Any())
            {
                sb.Append($"{i}    core_lib = {{\n");
                foreach (var pair in CoreLib)
                    sb.Append($"{i}        \"{pair.Key}\": \"{pair.Value}\",\n");
                sb.Append($"{i}    }},\n");
            }
            if (NetLib != null && NetLib.Any())
            {
                sb.Append($"{i}    net_lib = {{\n");
                foreach (var pair in NetLib)
                    sb.Append($"{i}        \"{pair.Key}\": \"{pair.Value}\",\n");
                sb.Append($"{i}    }},\n");
            }
            if (!String.IsNullOrEmpty(MonoLib))
                sb.Append($"{i}    mono_lib = \"{MonoLib}\",\n");
            if (CoreTool != null && CoreTool.Sum(x => x.Value.Count()) > 0)
            {
                sb.Append($"{i}   core_tool = {{\n");
                foreach (var pair in CoreTool)
                    sb.Append($"{i}       \"{pair.Key}\": \"{pair.Value}\",\n");
                sb.Append($"{i}   }},\n");
            }
            if (NetTool != null && NetTool.Sum(x => x.Value.Count()) > 0)
            {
                sb.Append($"{i}   net_tool = {{\n");
                foreach (var pair in NetTool)
                    sb.Append($"{i}       \"{pair.Key}\": \"{pair.Value}\",\n");
                sb.Append($"{i}   }},\n");
            }
            if (!String.IsNullOrEmpty(MonoTool))
                sb.Append($"{i}    mono_tool = \"{MonoTool}\",\n");

            if (Core_Deps != null && Core_Deps.Sum(x => x.Value.Count()) > 0)
            {
                sb.Append($"{i}    core_deps = {{\n");
                foreach (var pair in Core_Deps)
                {
                    if (!pair.Value.Any())
                        continue;

                    sb.Append($"{i}        \"{pair.Key}\": [\n");
                    foreach (var s in pair.Value)
                        sb.Append($"{i}           \"{s}\",\n");
                    sb.Append($"{i}        ],\n");
                }
                sb.Append($"{i}    }},\n");
            }

            if (Net_Deps != null && Net_Deps.Sum(x => x.Value.Count()) > 0)
            {
                sb.Append($"{i}    net_deps = {{\n");
                foreach (var pair in Net_Deps)
                {
                    if (!pair.Value.Any())
                        continue;

                    sb.Append($"{i}        \"{pair.Key}\": [\n");
                    foreach (var s in pair.Value)
                        sb.Append($"{i}           \"{s}\",\n");
                    sb.Append($"{i}        ],\n");
                }
                sb.Append($"{i}    }},\n");
            }

            if (Mono_Deps != null && Mono_Deps.Any())
            {
                sb.Append($"{i}    mono_deps = [\n");
                foreach (var s in Mono_Deps)
                    sb.Append($"{i}        \"{s}\",\n");
                sb.Append($"{i}    ],\n");
            }

            if (Core_Files != null && Core_Files.Sum(x => x.Value.Count()) > 0)
            {
                sb.Append($"{i}    core_files = {{\n");
                foreach (var pair in Core_Files)
                {
                    if (!pair.Value.Any())
                        continue;

                    sb.Append($"{i}        \"{pair.Key}\": [\n");
                    foreach (var s in pair.Value)
                        sb.Append($"{i}           \"{s}\",\n");
                    sb.Append($"{i}        ],\n");
                }
                sb.Append($"{i}    }},\n");
            }

            if (Net_Files != null && Net_Files.Sum(x => x.Value.Count()) > 0)
            {
                sb.Append($"{i}    net_files = {{\n");
                foreach (var pair in Net_Files)
                {
                    if (!pair.Value.Any())
                        continue;

                    sb.Append($"{i}        \"{pair.Key}\": [\n");
                    foreach (var s in pair.Value)
                        sb.Append($"{i}           \"{s}\",\n");
                    sb.Append($"{i}        ],\n");
                }
                sb.Append($"{i}    }},\n");
            }

            if (Mono_Files != null && Mono_Files.Any())
            {
                sb.Append($"{i}    mono_files = [\n");
                foreach (var s in Mono_Files)
                    sb.Append($"{i}        \"{s}\",\n");
                sb.Append($"{i}    ],\n");
            }
            sb.Append($"{i})\n");
            return sb.ToString();
        }

        private string ToRefCore(string id, NuGetFramework framework)
        {
            if (SdkList.Dlls.Contains(id.ToLower()))
                return null;

            return $"@{id.ToLower()}//:{framework.GetShortFolderName()}_core";
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
        public string Variable { get; set; }
        public IDictionary<string, string> CoreLib { get; set; }
        public IDictionary<string, string> NetLib { get; set; }
        public string MonoLib { get; set; }
        public IDictionary<string, string> CoreTool { get; set; }
        public IDictionary<string, string> NetTool { get; set; }
        public string MonoTool { get; set; }
        public IDictionary<string, IEnumerable<string>> Core_Deps { get; set; }
        public IDictionary<string, IEnumerable<string>> Net_Deps { get; set; }
        public IEnumerable<string> Mono_Deps { get; set; }
        public IDictionary<string, IEnumerable<string>> Core_Files { get; set; }
        public IDictionary<string, IEnumerable<string>> Net_Files { get; set; }
        public IEnumerable<string> Mono_Files { get; set; }
    }
}
