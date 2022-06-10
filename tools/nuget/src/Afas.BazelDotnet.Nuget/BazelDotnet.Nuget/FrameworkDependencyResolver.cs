using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Text.RegularExpressions;
using System.Threading.Tasks;
using System.Xml.Linq;
using NuGet.Frameworks;
using NuGet.Packaging;
using NuGet.Packaging.Core;
using NuGet.Repositories;
using NuGet.Versioning;

namespace Afas.BazelDotnet.Nuget
{
  internal class FrameworkDependencyResolver
  {
    private static readonly IReadOnlyDictionary<string, string> _frameworkReferenceTargetPackMap = new Dictionary<string, string>(StringComparer.OrdinalIgnoreCase)
    {
      ["Microsoft.NETCore.App"] = "Microsoft.NETCore.App.Ref",
      ["Microsoft.AspNetCore.App"] = "Microsoft.AspNetCore.App.Ref",
    };

    private readonly TransitiveDependencyResolver _dependencyResolver;

    internal FrameworkDependencyResolver(TransitiveDependencyResolver dependencyResolver)
    {
      _dependencyResolver = dependencyResolver;
    }

    private static string GetFrameworkVersion(string targetFramework)
    {
      var match = Regex.Match(targetFramework, "(?:net|netcoreapp)([0-9]+\\.[0-9]+)");

      if(!match.Success)
      {
        throw new Exception($"Unsupported targetFramework {targetFramework}");
      }

      return $"{match.Groups[1].Value}.0";
    }

    public async Task<(IReadOnlyCollection<NugetRepositoryEntry> entries, IReadOnlyDictionary<string, string> overrides)> ResolveFrameworkPackages(
      IReadOnlyCollection<NugetRepositoryEntry> localPackages, string targetFramework)
    {
      var existingPackagesLookup = localPackages.ToDictionary(l => l.LocalPackageSourceInfo.Package.Id, l => l, StringComparer.OrdinalIgnoreCase);
      var entries = new List<NugetRepositoryEntry>();
      var overrides = new Dictionary<string, string>(StringComparer.OrdinalIgnoreCase);

      // Resolve distinct FrameworkReferences from each nuget package
      var localTargetPackages = await Task.WhenAll(
        GetTargetPackages(localPackages)
          .Select(p => DownloadTargetPackage(p, targetFramework))
      ).ConfigureAwait(false);

      foreach(var targetPackage in localTargetPackages)
      {
        var frameworkList = GetFrameworkList(targetPackage, targetFramework);
        var packageOverrides = GetPackageOverrides(targetPackage);

        // Resolve overrides as specified in the TargetPackage (FrameworkReference) data/PackageOverrides.txt
        foreach(var (id, packageOverride) in packageOverrides)
        {
          // The override does not apply since there is nothing to override
          if(!existingPackagesLookup.TryGetValue(id, out var existingPackage))
          {
            continue;
          }

          var existingPackageIsEmpty = existingPackage.RefItemGroups.SingleOrDefault()?.Items.Any() != true;
          if(existingPackageIsEmpty || packageOverride >= existingPackage.Version)
          {
            if(frameworkList.TryGetValue(id, out var frameworkItem))
            {
              // override to a binary from this TargetPackage (data/FrameworkList.xml)
              overrides.Add(id, $"//{targetPackage.Package.Id.ToLower()}:current/{frameworkItem.file}");
            }
            else
            {
              // override to null, resulting in dropping the binary reference
              overrides.Add(id, null);
            }
          }
        }

        // Keep track of a list of packages that have higher versions than the TargetPackage provided ones
        // These binaries are dropped from the TargetPackage and redirected (using deps) to the nuget package
        var upgrades = new HashSet<string>();

        // Resolve conflicts using the assembly version
        foreach(var (id, (assemblyName, assemblyVersion)) in frameworkList)
        {
          // No conflict
          if(!existingPackagesLookup.TryGetValue(id, out var existingPackage))
          {
            continue;
          }

          // Handled by the overrides, no conflict
          if(overrides.ContainsKey(id))
          {
            continue;
          }

          if(OverridesAssemblyVersion(existingPackage, assemblyVersion))
          {
            overrides.Add(id, $"//{targetPackage.Package.Id.ToLower()}:current/{assemblyName}");
          }
          else
          {
            upgrades.Add(id);
          }
        }

        entries.Add(
          BuildEntry(targetPackage, targetFramework, frameworkList, upgrades)
        );
      }

      return (entries, overrides);

      bool OverridesAssemblyVersion(NugetRepositoryEntry package, Version frameworkListVersion)
      {
        var refItems = package.RefItemGroups.Single();
        if(!refItems.Items.Any())
        {
          return true;
        }
        var refAssembly = refItems.Items.Single();

        var conflictingFile = $"{package.LocalPackageSourceInfo.Package.ExpandedPath}/{refAssembly}";
        var conflictingVersion = FileUtilities.GetAssemblyVersion(conflictingFile);

        return frameworkListVersion >= conflictingVersion;
      }
    }

    private IEnumerable<string> GetTargetPackages(IReadOnlyCollection<NugetRepositoryEntry> localPackages)
    {
      // see core_sdk\core\sdk\3.1.100\Microsoft.NETCoreSdk.BundledVersions.props
      var frameworkRefs = localPackages
        // TODO consider target framework when multiple specified
        .SelectMany(l => l.LocalPackageSourceInfo.Package.Nuspec
          .GetFrameworkRefGroups()
          .SelectMany(g => g.FrameworkReferences))
        // Temp solution: this is not included in packages props and should be included as an additional argument instead
        .Prepend(new FrameworkReference("Microsoft.AspNetCore.App"))
        .Distinct()
        // Implicit dependency of al netcoreapp projects
        .Prepend(new FrameworkReference("Microsoft.NETCore.App"))
        .ToArray();
      return frameworkRefs.Select(r => _frameworkReferenceTargetPackMap[r.Name]);
    }

    private NugetRepositoryEntry BuildEntry(
      LocalPackageSourceInfo targetPackage,
      string targetFramework,
      Dictionary<string, (string file, Version version)> frameworkList,
      HashSet<string> upgrades)
    {
      var nuGetFramework = NuGetFramework.Parse(targetFramework);
      var entry = new NugetRepositoryEntry(targetPackage);
      entry.RefItemGroups.Add(new FrameworkSpecificGroup(
        nuGetFramework,
        frameworkList.Where(pair => !upgrades.Contains(pair.Key)).Select(pair => pair.Value.file).ToArray()));
      entry.DependencyGroups.Add(new PackageDependencyGroup(
        nuGetFramework,
        upgrades.Select(id => new PackageDependency(id)).ToArray()));
      return entry;
    }

    private async Task<LocalPackageSourceInfo> DownloadTargetPackage(string targetPackId, string targetFramework)
    {
      var packGraph = await _dependencyResolver
        .ResolveFrameworkReference(targetPackId, GetFrameworkVersion(targetFramework), targetFramework).ConfigureAwait(false);

      var packNode = packGraph.Flattened.Single();
      return await _dependencyResolver.DownloadPackage(packNode).ConfigureAwait(false);
    }

    private Dictionary<string, (string file, Version version)> GetFrameworkList(LocalPackageSourceInfo targetPackage, string targetFramework)
    {
      var frameworkListPath = "data/FrameworkList.xml";

      if(!targetPackage.Package.Files.Contains(frameworkListPath))
      {
        throw new Exception($"No data/FrameworkList.xml found in {targetPackage.Package.Id}");
      }

      return XDocument.Load(Path.Combine(targetPackage.Package.ExpandedPath, frameworkListPath))
        .Descendants("File")
        .Where(f => !string.Equals(f.Attribute("Type").Value, "Analyzer", StringComparison.OrdinalIgnoreCase))
        .ToDictionary(
          f => f.Attribute("AssemblyName").Value,
          f => (file: FixPath(f.Attribute("Path").Value), version: Version.Parse(f.Attribute("AssemblyVersion").Value)),
          StringComparer.OrdinalIgnoreCase);

      // Some inconsistency in FrameworkList
      string FixPath(string v) => v.StartsWith("ref/") ? v : $"ref/{targetFramework}/{v}";
    }

    private IReadOnlyDictionary<string, NuGetVersion> GetPackageOverrides(LocalPackageSourceInfo targetPackage)
    {
      var packageOverridesPath = "data/PackageOverrides.txt";

      if(!targetPackage.Package.Files.Contains(packageOverridesPath))
      {
        return new Dictionary<string, NuGetVersion>();
      }

      return File.ReadAllLines(Path.Combine(targetPackage.Package.ExpandedPath, packageOverridesPath))
        .Select(l => l.Split("|"))
        .ToDictionary(s => s[0], s => NuGetVersion.Parse(s[1]), StringComparer.OrdinalIgnoreCase);
    }

    public static PackageDependency ConvertToDependency(FrameworkReference framework) =>
      new PackageDependency(_frameworkReferenceTargetPackMap[framework.Name]);
  }
}
