using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Threading.Tasks;
using Newtonsoft.Json;
using nuget2bazel;
using Xunit;

namespace nuget2bazel_test
{
    public class SyncT : TestBase
    {
        [Fact]
        public async Task DoSimpleSyncT()
        {
            var syncCmd = new SyncCommand();
            var packagesJson = new PackagesJson();
            packagesJson.dependencies = new Dictionary<string, string>();
            packagesJson.dependencies.Add("xunit.core", "2.4.1");
            packagesJson.dependencies.Add("CommandLineParser", "2.3.0");

            var packagesJsonPath = Path.Combine(_prjConfig.RootPath, _prjConfig.Nuget2BazelConfigName);
            await File.WriteAllTextAsync(packagesJsonPath, JsonConvert.SerializeObject(packagesJson));

            await syncCmd.Do(_prjConfig);

            var readback = await File.ReadAllTextAsync(packagesJsonPath);
            var readbackJson = JsonConvert.DeserializeObject<PackagesJson>(readback);

            var filtered = readbackJson.dependencies.Select(y => y.Key).ToList();
            Assert.Equal(18, filtered.Count);
            Assert.Contains("CommandLineParser", filtered);
            Assert.Contains("xunit.abstractions", filtered);
            Assert.Contains("xunit.core", filtered);
            Assert.Contains("xunit.extensibility.core", filtered);
            Assert.Contains("xunit.extensibility.execution", filtered);
        }
    }
}