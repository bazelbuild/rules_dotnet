using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using CommandLine;

namespace nuget2bazel
{
    [Verb("sync", HelpText = "Syncs bazel file with nuget config file")]
    public class SyncVerb : BaseVerb
    {
    }
}
