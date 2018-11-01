using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using CommandLine;

namespace nuget2bazel
{
    [Verb("add", HelpText = "Adds a pckage to the WORKSPACE and packages.json")]
    public class AddVerb
    {
        [Value(index: 0,
            Required = true,
            HelpText = "Package id")]
        public string Package { get; set; }

        [Value(index: 1,
            Required = true,
            HelpText = "Package version")]
        public string Version { get; set; }

        [Option('p', "path",
            Default = null,
            HelpText = "Path to the directory with the WORKSPACE file")]
        public string RootPath { get; set; }

        [Option('m', "mainFile",
            Default = null,
            HelpText = "Basename of the main file in the libs or tools folder if multiple are present")]
        public string MainFile { get; set; }
    }
}
