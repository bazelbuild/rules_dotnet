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
                    var res = new AddCommand().Do(opts.Package, opts.Version, opts.RootPath, opts.MainFile, opts.SkipSha256);
                    res.Wait();
                    return 0;
                },
                (DeleteVerb opts) =>
                {
                    var res = new DeleteCommand().Do(opts.Package, opts.RootPath);
                    res.Wait();
                    return 0;
                },
                (SyncVerb opts) =>
                {
                    var res = new SyncCommand().Do(opts.RootPath);
                    res.Wait();
                    return 0;
                },
                (UpdateVerb opts) =>
                {
                    var res = new UpdateCommand().Do(opts.Package, opts.Version, opts.RootPath, opts.MainFile, opts.SkipSha256);
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
