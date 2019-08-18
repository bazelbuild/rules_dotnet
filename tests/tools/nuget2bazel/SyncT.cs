using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Threading.Tasks;
using Newtonsoft.Json;
using Xunit;

namespace nuget2bazel
{
    public class SyncT: IDisposable
    {
        private string _root;
        public void Dispose()
        {
            Directory.Delete(_root, true);
        }

        public SyncT()
        {
            _root = Path.Combine(Path.GetTempPath(), Path.GetRandomFileName());
            Directory.CreateDirectory(_root);
            // Nuget libraries require HOME set
            Environment.SetEnvironmentVariable("HOME", _root);
        }


        [Fact]
        public async Task DoSimpleSyncT()
        {
            var syncCmd = new SyncCommand();
            var packagesJson = new PackagesJson();
            packagesJson.dependencies = new Dictionary<string, string>();
            packagesJson.dependencies.Add("xunit.core", "2.4.1");
            packagesJson.dependencies.Add("CommandLineParser", "2.3.0");
            packagesJson.dependencies.Add("System.Console", "4.3.1");

            var packagesJsonPath = Path.Combine(_root, "packages.json");
            await File.WriteAllTextAsync(packagesJsonPath, JsonConvert.SerializeObject(packagesJson));
            
            await syncCmd.Do(_root);

            var readback = await File.ReadAllTextAsync(packagesJsonPath);
            var readbackJson = JsonConvert.DeserializeObject<PackagesJson>(readback);

            var filtered = readbackJson.dependencies.Where(x => !SdkList.Dlls.Contains(x.Key.ToLower())).Select(y => y.Key).ToList();
            Assert.Equal(5, filtered.Count);
            Assert.Contains("CommandLineParser", filtered);
            Assert.Contains("xunit.abstractions", filtered);
            Assert.Contains("xunit.core", filtered);
            Assert.Contains("xunit.extensibility.core", filtered);
            Assert.Contains("xunit.extensibility.execution", filtered);
        }
    }
}