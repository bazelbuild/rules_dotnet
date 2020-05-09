using System.Collections.Generic;
using System.Threading.Tasks;
using nuget2bazel;
using Xunit;

[assembly: CollectionBehavior(CollectionBehavior.CollectionPerAssembly)]

namespace nuget2bazel_test
{
    public class TestProject : ProjectBazelManipulator
    {
        public List<WorkspaceEntry> Entries = new List<WorkspaceEntry>();

        public TestProject(ProjectBazelConfig prjConfig) : base(prjConfig, null, false, null)
        {
        }

        public override Task AddEntry(WorkspaceEntry entry)
        {
            Entries.Add(entry);
            return base.AddEntry(entry);
        }
    }
}
