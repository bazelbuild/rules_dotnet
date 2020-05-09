using System.Linq;
using nuget2bazel;
using Xunit;

namespace nuget2bazel_test
{
    public class WorkspaceParserT
    {
        [Fact]
        public void EmptyEntry()
        {
            var data = @"
nuget_package(
    name = ""remotion.linq"",
    package = ""remotion.linq"",
    version = ""2.2.0"",
)
";
            var parser = new WorkspaceParser(data);
            var result = parser.Parse();
            Assert.Single(result);
            var entry = result.First();
            Assert.Equal("remotion.linq", entry.PackageIdentity.Id);
            Assert.Equal("2.2.0", entry.PackageIdentity.Version.ToString());

        }

        [Fact]
        public void ComplexEntry()
        {
            var data = @"
nuget_package(
    name = ""remotion.linq"",
    package = ""remotion.linq"",
    version = ""2.2.0"",
    core_lib = {
        ""netcoreapp2.0"": ""lib/netstandard1.0/Remotion.Linq.dll"",
        ""netcoreapp2.1"": ""lib/netstandard1.0/Remotion.Linq.dll"",
    },
)
";
            var parser = new WorkspaceParser(data);
            var result = parser.Parse();
            Assert.Single(result);
            var entry = result.First();
            Assert.Equal("remotion.linq", entry.PackageIdentity.Id);
            Assert.Equal("2.2.0", entry.PackageIdentity.Version.ToString());
            Assert.Equal(2, entry.CoreLib.Count);
        }

        [Fact]
        public void RefEntry()
        {
            var data = @"
nuget_package(
    name = ""remotion.linq"",
    package = ""remotion.linq"",
    version = ""2.2.0"",
    core_ref = {
        ""netcoreapp2.0"": ""lib/netstandard1.0/Remotion.Linq.dll"",
        ""netcoreapp2.1"": ""lib/netstandard1.0/Remotion.Linq.dll"",
    },
    net_ref = {
        ""netcoreapp2.0"": ""lib/netstandard1.0/Remotion.Linq.dll"",
    },
    mono_ref = ""ref/net45/Newtonsoft.Json.dll"",
)
";
            var parser = new WorkspaceParser(data);
            var result = parser.Parse();
            Assert.Single(result);
            var entry = result.First();
            Assert.Equal("remotion.linq", entry.PackageIdentity.Id);
            Assert.Equal("2.2.0", entry.PackageIdentity.Version.ToString());
            Assert.Equal(2, entry.CoreRef.Count);
            Assert.Equal(1, entry.NetRef.Count);
            Assert.Equal("ref/net45/Newtonsoft.Json.dll", entry.MonoRef);
        }

        [Fact]
        public void FullEntry()
        {
            var data = @"
nuget_package(
    name = ""newtonsoft.json"",
    core_files = {
        ""netcoreapp2.0"": [
            ""lib/netstandard2.0/Newtonsoft.Json.dll"",
            ""lib/netstandard2.0/Newtonsoft.Json.xml"",
        ],
        ""netcoreapp2.1"": [
            ""lib/netstandard2.0/Newtonsoft.Json.dll"",
            ""lib/netstandard2.0/Newtonsoft.Json.xml"",
        ],
    },
    core_lib = {
        ""netcoreapp2.0"": ""lib/netstandard2.0/Newtonsoft.Json.dll"",
        ""netcoreapp2.1"": ""lib/netstandard2.0/Newtonsoft.Json.dll"",
    },
    core_ref = {
        ""netcoreapp2.0"": ""ref/netstandard2.0/Newtonsoft.Json.dll"",
        ""netcoreapp2.1"": ""ref/netstandard2.0/Newtonsoft.Json.dll"",
    },
    mono_files = [
        ""lib/net45/Newtonsoft.Json.dll"",
        ""lib/net45/Newtonsoft.Json.xml"",
    ],
    mono_lib = ""lib/net45/Newtonsoft.Json.dll"",
    mono_ref = ""ref/net45/Newtonsoft.Json.dll"",
    net_files = {
        ""net45"": [
            ""lib/net45/Newtonsoft.Json.dll"",
            ""lib/net45/Newtonsoft.Json.xml"",
        ],
        ""net451"": [
            ""lib/net45/Newtonsoft.Json.dll"",
            ""lib/net45/Newtonsoft.Json.xml"",
        ],
        ""net452"": [
            ""lib/net45/Newtonsoft.Json.dll"",
            ""lib/net45/Newtonsoft.Json.xml"",
        ],
        ""net46"": [
            ""lib/net45/Newtonsoft.Json.dll"",
            ""lib/net45/Newtonsoft.Json.xml"",
        ],
        ""net461"": [
            ""lib/net45/Newtonsoft.Json.dll"",
            ""lib/net45/Newtonsoft.Json.xml"",
        ],
        ""net462"": [
            ""lib/net45/Newtonsoft.Json.dll"",
            ""lib/net45/Newtonsoft.Json.xml"",
        ],
        ""net47"": [
            ""lib/net45/Newtonsoft.Json.dll"",
            ""lib/net45/Newtonsoft.Json.xml"",
        ],
        ""net471"": [
            ""lib/net45/Newtonsoft.Json.dll"",
            ""lib/net45/Newtonsoft.Json.xml"",
        ],
        ""net472"": [
            ""lib/net45/Newtonsoft.Json.dll"",
            ""lib/net45/Newtonsoft.Json.xml"",
        ],
        ""netstandard1.0"": [
            ""lib/netstandard1.0/Newtonsoft.Json.dll"",
            ""lib/netstandard1.0/Newtonsoft.Json.xml"",
        ],
        ""netstandard1.1"": [
            ""lib/netstandard1.0/Newtonsoft.Json.dll"",
            ""lib/netstandard1.0/Newtonsoft.Json.xml"",
        ],
        ""netstandard1.2"": [
            ""lib/netstandard1.0/Newtonsoft.Json.dll"",
            ""lib/netstandard1.0/Newtonsoft.Json.xml"",
        ],
        ""netstandard1.3"": [
            ""lib/netstandard1.3/Newtonsoft.Json.dll"",
            ""lib/netstandard1.3/Newtonsoft.Json.xml"",
        ],
        ""netstandard1.4"": [
            ""lib/netstandard1.3/Newtonsoft.Json.dll"",
            ""lib/netstandard1.3/Newtonsoft.Json.xml"",
        ],
        ""netstandard1.5"": [
            ""lib/netstandard1.3/Newtonsoft.Json.dll"",
            ""lib/netstandard1.3/Newtonsoft.Json.xml"",
        ],
        ""netstandard1.6"": [
            ""lib/netstandard1.3/Newtonsoft.Json.dll"",
            ""lib/netstandard1.3/Newtonsoft.Json.xml"",
        ],
        ""netstandard2.0"": [
            ""lib/netstandard2.0/Newtonsoft.Json.dll"",
            ""lib/netstandard2.0/Newtonsoft.Json.xml"",
        ],
    },
    net_lib = {
        ""net45"": ""lib/net45/Newtonsoft.Json.dll"",
        ""net451"": ""lib/net45/Newtonsoft.Json.dll"",
        ""net452"": ""lib/net45/Newtonsoft.Json.dll"",
        ""net46"": ""lib/net45/Newtonsoft.Json.dll"",
        ""net461"": ""lib/net45/Newtonsoft.Json.dll"",
        ""net462"": ""lib/net45/Newtonsoft.Json.dll"",
        ""net47"": ""lib/net45/Newtonsoft.Json.dll"",
        ""net471"": ""lib/net45/Newtonsoft.Json.dll"",
        ""net472"": ""lib/net45/Newtonsoft.Json.dll"",
        ""netstandard1.0"": ""lib/netstandard1.0/Newtonsoft.Json.dll"",
        ""netstandard1.1"": ""lib/netstandard1.0/Newtonsoft.Json.dll"",
        ""netstandard1.2"": ""lib/netstandard1.0/Newtonsoft.Json.dll"",
        ""netstandard1.3"": ""lib/netstandard1.3/Newtonsoft.Json.dll"",
        ""netstandard1.4"": ""lib/netstandard1.3/Newtonsoft.Json.dll"",
        ""netstandard1.5"": ""lib/netstandard1.3/Newtonsoft.Json.dll"",
        ""netstandard1.6"": ""lib/netstandard1.3/Newtonsoft.Json.dll"",
        ""netstandard2.0"": ""lib/netstandard2.0/Newtonsoft.Json.dll"",
    },
    net_ref = {
        ""net45"": ""ref/net45/Newtonsoft.Json.dll"",
        ""net451"": ""ref/net45/Newtonsoft.Json.dll"",
        ""net452"": ""ref/net45/Newtonsoft.Json.dll"",
        ""net46"": ""ref/net45/Newtonsoft.Json.dll"",
        ""net461"": ""ref/net45/Newtonsoft.Json.dll"",
        ""net462"": ""ref/net45/Newtonsoft.Json.dll"",
        ""net47"": ""ref/net45/Newtonsoft.Json.dll"",
        ""net471"": ""ref/net45/Newtonsoft.Json.dll"",
        ""net472"": ""ref/net45/Newtonsoft.Json.dll"",
        ""netstandard1.0"": ""ref/netstandard1.0/Newtonsoft.Json.dll"",
        ""netstandard1.1"": ""ref/netstandard1.0/Newtonsoft.Json.dll"",
        ""netstandard1.2"": ""ref/netstandard1.0/Newtonsoft.Json.dll"",
        ""netstandard1.3"": ""ref/netstandard1.3/Newtonsoft.Json.dll"",
        ""netstandard1.4"": ""ref/netstandard1.3/Newtonsoft.Json.dll"",
        ""netstandard1.5"": ""ref/netstandard1.3/Newtonsoft.Json.dll"",
        ""netstandard1.6"": ""ref/netstandard1.3/Newtonsoft.Json.dll"",
        ""netstandard2.0"": ""ref/netstandard2.0/Newtonsoft.Json.dll"",
    },
    package = ""newtonsoft.json"",
    version = ""11.0.2"",
)

";
            var parser = new WorkspaceParser(data);
            var result = parser.Parse();
            Assert.Single(result);
            var entry = result.First();
            Assert.Equal("newtonsoft.json", entry.PackageIdentity.Id);
            Assert.Equal("11.0.2", entry.PackageIdentity.Version.ToString());
            Assert.Equal(2, entry.CoreLib.Count);
        }

        [Fact]
        public void IndentedEntry()
        {
            var data = @"
   nuget_package(
       name = ""remotion.linq"",
       package = ""remotion.linq"",
       version = ""2.2.0"",
   )
";
            var parser = new WorkspaceParser(data);
            var result = parser.Parse();
            Assert.Single(result);
            var entry = result.First();
            Assert.Equal("remotion.linq", entry.PackageIdentity.Id);
            Assert.Equal("2.2.0", entry.PackageIdentity.Version.ToString());

        }

        [Fact]
        public void EntryWithVariable()
        {
            var data = @"
nuget_package(
    name = nunitv2,
    package = ""remotion.linq"",
    version = ""2.2.0"",
)
";
            var parser = new WorkspaceParser(data);
            var result = parser.Parse();
            Assert.Single(result);
            var entry = result.First();
            Assert.Equal("remotion.linq", entry.PackageIdentity.Id);
            Assert.Equal("nunitv2", entry.Variable);
            Assert.Equal("2.2.0", entry.PackageIdentity.Version.ToString());

        }

    }
}