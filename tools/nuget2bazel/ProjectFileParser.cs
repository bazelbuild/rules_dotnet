using System;
using System.IO;
using System.Linq;
using System.Xml.Linq;
using System.Collections.Generic;

namespace nuget2bazel
{
    public class ProjectFileNugetPackage
    {
        public string Name {get; set;}
        public string Version {get; set;}
    }

    public class ProjectFileParser
    {
        private readonly ProjectBazelConfig prjConfig;
        public ProjectFileParser(ProjectBazelConfig prjConfig)
        {
            this.prjConfig = prjConfig;
        }

        public List<ProjectFileNugetPackage> GetNugetPackages()
        {
            var nugetPackages = new List<ProjectFileNugetPackage>();
            var packages = new Dictionary<string, string>();

            foreach(var projectFile in prjConfig.ProjectFiles.Split(' '))
            {
                var projectXml = XElement.Load($"{prjConfig.RootPath}{Path.DirectorySeparatorChar}{projectFile}");

                foreach(var p in projectXml.Element("ItemGroup").Descendants("PackageReference"))
                {
                    var name = p.Attribute("Include").Value;
                    var version = p.Attribute("Version").Value;
                    var key = $"{name}-{version}";
                    
                    if(!packages.ContainsKey(key))
                    {
                        nugetPackages.Add(new ProjectFileNugetPackage() {Name = name, Version = version});
                        packages.Add(key, key);
                    }
                }
            }

            return nugetPackages;
        }
    }
}