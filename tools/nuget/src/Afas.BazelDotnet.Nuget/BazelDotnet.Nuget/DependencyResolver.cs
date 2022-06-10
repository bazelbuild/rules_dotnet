using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Threading.Tasks;
using NuGet.Common;
using NuGet.Configuration;
using NuGet.Credentials;
using NuGet.Frameworks;
using NuGet.Protocol.Core.Types;

namespace Afas.BazelDotnet.Nuget
{

  internal interface IDependencyResolver
  {
    Task<INugetRepositoryEntry[]> Resolve(IEnumerable<(string package, string version)> packageReferences);
  }

  internal class DependencyResolver : IDependencyResolver
  {
    private readonly string _nugetConfig;
    private readonly string _targetFramework;
    private readonly string _targetRuntime;

    public DependencyResolver(string nugetConfig, string targetFramework, string targetRuntime)
    {
      _nugetConfig = nugetConfig;
      _targetFramework = targetFramework;
      _targetRuntime = targetRuntime;
    }

    public async Task<INugetRepositoryEntry[]> Resolve(IEnumerable<(string package, string version)> packageReferences)
    {
      // allow interactions for 2 factor authentication. CI scenario should never hit this.
      bool interactive = true;

      // prevent verbose logging when there could be interactive 2 factor output shown to the user.
      ILogger logger = new ConsoleLogger(interactive ? LogLevel.Minimal : LogLevel.Debug);
      var settings = Settings.LoadSpecificSettings(Path.GetDirectoryName(_nugetConfig), Path.GetFileName(_nugetConfig));
      DefaultCredentialServiceUtility.SetupDefaultCredentialService(logger, nonInteractive: !interactive);

      // ~/.nuget/packages
      using var cache = new SourceCacheContext();

      var dependencyGraphResolver = new TransitiveDependencyResolver(settings, logger, cache);

      foreach(var (package, version) in packageReferences)
      {
        dependencyGraphResolver.AddPackageReference(package, version);
      }

      var dependencyGraph = await dependencyGraphResolver.ResolveGraph(_targetFramework, _targetRuntime).ConfigureAwait(false);
      var localPackages = await dependencyGraphResolver.DownloadPackages(dependencyGraph).ConfigureAwait(false);

      var entryBuilder = new NugetRepositoryEntryBuilder(logger, dependencyGraph.Conventions)
        .WithTarget(new FrameworkRuntimePair(NuGetFramework.Parse(_targetFramework), _targetRuntime));

      var entries = localPackages.Select(entryBuilder.ResolveGroups).ToArray();

      var (frameworkEntries, frameworkOverrides) = await new FrameworkDependencyResolver(dependencyGraphResolver)
        .ResolveFrameworkPackages(entries, _targetFramework)
        .ConfigureAwait(false);

      var overridenEntries = entries.Select(p =>
        frameworkOverrides.TryGetValue(p.LocalPackageSourceInfo.Package.Id, out var frameworkOverride)
          ? entryBuilder.BuildFrameworkOverride(p, frameworkOverride)
          : p);

      return frameworkEntries.Concat(overridenEntries).ToArray();

    }
  }
}