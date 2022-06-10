using System;
using System.Collections.Generic;
using System.Diagnostics;
using System.IO;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using NuGet.Common;
using NuGet.Configuration;
using NuGet.Credentials;
using NuGet.Frameworks;
using NuGet.Protocol;
using NuGet.Protocol.Core.Types;
using NuGet.Protocol.Plugins;

namespace Afas.BazelDotnet.Nuget
{
  public class NugetRepositoryGenerator
  {
    private readonly IDependencyResolver _dependencyResolver;
    private readonly ILookup<string, (string target, string configSetting)> _imports;

    public NugetRepositoryGenerator(string nugetConfig, string targetFramework, string targetRuntime, ILookup<string, (string target, string configSetting)> imports)
      : this(new DependencyResolver(nugetConfig, targetFramework, targetRuntime), imports)
    {
    }

    private NugetRepositoryGenerator(IDependencyResolver dependencyResolver, ILookup<string, (string target, string configSetting)> imports)
    {
      _dependencyResolver = dependencyResolver;
      _imports = imports;
    }

    public async Task WriteRepository(IEnumerable<(string package, string version)> packageReferences)
    {
      var packages = await _dependencyResolver.Resolve(packageReferences).ConfigureAwait(false);

      var symlinks = new HashSet<(string link, string target)>();

      foreach(var entryGroup in packages.GroupBy(e => e.Id, StringComparer.OrdinalIgnoreCase))
      {
        var id = entryGroup.Key.ToLower();
        bool isSingle = entryGroup.Count() == 1;

        if(isSingle)
        {
          WriteBuildFile(entryGroup.Single(), id);
        }
        else
        {
          WriteBuildFile(entryGroup, id);
        }

        // Possibly link multiple versions
        foreach(var entry in entryGroup)
        {
          symlinks.Add(($"{id}/{entry.Version}", entry.ExpandedPath));

          if(isSingle)
          {
            symlinks.Add(($"{id}/current", entry.ExpandedPath));
          }
        }
      }

      File.WriteAllText("BUILD", "");

      File.WriteAllText("symlinks_manifest", string.Join("\n", symlinks
        .Select(sl => $@"{sl.link} {sl.target}")));

      File.WriteAllText("link.cmd", @"
for /F ""usebackq tokens=1,2 delims= "" %%i in (""symlinks_manifest"") do mklink /J ""%%i"" ""%%j""
exit /b %errorlevel%
");
      var proc = Process.Start(new ProcessStartInfo("cmd.exe", "/C link.cmd")
      {
        RedirectStandardOutput = true,
      });
      proc.StandardOutput.ReadToEnd();
      proc.WaitForExit();

      if(proc.ExitCode != 0)
      {
        throw new Exception("Creating symlinks exited non 0");
      }
    }

    private void WriteBuildFile(INugetRepositoryEntry entry, string id)
    {
      var content = $@"package(default_visibility = [""//visibility:public""])
load(""@io_bazel_rules_dotnet//dotnet:defs.bzl"", ""core_import_library"")

exports_files([""contentfiles.txt""])

{CreateTarget(entry)}";

      var filePath = $"{id}/BUILD";
      new FileInfo(filePath).Directory.Create();
      File.WriteAllText(filePath, content);

      // Also write a special file that lists the content files in this package.
      // This is to work around the fact that we cannot easily expose folders.
      File.WriteAllLines($"{id}/contentfiles.txt", GetContentFiles(entry).Select(v => $"current/{v}"));
    }

    private void WriteBuildFile(IGrouping<string, INugetRepositoryEntry> entryGroup, string id)
    {
      var content = $@"package(default_visibility = [""//visibility:public""])
load(""@io_bazel_rules_dotnet//dotnet:defs.bzl"", ""core_import_library"")

{string.Join("\n\n", entryGroup.Select(CreateTarget))}";

      var filePath = $"{id}/BUILD";
      new FileInfo(filePath).Directory.Create();
      File.WriteAllText(filePath, content);
    }

    private IEnumerable<string> GetContentFiles(INugetRepositoryEntry package)
    {
      var group = package.ContentFileGroups.SingleOrDefault();
      if(group?.Items.Any() == true)
      {
        // Symlink optimization to link the entire group folder e.g. contentFiles/any/netcoreapp3.1
        // We assume all files in a group have the same prefix
        //yield return string.Join('/', group.Items.First().Split('/').Take(3));

        foreach(var item in group.Items)
        {
          yield return item;
        }
      }
    }

    private string CreateTarget(INugetRepositoryEntry package)
    {
      var folder = package.Version.ToString();

      IEnumerable<string> Elems()
      {
        yield return $@"exports_files(glob([""current/**"", ""{package.Version}/**""]))";

        yield return $@"filegroup(
  name = ""content_files"",
  srcs = {StringArray(GetContentFiles(package).Select(v => $"{folder}/{v}"))},
)";

        var name = package.Id.ToLower();

        if(_imports.Contains(name))
        {
          var selects = _imports[name].ToDictionary(i => i.configSetting, i => i.target);
          name += "__nuget";
          selects["//conditions:default"] = name;

          yield return $@"alias(
  name = ""{package.Id.ToLower()}"",
  actual = select({Indent(Dict(selects))})
)";
        }

        bool hasDebugDlls = package.DebugRuntimeItemGroups.Count != 0;
        var libs = StringArray(package.RuntimeItemGroups.SingleOrDefault()?.Items.Select(v => $"{folder}/{v}"));

        if(hasDebugDlls)
        {
          yield return @"
config_setting(
  name = ""compilation_mode_dbg"",
  values = {
    ""compilation_mode"": ""dbg"",
  },
)";
          libs = Indent($@"select({{
  "":compilation_mode_dbg"": {StringArray(package.DebugRuntimeItemGroups.Single().Items.Select(v => $"{folder}/{v}"))},
  ""//conditions:default"": {libs},
}})");
        }


        yield return $@"core_import_library(
  name = ""{name}"",
  libs = {libs},
  refs = {StringArray(package.RefItemGroups.SingleOrDefault()?.Items.Select(v => v.StartsWith("//") ? v : $"{folder}/{v}"))},
  analyzers = {StringArray(package.AnalyzerItemGroups.SingleOrDefault()?.Items.Select(v => v.StartsWith("//") ? v : $"{folder}/{v}"))},
  deps = {StringArray(package.DependencyGroups.SingleOrDefault()?.Packages.Select(p => $"//{p.Id.ToLower()}"))},
  data = ["":content_files""],
  version = ""{package.Version}"",
)";
      }

      return string.Join("\n\n", Elems());
    }

    private static string Indent(string input)
    {
      var lines = input.Split('\n');
      if(lines.Length > 1)
      {
        return $"{lines[0]}\n{string.Join('\n', lines[1..].Select(l => "" + $"  {l}"))}";
      }
      return lines[0];
    }

    private static string StringArray(IEnumerable<string> items) => items?.Any() != true ? "[]" : Indent($@"[
{string.Join(",\n", items.Select(i => $@"  ""{i}"""))}
]");

    private static string Dict(IReadOnlyDictionary<string, string> items)
    {
      var s = new StringBuilder();

      s.Append("{\n");

      foreach(var (key, value) in items)
      {
        s.Append($@"  ""{key}"": ""{value}"",
");
      }

      s.Append("}");

      return s.ToString();
    }
  }
}