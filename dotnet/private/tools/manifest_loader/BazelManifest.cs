using System;
using System.Collections;
using System.Collections.Generic;
using System.Diagnostics;
using System.IO;
using System.Linq;
using System.Reflection;
using System.Runtime.InteropServices;
using System.Runtime.Loader;

public class BazelManifest
{
    private static readonly string BinPath = Process.GetCurrentProcess().MainModule?.FileName;
    
    private static readonly string[] _manifest_options = 
    {
        Environment.GetEnvironmentVariable("RUNFILES_MANIFEST_FILE"),
        Path.Combine($"{AppContext.BaseDirectory}", $"{System.AppDomain.CurrentDomain.FriendlyName}.dll.runfiles", "MANIFEST"),
        Path.Combine($"{AppContext.BaseDirectory}", $"{System.AppDomain.CurrentDomain.FriendlyName}.exe.runfiles", "MANIFEST"),
        Path.Combine($"{AppContext.BaseDirectory}", $"{System.AppDomain.CurrentDomain.FriendlyName}.sh.runfiles", "MANIFEST"),
        Path.Combine($"{AppContext.BaseDirectory}", $"{System.AppDomain.CurrentDomain.FriendlyName}.bat.runfiles_manifest"),
    };

    private BazelManifest(string[] lines)
    {
        var dict = new Dictionary<string, string>(StringComparer.OrdinalIgnoreCase);
        foreach(var l in lines.Select(l => l.Split(' ')))
        {
            if (l[0].EndsWith(".dll", StringComparison.OrdinalIgnoreCase))
            {
                dict[Path.GetFileNameWithoutExtension(l[0])] = l[1];
            }
        }
        EntriesByFileName = dict;
    }

    public IReadOnlyDictionary<string, string> EntriesByFileName { get; }

    public static bool TryRead(out BazelManifest manifest)
    {
        foreach(var option in _manifest_options.Where(o => !string.IsNullOrEmpty(o)))
        {
            var file = new FileInfo(option);
            if(file.Exists)
            {
                manifest = new BazelManifest(File.ReadAllLines(option));
                return true;
            }
        }
        Console.WriteLine("No manifest file found!");
        manifest = null;
        return false;
    }

    public Assembly Resolve(AssemblyLoadContext context, AssemblyName name)
    {
        if (EntriesByFileName.TryGetValue(name.Name, out var path))
        {
            
            return context.LoadFromAssemblyPath(path);
        }

        return null;
    }

    public IntPtr ResolveUnmanagedDll(Assembly invoking, string assemblyName)
    {
        if (EntriesByFileName.TryGetValue(Path.GetFileNameWithoutExtension(assemblyName), out var path))
        {
            
            return NativeLibrary.Load(path);
        }

        return IntPtr.Zero;
    }
}
