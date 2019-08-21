using System;
using System.Collections.Generic;
using System.Text;

namespace nuget2bazel
{
    public class ProjectBazelConfig
    {
        public ProjectBazelConfig()
        {
            externals = new Dictionary<string, string>();
            dependencies = new Dictionary<string, string>();
        }
        public IDictionary<string, string> externals { get; set; }
        public IDictionary<string, string> dependencies { get; set; }
    }
}
