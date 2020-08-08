using System.Linq;
using System.Threading.Tasks;
using nuget2bazel;
using Xunit;

namespace nuget2bazel_test
{
    public class NewtonsoftT : TestBase
    {
        [Fact]
        public async Task NetwonsoftTest()
        {
            var project = new TestProject(_prjConfig);
            var addCmd = new AddCommand();

            await addCmd.DoWithProject("https://api.nuget.org/v3/index.json", "Newtonsoft.Json", "9.0.1", project, false);

            Assert.Single(project.Entries);
            var entry = project.Entries.First();
            foreach (var dep in entry.Core_Deps)
                Assert.False(dep.Value.Any());
            foreach (var dep in entry.Net_Deps)
                Assert.False(dep.Value.Any());
        }
    }
}