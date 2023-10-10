using System;
using System.IO;
using System.Diagnostics;
using System.Collections;
using System.Collections.Generic;
using System.Runtime.InteropServices;
using System.Text.RegularExpressions;

// For the Runfiles spec see https://docs.google.com/document/d/e/2PACX-1vSDIrFnFvEYhKsCMdGdD40wZRBX3m3aZ5HhVj4CtHPmiXKDCxioTUbYsDydjKtFDAzER5eg7OjJWs3V/pub
namespace Bazel
{

    /// <summary>
    /// Runfiles lookup library for Bazel-built Java binaries and tests.
    /// <example>
    /// USAGE:
    ///
    /// 1. Depend on this runfiles library from your build rule:
    ///
    /// <code>
    /// csharp_binary(
    ///     name = "my_binary",
    ///     ...
    ///     deps = ["@bazel_tools//tools/java/runfiles"],
    /// )
    /// </code>
    ///
    /// 2. Import the runfiles library.
    ///
    /// <code>
    /// using Bazel.Runfiles;
    /// </code>
    ///
    /// 3. Create a Runfiles object and use rlocation to look up runfile paths:
    ///
    /// <code>
    /// public void MyFunction() {
    ///   var runfiles = Runfiles.create();
    ///   var path = runfiles.Rlocation("my_workspace/path/to/my/data.txt");
    ///   ...
    /// }
    /// </code>
    ///
    /// If you want to start subprocesses that also need runfiles, you need to set the right
    /// environment variables for them:
    ///
    /// <code>
    /// var path = runfiles.Rlocation("path/to/binary");
    /// var process = new System.Diagnostics.Process();
    /// process.StartInfo.FileName = path;
    /// process.StartInfo.Environment = Runfiles.GetEnvVars();
    /// ...
    /// process.Start();
    /// </code>
    /// </example>
    /// </summary>
    public abstract class Runfiles
    {
        private Dictionary<string, string> repoMapping = new Dictionary<string, string>();
        private string sourceRepo;
        private readonly string legacyExternalGeneratedFileRegex = "^bazel-out[/][^/]+/bin/external/([^/]+)/";
        private readonly string legacyExternalFile = "^external/([^/]+)/";

        private Runfiles()
        {
        }

        /// <summary>
        /// Creates a new <c>Runfiles</c> instance.
        /// </summary>
        /// <returns>A new <c>Runfiles</c> instance.</returns>
        public static Runfiles Create()
        {
            var argv0 = System.Diagnostics.Process.GetCurrentProcess().MainModule.FileName;
            var env = new Dictionary<string, string>();
            foreach (DictionaryEntry e in System.Environment.GetEnvironmentVariables())
            {
                env.Add(e.Key.ToString(), e.Value.ToString());
            }
            return Create(argv0, env);
        }

        /// <summary>
        /// Creates a new <c>Runfiles</c> instance.
        ///
        /// The returned object is either:
        ///
        /// manifest-based: meaning it looks up runfile paths from a manifest file
        /// directory-based: meaning it looks up runfile paths under a given directory path
        ///
        /// If <paramref name="env"/> contains RUNFILES_MANIFEST_ONLY=1, this method returns a manifest-based implementation.
        /// The manifest's path is defined by the RUNFILES_MANIFEST_FILE key's value in <paramref name="env"/>.
        ///
        /// If <paramref name="env"/> contains RUNFILES_DIR=SOME_DIRECTORY or JAVA_RUNFILES=SOME_DIRECTORY,
        /// this method returns a directory-based implementation.
        ///
        /// Otherwise this method tries to find a the manifest file based on the argv0
        /// If argv0 + ".runfiles/MANFIEST" exists RUNFILES_MANIFEST_FILE will be set to to that path
        /// else if argv0 + ".runfiles_manifest" exists RUNFILES_MANIFEST_FILE will be set to to that path.
        /// If argv0 + ".runfiles" exists RUNFILES_DIR will be set to to that path.
        ///
        /// Note about performance: the manifest-based implementation eagerly reads and caches the whole manifest file upon
        /// instantiation.
        /// </summary>
        /// <param name="argv0">The first parameter to the running process. Usually the executable itself.</param>
        /// <param name="env">The environment variables to use.</param>
        /// <returns>A new <c>Runfiles</c> instance.</returns>
        /// <exception cref="System.IO.FileNotFoundException">
        /// If RUNFILES_MANIFEST_ONLY=1 is in <paramref name="env"/> but there's no
        /// "RUNFILES_MANIFEST_FILE", "RUNFILES_DIR", or "JAVA_RUNFILES" key in <paramref name="env"/> or their
        /// values are empty, or some IO error occurs
        /// </exception>
        public static Runfiles Create(string argv0, IDictionary<string, string> env, string sourceRepo = null)
        {
            Runfiles strategy;
            if (isManifestOnly(env))
            {
                // On Windows, Bazel sets RUNFILES_MANIFEST_ONLY=1.
                // On every platform, Bazel also sets RUNFILES_MANIFEST_FILE, but on Linux and macOS it's
                // faster to use RUNFILES_DIR.
                var manifestPath = getManifestPath(env);
                if (!String.IsNullOrEmpty(manifestPath))
                {
                    strategy = new ManifestBased(manifestPath);
                }
                else
                {
                    var argv0ManifestPath = getManifestPathFromArgv0(argv0);

                    if (!String.IsNullOrEmpty(argv0ManifestPath))
                    {
                        strategy = new ManifestBased(argv0ManifestPath);
                    }
                    else
                    {
                        throw new FileNotFoundException(
                                     "Cannot load runfiles manifest: $RUNFILES_MANIFEST_ONLY is 1 but"
                                         + " $RUNFILES_MANIFEST_FILE is empty or undefined."
                                         + " argv0 was: " + argv0);
                    }
                }
            }
            else
            {
                var runfilesDir = getRunfilesDir(env);
                if (!String.IsNullOrEmpty(runfilesDir))
                {
                    strategy = new DirectoryBased(runfilesDir);
                }
                else
                {
                    var argv0RunfilesDir = getRunfilesDirFromArgv0(argv0);
                    if (!String.IsNullOrEmpty(argv0RunfilesDir))
                    {
                        strategy = new DirectoryBased(argv0RunfilesDir);
                    }
                    else
                    {
                        throw new FileNotFoundException("Cannot find runfiles: $RUNFILES_DIR and $JAVA_RUNFILES are both unset or empty. argv0 was: " + argv0);
                    }
                }
            }

            strategy.ParseRepoMapping(strategy.Rlocation("_repo_mapping"));
            strategy.SetSourceRepo(sourceRepo);
            return strategy;
        }

        /// <summary>
        /// Returns the runtime path of a runfile (a Bazel-built binary's/test's data-dependency).
        ///
        /// The returned path may not be valid. The caller should check the path's validity and that the
        /// path exists.
        /// </summary>
        /// <param name="path">runfiles-root-relative path of the runfile</param>
        /// <returns>The runtime path of a runfile (a Bazel-built binary's/test's data-dependency).</returns>
        /// <exception cref="System.ArgumentException">
        /// If <paramref name="path"/> fails validation, for example if it's null or
        /// empty, or not normalized (contains "./", "../", or "//")
        /// </exception>
        public string Rlocation(string path)
        {
            if (string.IsNullOrEmpty(path))
            {
                throw new ArgumentException("path must not be null or empty");
            }
            if (path.Contains("../") || path.Contains("/..") || path.StartsWith("./") || path.Contains("/./") || path.EndsWith("/.") || path.Contains("//"))
            {
                throw new ArgumentException($"path is not normalized: \"{path}\"");
            }
            if (path.StartsWith("\\"))
            {
                throw new ArgumentException($"path is absolute without a drive letter: \"{path}\"");
            }

            if (IsPathFullyQualified(path))
            {
                return path;
            }

            var mappedPath = path;
            var split = path.Split(new char[] { '/' }, 2);
            if (split.Length == 2)
            {
                var targetRepo = split[0];
                var remainder = split[1];
                var key = $"{this.sourceRepo},{targetRepo}";
                if (this.repoMapping.ContainsKey(key))
                {
                    mappedPath = $"{this.repoMapping[key]}/{remainder}";
                }
            }

            return RlocationChecked(mappedPath);
        }

        /// <summary>
        /// Returns environment variables for subprocesses.
        /// The caller should add the returned key-value pairs to the environment of subprocesses in
        /// case those subprocesses are also Bazel-built binaries that need to use runfiles.
        /// </summary>
        public abstract IDictionary<string, string> GetEnvVars();

        private void ParseRepoMapping(string repoMappingPath)
        {
            if (!String.IsNullOrEmpty(repoMappingPath))
            {
                if (File.Exists(repoMappingPath))
                {
                    var lines = File.ReadAllLines(repoMappingPath);
                    foreach (var line in lines)
                    {
                        var segments = line.Split(',');
                        repoMapping[segments[0] + "," + segments[1]] = segments[2];
                    }
                }
            }
        }

        private void SetSourceRepo(string sourceRepo)
        {
            if (sourceRepo == null)
            {
                var caller = System.Reflection.Assembly.GetEntryAssembly().FullName;

                var legacyExternalGeneratedFileMatch = Regex.Match(caller, legacyExternalGeneratedFileRegex);
                if (legacyExternalGeneratedFileMatch.Success)
                {
                    this.sourceRepo = legacyExternalGeneratedFileMatch.Value;
                }
                else
                {
                    var legacyExternalFileMatch = Regex.Match(caller, legacyExternalFile);
                    if (legacyExternalFileMatch.Success)
                    {
                        this.sourceRepo = legacyExternalFileMatch.Value;
                    }
                    else
                    {
                        this.sourceRepo = "";
                    }
                }
            }
            else
            {
                this.sourceRepo = sourceRepo;
            }
        }


        /// <summary>
        /// Returns true if the path is fixed to a specific drive or UNC path. This method does no
        /// validation of the path (URIs will be returned as relative as a result).
        /// Returns false if the path specified is relative to the current drive or working directory.
        /// </summary>
        /// <param name="path">Path to check.</param>
        /// <remarks>
        /// Handles paths that use the alternate directory separator.  It is a frequent mistake to
        /// assume that rooted paths <see cref="System.IO.Path.IsPathRooted(string)"/> are not relative.  This isn't the case.
        /// "C:a" is drive relative- meaning that it will be resolved against the current directory
        /// for C: (rooted, but relative). "C:\a" is rooted and not relative (the current directory
        /// will not be used to modify the path).
        /// </remarks>
        /// <exception cref="ArgumentNullException">
        /// Thrown if <paramref name="path"/> is null.
        /// </exception>
        private static bool IsPathFullyQualified(string path)
        {
            if (path == null)
            {
                throw new ArgumentNullException(nameof(path));
            }

            return !IsPathPartiallyQualified(path);
        }

        /// <summary>
        /// Returns true if the path specified is relative to the current drive or working directory.
        /// Returns false if the path is fixed to a specific drive or UNC path.  This method does no
        /// validation of the path (URIs will be returned as relative as a result).
        /// </summary>
        /// <remarks>
        /// Handles paths that use the alternate directory separator.  It is a frequent mistake to
        /// assume that rooted paths (Path.IsPathRooted) are not relative.  This isn't the case.
        /// "C:a" is drive relative- meaning that it will be resolved against the current directory
        /// for C: (rooted, but relative). "C:\a" is rooted and not relative (the current directory
        /// will not be used to modify the path).
        /// </remarks>
        private static bool IsPathPartiallyQualified(string path)
        {
            if (!RuntimeInformation.IsOSPlatform(OSPlatform.Windows))
            {
                return !Path.IsPathRooted(path);
            }
            else
            {
                if (path.Length < 2)
                {
                    // It isn't fixed, it must be relative.  There is no way to specify a fixed
                    // path with one character (or less).
                    return false;
                }

                if (IsDirectorySeparator(path[0]))
                {
                    // There is no valid way to specify a relative path with two initial slashes or
                    // \? as ? isn't valid for drive relative paths and \??\ is equivalent to \\?\
                    return !(path[1] == '?' || IsDirectorySeparator(path[1]));
                }

                // The only way to specify a fixed path that doesn't begin with two slashes
                // is the drive, colon, slash format- i.e. C:\
                return !((path.Length >= 3)
                    && (path[1] == Path.VolumeSeparatorChar)
                    && IsDirectorySeparator(path[2])
                    // To match old behavior we'll check the drive character for validity as the path is technically
                    // not qualified if you don't have a valid drive. "=:\" is the "=" file's default data stream.
                    && IsValidDriveChar(path[0]));
            }
        }

        /// <summary>
        /// True if the given character is a directory separator.
        /// </summary>
        private static bool IsDirectorySeparator(char character)
        {
            return character == Path.DirectorySeparatorChar || character == Path.AltDirectorySeparatorChar;
        }

        /// <summary>
        /// Returns true if the given character is a valid drive letter
        /// </summary>
        private static bool IsValidDriveChar(char value)
        {
            return (uint)((value | 0x20) - 'a') <= (uint)('z' - 'a');
        }

        private static Boolean isManifestOnly(IDictionary<string, string> env)
        {
            env.TryGetValue("RUNFILES_MANIFEST_ONLY", out var value);
            return value == "1" ? true : false;
        }


        private static string getManifestPath(IDictionary<string, string> env)
        {
            env.TryGetValue("RUNFILES_MANIFEST_FILE", out var value);

            return value;
        }

        private static String getRunfilesDir(IDictionary<string, string> env)
        {
            env.TryGetValue("RUNFILES_DIR", out var value);
            if (String.IsNullOrEmpty(value))
            {
                env.TryGetValue("JAVA_RUNFILES", out value);
            }

            return value;
        }

        private static String getManifestPathFromArgv0(string argv0)
        {
            if (String.IsNullOrEmpty(argv0))
            {
                return "";
            }
            else
            {
                var parentDir = Directory.GetParent(argv0).ToString();
                var fileName = Path.GetFileName(argv0);

                // We need to work around this issue: https://github.com/dotnet/runtime/issues/11305
                var extension = Path.GetExtension(fileName);
                if (extension == ".dll")
                {
                    var fileWithoutExtension = Path.GetFileNameWithoutExtension(fileName);
                    fileName = RuntimeInformation.IsOSPlatform(OSPlatform.Windows) ? fileWithoutExtension + ".exe" : fileWithoutExtension;
                }


                var manifest = Path.Combine(parentDir, fileName + ".runfiles", "MANIFEST");

                if (File.Exists(manifest))
                {
                    return manifest;
                }

                manifest = Path.Combine(parentDir, fileName + ".runfiles_manifest");

                if (File.Exists(manifest))
                {
                    return manifest;
                }
            }

            return "";
        }

        private static String getRunfilesDirFromArgv0(string argv0)
        {
            if (String.IsNullOrEmpty(argv0))
            {
                return "";
            }
            else
            {
                var parentDir = Directory.GetParent(argv0).ToString();
                var fileName = Path.GetFileName(argv0);

                // We need to work around this issue: https://github.com/dotnet/runtime/issues/11305
                var extension = Path.GetExtension(fileName);
                if (extension == ".dll")
                {
                    var fileWithoutExtension = Path.GetFileNameWithoutExtension(fileName);
                    fileName = RuntimeInformation.IsOSPlatform(OSPlatform.Windows) ? fileWithoutExtension + ".exe" : fileWithoutExtension;
                }

                var runfilesDir = Path.Combine(parentDir, fileName + ".runfiles");

                if (Directory.Exists(runfilesDir))
                {
                    return runfilesDir;
                }
            }

            return "";
        }

        public abstract string RlocationChecked(string path);

        private class ManifestBased : Runfiles
        {
            private readonly IDictionary<string, string> runfiles;
            private readonly string manifestPath;

            internal ManifestBased(string manifestPath)
            {
                if (string.IsNullOrEmpty(manifestPath))
                {
                    throw new FileNotFoundException("Manifest path was null or empty");
                }

                this.manifestPath = manifestPath;
                this.runfiles = loadRunfiles(manifestPath);
            }

            private static IDictionary<string, string> loadRunfiles(string path)
            {
                var result = new Dictionary<string, string>();
                var lines = File.ReadAllLines(path);
                foreach (var line in lines)
                {
                    int index = line.IndexOf(' ');
                    var runfile = (index == -1) ? line : line.Substring(0, index);
                    var realPath = (index == -1) ? line : line.Substring(index + 1);
                    result.Add(runfile, realPath);
                }
                return result;
            }

            private static string findRunfilesDir(string manifest)
            {
                if (manifest.EndsWith("/MANIFEST") || manifest.EndsWith("\\MANIFEST") || manifest.EndsWith(".runfiles_manifest"))
                {
                    var path = manifest.Substring(0, manifest.Length - 9);
                    if ((File.GetAttributes(path) & FileAttributes.Directory) == FileAttributes.Directory)
                    {
                        return path;
                    }
                }
                return "";
            }

            public override String RlocationChecked(String path)
            {
                runfiles.TryGetValue(path, out var exactMatch);
                if (exactMatch != null)
                {
                    return exactMatch;
                }
                // If path references a runfile that lies under a directory that itself is a runfile, then
                // only the directory is listed in the manifest. Look up all prefixes of path in the manifest
                // and append the relative path from the prefix if there is a match.
                var prefixEnd = path.Length;
                while ((prefixEnd = path.LastIndexOf('/', prefixEnd - 1)) != -1)
                {
                    runfiles.TryGetValue(path.Substring(0, prefixEnd), out var prefixMatch);
                    if (prefixMatch != null)
                    {
                        return prefixMatch + '/' + path.Substring(prefixEnd + 1);
                    }
                }
                return null;
            }

            public override IDictionary<string, string> GetEnvVars()
            {
                var result = new Dictionary<string, string>(4);
                result.Add("RUNFILES_MANIFEST_ONLY", "1");
                result.Add("RUNFILES_MANIFEST_FILE", manifestPath);
                var runfilesDir = findRunfilesDir(manifestPath);
                result.Add("RUNFILES_DIR", runfilesDir);
                // TODO(laszlocsomor): remove JAVA_RUNFILES once the Java launcher can pick up RUNFILES_DIR.
                result.Add("JAVA_RUNFILES", runfilesDir);
                return result;
            }
        }

        private class DirectoryBased : Runfiles
        {
            private readonly string runfilesRoot;

            internal DirectoryBased(string runfilesDir)
            {
                if (string.IsNullOrEmpty(runfilesDir))
                {
                    throw new ArgumentException("Runfiles directory was null or empty");
                }

                if (!Directory.Exists(runfilesDir))
                {
                    throw new ArgumentException($"Runfiles directory did not exist: {runfilesDir}");
                }

                this.runfilesRoot = runfilesDir;
            }

            public override string RlocationChecked(string path)
            {
                return runfilesRoot + "/" + path;
            }

            public override IDictionary<string, string> GetEnvVars()
            {
                var result = new Dictionary<string, string>(2);
                result.Add("RUNFILES_DIR", runfilesRoot);
                // TODO(laszlocsomor): remove JAVA_RUNFILES once the Java launcher can pick up RUNFILES_DIR.
                result.Add("JAVA_RUNFILES", runfilesRoot);
                return result;
            }
        }

        public static Runfiles CreateManifestBasedForTesting(String manifestPath)
        {
            return new ManifestBased(manifestPath);
        }

        public static Runfiles CreateDirectoryBasedForTesting(String runfilesDir)
        {
            return new DirectoryBased(runfilesDir);
        }
    }
}
