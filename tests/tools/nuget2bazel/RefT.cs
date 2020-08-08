using System.Linq;
using System.Threading.Tasks;
using nuget2bazel;
using Xunit;

namespace nuget2bazel_test
{
    public class RefT : TestBase
    {
        [Fact]
        public async Task SystemRuntimeCompilerServicesUnsafe()
        {
            var project = new TestProject(_prjConfig);
            var addCmd = new AddCommand();

            await addCmd.DoWithProject("https://api.nuget.org/v3/index.json", "System.Runtime.CompilerServices.Unsafe", "4.7.1", project, false);

            Assert.Single(project.Entries);
            var entry = project.Entries.First();
            Assert.Equal("lib/netcoreapp2.0/System.Runtime.CompilerServices.Unsafe.dll", entry.CoreLib["netcoreapp2.0"]);
            Assert.Equal("ref/netstandard2.0/System.Runtime.CompilerServices.Unsafe.dll", entry.CoreRef["netcoreapp2.0"]);
        }
    }
}