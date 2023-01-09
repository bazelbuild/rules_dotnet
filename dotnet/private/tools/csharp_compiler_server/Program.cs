using System;
using System.Collections.Generic;
using System.Diagnostics;
using System.IO;
using System.Linq;
using System.Security.Cryptography;
using System.Text;
using System.Threading;
using System.Threading.Tasks;
using Blaze.Worker;
using dnlib.DotNet;
using Google.Protobuf;
using static Compiler.Server.Multiplex.Logger;

namespace Compiler.Server.Multiplex
{
    public static class Program
    {
        public static void Main(string[] args)
        {
            var dotnet = args[0]; // dotnet.exe
            var cscDir = Path.GetDirectoryName(args[1]);
            var csc = args[1]; // csc.dll
            var pathmap = args.Length > 2 ? Path.GetFullPath(args[2]) : null; // substitute the execroot with a stable or user defined path
            var vbcs = $@"{cscDir}\VBCSCompiler.dll";
            var pipe = GetPipeName(cscDir);
            var commitHash = GetCommitHash(csc);
            var tempDir = Path.GetTempPath();
            var serverLogFile = Path.GetTempFileName();

            var cancelSource = new CancellationTokenSource();

            Console.CancelKeyPress += (s, e) =>
            {
                Log("Cancel key");
                cancelSource.Cancel();
            };
            
            Log($"Server logging to: {serverLogFile}");

            var serverProcess = StartServerProcess(dotnet, vbcs, pipe, serverLogFile);

            while (!cancelSource.IsCancellationRequested)
            {
                var request = WorkRequest.Parser.ParseDelimitedFrom(Console.OpenStandardInput());

                switch (request.Arguments[0].ToLower())
                {
                    case "targets":
                        Task.Run(() => CreateTargets(request));
                        break;
                    default:
                        Log($"Received {request.RequestId}");
                        if (serverProcess.HasExited)
                        {
                            serverProcess = StartServerProcess(dotnet, vbcs, pipe, serverLogFile);
                        }
                        Task.Run(() => Compile(request));
                        break;
                }
            }

            Log("Done");

            void CreateTargets(WorkRequest request)
            {
                var symlinkResolver = new SymlinkResolver();
                
                string ScopePath(string path)
                {
                    if(symlinkResolver.TryResolveExternalSymlinkToAbsolutePath(path, out var absolutePath))
                    {
                        return absolutePath;
                    }
                    
                    return $"$(ExecRoot)\\{path}";
                }

                var outFolder = Path.GetDirectoryName(request.Arguments[2]).Replace('/', '\\') + "\\";

                var sb = new StringBuilder();

                foreach(var line in File.ReadAllLines(request.Arguments[1]))
                {
                    // compile files
                    if(!line.StartsWith('/'))
                    {
                        var compileFile = line.Trim('"').Replace('/', '\\');
                        // bazel generated compile files
                        if(compileFile.StartsWith(outFolder))
                        {
                            sb.Append($@"<BazelOutCompile Include=""{ScopePath(compileFile)}"">
    <Link>{compileFile.Substring(outFolder.Length)}</Link>
</BazelOutCompile>
");
                        }
                    }
                    else if(line.StartsWith("/reference:"))
                    {
                        var refPath = line.Substring(11).Replace('/', '\\');
                        var dllPath = refPath.Replace(".ref.dll", ".dll");
                        
                        string projectRef = string.Empty;
                        string sourceTarget = "ResolveAssemblyReference";
                        if(refPath.EndsWith(".ref.dll", StringComparison.OrdinalIgnoreCase)) // recognize bazel build project
                        {
                            sourceTarget = "ProjectReference";
                            projectRef = Path.GetRelativePath(Path.GetDirectoryName(request.Arguments[1]), Path.ChangeExtension(dllPath, ".csproj"));
                        }
                        
                        sb.Append($@"<CSCReference Include=""{ScopePath(dllPath)}"">
    <ReferenceAssembly>{ScopePath(refPath)}</ReferenceAssembly>
    <ReferenceOutputAssembly>true</ReferenceOutputAssembly>
    <ReferenceSourceTarget>{sourceTarget}</ReferenceSourceTarget>
    <ProjectReferenceOriginalItemSpec>{projectRef}</ProjectReferenceOriginalItemSpec>
    <OriginalProjectReferenceItemSpec>{projectRef}</OriginalProjectReferenceItemSpec>
</CSCReference>
");
                    }
                    else if (line.StartsWith("/analyzer:") && (line.EndsWith("SourceGenerator.dll") || line.EndsWith("SourceGeneration.dll")))
                    {
                        var analyzerPath = line.Substring(10).Replace('/', '\\');
                        sb.Append($"<CSCAnalyzer Include=\"{ScopePath(analyzerPath)}\" />\n\n");
                    }
                }

                // obj/....csproj.bazel.props file
                (string, string) SplitBin(string path)
                {
                    const string bin = "/bin/";
                    return (path.Substring(0, path.IndexOf(bin)), path.Substring(path.IndexOf(bin) + bin.Length));
                }

                var (to, from) = SplitBin(request.Arguments[2]);
                var objProps = Path.Combine(Path.GetDirectoryName(from), "obj", Path.GetFileName(from));
                new DirectoryInfo(Path.GetDirectoryName(objProps)).Create();
                var persistedProps = Path.GetFullPath(Path.ChangeExtension(request.Arguments[2], ".persist.props"));
                var parameterizedTo = $"{to.Substring(0, to.LastIndexOf('-') + 1)}$(BazelCompilationMode)";
                var parameterizedPersistedProps = Path.Combine(Directory.GetCurrentDirectory(), parameterizedTo, "bin", Path.ChangeExtension(from, ".persist.props"));
                File.WriteAllText(objProps, $@"<?xml version=""1.0"" encoding=""utf-8""?>
<Project>
  <PropertyGroup>
    <BazelCompilationMode Condition=""'$(Configuration)'=='Release'"">opt</BazelCompilationMode>
    <BazelCompilationMode Condition=""'$(Configuration)'!='Release'"">dbg</BazelCompilationMode>
    <ExecRoot>{Directory.GetCurrentDirectory()}</ExecRoot>
    <BazelPropsUpdatedAt>{DateTime.UtcNow:o}</BazelPropsUpdatedAt>
    <BazelPropsPath>{parameterizedPersistedProps}</BazelPropsPath>
  </PropertyGroup>
  <Import Project=""$(BazelPropsPath)"" Condition=""exists('$(BazelPropsPath)')"" />
</Project>
");

                // Deleted by bazel. We do not use it but bazel requires it to be written
                File.WriteAllText(request.Arguments[2], string.Empty);
                // Write this file outside of bazels knowledge so it wont be temporarily deleted
                File.WriteAllText(persistedProps, @$"<?xml version=""1.0"" encoding=""utf-8""?>
<Project>
  <ItemGroup>
{sb}
  </ItemGroup>
</Project>
");

                new WorkResponse
                {
                    ExitCode = 0,
                    RequestId = request.RequestId,
                    Output = string.Empty
                }.WriteDelimitedTo(Console.OpenStandardOutput());
            }

            async Task Compile(WorkRequest request)
            {
                var client = new Client(pipe, tempDir, commitHash, pathmap);
                var response = await client.Work(request.RequestId, request.Arguments[1], cancelSource.Token).ConfigureAwait(false);

                if (response.ExitCode == 0 && request.Arguments.Count >= 4)
                {
                    var cscParamsFile = request.Arguments[1];
                    var unusedRefsOutput = request.Arguments[2];
                    var dll = request.Arguments[3];
                    var unusedReferences = ResolveUnusedReferences(cscParamsFile, dll);
                    File.WriteAllText(Path.GetFullPath(unusedRefsOutput), string.Join("\n", unusedReferences));
                }

                response.WriteDelimitedTo(Console.OpenStandardOutput());

                Log($"Replied {response.RequestId}");
            }
        }

        private static Process StartServerProcess(string dotnet, string vbcs, string pipe, string logFilePath)
        {
            Process serverProcess = new Process();
            var processStartInfo = new ProcessStartInfo(dotnet, $"\"{vbcs}\" -pipename:{pipe}");
            processStartInfo.RedirectStandardOutput = true;
            processStartInfo.RedirectStandardError = true;
            processStartInfo.Environment["RoslynCommandLineLogFile"] = logFilePath;
            serverProcess.StartInfo = processStartInfo;
            serverProcess.OutputDataReceived += (sender, args) => Console.Error.WriteLine(args.Data);
            serverProcess.ErrorDataReceived += (sender, args) => Console.Error.WriteLine(args.Data);

            serverProcess.Exited += (sender, args) =>
            {
                Log("VBCS exited");
            };
            serverProcess.Start();
            Log("VBCS Started");

            return serverProcess;
        }

        private static IEnumerable<string> ResolveUnusedReferences(string cscParamsFile, string dll)
        {
            var prefix = "/reference:";
            var prefixL = prefix.Length;

            var refs = File.ReadAllText(cscParamsFile)
                .Split("\n")
                .Where(l => l.StartsWith(prefix))
                .Select(r => r.Substring(prefixL).Trim());

            var usedRefs = GetReferencedAssemblies(dll)
                .ToHashSet(StringComparer.OrdinalIgnoreCase);

            var refDll = ".ref.dll";
            var d = ".dll";

            return refs
                .Where(r =>
                {
                    var f = Path.GetFileName(r);
                    var fn = f.Substring(0, f.Length - (f.EndsWith(refDll) ? refDll.Length : d.Length));
                    return !usedRefs.Contains(fn);
                });
        }

        private static IEnumerable<string> GetReferencedAssemblies(string file)
        {
            var ctx = ModuleDef.CreateModuleContext();
            // Read all bytes so we wont keep the file open
            ModuleDefMD module = ModuleDefMD.Load(File.ReadAllBytes(Path.GetFullPath(file)), ctx);
            return module.Assembly.ManifestModule.GetAssemblyRefs().Select(r => r.Name.String);
        }

        private static string GetCommitHash(string file)
        {
            var ctx = ModuleDef.CreateModuleContext();
            // Read all bytes so we wont keep the file open
            ModuleDefMD module = ModuleDefMD.Load(File.ReadAllBytes(Path.GetFullPath(file)), ctx);
            var attribute = module.Assembly.CustomAttributes.FirstOrDefault(a => a.TypeFullName.Contains("CommitHashAttribute"));
            return attribute.ConstructorArguments[0].Value.ToString();
        }

        private static string GetPipeName(string compilerExeDirectory)
        {
            // Normalize away trailing slashes.  File APIs include / exclude this with no 
            // discernable pattern.  Easiest to normalize it here vs. auditing every caller
            // of this method.
            compilerExeDirectory = compilerExeDirectory.TrimEnd(Path.DirectorySeparatorChar);

            var pipeNameInput = $"{Environment.UserName}.{compilerExeDirectory}";
            using (var sha = SHA256.Create())
            {
                var bytes = sha.ComputeHash(Encoding.UTF8.GetBytes(pipeNameInput));
                return Convert.ToBase64String(bytes)
                    .Replace("/", "_")
                    .Replace("=", string.Empty);
            }
        }
    }
}
