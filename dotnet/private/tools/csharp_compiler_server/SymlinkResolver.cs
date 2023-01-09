using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;

namespace Compiler.Server.Multiplex
{
    /// <summary>
    ///   External repositories can write a symlinks_manifest file
    ///   We use this to resolve absolute paths to embed in bazel.props files
    ///   This should help the IDE to remain tracking files even when bazel is re-creating the external repo
    /// </summary>
    internal class SymlinkResolver
    {
        private readonly Dictionary<string, IReadOnlyDictionary<string, string>> _symlinksLookup = new Dictionary<string, IReadOnlyDictionary<string, string>>();
        private const string _external = "external";
        private const string _manifest = "symlinks_manifest";

        public bool TryResolveExternalSymlinkToAbsolutePath(string path, out string absolutePath)
        {
            absolutePath = null;

            if(!path.StartsWith("external", StringComparison.OrdinalIgnoreCase))
            {
                return false;
            }

            var key = path.Substring(0, path.IndexOf('\\', _external.Length + 1));
            if(!_symlinksLookup.TryGetValue(key, out var symlinks))
            {
                _symlinksLookup[key] = symlinks = CreateExternalSymlinksLookup(key);
            }

            if(symlinks == null)
            {
                return false;
            }

            var localPath = path.Substring(key.Length + 1);
            var segments = localPath.Split('\\');
            for(var i = 0; i < segments.Length; i++)
            {
                var prefix = string.Join('\\', segments.Take(i + 1));
                if(symlinks.TryGetValue(prefix, out var absolutePrefix))
                {
                    absolutePath = $"{absolutePrefix}\\{string.Join('\\', segments.Skip(i + 1))}";
                    return true;
                }
            }

            return false;
        }
        
        private IReadOnlyDictionary<string, string> CreateExternalSymlinksLookup(string key)
        {
            var file = Path.Combine(key, _manifest);
            if(!File.Exists(file))
            {
                return null;
            }

            return File.ReadLines(file)
                .Select(line => line.Replace('/', '\\').Split(' ', 2, StringSplitOptions.RemoveEmptyEntries))
                .ToDictionary(s => s[0], s => s[1], StringComparer.OrdinalIgnoreCase);
        }
    }
}
