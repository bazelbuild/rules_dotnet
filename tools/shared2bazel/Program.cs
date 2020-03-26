using System;
using System.Reflection;
using System.Text.Json;
using System.IO;
using System.Buffers;
using System.Text.RegularExpressions;
using System.Text;
using System.Linq;

namespace shared2bazel
{
    class Program
    {
        static void Main(string[] args)
        {
            //var root = "/usr/local/share/dotnet/shared/Microsoft.AspNetCore.App/3.1.1/";
            ////var jsonPath = args[1];
            //var jsonPath = "/usr/local/share/dotnet/shared/Microsoft.AspNetCore.App/3.1.1/Microsoft.AspNetCore.App.deps.json";
            
            var root = "/usr/local/share/dotnet/shared/Microsoft.NETCore.App/3.1.1/";
            //var jsonPath = args[1];
            var jsonPath = "/usr/local/share/dotnet/shared/Microsoft.NETCore.App/3.1.1/Microsoft.NETCore.App.deps.json";
            string jsonText;
            using (StreamReader r = new StreamReader(jsonPath))
            {
                jsonText = r.ReadToEnd();
            }

            //MatchCollection matches = Regex.Matches(jsonText, "\"(.*?\\.dll)\"");
            MatchCollection matches = Regex.Matches(jsonText, "/([^/]*?\\.dll)\"");
            StringBuilder sb = new StringBuilder();
            foreach (Match match in matches) {
                if (match.Groups[1].ToString().ToLower() != "system.runtime.intrinsics.dll") {
                    Console.WriteLine($"Skipping {match.Groups[1]}");
                    continue;
                }
                var assemblies = Assembly.LoadFile(root + match.Groups[1]).GetReferencedAssemblies();
                sb.AppendLine("    core_stdlib(");
                sb.AppendLine($"        name = \"{match.Groups[1].ToString().ToLower()}\",");
                sb.AppendLine("        deps = [");
                foreach (var assembly in assemblies.OrderBy(i => i.Name))
                {
                    sb.AppendLine($"            \":{assembly.Name.ToLower()}.dll\",");
                }
                sb.AppendLine("        ],");
                sb.AppendLine("        dotnet_context_data = context,");
                sb.AppendLine("    )");
            }

            System.Console.Write(sb.ToString());
        }
    }
}
