using System.Linq;
using System.IO;
using System.Threading.Tasks;
using nuget2bazel;
using Xunit;

namespace nuget2bazel_test
{
    public class ProjectFileParserT : TestBase
    {
        private static string project1 = @"
            <Project Sdk='Microsoft.NET.Sdk'>
                <PropertyGroup>
                    <TargetFramework>netcoreapp3.1</TargetFramework>
                    <RootNamespace>nuget2bazel_test</RootNamespace>
                    <IsPackable>false</IsPackable>
                </PropertyGroup>
                <ItemGroup>
                    <PackageReference Include='xunit' Version='2.4.0' />
                </ItemGroup>
            </Project>
            ";

        // Second project file with a duplicate nuget package 
        private static string project2 = @"
            <Project Sdk='Microsoft.NET.Sdk'>
                <PropertyGroup>
                    <TargetFramework>netcoreapp3.1</TargetFramework>
                    <RootNamespace>nuget2bazel_test</RootNamespace>
                    <IsPackable>false</IsPackable>
                </PropertyGroup>
                <ItemGroup>
                    <PackageReference Include='xunit.runner.visualstudio' Version='2.4.1' />
                    <PackageReference Include='xunit' Version='2.4.0' />
                </ItemGroup>
            </Project>
            ";    

        [Fact]
        public async Task ParseSingleProjectFile()
        {
            var projectFileParser = new ProjectFileParser(_prjConfig);
            
            _prjConfig.ProjectFiles = "project1.csproj";
            await File.WriteAllTextAsync($"{_prjConfig.RootPath}/project1.csproj", project1);

            var packages = projectFileParser.GetNugetPackages();

            Assert.Equal(1, packages.Count);
            Assert.Equal("xunit", packages[0].Name);
            Assert.Equal("2.4.0", packages[0].Version);
        }

        [Fact]
        public async Task ParseMultipleProjectFiles()
        {
            var projectFileParser = new ProjectFileParser(_prjConfig);
            
            _prjConfig.ProjectFiles = "project1.csproj project2.csproj";
            await File.WriteAllTextAsync($"{_prjConfig.RootPath}/project1.csproj", project1);
            await File.WriteAllTextAsync($"{_prjConfig.RootPath}/project2.csproj", project2);

            var packages = projectFileParser.GetNugetPackages();

            Assert.Equal(2, packages.Count);

            Assert.Equal("xunit", packages[0].Name);
            Assert.Equal("2.4.0", packages[0].Version);

            Assert.Equal("xunit.runner.visualstudio", packages[1].Name);
            Assert.Equal("2.4.1", packages[1].Version);
        } 
    }
}