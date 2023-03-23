using System;
using System.Linq;
using System.IO;
using static Lib.Stuff;

namespace Hello
{
    public static class Program
    {
        public static void Main(string[] args)
        {
            File.WriteAllText(args[0], Lib.Stuff.HelloWorld());
        }
    }
}
