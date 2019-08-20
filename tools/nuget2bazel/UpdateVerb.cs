using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using CommandLine;

namespace nuget2bazel
{
    [Verb("update", HelpText = "Updates a pckage to the WORKSPACE and packages.json")]
    public class UpdateVerb
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

        [Option('s', "skipSha256",
            HelpText = "If true, do not emit the sha256 value for generated nuget_package rules")]
        public bool SkipSha256 { get; set; }
    }
}
