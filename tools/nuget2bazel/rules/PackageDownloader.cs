using System;
using System.Collections.Generic;
using System.IO;
using System.Text;
using System.Threading.Tasks;

namespace nuget2bazel.rules
{
    public static class PackageDownloader
    {
        public static async Task<string> DownloadPackageIfNedeed(string configDir, string package, string version)
        {
            var dir = Path.Combine(configDir, package, version);
            if (Directory.Exists(Path.Combine(dir, "packages")))
                return dir;

            var prjConfig = new ProjectBazelConfig(dir);
            Directory.CreateDirectory(dir);
            var cmd = new AddCommand();
            await cmd.Do(prjConfig, package, version, null, true, false, null);

            return dir;
        }
    }
}
