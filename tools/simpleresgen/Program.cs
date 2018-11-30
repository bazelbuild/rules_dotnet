using System;
using System.Reflection;

namespace simpleresgen
{
    class Program
    {
        static void Main(string[] args)
        {
            if (args.Length != 2)
            {
                Console.WriteLine($"Usage: {Assembly.GetExecutingAssembly().FullName} <infile.resx> <outfile.resources>");
                Environment.Exit(-1);
            }

            var infile = args[0];
            var outfile = args[1];
            try
            {
                var translator = new Translator();
                translator.Translate(infile, outfile);
            }
            catch (Exception ex)
            {
                Console.WriteLine($"Exception: {ex.ToString()}\n{ex.StackTrace}");
                Environment.Exit(-1);
            }
        }
    }
}
