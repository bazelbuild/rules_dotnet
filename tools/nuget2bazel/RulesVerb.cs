using CommandLine;

namespace nuget2bazel
{
    [Verb("rules", HelpText = "Generates all files required by rules_dotnet")]
    public class RulesVerb : BaseVerb
    {
        [Value(index: 0,
            Required = true,
            HelpText = "Rules_dotnet root path")]
        public string Path { get; set; }
    }
}
