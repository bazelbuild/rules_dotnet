using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Threading.Tasks;
using Xunit;

namespace nuget2bazel
{
    public class DependenciesT : IDisposable
    {
        private ProjectBazelConfig _prjConfig;
        public void Dispose()
        {
            Directory.Delete(_prjConfig.RootPath, true);
        }

        public DependenciesT()
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
        public async Task check_xunit_analyzer()
        {
            var project = new TestProject(_prjConfig);
            var addCmd = new AddCommand();

            await addCmd.DoWithProject("xunit.analyzers", "0.10.0", project, false);

            var analyzers = project.Entries.FirstOrDefault(x => x.PackageIdentity.Id == "xunit.analyzers");
            Assert.NotNull(analyzers);
            Assert.Empty(analyzers.CoreLib);
            Assert.Empty(analyzers.NetLib);
            Assert.Null(analyzers.MonoLib);

            Assert.Empty(analyzers.Core_Deps);
            Assert.Equal(4, analyzers.Core_Files.Count);

            Assert.Empty(analyzers.Net_Deps);
            Assert.Equal(19, analyzers.Net_Files.Count);

            Assert.Null(analyzers.Mono_Deps);
        }

        [Fact]
        public async Task check_xunit()
        {
            var project = new TestProject(_prjConfig);
            var addCmd = new AddCommand();

            await addCmd.DoWithProject("xunit", "2.4.0", project, false);

            var lib = project.Entries.FirstOrDefault(x => x.PackageIdentity.Id == "xunit");
            Assert.NotNull(lib);
            Assert.Empty(lib.CoreLib);
        }

        [Fact]
        public async Task check_xunit_assert()
        {
            var project = new TestProject(_prjConfig);
            var addCmd = new AddCommand();

            await addCmd.DoWithProject("xunit.assert", "2.4.1", project, false);

            var lib = project.Entries.FirstOrDefault(x => x.PackageIdentity.Id == "xunit.assert");
            Assert.NotNull(lib);
            Assert.NotNull(lib.MonoLib);
        }

    }
}