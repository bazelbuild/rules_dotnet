using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Threading.Tasks;
using Xunit;

namespace nuget2bazel
{
    public class TestProject : ProjectBazelManipulator
    {
        public List<WorkspaceEntry> Entries = new List<WorkspaceEntry>();

        public TestProject(ProjectBazelConfig prjConfig) : base(prjConfig, null, false)
        {
        }

        public override Task AddEntry(WorkspaceEntry entry)
        {
            Entries.Add(entry);
            return base.AddEntry(entry);
        }
    }

    public class RemotionLinq : IDisposable
    {
        private ProjectBazelConfig _prjConfig;
        public void Dispose()
        {
            Directory.Delete(_prjConfig.RootPath, true);
        }

        public RemotionLinq()
        {
            var root = Path.Combine(Path.GetTempPath(), Path.GetRandomFileName());
            Directory.CreateDirectory(root);
            _prjConfig = new ProjectBazelConfig(root);

            // Nuget libraries require HOME set
            Environment.SetEnvironmentVariable("HOME", root);
        }


        [Fact]
        public async Task RemotionLinqT()
        {
            var project = new TestProject(_prjConfig);
            var addCmd = new AddCommand();

            await addCmd.DoWithProject("Remotion.Linq", "2.2.0", project, false);

            Assert.Single(project.Entries);
            var entry = project.Entries.First();
            Assert.Equal(2, entry.CoreLib.Count);
            Assert.Equal("lib/netstandard1.0/Remotion.Linq.dll", entry.CoreLib["netcoreapp2.0"]);
        }
    }
}