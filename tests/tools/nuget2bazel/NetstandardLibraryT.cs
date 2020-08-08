using System.Linq;
using System.Threading.Tasks;
using nuget2bazel;
using Xunit;

namespace nuget2bazel_test
{
    public class NetstandardLibraryT : TestBase
    {
        [Fact]
        public async Task NetstandardLibraryTest()
        {
            var project = new TestProject(_prjConfig);
            var addCmd = new AddCommand();

            await addCmd.DoWithProject("https://api.nuget.org/v3/index.json", "NETStandard.Library", "2.0.3", project, false);

            Assert.Equal(2, project.Entries.Count);
            var entry = project.Entries.Last();
            foreach (var dep in entry.Core_Deps)
            {
                Assert.True(dep.Value.Any());
                Assert.Contains("microsoft.netcore.platforms", dep.Value.First());
            }

            foreach (var dep in entry.Net_Deps)
            {
                Assert.True(dep.Value.Any());
                Assert.Contains("microsoft.netcore.platforms", dep.Value.First());
            }
        }
    }
}