using System;
using System.Diagnostics;
using System.Text;
using System.Threading.Tasks;

namespace testlib
{
    // based on https://gist.github.com/AlexMAS/276eed492bc989e13dcce7c78b9e179d
    public static class ProcessAsyncHelper
    {
        public static async Task<ProcessResult> RunProcessAsync(string command, string arguments, string workingdir, int timeout)
        {
            var result = new ProcessResult();

            using (var process = new Process())
            {
                process.StartInfo.FileName = command;
                process.StartInfo.Arguments = arguments;
                process.StartInfo.WorkingDirectory = workingdir;
                process.StartInfo.UseShellExecute = false;
                process.StartInfo.RedirectStandardOutput = true;
                process.StartInfo.RedirectStandardError = true;
                process.StartInfo.CreateNoWindow = true;

                var outputBuilder = new StringBuilder();
                var outputCloseEvent = new TaskCompletionSource<bool>();

                process.OutputDataReceived += (s, e) =>
                {
                    if (e.Data == null)
                    {
                        outputCloseEvent.SetResult(true);
                    }
                    else
                    {
                        outputBuilder.Append(e.Data);
                        outputBuilder.Append('\n');
                    }
                };

                var errorBuilder = new StringBuilder();
                var errorCloseEvent = new TaskCompletionSource<bool>();

                process.ErrorDataReceived += (s, e) =>
                {
                    if (e.Data == null)
                    {
                        errorCloseEvent.SetResult(true);
                    }
                    else
                    {
                        errorBuilder.Append(e.Data);
                        errorBuilder.Append('\n');
                    }
                };

                var isStarted = process.Start();
                if (!isStarted)
                {
                    result.ExitCode = process.ExitCode;
                    return result;
                }

                // Reads the output stream first and then waits because deadlocks are possible
                process.BeginOutputReadLine();
                process.BeginErrorReadLine();

                // Creates task to wait for process exit using timeout
                var waitForExit = WaitForExitAsync(process, timeout);

                // Create task to wait for process exit and closing all output streams
                var processTask = Task.WhenAll(waitForExit, outputCloseEvent.Task, errorCloseEvent.Task);

                // Waits process completion and then checks it was not completed by timeout
                if (await Task.WhenAny(Task.Delay(timeout), processTask) == processTask && waitForExit.Result)
                {
                    result.ExitCode = process.ExitCode;
                    result.Output = outputBuilder.ToString();
                    result.Error = errorBuilder.ToString();
                }
                else
                {
                    try
                    {
                        // Kill hung process
                        process.Kill();
                    }
                    catch
                    {
                        // ignored
                    }
                }
            }

            return result;
        }


        private static Task<bool> WaitForExitAsync(Process process, int timeout)
        {
            return Task.Run(() => process.WaitForExit(timeout));
        }


        public struct ProcessResult
        {
            public int? ExitCode;
            public string Output;
            public string Error;
        }
    }
}