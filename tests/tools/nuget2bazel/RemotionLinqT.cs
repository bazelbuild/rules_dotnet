using System.Linq;
using System.Threading.Tasks;
using nuget2bazel;
using Xunit;

namespace nuget2bazel_test
{
    public class RemotionLinq : TestBase
    {
        [Fact]
        public async Task RemotionLinqT()
        {
            var project = new TestProject(_prjConfig);
            var addCmd = new AddCommand();

            await addCmd.DoWithProject("https://api.nuget.org/v3/index.json", "Remotion.Linq", "2.2.0", project, false);

            Assert.Single(project.Entries);
            var entry = project.Entries.First();
            Assert.Equal(7, entry.CoreLib.Count);
            Assert.Equal("lib/netstandard1.0/Remotion.Linq.dll", entry.CoreLib["netcoreapp2.0"]);
        }
    }
}
