using System;
using System.Collections.Generic;
using System.IO;
using System.IO.Compression;
using System.Linq;
using System.Net;
using System.Net.Http;
using System.Reflection;
using System.Runtime.InteropServices.ComTypes;
using System.Text;
using System.Threading;
using System.Threading.Tasks;
using NuGet.Configuration;
using NuGet.PackageManagement;
using NuGet.Packaging.Core;
using NuGet.ProjectManagement;
using NuGet.Protocol;
using NuGet.Protocol.Core.Types;
using NuGet.Resolver;
using NuGet.Versioning;

namespace nuget2bazel.rules
{
    public class RulesCommand
    {
        public async Task Do(string path)
        {
            var configDir = Path.Combine(Path.GetTempPath(), "nuget2bazel");

            var netStdlibGenerator = new StdlibNetGenerator(configDir, path);
            await netStdlibGenerator.Do();

            var stdlibCoreGenerator = new StdlibCoreGenerator(configDir, path);
            await stdlibCoreGenerator.Do();
        }
    }
}