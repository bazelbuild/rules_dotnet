using Bazel;
using LibGit2Sharp;
using System;
using System.IO;
using System.Diagnostics;

namespace AppToPublish
{
    public static class Program
    {
        public static void Main()
        {
            var process = Process.GetCurrentProcess();
            Console.WriteLine($"Process args: {Environment.GetCommandLineArgs()[0]}");
            Console.WriteLine($"Process args2: {System.Environment.ProcessPath}");
            Console.WriteLine($"Process location: {process.MainModule.FileName}");

            // Make sure that runfiles work when publishing
            var runfiles = Runfiles.Create();
            var dataFilePath = runfiles.Rlocation("rules_dotnet/tests/publish/app_to_publish/nested/runfiles/data-file");
            var data = File.ReadAllLines(dataFilePath)[0];

            if (data != "SOME CRAZY DATA!")
            {
                throw new Exception("Unexpected data in data file");
            }
            else
            {
                Console.WriteLine("Data file read successfully!");
            }

            // Make sure that native binaries work when publishing
            try
            {
                new Repository("./");
            }
            catch (RepositoryNotFoundException e)
            {
                Console.WriteLine("Got excpected RepositoryNotFoundException: " + e.Message);
            }
        }
    }
}


