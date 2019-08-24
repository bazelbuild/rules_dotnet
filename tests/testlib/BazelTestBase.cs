using System;
using System.Buffers.Text;
using System.Collections;
using System.Collections.Generic;
using System.Diagnostics;
using System.IO;
using System.Linq;
using System.Security.Cryptography;
using System.Text;
using System.Threading.Tasks;

namespace testlib
{
    public class BazelTestBase
    {
        public int DoTest(string[] files, out string stdout, out string stderr)
        {
            var result = GetHash(files);

            var dir = Path.Combine(Path.GetTempPath(), result);
            CopyFiles(files, dir);
            return RunCommand(dir, out stdout, out stderr);
        }

        private int RunCommand(string dir, out string stdout, out string stderr)
        {
            var bazel = GetBazelPath();

            Environment.SetEnvironmentVariable("TEST_TMPDIR", "");

            Console.WriteLine($"Starting {bazel} in {dir}");

            using (var myProcess = new Process())
            {
                myProcess.StartInfo.UseShellExecute = false;
                myProcess.StartInfo.FileName = bazel;
                myProcess.StartInfo.CreateNoWindow = true;
                myProcess.StartInfo.Arguments = $"--bazelrc bazelrc test //...";
                myProcess.StartInfo.WorkingDirectory = dir;
                myProcess.StartInfo.RedirectStandardError = true;
                myProcess.StartInfo.RedirectStandardOutput = true;
                myProcess.Start();

                bool r = myProcess.WaitForExit(300 * 1000);
                if (!r)
                    myProcess.Kill();

                var err = myProcess.StandardError.ReadToEnd();
                var output = myProcess.StandardOutput.ReadToEnd();
                Console.WriteLine(output);
                Console.WriteLine(err);
                stdout = output;
                stderr = err;
                return r ? myProcess.ExitCode : -100;
            }

        }

        private string GetBazelPath()
        {
            var s = Environment.GetEnvironmentVariable("BAZEL");
            if (!string.IsNullOrEmpty(s))
                return s;

            s = Environment.GetEnvironmentVariable("BAZEL_VERSION");
            if (!string.IsNullOrEmpty(s))
            {
                var home = Environment.GetEnvironmentVariable("HOME");
                return $"{home}/.bazel/{s}/bin/bazel";
            }

            return "bazel";
        }

        private void CopyFiles(string[] files, string dir)
        {
            if (!Directory.Exists(dir))
                Directory.CreateDirectory(dir);

            var srcPath = Path.GetDirectoryName(GetType().Assembly.Location);

            foreach (var f in files)
            {
                var destpath = Path.Combine(dir, f.Replace(".in", ""));
                if (!File.Exists(destpath))
                {
                    if (Path.GetFileName(destpath).ToLower() == "workspace")
                    {
                        var workspace = File.ReadAllText(Path.Combine(srcPath, f));
                        workspace = workspace.Replace("%%RULES_DOTNET_WORKSPACE_ROOT%%", GetWorkspaceRoot());
                        File.WriteAllText(destpath, workspace);
                    }
                    else
                        File.Copy(Path.Combine(srcPath, f), destpath, true);
                }
            }

            var bazelrc = Path.Combine(dir, "bazelrc");
            if (!File.Exists(bazelrc))
                File.WriteAllText(bazelrc, GetBazelRc());
        }

        private string GetWorkspaceRoot()
        {
            var dir = Directory.GetParent(Directory.GetCurrentDirectory());
            while (dir != null)
            {
                var prospect = Path.Combine(dir.FullName, "external/io_bazel_rules_dotnet");
                if (Directory.Exists(prospect))
                {
                    var workspace = Path.Combine(prospect, "WORKSPACE");
                    if (File.Exists(workspace))
                        return prospect.Replace('\\', '/');
                }

                dir = dir.Parent;
            }
            return "/rules_dotnet";
        }

        private string GetHash(string[] files)
        {
            var combined = GetBazelRc();
            var srcPath = Path.GetDirectoryName(GetType().Assembly.Location);
            foreach (var f in files)
            {
                using (var sha = SHA256.Create())
                {
                    using (var stream = new FileStream(Path.Combine(srcPath, f), FileMode.Open))
                    {
                        var bytes = sha.ComputeHash(stream);
                        combined += Convert.ToBase64String(bytes);
                    }
                }
            }

            using (var sha = SHA256.Create())
            {
                var bytes = sha.ComputeHash(Encoding.ASCII.GetBytes(combined));
                return Uri.EscapeDataString(Convert.ToBase64String(bytes));
            }

        }

        public string GetBazelRc()
        {
            return @"
build --verbose_failures
build --sandbox_debug
build --test_output=errors
build --spawn_strategy=standalone
build --genrule_strategy=standalone

test --test_strategy=standalone
test --nocache_test_results
";
        }

    }
}
