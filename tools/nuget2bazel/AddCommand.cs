using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Xml.Linq;
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
        public Task Do(ProjectBazelConfig prjConfig, string package, string version, string mainFile, bool skipSha256, bool lowest, string variable)
        {
            var project = new ProjectBazelManipulator(prjConfig, mainFile, skipSha256, variable);

            if(prjConfig.ProjectFiles != null)
            {
                var projectFileParser = new ProjectFileParser(prjConfig);
                var packages = projectFileParser.GetNugetPackages();
                
                var nugetTasks = packages.Select(p => DoWithProject(prjConfig.NugetSource, p.Name, p.Version, project, lowest)).ToArray();
                
                return Task.WhenAll(nugetTasks);
            }
            
            return DoWithProject(prjConfig.NugetSource, package, version, project, lowest);
        }
        public async Task DoWithProject(string nugetSource, string package, string version, ProjectBazelManipulator project, bool lowest)
        {
            var logger = new Logger();
            var providers = new List<Lazy<INuGetResourceProvider>>();
            providers.AddRange(Repository.Provider.GetCoreV3());  // Add v3 API support
            var packageSource = new PackageSource(nugetSource);
            var sourceRepository = new SourceRepository(packageSource, providers);
            var packageMetadataResource = await sourceRepository.GetResourceAsync<PackageMetadataResource>();
            var verParsed = NuGetVersion.Parse(version);
            var identity = new NuGet.Packaging.Core.PackageIdentity(package, verParsed);
            var content = new SourceCacheContext();
            var found = await packageMetadataResource.GetMetadataAsync(identity, content, logger, CancellationToken.None);

            //var settings = Settings.LoadDefaultSettings(project.ProjectConfig.RootPath, null, new MachineWideSettings());
            var settings = Settings.LoadDefaultSettings(project.ProjectConfig.RootPath, null, null);
            var sourceRepositoryProvider = new SourceRepositoryProvider(settings, providers);
            var packageManager = new NuGetPackageManager(sourceRepositoryProvider, settings, project.ProjectConfig.RootPath)
            {
                PackagesFolderNuGetProject = project
            };

            const bool allowPrereleaseVersions = false;
            const bool allowUnlisted = false;
            var resolutionContext = new ResolutionContext(
                lowest ? DependencyBehavior.Lowest : DependencyBehavior.HighestMinor, allowPrereleaseVersions, allowUnlisted, VersionConstraints.None);

            var projectContext = new ProjectContext(settings);

            var actions = await packageManager.PreviewInstallPackageAsync(packageManager.PackagesFolderNuGetProject,
                identity, resolutionContext, projectContext, sourceRepository,
                sourceRepositoryProvider.GetRepositories(),
                CancellationToken.None);
            project.NuGetProjectActions = actions;

            await packageManager.InstallPackageAsync(packageManager.PackagesFolderNuGetProject,
                identity, resolutionContext, projectContext, sourceRepository,
                sourceRepositoryProvider.GetRepositories(),
                CancellationToken.None);

            NuGetPackageManager.ClearDirectInstall(projectContext);

        }
    }
}
