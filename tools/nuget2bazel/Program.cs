using System;
using System.Diagnostics;
using System.Threading.Tasks;
using CommandLine;
using CommandLine.Text;
using nuget2bazel.rules;

namespace nuget2bazel
{
    class Program
    {
        static async Task Main(string[] args)
        {
            var parsed = Parser.Default.ParseArguments<AddVerb, DeleteVerb, SyncVerb, UpdateVerb, RulesVerb>(args);
            var result = await parsed.MapResult<AddVerb, DeleteVerb, SyncVerb, UpdateVerb, RulesVerb, Task<int>>(
                async (AddVerb opts) =>
                {
                    var prjConfig = new ProjectBazelConfig(opts);
                    await new AddCommand().Do(prjConfig, opts.Package, opts.Version, opts.MainFile, opts.SkipSha256, opts.Lowest, opts.Variable);
                    return 0;
                },
                async (DeleteVerb opts) =>
                {
                    var prjConfig = new ProjectBazelConfig(opts);
                    await new DeleteCommand().Do(prjConfig, opts.Package);
                    return 0;
                },
                async (SyncVerb opts) =>
                {
                    var prjConfig = new ProjectBazelConfig(opts);
                    await new SyncCommand().Do(prjConfig);
                    return 0;
                },
                async (UpdateVerb opts) =>
                {
                    var prjConfig = new ProjectBazelConfig(opts);
                    await new UpdateCommand().Do(prjConfig, opts.Package, opts.Version, opts.MainFile, opts.SkipSha256, opts.Lowest, opts.Variable);
                    return 0;
                },
                async (RulesVerb opts) =>
                {
                    await new RulesCommand().Do(opts.Path);
                    return 0;
                },
                errs =>
                {
                    HelpText.AutoBuild(parsed);
                    return Task.FromResult(-1);
                }
            );

            Environment.Exit(result);
        }
    }
}
