using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Threading.Tasks;
using Xunit;

namespace nuget2bazel
{
    public class PreReleaseT: IDisposable
    {
        private string _root;
        public void Dispose()
        {
            Directory.Delete(_root, true);
        }

        public PreReleaseT()
        {
            _root = Path.Combine(Path.GetTempPath(), Path.GetRandomFileName());
            Directory.CreateDirectory(_root);
        }


        [Fact]
        public async Task DoPreReleaseT()
        {
            var project = new TestProject(_root);
            var addCmd = new AddCommand();

            await addCmd.DoWithProject("System.Security.Permissions", "4.6.0-preview8.19405.3", project);

            Assert.Single(project.Entries);
            var entry = project.Entries.First();
            Assert.Equal(2, entry.CoreLib.Count);
            Assert.Equal("ref/netstandard2.0/System.Security.Permissions.dll", entry.CoreLib["netcoreapp2.0"]);
        }
   }
}