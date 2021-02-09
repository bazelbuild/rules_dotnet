using System.Linq;
using System.Threading.Tasks;
using nuget2bazel;
using Xunit;

namespace nuget2bazel_test
{
    public class DependenciesT : TestBase
    {
        [Fact]
        public async Task check_xunit_analyzer()
        {
            var project = new TestProject(_prjConfig);
            var addCmd = new AddCommand();

            await addCmd.DoWithProject("https://api.nuget.org/v3/index.json", "xunit.analyzers", "0.10.0", project, false);

            var analyzers = project.Entries.FirstOrDefault(x => x.PackageIdentity.Id == "xunit.analyzers");
            Assert.NotNull(analyzers);
            Assert.Empty(analyzers.CoreLib);
            Assert.Empty(analyzers.NetLib);
            Assert.Null(analyzers.MonoLib);

            Assert.Empty(analyzers.Core_Deps);
            Assert.Equal(5, analyzers.Core_Files.Count);

            Assert.Empty(analyzers.Net_Deps);
            Assert.Equal(19, analyzers.Net_Files.Count);

            Assert.Null(analyzers.Mono_Deps);
        }

        [Fact]
        public async Task check_xunit()
        {
            var project = new TestProject(_prjConfig);
            var addCmd = new AddCommand();

            await addCmd.DoWithProject("https://api.nuget.org/v3/index.json", "xunit", "2.4.0", project, false);

            var lib = project.Entries.FirstOrDefault(x => x.PackageIdentity.Id == "xunit");
            Assert.NotNull(lib);
            Assert.Empty(lib.CoreLib);
        }

        [Fact]
        public async Task check_xunit_assert()
        {
            var project = new TestProject(_prjConfig);
            var addCmd = new AddCommand();

            await addCmd.DoWithProject("https://api.nuget.org/v3/index.json", "xunit.assert", "2.4.1", project, false);

            var lib = project.Entries.FirstOrDefault(x => x.PackageIdentity.Id == "xunit.assert");
            Assert.NotNull(lib);
            Assert.NotNull(lib.MonoLib);
        }

    }
}