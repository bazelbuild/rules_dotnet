using System;
using System.Collections.Generic;
using System.Reflection.Metadata.Ecma335;
using System.Text;
using System.Threading.Tasks;

namespace nuget2bazel.rules
{
    public abstract class Sdk
    {
        public Sdk()
        {
        }

        public Sdk(string internalVersionFolder, string version, string windowsUrl, string linuxUrl, string darwinUrl, string[] packs = null, bool defaulSdk = false)
        {
            Version = version;
            InternalVersionFolder = internalVersionFolder;
            WindowsUrl = windowsUrl;
            LinuxUrl = linuxUrl;
            DarwinUrl = darwinUrl;
            Packs = packs;
            DefaultSdk = defaulSdk;
        }
        public string Version { get; set; }
        public string InternalVersionFolder { get; set; }
        public string WindowsUrl { get; set; }
        public string LinuxUrl { get; set; }
        public string DarwinUrl { get; set; }
        public string[] Packs { get; set; }
        public bool DefaultSdk { get; set; }

        public abstract Task<List<RefInfo>> GetRefInfos(string configDir);
    }

    public static class SdkInfos
    {
        public static Sdk[] Sdks = new Sdk[] {
            new SdkCorePre3("2.0.7", "v2.1.200",
                "https://download.microsoft.com/download/3/7/1/37189942-C91D-46E9-907B-CF2B2DE584C7/dotnet-sdk-2.1.200-win-x64.zip",
                "https://download.microsoft.com/download/3/7/1/37189942-C91D-46E9-907B-CF2B2DE584C7/dotnet-sdk-2.1.200-linux-x64.tar.gz",
                "https://download.microsoft.com/download/3/7/1/37189942-C91D-46E9-907B-CF2B2DE584C7/dotnet-sdk-2.1.200-osx-x64.tar.gz"
            ),
            new SdkCorePre3("2.1.6", "v2.1.502",
                "https://download.visualstudio.microsoft.com/download/pr/c88b53e5-121c-4bc9-af5d-47a9d154ea64/e62eff84357c48dc8052a9c6ce5dfb8a/dotnet-sdk-2.1.502-win-x64.zip",
                "https://download.visualstudio.microsoft.com/download/pr/4c8893df-3b05-48a5-b760-20f2db692c45/ff0545dbbb3c52f6fa38657ad97d65d8/dotnet-sdk-2.1.502-linux-x64.tar.gz",
                "https://download.visualstudio.microsoft.com/download/pr/50729ca4-03ce-4e19-af87-bfae014b0431/1c830d9dcffa7663702e32fab6953425/dotnet-sdk-2.1.502-osx-x64.tar.gz"
            ),
            new SdkCorePre3("2.1.7", "v2.1.503",
                "https://download.visualstudio.microsoft.com/download/pr/81e18dc2-7747-4b2d-9912-3be0f83050f1/5bc41cb27df3da63378df2d051be4b7f/dotnet-sdk-2.1.503-win-x64.zip",
                "https://download.visualstudio.microsoft.com/download/pr/04d83723-8370-4b54-b8b9-55708822fcde/63aab1f4d0be5246e3a92e1eb3063935/dotnet-sdk-2.1.503-linux-x64.tar.gz",
                "https://download.visualstudio.microsoft.com/download/pr/c922688d-74e8-4af5-bcc8-5850eafbca7f/cf3b9a0b06c0dfa3a5098f893a9730bd/dotnet-sdk-2.1.503-osx-x64.tar.gz"
            ),
            new SdkCorePre3("2.2.0", "v2.2.101",
                "https://download.visualstudio.microsoft.com/download/pr/25d4104d-1776-41cb-b96e-dff9e9bf1542/b878c013de90f0e6c91f6f3c98a2d592/dotnet-sdk-2.2.101-win-x64.zip",
                "https://download.visualstudio.microsoft.com/download/pr/80e1d007-d6f0-402f-b047-779464dd989b/9ae5e2df9aa166b720bdb92d19977044/dotnet-sdk-2.2.101-linux-x64.tar.gz",
                "https://download.visualstudio.microsoft.com/download/pr/55c65d12-5f99-45d3-aa14-35359a6d02ca/3f6bcd694e3bfbb84e6b99e65279bd1e/dotnet-sdk-2.2.101-osx-x64.tar.gz"
            ),
            new SdkCorePre3("2.2.7", "v2.2.402",
                "https://download.visualstudio.microsoft.com/download/pr/8ac3e8b7-9918-4e0c-b1be-5aa3e6afd00f/0be99c6ab9362b3c47050cdd50cba846/dotnet-sdk-2.2.402-win-x64.zip",
                "https://download.visualstudio.microsoft.com/download/pr/46411df1-f625-45c8-b5e7-08ab736d3daa/0fbc446088b471b0a483f42eb3cbf7a2/dotnet-sdk-2.2.402-linux-x64.tar.gz",
                "https://download.visualstudio.microsoft.com/download/pr/2079de3a-714b-4fa5-840f-70e898b393ef/d631b5018560873ac350d692290881db/dotnet-sdk-2.2.402-osx-x64.tar.gz"
            ),
            new SdkCorePost3("3.0.0", "v3.0.100",
                "https://download.visualstudio.microsoft.com/download/pr/a24f4f34-ada1-433a-a437-5bc85fc2576a/7e886d06729949c15c96fe7e70faa8ae/dotnet-sdk-3.0.100-win-x64.zip",
                "https://download.visualstudio.microsoft.com/download/pr/886b4a4c-30af-454b-8bec-81c72b7b4e1f/d1a0c8de9abb36d8535363ede4a15de6/dotnet-sdk-3.0.100-linux-x64.tar.gz",
                "https://download.visualstudio.microsoft.com/download/pr/b9251194-4118-41cb-ae05-6763fb002e5d/1d398b4e97069fa4968628080b617587/dotnet-sdk-3.0.100-osx-x64.tar.gz",
                new[] { "Microsoft.NETCore.App.Ref", "Microsoft.AspNetCore.App.Ref", "NETStandard.Library.Ref" }
            ),
            new SdkCorePost3("3.1.0", "v3.1.100",
                "https://download.visualstudio.microsoft.com/download/pr/28a2c4ff-6154-473b-bd51-c62c76171551/ea47eab2219f323596c039b3b679c3d6/dotnet-sdk-3.1.100-win-x64.zip",
                "https://download.visualstudio.microsoft.com/download/pr/d731f991-8e68-4c7c-8ea0-fad5605b077a/49497b5420eecbd905158d86d738af64/dotnet-sdk-3.1.100-linux-x64.tar.gz",
                "https://download.visualstudio.microsoft.com/download/pr/bea99127-a762-4f9e-aac8-542ad8aa9a94/afb5af074b879303b19c6069e9e8d75f/dotnet-sdk-3.1.100-osx-x64.tar.gz",
                new[] { "Microsoft.NETCore.App.Ref", "Microsoft.AspNetCore.App.Ref", "NETStandard.Library.Ref" },
                true
            )
        };
    }
}
