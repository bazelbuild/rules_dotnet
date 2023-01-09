using System;

namespace Compiler.Server.Multiplex
{
    internal static class Logger
    {
        public static void Log(string format, params object[] arguments)
        {
            var message = string.Format(format, arguments);
            Console.Error.WriteLine($"|{DateTime.Now:yyyy-dd-MM HH:mm:ss.fff}| {message}");
        }

        public static void Log(string message)
        {
            Console.Error.WriteLine($"|{DateTime.Now:yyyy-dd-MM HH:mm:ss.fff}| {message}");
        }
    }
}
