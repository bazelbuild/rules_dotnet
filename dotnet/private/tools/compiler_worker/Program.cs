#nullable enable

using System;
using System.Collections.Generic;
using System.Diagnostics;
using System.IO;
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

        private static readonly Encoding Utf8WithBom = new UTF8Encoding(encoderShouldEmitUTF8Identifier: true);

        public static int Main(string[] args)
        {
            // <dotnet> <compiler.dll> [--persistent_worker] [args...]
            if (args.Length < 2)
            {
                Console.Error.WriteLine("usage: compiler_worker <dotnet> <compiler.dll> [flags...] [args...]");
                return 1;
            }

            var dotnet = args[0];
            var compiler = args[1];

            var rest = new List<string>();
            var persistent = false;
            foreach (var arg in args[2..])
            {
                if (arg == "--persistent_worker")
                {
                    persistent = true;
                }
                else
                {
                    rest.Add(arg);
                }
            }

            if (persistent)
            {
                return RunWorkerLoop(dotnet, compiler);
            }

            var output = new StringBuilder();
            var exitCode = Compile(dotnet, compiler, rest, shared: false, output);
            Console.Error.Write(output.ToString());
            return exitCode;
        }

        private static int RunWorkerLoop(string dotnet, string compiler)
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
                    exitCode = Compile(dotnet, compiler, arguments, shared: true, output);
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

        private static int Compile(string dotnet, string compiler, List<string> arguments, bool shared, StringBuilder output)
        {
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

            // Bazel expands its response file into the request arguments, and a
            // compile carrying the targeting pack's references is far past the
            // 32767 characters Windows allows on a command line, so they go back
            // into a response file. One line per argument, as Bazel wrote it.
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
