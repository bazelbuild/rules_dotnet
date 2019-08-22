using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Threading.Tasks;
using Xunit;

namespace nuget2bazel
{
    public class PreReleaseT : IDisposable
    {
        private ProjectBazelConfig _prjConfig;
        public void Dispose()
        {
            Directory.Delete(_prjConfig.RootPath, true);
        }

        public PreReleaseT()
        {
            var root = Path.Combine(Path.GetTempPath(), Path.GetRandomFileName());
            Directory.CreateDirectory(root);
            _prjConfig = new ProjectBazelConfig(root);

            // Nuget libraries require HOME set
            Environment.SetEnvironmentVariable("HOME", root);
        }


        [Fact]
        public async Task DoPreReleaseT()
        {
            var project = new TestProject(_prjConfig);
            var addCmd = new AddCommand();

            await addCmd.DoWithProject("System.Security.Permissions", "4.6.0-preview8.19405.3", project, false);

            Assert.Single(project.Entries);
            var entry = project.Entries.First();
            Assert.Equal(2, entry.CoreLib.Count);
            Assert.Equal("ref/netstandard2.0/System.Security.Permissions.dll", entry.CoreLib["netcoreapp2.0"]);
        }
    }
}