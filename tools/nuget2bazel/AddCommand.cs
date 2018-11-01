using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Runtime.InteropServices.ComTypes;
using System.Text;
using System.Threading;
using System.Threading.Tasks;
using NuGet.Configuration;
using NuGet.PackageManagement;
using NuGet.Packaging.Core;
using NuGet.ProjectManagement;
using NuGet.Protocol;
using NuGet.Protocol.Core.Types;
using NuGet.Resolver;
using NuGet.Versioning;

namespace nuget2bazel
{
    public class AddCommand
    {
        public async Task Do(string package, string version, string rootPath, string mainFile)
        {
            if (rootPath == null)
                rootPath = Directory.GetCurrentDirectory();

            var logger = new Logger();
            var providers = new List<Lazy<INuGetResourceProvider>>();
            providers.AddRange(Repository.Provider.GetCoreV3());  // Add v3 API support
            var packageSource = new PackageSource("https://api.nuget.org/v3/index.json");
            var sourceRepository = new SourceRepository(packageSource, providers);
            var packageMetadataResource = await sourceRepository.GetResourceAsync<PackageMetadataResource>();
            var verParsed = NuGetVersion.Parse(version);
            var identity = new NuGet.Packaging.Core.PackageIdentity(package, verParsed);
            var content = new SourceCacheContext();
            var found = await packageMetadataResource.GetMetadataAsync(identity, content, logger, CancellationToken.None);

            var settings = Settings.LoadDefaultSettings(rootPath, null, new MachineWideSettings());
            var project = new ProjectBazel(rootPath, mainFile);
            var sourceRepositoryProvider = new SourceRepositoryProvider(settings, providers);
            var packageManager = new NuGetPackageManager(sourceRepositoryProvider, settings, rootPath)
            {
                PackagesFolderNuGetProject = project
            };

            const bool  allowPrereleaseVersions = false;
            const bool allowUnlisted = false;
            var resolutionContext = new ResolutionContext(
                DependencyBehavior.HighestMinor, allowPrereleaseVersions, allowUnlisted, VersionConstraints.None);

            var projectContext = new ProjectContext();

            var actions = await packageManager.PreviewInstallPackageAsync(packageManager.PackagesFolderNuGetProject,
                identity, resolutionContext, projectContext, sourceRepository,
                Array.Empty<SourceRepository>(),  // This is a list of secondary source respositories, probably empty
                CancellationToken.None);
            project.NuGetProjectActions = actions;

            await packageManager.InstallPackageAsync(packageManager.PackagesFolderNuGetProject,
                identity, resolutionContext, projectContext, sourceRepository,
                Array.Empty<SourceRepository>(),  // This is a list of secondary source respositories, probably empty
                CancellationToken.None);

            NuGetPackageManager.ClearDirectInstall(projectContext);

        }
    }
}
