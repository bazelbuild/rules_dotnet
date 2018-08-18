using System;
using example_lib;

namespace example_tool
{
    class MainClass
    {
        public static void Main(string[] args)
        {
            Console.WriteLine("Invoked");
            if (args.Length == 0) {
                Console.Error.WriteLine("No output files specified!");
                Environment.Exit(1);
            }

            var mc = new MyClass();
            foreach (string output_file in args) {
                Console.WriteLine("Generating {0}", output_file);
                System.IO.File.WriteAllText(output_file, mc.Message);
            }
        }
    }
}
