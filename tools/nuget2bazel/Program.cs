using System;
using System.Diagnostics;
using CommandLine;
using CommandLine.Text;

namespace nuget2bazel
{
    class Program
    {
        static void Main(string[] args)
        {
            var parsed = Parser.Default.ParseArguments<AddVerb, DeleteVerb, SyncVerb, UpdateVerb>(args);
            var result = parsed.MapResult<AddVerb, DeleteVerb, SyncVerb, UpdateVerb, int>(
                (AddVerb opts) =>
                {
                    var prjConfig = new ProjectBazelConfig(opts);
                    var res = new AddCommand().Do(prjConfig, opts.Package, opts.Version, opts.MainFile, opts.SkipSha256);
                    res.Wait();
                    return 0;
                },
                (DeleteVerb opts) =>
                {
                    var prjConfig = new ProjectBazelConfig(opts);
                    var res = new DeleteCommand().Do(prjConfig, opts.Package);
                    res.Wait();
                    return 0;
                },
                (SyncVerb opts) =>
                {
                    var prjConfig = new ProjectBazelConfig(opts);
                    var res = new SyncCommand().Do(prjConfig);
                    res.Wait();
                    return 0;
                },
                (UpdateVerb opts) =>
                {
                    var prjConfig = new ProjectBazelConfig(opts);
                    var res = new UpdateCommand().Do(prjConfig, opts.Package, opts.Version, opts.MainFile, opts.SkipSha256);
                    res.Wait();
                    return 0;
                },
                errs =>
                {
                    HelpText.AutoBuild(parsed);
                    return -1;
                }
            );

            Environment.Exit(result);
        }
    }
}
