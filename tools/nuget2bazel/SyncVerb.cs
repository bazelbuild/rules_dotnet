using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using CommandLine;

namespace nuget2bazel
{
    [Verb("sync", HelpText = "Syncs WORKSPACE with packages.json")]
    public class SyncVerb
    {
        [Option('p', "path",
            Default = null,
            HelpText = "Path to the directory with the WORKSPACE file")]
        public string RootPath { get; set; }
    }
}
