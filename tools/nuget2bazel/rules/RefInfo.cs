using System;
using System.Collections.Generic;
using System.Text;

namespace nuget2bazel.rules
{
    public class RefInfo
    {
        public RefInfo()
        {
            Deps = new List<string>();
        }
        public string Name { get; set; }
        public string Ref { get; set; }
        public string StdlibPath { get; set; }
        public string Version { get; set; }
        public string Pack { get; set; }
        public List<string> Deps { get; set; }
    }
}
