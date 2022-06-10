using System;
using System.Threading;
using System.Threading.Tasks;
using NuGet.Common;
using NuGet.Configuration;
using NuGet.DependencyResolver;
using NuGet.Packaging;
using NuGet.Packaging.Core;
using NuGet.Packaging.Signing;
using NuGet.Protocol;
using NuGet.Protocol.Core.Types;
using NuGet.Repositories;

namespace Afas.BazelDotnet.Nuget
{
  internal class LocalPackageExtractor
  {
    private readonly NuGetv3LocalRepository _v3LocalRepository;
    private readonly SourceCacheContext _cache;
    private readonly PackageExtractionContext _context;

    public LocalPackageExtractor(ISettings settings, ILogger logger, SourceCacheContext cache)
    {
      _v3LocalRepository = new NuGetv3LocalRepository(SettingsUtility.GetGlobalPackagesFolder(settings), new LocalPackageFileCache(), false);
      _cache = cache;
      _context = new PackageExtractionContext(PackageSaveMode.Defaultv3, XmlDocFileSaveMode.Skip, ClientPolicyContext.GetClientPolicy(settings, logger), logger);
    }

    public async Task<LocalPackageSourceInfo> EnsureLocalPackage(IRemoteDependencyProvider provider,
      PackageIdentity packageIdentity)
    {
      if(!_v3LocalRepository.Exists(packageIdentity.Id, packageIdentity.Version))
      {
        var downloader = await provider.GetPackageDownloaderAsync(packageIdentity, _cache, _context.Logger, CancellationToken.None);

        var installed = await PackageExtractor.InstallFromSourceAsync(
          packageIdentity,
          downloader,
          _v3LocalRepository.PathResolver,
          _context,
          CancellationToken.None,
          Guid.NewGuid());

        // 1) If another project in this process installs the package this will return false but userPackageFolder will contain the package.
        // 2) If another process installs the package then this will also return false but we still need to update the cache.
        // For #2 double check that the cache has the package now otherwise clear
        if(installed || !_v3LocalRepository.Exists(packageIdentity.Id, packageIdentity.Version))
        {
          // If the package was added, clear the cache so that the next caller can see it.
          // Avoid calling this for packages that were not actually installed.
          _v3LocalRepository.ClearCacheForIds(new string[] { packageIdentity.Id });
        }
      }

      return NuGetv3LocalRepositoryUtility.GetPackage(new[] { _v3LocalRepository }, packageIdentity.Id, packageIdentity.Version);
    }
  }
}