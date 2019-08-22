using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using NuGet.PackageManagement;
using NuGet.ProjectManagement;

namespace nuget2bazel
{
    public class BazelSolutionManager : ISolutionManager
    {
        private readonly ProjectBazelManipulator _project;
#pragma warning disable 67
        public event EventHandler SolutionOpening;
        public event EventHandler SolutionOpened;
        public event EventHandler SolutionClosing;
        public event EventHandler SolutionClosed;
        public event EventHandler<NuGetEventArgs<string>> AfterNuGetCacheUpdated;
        public event EventHandler<NuGetProjectEventArgs> NuGetProjectAdded;
        public event EventHandler<NuGetProjectEventArgs> NuGetProjectRemoved;
        public event EventHandler<NuGetProjectEventArgs> NuGetProjectRenamed;
        public event EventHandler<NuGetProjectEventArgs> NuGetProjectUpdated;
        public event EventHandler<NuGetProjectEventArgs> AfterNuGetProjectRenamed;
        public event EventHandler<ActionsExecutedEventArgs> ActionsExecuted;
        public string SolutionDirectory { get; }
        public bool IsSolutionOpen { get; }
#pragma warning restore 67

        public BazelSolutionManager(ProjectBazelManipulator project, string rootPath)
        {
            _project = project;
            SolutionDirectory = rootPath;
        }

        public Task<bool> IsSolutionAvailableAsync()
        {
            throw new NotImplementedException();
        }

        public INuGetProjectContext NuGetProjectContext { get; set; }

        public bool IsSolutionAvailable => throw new NotImplementedException();

        public Task<IEnumerable<NuGetProject>> GetNuGetProjectsAsync()
        {
            return Task.FromResult(new NuGetProject[] { _project }.AsEnumerable());
        }

        public Task<string> GetNuGetProjectSafeNameAsync(NuGetProject nuGetProject)
        {
            throw new NotImplementedException();
        }

        public Task<NuGetProject> GetNuGetProjectAsync(string nuGetProjectSafeName)
        {
            throw new NotImplementedException();
        }

        public void OnActionsExecuted(IEnumerable<ResolvedAction> actions)
        {
            throw new NotImplementedException();
        }

        public void EnsureSolutionIsLoaded()
        {
            throw new NotImplementedException();
        }

        public Task<bool> DoesNuGetSupportsAnyProjectAsync()
        {
            throw new NotImplementedException();
        }

        public IEnumerable<NuGetProject> GetNuGetProjects()
        {
            throw new NotImplementedException();
        }

        public string GetNuGetProjectSafeName(NuGetProject nuGetProject)
        {
            throw new NotImplementedException();
        }

        public NuGetProject GetNuGetProject(string nuGetProjectSafeName)
        {
            throw new NotImplementedException();
        }
    }
}
