using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Runtime.InteropServices.ComTypes;
using System.Text;
using System.Threading;
using System.Threading.Tasks;
using Newtonsoft.Json;
using NuGet.Common;
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
    public class PackagesJson
    {
        public Dictionary<string, string> dependencies { get; set; }
    }

    public class SyncCommand
    {
        public async Task Do(ProjectBazelConfig prjConfig)
        {
            var logger = new Logger();

            var packagesJsonPath = Path.Combine(prjConfig.RootPath, prjConfig.Nuget2BazelConfigName);
            var s = await File.ReadAllTextAsync(packagesJsonPath);
            var packagesJson = JsonConvert.DeserializeObject<PackagesJson>(s);

            foreach (var d in packagesJson.dependencies)
                await Delete(logger, d.Key, prjConfig);

            foreach (var d in packagesJson.dependencies)
                await Add(logger, d.Key, d.Value, prjConfig);
        }

        private async Task Delete(ILogger logger, string package, ProjectBazelConfig prjConfig)
        {
            try
            {
                var cmd = new DeleteCommand();
                await cmd.Do(prjConfig, package);
            }
            catch (Exception ex)
            {
                logger.LogError($"Exception on deleting {package}");
                logger.LogError(ex.ToString());
            }

        }
        private async Task Add(ILogger logger, string package, string version, ProjectBazelConfig prjConfig)
        {
            try
            {
                var cmd = new AddCommand();
                await cmd.Do(prjConfig, package, version, null, true, false, null);
            }
            catch (Exception ex)
            {
                logger.LogError($"Exception on adding {package}:{version}");
                logger.LogError(ex.ToString());
            }
        }

    }
}
