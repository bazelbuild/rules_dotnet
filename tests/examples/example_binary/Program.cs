using System;
using example_lib;

namespace example_binary
{
    class MainClass
    {
        public static void Main(string[] args)
        {
            var mc = new MyClass();
            Console.WriteLine(mc.Message);
            Console.WriteLine($"Mono Runtime: {Type.GetType ("Mono.Runtime")}");
        }
    }
}
