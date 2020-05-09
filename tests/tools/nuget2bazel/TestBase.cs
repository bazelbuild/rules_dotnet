using System;
using System.IO;
using nuget2bazel;

namespace nuget2bazel_test
{
    public class TestBase : IDisposable
    {
        protected ProjectBazelConfig _prjConfig;
        public void Dispose()
        {
            Directory.Delete(_prjConfig.RootPath, true);
        }

        public TestBase()
        {
            var root = Path.Combine(Path.GetTempPath(), Path.GetRandomFileName());
            Directory.CreateDirectory(root);
            _prjConfig = new ProjectBazelConfig(root);

            // Nuget libraries require HOME ans some other variables set
            Environment.SetEnvironmentVariable("HOME", root);
            Environment.SetEnvironmentVariable("DOTNET_CLI_HOME", root);
            Environment.SetEnvironmentVariable("APPDATA", Path.Combine(root, ".nuget"));
            Environment.SetEnvironmentVariable("PROGRAMFILES", Path.Combine(root, ".nuget"));
            Environment.SetEnvironmentVariable("LOCALAPPDATA", Path.Combine(root, ".local", "share"));
        }

    }
}
