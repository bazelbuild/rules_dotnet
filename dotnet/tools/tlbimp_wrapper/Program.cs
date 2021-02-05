using System;
using System.Collections.Generic;
using System.Diagnostics;
using System.Text;
using System.Threading.Tasks;
using Microsoft.Win32;

namespace tblimp_wrapper
{
    class Program
    {
        static void Main(string[] args)
        {
            if (args.Length != 8)
            {
                Console.WriteLine("Usage: tblimp_wrapper tlbimppath guid major_version minor_version lcid platform namespace output ");
                Environment.Exit(-1);
            }

            var tlbimppath = args[0];
            var guid = args[1];
            var major_version = args[2];
            var minor_version = args[3];
            var lcid = args[4];
            var platform = args[5];
            var nspace = args[6];
            var output = args[7];

            var r = RegistryKey.OpenBaseKey(RegistryHive.ClassesRoot, RegistryView.Default);
            var key = $"TypeLib\\{{{guid}}}\\{major_version}.{minor_version}\\{lcid}\\{platform}";
            var k = r.OpenSubKey(key);
            if (k == null)
            {
                Console.WriteLine($"Failed to open registry key {key}");
                Environment.Exit(-1);
            }
            object dll = k.GetValue("");
            if (dll == null || !(dll is string))
            {
                Console.WriteLine($"Unexpected value {dll} from registry");
                Environment.Exit(-1);
            }

            output = output.Replace("%SystemRoot", Environment.SystemDirectory);

            try
            {
                using (var myProcess = new Process())
                {
                    myProcess.StartInfo.UseShellExecute = false;
                    myProcess.StartInfo.FileName = tlbimppath;
                    myProcess.StartInfo.CreateNoWindow = true;
                    myProcess.StartInfo.Arguments = $"{dll} /out:{output} /namespace:{nspace}";
                    myProcess.StartInfo.RedirectStandardError = true;
                    myProcess.StartInfo.RedirectStandardOutput = true;
                    myProcess.Start();

                    myProcess.WaitForExit();

                    var stderr = myProcess.StandardError.ReadToEnd();
                    var stdout = myProcess.StandardOutput.ReadToEnd();
                    Console.WriteLine(stdout);
                    Console.WriteLine(stderr);
                    Environment.Exit(myProcess.ExitCode);
                }
            }
            catch (Exception e)
            {
                Console.WriteLine(e.Message);
                Environment.Exit(-1);
            }
        }
    }
}
