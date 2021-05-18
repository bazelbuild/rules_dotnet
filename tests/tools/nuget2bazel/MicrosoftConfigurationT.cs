using System.Linq;
using System.Threading.Tasks;
using nuget2bazel;
using Xunit;

namespace nuget2bazel_test
{
    public class MicrosoftConfigurationT : TestBase
    {
        // If we allow prerelease versions then this test fails for 5.9.0, 5.9.1 and 5.10.0-preview.
        // It seems that there is an internal error in Nuget.Resolver related to sorting versions.
        [Fact]
        public async Task MicrosoftConfigurationTest()
        {
            var project = new TestProject(_prjConfig);
            var addCmd = new AddCommand();

            await addCmd.DoWithProject("https://api.nuget.org/v3/index.json", "Microsoft.Extensions.Configuration", "5.0.0", project, false);
        }
    }
}