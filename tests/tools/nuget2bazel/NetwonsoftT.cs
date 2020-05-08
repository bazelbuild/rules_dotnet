using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Threading.Tasks;
using Xunit;

namespace nuget2bazel
{
    public class NewtonsoftT : IDisposable
    {
        private ProjectBazelConfig _prjConfig;
        public void Dispose()
        {
            Directory.Delete(_prjConfig.RootPath, true);
        }

        public NewtonsoftT()
        {
            var root = Path.Combine(Path.GetTempPath(), Path.GetRandomFileName());
            Directory.CreateDirectory(root);
            _prjConfig = new ProjectBazelConfig(root);

            // Nuget libraries require HOME ans some other variables set
            Environment.SetEnvironmentVariable("HOME", root);
            Environment.SetEnvironmentVariable("DOTNET_CLI_HOME", root);
            Environment.SetEnvironmentVariable("APPDATA", Path.Combine(root, ".nuget"));
            Environment.SetEnvironmentVariable("PROGRAMFILES", Path.Combine(root, ".nuget"));
            Environment.SetEnvironmentVariable("LOCALAPPDATA", Path.Combine(root, ".local", "share"));
        }


        [Fact]
        public async Task NetwonsoftTest()
        {
            var project = new TestProject(_prjConfig);
            var addCmd = new AddCommand();

            await addCmd.DoWithProject("Newtonsoft.Json", "9.0.1", project, false);

            Assert.Single(project.Entries);
            var entry = project.Entries.First();
            foreach (var dep in entry.Core_Deps)
                Assert.False(dep.Value.Any());
            foreach (var dep in entry.Net_Deps)
                Assert.False(dep.Value.Any());
        }
    }
}