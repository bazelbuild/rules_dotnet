using System;
using System.Collections.Generic;
using System.Text;
using CommandLine;

namespace nuget2bazel
{
    public class AddOrUpdateVerb : BaseVerb
    {
        [Value(index: 0,
            Required = false,
            HelpText = "Package id. ")]
        public string Package { get; set; }

        [Value(index: 1,
            Required = false,
            HelpText = "Package version")]
        public string Version { get; set; }

        [Option('m', "mainFile",
            Default = null,
            HelpText = "Basename of the main file in the libs or tools folder if multiple are present")]
        public string MainFile { get; set; }

        [Option('s', "skipSha256",
            HelpText = "If true, do not emit the sha256 value for generated nuget_package rules")]
        public bool SkipSha256 { get; set; }

        [Option('l', "lowest",
            Default = false,
            HelpText = "Dependency behavior. Default is HighestMinor; setting this option changes to Lowest")]
        public bool Lowest { get; set; }

        [Option('v', "variable",
            Default = null,
            SetName = "variable",
            HelpText = "Variable name to use in nuget_package rule")]
        public string Variable { get; set; }

        [Option('t',
            "targetname",
            Default = null,
            SetName = "target_name",
            HelpText = "Target name to use in nuget_package rule")]
        public string TargetName { get; set; }

        public string CustomTargetName => Variable ?? (TargetName != null ? $"\"{TargetName}\"" : null);
    }
}