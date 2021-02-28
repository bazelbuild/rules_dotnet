using System;
using System.Collections.Generic;
using System.IO;
using System.Text;

namespace nuget2bazel
{
    public class ProjectBazelConfig
    {
        public ProjectBazelConfig(string root)
        {
            RootPath = root;
            
            Nuget2BazelConfigName = "nuget2config.json";
            BazelFileName = "WORKSPACE";
            Indent = false;
            NugetSource = "https://api.nuget.org/v3/index.json";
            NugetSourceCustom = false;
        }
        public ProjectBazelConfig(BaseVerb verb)
        {
            ProjectFiles = verb.ProjectFiles;

            RootPath = verb.RootPath;
            if (RootPath == null)
                RootPath = Directory.GetCurrentDirectory();

            Nuget2BazelConfigName = verb.Nuget2BazelConfigName;
            BazelFileName = verb.BazelFileName;
            Indent = verb.Indent;
            NugetSource = verb.Source;
            NugetSourceCustom = verb.NugetSourceCustom;
        }

        public string RootPath { get; set; }
        public string Nuget2BazelConfigName { get; set; }
        public string BazelFileName { get; set; }
        public string NugetSource { get; set; }
        public bool NugetSourceCustom { get; set; }
        public bool Indent { get; set; }
        public string ProjectFiles { get; set; }
    }
}
