using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Threading.Tasks;
using Xunit;

namespace nuget2bazel
{
    public class TestProject : ProjectBazel
    {
        public List<WorkspaceEntry> Entries = new List<WorkspaceEntry>();

        public TestProject(string root) : base(root, null, false)
        {
        }

        public override Task AddEntry(WorkspaceEntry entry)
        {
            Entries.Add(entry);
            return base.AddEntry(entry);
        }
    }

    public class RemotionLinq: IDisposable
    {
        private string _root;
        public void Dispose()
        {
            Directory.Delete(_root, true);
        }

        public RemotionLinq()
        {
            _root = Path.Combine(Path.GetTempPath(), Path.GetRandomFileName());
            Directory.CreateDirectory(_root);
            // Nuget libraries require HOME set
            Environment.SetEnvironmentVariable("HOME", _root);
        }


        [Fact]
        public async Task RemotionLinqT()
        {
            var project = new TestProject(_root);
            var addCmd = new AddCommand();

            await addCmd.DoWithProject("Remotion.Linq", "2.2.0", project);

            Assert.Single(project.Entries);
            var entry = project.Entries.First();
            Assert.Equal(2, entry.CoreLib.Count);
            Assert.Equal("lib/netstandard1.0/Remotion.Linq.dll", entry.CoreLib["netcoreapp2.0"]);
        }
   }
}