using System;
using System.Collections.Generic;
using System.IO;
using System.Threading.Tasks;
using NuGet.Packaging;
using NuGet.Repositories;
using NuGet.Versioning;

namespace Afas.BazelDotnet.Nuget
{
  internal interface INugetRepositoryEntry
  {
    NuGetVersion Version { get; }
    string Id { get; }
    string ExpandedPath { get; }
    List<FrameworkSpecificGroup> RefItemGroups { get; }
    List<FrameworkSpecificGroup> RuntimeItemGroups { get; }
    List<FrameworkSpecificGroup> DebugRuntimeItemGroups { get; }
    List<FrameworkSpecificGroup> ContentFileGroups { get; }
    List<FrameworkSpecificGroup> AnalyzerItemGroups { get; }
    List<PackageDependencyGroup> DependencyGroups { get; }
    string Hash { get; }
  }

  internal class NugetRepositoryEntry : INugetRepositoryEntry
  {
    public NugetRepositoryEntry(LocalPackageSourceInfo localPackageSourceInfo,
      List<FrameworkSpecificGroup> refItemGroups = null,
      List<FrameworkSpecificGroup> runtimeItemGroups = null,
      List<FrameworkSpecificGroup> debugRuntimeItemGroups = null,
      List<FrameworkSpecificGroup> contentFileGroups = null,
      List<FrameworkSpecificGroup> analyzerItemGroups = null,
      List<PackageDependencyGroup> dependencyGroups = null)
    {
      LocalPackageSourceInfo = localPackageSourceInfo;
      RefItemGroups = refItemGroups ?? new List<FrameworkSpecificGroup>();
      RuntimeItemGroups = runtimeItemGroups ?? new List<FrameworkSpecificGroup>();
      DebugRuntimeItemGroups = debugRuntimeItemGroups ?? new List<FrameworkSpecificGroup>();
      ContentFileGroups = contentFileGroups ?? new List<FrameworkSpecificGroup>();
      AnalyzerItemGroups = analyzerItemGroups ?? new List<FrameworkSpecificGroup>();
      DependencyGroups = dependencyGroups ?? new List<PackageDependencyGroup>();
    }

    public LocalPackageSourceInfo LocalPackageSourceInfo { get; }

    public NuGetVersion Version => LocalPackageSourceInfo.Package.Version;

    public string Id => LocalPackageSourceInfo.Package.Id;

    public string ExpandedPath => LocalPackageSourceInfo.Package.ExpandedPath;

    public List<FrameworkSpecificGroup> RefItemGroups { get; }

    public List<FrameworkSpecificGroup> RuntimeItemGroups { get; }

    public List<FrameworkSpecificGroup> DebugRuntimeItemGroups { get; }

    public List<FrameworkSpecificGroup> ContentFileGroups { get; }

    public List<FrameworkSpecificGroup> AnalyzerItemGroups { get; }

    public List<PackageDependencyGroup> DependencyGroups { get; }

    public string Hash => $"sha512-{ReadHash()}";

    private string ReadHash() => File.ReadAllText(LocalPackageSourceInfo.Repository.PathResolver.GetHashPath(LocalPackageSourceInfo.Package.Id, LocalPackageSourceInfo.Package.Version)).Trim();
  }
}