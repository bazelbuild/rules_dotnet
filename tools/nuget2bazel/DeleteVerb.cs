using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using CommandLine;

namespace nuget2bazel
{
    [Verb("delete", HelpText = "Remove the package from WORKSPACE and packages.json")]
    public class DeleteVerb : BaseVerb
    {
        [Value(index: 0,
            Required = true,
            HelpText = "Package id")]
        public string Package { get; set; }
    }
}
