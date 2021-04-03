using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using NuGet.PackageManagement;
using NuGet.Packaging.Core;
using NuGet.ProjectManagement;

namespace nuget2bazel
{
    public class DeleteOnRestart : IDeleteOnRestartManager
    {
        public IReadOnlyList<string> GetPackageDirectoriesMarkedForDeletion()
        {
            throw new NotImplementedException();
        }

        public void CheckAndRaisePackageDirectoriesMarkedForDeletion()
        {
            throw new NotImplementedException();
        }

        public void MarkPackageDirectoryForDeletion(PackageIdentity package, string packageDirectory,
            INuGetProjectContext projectContext)
        {
            throw new NotImplementedException();
        }

        public Task DeleteMarkedPackageDirectoriesAsync(INuGetProjectContext projectContext)
        {
            throw new NotImplementedException();
        }

        public void DeleteMarkedPackageDirectories(INuGetProjectContext projectContext)
        {
            throw new NotImplementedException();
        }
#pragma warning disable 67
        public event EventHandler<PackagesMarkedForDeletionEventArgs> PackagesMarkedForDeletionFound;
#pragma warning restore 67
    }
}
