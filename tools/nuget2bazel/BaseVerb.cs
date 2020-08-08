using CommandLine;

namespace nuget2bazel
{
    public class BaseVerb
    {
        [Option('p', "path",
            Default = null,
            HelpText = "Path to the directory with the config file and bazel file")]
        public string RootPath { get; set; }

        [Option('b', "bazelfile",
            Default = "WORKSPACE",
            HelpText = "Name of the bazel file to modify")]
        public string BazelFileName { get; set; }

        [Option('c', "configfile",
            Default = "nuget2config.json",
            HelpText = "Name of the config file to use for nuget manipulation")]
        public string Nuget2BazelConfigName { get; set; }

        [Option('i', "indent",
            Default = false,
            HelpText = "Should the ouput be indented")]
        public bool Indent { get; set; }

        [Option('n', "nugetsource",
            Default = "https://api.nuget.org/v3/index.json",
            HelpText = "Source of the nuget package; https://api.nuget.org/v3/index.json if not specified")]
        public string Source { get; set; }

        [Option('u', "nugetsourcecustom",
            Default = false,
            HelpText = "Should nuget_package reference source variable")]
        public bool NugetSourceCustom { get; set; }
    }
}
