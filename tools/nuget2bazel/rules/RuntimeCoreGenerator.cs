using System;
using System.Collections.Generic;
using System.Diagnostics;
using System.IO;
using System.Linq;
using System.Reflection;
using System.Threading.Tasks;

namespace nuget2bazel.rules
{
    class RuntimeCoreGenerator
    {
        private readonly string _configDir;
        private readonly string _rulesPath;

        public RuntimeCoreGenerator(string configDir, string rulesPath)
        {
            _configDir = configDir;
            _rulesPath = rulesPath;
        }

        public async Task Do()
        {
            await using var f = new StreamWriter(Path.Combine(_rulesPath, "dotnet/private/runtime_generated.bzl"));
            var sdks = new[]
            {
                new Tuple<string, string, string, string, string>("2.0.7", "v2.1.200",
                    "https://download.microsoft.com/download/3/7/1/37189942-C91D-46E9-907B-CF2B2DE584C7/dotnet-sdk-2.1.200-win-x64.zip",
                    "https://download.microsoft.com/download/3/7/1/37189942-C91D-46E9-907B-CF2B2DE584C7/dotnet-sdk-2.1.200-linux-x64.tar.gz",
                    "https://download.microsoft.com/download/3/7/1/37189942-C91D-46E9-907B-CF2B2DE584C7/dotnet-sdk-2.1.200-osx-x64.tar.gz"
                ),
                new Tuple<string, string, string, string, string>("2.1.6", "v2.1.502",
                    "https://download.visualstudio.microsoft.com/download/pr/c88b53e5-121c-4bc9-af5d-47a9d154ea64/e62eff84357c48dc8052a9c6ce5dfb8a/dotnet-sdk-2.1.502-win-x64.zip",
                    "https://download.visualstudio.microsoft.com/download/pr/4c8893df-3b05-48a5-b760-20f2db692c45/ff0545dbbb3c52f6fa38657ad97d65d8/dotnet-sdk-2.1.502-linux-x64.tar.gz",
                    "https://download.visualstudio.microsoft.com/download/pr/50729ca4-03ce-4e19-af87-bfae014b0431/1c830d9dcffa7663702e32fab6953425/dotnet-sdk-2.1.502-osx-x64.tar.gz"
                ),
                new Tuple<string, string, string, string, string>("2.1.7", "v2.1.503",
                    "https://download.visualstudio.microsoft.com/download/pr/81e18dc2-7747-4b2d-9912-3be0f83050f1/5bc41cb27df3da63378df2d051be4b7f/dotnet-sdk-2.1.503-win-x64.zip",
                    "https://download.visualstudio.microsoft.com/download/pr/04d83723-8370-4b54-b8b9-55708822fcde/63aab1f4d0be5246e3a92e1eb3063935/dotnet-sdk-2.1.503-linux-x64.tar.gz",
                    "https://download.visualstudio.microsoft.com/download/pr/c922688d-74e8-4af5-bcc8-5850eafbca7f/cf3b9a0b06c0dfa3a5098f893a9730bd/dotnet-sdk-2.1.503-osx-x64.tar.gz"
                ),
                new Tuple<string, string, string, string, string>("2.2.0", "v2.2.101",
                    "https://download.visualstudio.microsoft.com/download/pr/25d4104d-1776-41cb-b96e-dff9e9bf1542/b878c013de90f0e6c91f6f3c98a2d592/dotnet-sdk-2.2.101-win-x64.zip",
                    "https://download.visualstudio.microsoft.com/download/pr/80e1d007-d6f0-402f-b047-779464dd989b/9ae5e2df9aa166b720bdb92d19977044/dotnet-sdk-2.2.101-linux-x64.tar.gz",
                    "https://download.visualstudio.microsoft.com/download/pr/55c65d12-5f99-45d3-aa14-35359a6d02ca/3f6bcd694e3bfbb84e6b99e65279bd1e/dotnet-sdk-2.2.101-osx-x64.tar.gz"
                ),
                new Tuple<string, string, string, string, string>("2.2.7", "v2.2.402",
                    "https://download.visualstudio.microsoft.com/download/pr/8ac3e8b7-9918-4e0c-b1be-5aa3e6afd00f/0be99c6ab9362b3c47050cdd50cba846/dotnet-sdk-2.2.402-win-x64.zip",
                    "https://download.visualstudio.microsoft.com/download/pr/46411df1-f625-45c8-b5e7-08ab736d3daa/0fbc446088b471b0a483f42eb3cbf7a2/dotnet-sdk-2.2.402-linux-x64.tar.gz",
                    "https://download.visualstudio.microsoft.com/download/pr/2079de3a-714b-4fa5-840f-70e898b393ef/d631b5018560873ac350d692290881db/dotnet-sdk-2.2.402-osx-x64.tar.gz"
                ),
                new Tuple<string, string, string, string, string>("3.0.0", "v3.0.100",
                    "https://download.visualstudio.microsoft.com/download/pr/a24f4f34-ada1-433a-a437-5bc85fc2576a/7e886d06729949c15c96fe7e70faa8ae/dotnet-sdk-3.0.100-win-x64.zip",
                    "https://download.visualstudio.microsoft.com/download/pr/886b4a4c-30af-454b-8bec-81c72b7b4e1f/d1a0c8de9abb36d8535363ede4a15de6/dotnet-sdk-3.0.100-linux-x64.tar.gz",
                    "https://download.visualstudio.microsoft.com/download/pr/b9251194-4118-41cb-ae05-6763fb002e5d/1d398b4e97069fa4968628080b617587/dotnet-sdk-3.0.100-osx-x64.tar.gz"
                ),
                new Tuple<string, string, string, string, string>("3.1.0", "v3.1.100",
                    "https://download.visualstudio.microsoft.com/download/pr/28a2c4ff-6154-473b-bd51-c62c76171551/ea47eab2219f323596c039b3b679c3d6/dotnet-sdk-3.1.100-win-x64.zip",
                    "https://download.visualstudio.microsoft.com/download/pr/d731f991-8e68-4c7c-8ea0-fad5605b077a/49497b5420eecbd905158d86d738af64/dotnet-sdk-3.1.100-linux-x64.tar.gz",
                    "https://download.visualstudio.microsoft.com/download/pr/bea99127-a762-4f9e-aac8-542ad8aa9a94/afb5af074b879303b19c6069e9e8d75f/dotnet-sdk-3.1.100-osx-x64.tar.gz"
                ),
            };

            foreach (var tfm in sdks)
            {
                await Handle(f,
                    "Microsoft.NETCore.App", tfm.Item1, tfm.Item2, tfm.Item3, tfm.Item4, tfm.Item5);
            }

            await f.WriteLineAsync("RUNTIME_DEPS_NATIVE = {");
            foreach (var tfm in sdks)
            {
                await f.WriteLineAsync($"    \"{tfm.Item2}\":RUNTIME_DEPS_NATIVE_{tfm.Item2.Replace(".", "_")},");
            }
            await f.WriteLineAsync("}");

            await f.WriteLineAsync("RUNTIME_DEPS = {");
            foreach (var tfm in sdks)
            {
                await f.WriteLineAsync($"    \"{tfm.Item2}\":RUNTIME_DEPS_{tfm.Item2.Replace(".", "_")},");
            }
            await f.WriteLineAsync("}");
        }

        private async Task Handle(StreamWriter f, string package, string version, string sdkVersion,
            string sdkWin, string sdkLinux, string sdkOsx)
        {
            var sdkDirWin = await ZipDownloader.DownloadIfNedeed(_configDir, sdkWin);
            var sdkDirLinux = await ZipDownloader.DownloadIfNedeed(_configDir, sdkLinux);
            var sdkDirOsx = await ZipDownloader.DownloadIfNedeed(_configDir, sdkOsx);


            var suffix = sdkVersion.Replace(".", "_");
            await ProcessDirectory(f, $"WINDOWS_RUNTIME_DEPS_{suffix}", sdkDirWin, package, version);
            await ProcessDirectory(f, $"LINUX_RUNTIME_DEPS_{suffix}", sdkDirLinux, package, version);
            await ProcessDirectory(f, $"OSX_RUNTIME_DEPS_{suffix}", sdkDirOsx, package, version);

            await f.WriteLineAsync($"RUNTIME_DEPS_NATIVE_{suffix} = {{");
            await f.WriteLineAsync($"    \"windows\": WINDOWS_RUNTIME_DEPS_{suffix}_NATIVE,");
            await f.WriteLineAsync($"    \"darwin\": OSX_RUNTIME_DEPS_{suffix}_NATIVE,");
            await f.WriteLineAsync($"    \"linux\": LINUX_RUNTIME_DEPS_{suffix}_NATIVE,");
            await f.WriteLineAsync("}");

            await f.WriteLineAsync($"RUNTIME_DEPS_{suffix} = {{");
            await f.WriteLineAsync($"    \"windows\": WINDOWS_RUNTIME_DEPS_{suffix},");
            await f.WriteLineAsync($"    \"darwin\": OSX_RUNTIME_DEPS_{suffix},");
            await f.WriteLineAsync($"    \"linux\": LINUX_RUNTIME_DEPS_{suffix},");
            await f.WriteLineAsync("}");
        }

        private async Task ProcessDirectory(StreamWriter f, string varname, string sdkDir, string package, string version)
        {
            var infos = StdlibCoreGenerator.GetSdkInfos(sdkDir, package, version);
            var native = Directory.GetFiles(Path.Combine(sdkDir, "shared", package, version))
                .Select(y => Path.GetFileName(y).ToLower()).Except(infos.Select(x => x.Name));

            await f.WriteLineAsync($"{varname}_NATIVE = [");
            foreach (var n in native)
                await f.WriteLineAsync($"    \"{n}\",");
            await f.WriteLineAsync($"]");

            await f.WriteLineAsync($"{varname} = {{");
            foreach (var i in infos)
                await f.WriteLineAsync($"    \"{i.Name}\":\"{i.Version}\",");
            await f.WriteLineAsync("}");
        }
    }
}
