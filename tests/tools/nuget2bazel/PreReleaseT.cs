using System.Linq;
using System.Threading.Tasks;
using nuget2bazel;
using Xunit;

namespace nuget2bazel_test
{
    public class PreReleaseT : TestBase
    {
        [Fact]
        public async Task DoPreReleaseT()
        {
            var project = new TestProject(_prjConfig);
            var addCmd = new AddCommand();

            await addCmd.DoWithProject("System.Security.Permissions", "4.6.0-preview8.19405.3", project, false);

            var entry = project.Entries.Last();
            Assert.Equal(4, entry.CoreLib.Count);
            Assert.Equal("ref/netstandard2.0/System.Security.Permissions.dll", entry.CoreLib["netcoreapp2.0"]);
        }
    }
}