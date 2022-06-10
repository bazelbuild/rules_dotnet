using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using NuGet.Commands;
using NuGet.Common;
using NuGet.Configuration;
using NuGet.DependencyResolver;
using NuGet.Frameworks;
using NuGet.LibraryModel;
using NuGet.Packaging.Core;
using NuGet.ProjectModel;
using NuGet.Protocol;
using NuGet.Protocol.Core.Types;
using NuGet.Repositories;
using NuGet.RuntimeModel;
using NuGet.Versioning;

namespace Afas.BazelDotnet.Nuget
{
  internal class TransitiveDependencyResolver
  {
    private const string _rootProjectName = "Root";
    private const string _rootProjectVersion = "1.0.0";

    private readonly RemoteWalkContext _context;
    private readonly LocalPackageExtractor _localPackageExtractor;
    private readonly List<LibraryRange> _packages;

    public TransitiveDependencyResolver(ISettings settings, ILogger logger, SourceCacheContext cache)
    {
      _context = CreateRemoteWalkContext(settings, cache, logger);
      _localPackageExtractor = new LocalPackageExtractor(settings, _context.Logger, _context.CacheContext);
      _packages = new List<LibraryRange>();
    }

    public TransitiveDependencyResolver AddPackageReference(string package, string version)
    {
      _packages.Add(new LibraryRange(package, VersionRange.Parse(version), LibraryDependencyTarget.Package));
      return this;
    }

    public async Task<RestoreTargetGraph> ResolveFrameworkReference(string id, string version, string targetFramework)
    {
      var nugetTargetFramework = NuGetFramework.Parse(targetFramework);
      return await GetIndependentGraph(id, version, nugetTargetFramework, _context).ConfigureAwait(false);
    }

    public async Task<RestoreTargetGraph> ResolveGraph(string targetFramework, string targetRuntime = null)
    {
      var nugetTargetFramework = NuGetFramework.Parse(targetFramework);
      PrepareRootProject(nugetTargetFramework);

      var independentGraph = await GetIndependentGraph(_rootProjectName, _rootProjectVersion, nugetTargetFramework, _context).ConfigureAwait(false);

      if(string.IsNullOrEmpty(targetRuntime))
      {
        return independentGraph;
      }

      // We could target multiple runtimes with RuntimeGraph.Merge
      var platformSpecificGraph = await GetPlatformSpecificGraph(independentGraph, _rootProjectName, _rootProjectVersion,
          nugetTargetFramework, targetRuntime, _context, _localPackageExtractor)
        .ConfigureAwait(false);

      return platformSpecificGraph;
    }

    public async Task<IReadOnlyCollection<LocalPackageSourceInfo>> DownloadPackages(RestoreTargetGraph dependencyGraph)
    {
      return await Task.WhenAll(dependencyGraph.Flattened
        .Where(i => !string.Equals(i.Key.Name, _rootProjectName, StringComparison.OrdinalIgnoreCase))
        .Select(DownloadPackage));
    }

    public Task<LocalPackageSourceInfo> DownloadPackage(GraphItem<RemoteResolveResult> item) =>
      _localPackageExtractor.EnsureLocalPackage(item.Data.Match.Provider, ToPackageIdentity(item.Data.Match));

    private void PrepareRootProject(NuGetFramework targetFramework)
    {
      PackageSpec project = new PackageSpec(new List<TargetFrameworkInformation>
      {
        new TargetFrameworkInformation
        {
          FrameworkName = targetFramework,
        }
      });
      project.Name = _rootProjectName;
      project.Version = NuGetVersion.Parse(_rootProjectVersion);

      project.Dependencies = _packages.Select(package => new LibraryDependency
        {
          LibraryRange = package,
          Type = LibraryDependencyType.Build,
          IncludeType = LibraryIncludeFlags.None,
          SuppressParent = LibraryIncludeFlags.All,
          AutoReferenced = true,
          GeneratePathProperty = false,
        })
        .ToList();

      // In case we get re-used we clear the previous value first
      _context.ProjectLibraryProviders.Clear();
      _context.ProjectLibraryProviders.Add(new PackageSpecReferenceDependencyProvider(new[]
      {
        new ExternalProjectReference(
          project.Name,
          project,
          msbuildProjectPath: null,
          projectReferences: Enumerable.Empty<string>()),
      }, _context.Logger));
    }

    private RemoteWalkContext CreateRemoteWalkContext(ISettings settings, SourceCacheContext cache, ILogger logger)
    {
      // nuget.org etc.
      var globalPackagesFolder = SettingsUtility.GetGlobalPackagesFolder(settings);
      var localRepository = Repository.Factory.GetCoreV3(globalPackagesFolder, FeedType.FileSystemV3);
      var sourceRepositoryProvider = new SourceRepositoryProvider(new PackageSourceProvider(settings), Repository.Provider.GetCoreV3());

      var context = new RemoteWalkContext(cache, logger);

      context.LocalLibraryProviders.Add(new SourceRepositoryDependencyProvider(localRepository, logger, cache,
        ignoreFailedSources: true,
        fileCache: new LocalPackageFileCache(),
        ignoreWarning: true,
        isFallbackFolderSource: false));

      foreach(var remoteRepository in sourceRepositoryProvider.GetRepositories())
      {
        context.RemoteLibraryProviders.Add(new SourceRepositoryDependencyProvider(remoteRepository, logger, cache,
          ignoreFailedSources: cache.IgnoreFailedSources,
          fileCache: new LocalPackageFileCache(),
          ignoreWarning: false,
          isFallbackFolderSource: false));
      }

      return context;
    }

    private async Task<RestoreTargetGraph> GetIndependentGraph(string package, string version, NuGetFramework nuGetFramework, RemoteWalkContext context)
    {
      var result = await new RemoteDependencyWalker(context).WalkAsync(
        new LibraryRange(package, VersionRange.Parse(version), LibraryDependencyTarget.All),
        nuGetFramework,
        runtimeGraph: RuntimeGraph.Empty,
        recursive: true,
        runtimeIdentifier: null);

      return RestoreTargetGraph.Create(RuntimeGraph.Empty, new[]
      {
        result
      }, _context, _context.Logger, nuGetFramework, runtimeIdentifier: null);
    }

    private static async Task<RestoreTargetGraph> GetPlatformSpecificGraph(RestoreTargetGraph independentGraph,
      string package, string version, NuGetFramework framework, string runtimeIdentifier,
      RemoteWalkContext context, LocalPackageExtractor extractor)
    {
      var graphTask = independentGraph.Flattened
        .Where(m => m.Data?.Match?.Library?.Type == LibraryType.Package)
        .Select(GetRuntimeGraphTask);

      var graphs = (await Task.WhenAll(graphTask))
        .Where(i => i != null);

      var runtimeGraph = graphs.Aggregate(RuntimeGraph.Empty, RuntimeGraph.Merge);

      // This results in additional entries
      var resultWin = await new RemoteDependencyWalker(context).WalkAsync(
        new LibraryRange(package, VersionRange.Parse(version), LibraryDependencyTarget.All),
        framework,
        runtimeGraph: runtimeGraph,
        recursive: true,
        runtimeIdentifier: runtimeIdentifier);

      return RestoreTargetGraph.Create(runtimeGraph, new[]
      {
        resultWin
      }, context, context.Logger, framework, runtimeIdentifier);

      async Task<RuntimeGraph> GetRuntimeGraphTask(GraphItem<RemoteResolveResult> item)
      {
        var packageIdentity = ToPackageIdentity(item.Data.Match);

        var localPackageSourceInfo = await extractor.EnsureLocalPackage(item.Data.Match.Provider, packageIdentity);

        return localPackageSourceInfo?.Package?.RuntimeGraph;
      }
    }

    private static PackageIdentity ToPackageIdentity(RemoteMatch match)
    {
      return new PackageIdentity(match.Library.Name, match.Library.Version);
    }
  }
}