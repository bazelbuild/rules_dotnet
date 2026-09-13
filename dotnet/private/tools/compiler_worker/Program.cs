#nullable enable

using System;
using System.Collections.Generic;
using System.Diagnostics;
using System.IO;
using System.Reflection.Metadata;
using System.Reflection.PortableExecutable;
using System.Runtime.InteropServices;
using System.Text;
using System.Text.Json;

namespace CompilerWorker
{
    /// <summary>
    /// Runs the Roslyn command line compiler: as a Bazel persistent worker when
    /// Bazel passes <c>--persistent_worker</c>, and as a single compilation
    /// otherwise, so that turning the worker strategy off is always safe.
    ///
    /// Living across compilations is what lets Roslyn's build server be reused,
    /// which is where nearly all of the time of a small compilation goes.
    /// </summary>
    public static class Program
    {
        private static readonly JsonSerializerOptions JsonOptions = new JsonSerializerOptions
        {
            PropertyNameCaseInsensitive = true,
        };

        /// <summary>csc only reads a response file as UTF-8 if it starts with a BOM.</summary>
        private static readonly Encoding Utf8WithBom = new UTF8Encoding(encoderShouldEmitUTF8Identifier: true);

        /// <summary>
        /// Assembly name of each reference read so far, keyed by path, size and
        /// mtime so that a changed file is read again. A file name is not a
        /// reliable stand-in for the assembly name, and re-reading ~170 reference
        /// assemblies per compilation would undo the point of the worker.
        /// </summary>
        private static readonly Dictionary<string, string?> AssemblyNameCache = new Dictionary<string, string?>();

        public static int Main(string[] args)
        {
            // <dotnet> <compiler.dll> [--persistent_worker] [--prune_unused_inputs] [args...]
            if (args.Length < 2)
            {
                Console.Error.WriteLine("usage: compiler_worker <dotnet> <compiler.dll> [flags...] [args...]");
                return 1;
            }

            var dotnet = args[0];
            var compiler = args[1];

            var rest = new List<string>();
            var persistent = false;
            var pruneUnusedInputs = false;
            foreach (var arg in args[2..])
            {
                if (arg == "--persistent_worker")
                {
                    persistent = true;
                }
                else if (arg == "--prune_unused_inputs")
                {
                    pruneUnusedInputs = true;
                }
                else
                {
                    rest.Add(arg);
                }
            }

            if (persistent)
            {
                return RunWorkerLoop(dotnet, compiler, pruneUnusedInputs);
            }

            var output = new StringBuilder();
            var exitCode = Compile(dotnet, compiler, rest, shared: false, pruneUnusedInputs, output);
            Console.Error.Write(output.ToString());
            return exitCode;
        }

        private static int RunWorkerLoop(string dotnet, string compiler, bool pruneUnusedInputs)
        {
            using var stdin = Console.OpenStandardInput();
            using var stdout = Console.OpenStandardOutput();

            var pending = new List<byte>();
            while (ReadRequest(stdin, pending) is { } request)
            {
                var arguments = request.Arguments ?? new List<string>();
                var output = new StringBuilder();
                int exitCode;
                try
                {
                    exitCode = Compile(dotnet, compiler, arguments, shared: true, pruneUnusedInputs, output);
                }
                catch (Exception e)
                {
                    // One bad request must not take the worker down with it.
                    output.AppendLine(e.ToString());
                    exitCode = 1;
                }

                WriteResponse(stdout, request.RequestId, exitCode, output.ToString());
            }

            return 0;
        }

        private static int Compile(string dotnet, string compiler, List<string> arguments, bool shared, bool pruneUnusedInputs, StringBuilder output)
        {
            arguments = ExpandResponseFiles(arguments);

            var startInfo = new ProcessStartInfo
            {
                FileName = dotnet,
                RedirectStandardOutput = true,
                RedirectStandardError = true,
                UseShellExecute = false,
            };

            startInfo.ArgumentList.Add(compiler);

            if (shared)
            {
                // Reuse Roslyn's build server between compilations, but do not let
                // it outlive the build by much: Bazel kills the worker, and the
                // server is the worker's own child.
                startInfo.ArgumentList.Add("/shared");
                startInfo.ArgumentList.Add("/keepalive:60");
            }

            // A compile carrying the targeting pack's references is far past the
            // 32767 characters Windows allows on a command line, so the arguments
            // go back into a response file. One line per argument.
            var responseFile = Path.Combine(Path.GetTempPath(), Path.GetRandomFileName() + ".rsp");
            File.WriteAllLines(responseFile, arguments, Utf8WithBom);
            startInfo.ArgumentList.Add("@" + responseFile);

            // csc embeds absolute paths into its output, and the execution root is
            // not known at analysis time, so the pathmap is built here.
            startInfo.ArgumentList.Add("-pathmap:" + Directory.GetCurrentDirectory() + "=.");

            try
            {
                using var process = Process.Start(startInfo);
                if (process == null)
                {
                    output.AppendLine("failed to start " + dotnet);
                    return 1;
                }

                // Drain both pipes at once: filling one while blocked on the other deadlocks.
                var standardOutput = process.StandardOutput.ReadToEndAsync();
                var standardError = process.StandardError.ReadToEndAsync();
                output.Append(standardOutput.GetAwaiter().GetResult());
                output.Append(standardError.GetAwaiter().GetResult());
                process.WaitForExit();

                if (pruneUnusedInputs)
                {
                    WriteUnusedInputs(arguments, process.ExitCode, output);
                }

                return process.ExitCode;
            }
            finally
            {
                // Never let a failed cleanup replace the compilation's own error.
                try
                {
                    File.Delete(responseFile);
                }
                catch (IOException)
                {
                }
            }
        }

        /// <summary>
        /// Inlines any <c>@file</c> argument. Bazel expands the response file into
        /// the request itself under the worker protocol, but passes it through as
        /// <c>@file</c> when this binary runs as a plain action, and the rest of
        /// the code only wants to deal with one of those shapes.
        /// </summary>
        private static List<string> ExpandResponseFiles(List<string> arguments)
        {
            var expanded = new List<string>(arguments.Count);
            foreach (var argument in arguments)
            {
                if (argument.StartsWith('@') && File.Exists(argument[1..]))
                {
                    expanded.AddRange(File.ReadAllLines(argument[1..]));
                }
                else
                {
                    expanded.Add(argument);
                }
            }

            return expanded;
        }

        private static string? AssemblyNameOf(string path)
        {
            string key;
            try
            {
                var info = new FileInfo(path);
                key = path + "|" + info.Length + "|" + info.LastWriteTimeUtc.Ticks;
            }
            catch (IOException)
            {
                return null;
            }

            if (AssemblyNameCache.TryGetValue(key, out var cached))
            {
                return cached;
            }

            string? name = null;
            try
            {
                using var stream = File.OpenRead(path);
                using var peReader = new PEReader(stream);
                if (peReader.HasMetadata)
                {
                    var metadata = peReader.GetMetadataReader();
                    name = metadata.GetString(metadata.GetAssemblyDefinition().Name);
                }
            }
            catch (Exception)
            {
                // Not a managed assembly, or unreadable. Null means the reference
                // counts as used, which is the safe direction.
            }

            AssemblyNameCache[key] = name;
            return name;
        }

        /// <summary>
        /// Writes the references that contributed nothing to the output, for
        /// Bazel's <c>unused_inputs_list</c>, next to the assembly that was just
        /// built. The used set is that assembly's reference table; anything that
        /// cannot be determined counts as used, so an unreadable file never prunes
        /// a reference that mattered.
        /// </summary>
        private static void WriteUnusedInputs(List<string> arguments, int exitCode, StringBuilder output)
        {
            var references = new List<string>();
            string? outputAssembly = null;
            foreach (var rawLine in arguments)
            {
                var line = rawLine.Trim();
                if (line.StartsWith("-r:", StringComparison.Ordinal))
                {
                    references.Add(line[3..]);
                }
                else if (line.StartsWith("/out:", StringComparison.Ordinal))
                {
                    outputAssembly = line[5..];
                }
            }

            if (outputAssembly == null)
            {
                return;
            }

            var unusedInputsFile = outputAssembly + ".unused_inputs";

            // An empty list keeps every input, which is always correct. Nothing was
            // produced on failure, so nothing can be shown to be unused.
            if (exitCode != 0 || !File.Exists(outputAssembly))
            {
                File.WriteAllText(unusedInputsFile, "");
                return;
            }

            var used = new HashSet<string>(StringComparer.OrdinalIgnoreCase);
            try
            {
                using var stream = File.OpenRead(outputAssembly);
                using var peReader = new PEReader(stream);
                var metadata = peReader.GetMetadataReader();
                foreach (var handle in metadata.AssemblyReferences)
                {
                    used.Add(metadata.GetString(metadata.GetAssemblyReference(handle).Name));
                }
            }
            catch (Exception e)
            {
                output.AppendLine("could not read assembly references from " + outputAssembly + ": " + e.Message);
                File.WriteAllText(unusedInputsFile, "");
                return;
            }

            var unused = new List<string>();
            foreach (var reference in references)
            {
                var name = AssemblyNameOf(reference);
                if (name != null && !used.Contains(name))
                {
                    unused.Add(reference);
                }
            }

            File.WriteAllLines(unusedInputsFile, unused);
        }

        private sealed class WorkRequest
        {
            public int RequestId { get; set; }

            public List<string>? Arguments { get; set; }
        }

        /// <summary>
        /// Reads the next work request, or null at end of stream. Bazel's JSON
        /// worker protocol writes the objects back to back with no delimiter
        /// between them, so <paramref name="pending"/> carries whatever was read
        /// past the end of the last one.
        /// </summary>
        private static WorkRequest? ReadRequest(Stream stream, List<byte> pending)
        {
            Span<byte> chunk = stackalloc byte[8192];

            while (true)
            {
                if (TryTakeRequest(pending, out var request))
                {
                    return request;
                }

                var read = stream.Read(chunk);
                if (read <= 0)
                {
                    return null;
                }

                pending.AddRange(chunk[..read]);
            }
        }

        private static bool TryTakeRequest(List<byte> pending, out WorkRequest? request)
        {
            // isFinalBlock: false makes a half-received object a "not yet", rather
            // than a parse error.
            var reader = new Utf8JsonReader(CollectionsMarshal.AsSpan(pending), isFinalBlock: false, state: default);
            if (!JsonDocument.TryParseValue(ref reader, out var document))
            {
                request = null;
                return false;
            }

            using (document)
            {
                request = document.RootElement.Deserialize<WorkRequest>(JsonOptions);
            }

            pending.RemoveRange(0, (int)reader.BytesConsumed);
            return true;
        }

        private static void WriteResponse(Stream stdout, int requestId, int exitCode, string output)
        {
            using var writer = new Utf8JsonWriter(stdout, new JsonWriterOptions { SkipValidation = true });
            writer.WriteStartObject();
            writer.WriteNumber("exitCode", exitCode);
            writer.WriteString("output", output);
            writer.WriteNumber("requestId", requestId);
            writer.WriteEndObject();
            writer.Flush();
            stdout.Flush();
        }
    }
}
