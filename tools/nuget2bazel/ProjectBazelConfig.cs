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
            Nuget2BazelConfigName = "nuget2bazel.json";
            BazelFileName = "WORKSPACE";
            Indent = false;
        }
        public ProjectBazelConfig(BaseVerb verb)
        {
            RootPath = verb.RootPath;
            if (RootPath == null)
                RootPath = Directory.GetCurrentDirectory();

            Nuget2BazelConfigName = verb.Nuget2BazelConfigName;
            BazelFileName = verb.BazelFileName;
            Indent = verb.Indent;
        }

        public string RootPath { get; set; }
        public string Nuget2BazelConfigName { get; set; }
        public string BazelFileName { get; set; }
        public bool Indent { get; set; }
    }
}
