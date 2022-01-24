using System;
using System.Collections.Generic;
using System.Reflection.Metadata.Ecma335;
using System.Runtime.InteropServices;
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

        public string GetDownloadUrl()
        {
            if (RuntimeInformation.IsOSPlatform(OSPlatform.Linux))
            {
                return LinuxUrl;
            }
            else if (RuntimeInformation.IsOSPlatform(OSPlatform.OSX))
            {
                return DarwinUrl;
            }

            return WindowsUrl;
        }
    }

    public static class SdkInfos
    {
        public static Sdk[] Sdks = new Sdk[] {
            new SdkCorePost3("3.1.0", "3.1.100",
                "https://download.visualstudio.microsoft.com/download/pr/28a2c4ff-6154-473b-bd51-c62c76171551/ea47eab2219f323596c039b3b679c3d6/dotnet-sdk-3.1.100-win-x64.zip",
                "https://download.visualstudio.microsoft.com/download/pr/d731f991-8e68-4c7c-8ea0-fad5605b077a/49497b5420eecbd905158d86d738af64/dotnet-sdk-3.1.100-linux-x64.tar.gz",
                "https://download.visualstudio.microsoft.com/download/pr/bea99127-a762-4f9e-aac8-542ad8aa9a94/afb5af074b879303b19c6069e9e8d75f/dotnet-sdk-3.1.100-osx-x64.tar.gz",
                new[] { "Microsoft.NETCore.App.Ref", "Microsoft.AspNetCore.App.Ref", "NETStandard.Library.Ref" }
            ),
             new SdkCorePost3("3.1.13", "3.1.407",
                "https://download.visualstudio.microsoft.com/download/pr/095412cb-5d87-4049-9659-35d917835355/a889375c044572335acef05b19473f60/dotnet-sdk-3.1.407-win-x64.zip",
                "https://download.visualstudio.microsoft.com/download/pr/ab82011d-2549-4e23-a8a9-a2b522a31f27/6e615d6177e49c3e874d05ee3566e8bf/dotnet-sdk-3.1.407-linux-x64.tar.gz",
                "https://download.visualstudio.microsoft.com/download/pr/17fa8fae-ad2e-4871-872c-bd393801f191/5a54261a28d5a5b25f5aa5606981e145/dotnet-sdk-3.1.407-osx-x64.tar.gz",
                new[] { "Microsoft.NETCore.App.Ref", "Microsoft.AspNetCore.App.Ref", "NETStandard.Library.Ref" }
            ),
            new SdkCorePost3("5.0.4", "5.0.201",
                "https://download.visualstudio.microsoft.com/download/pr/989b7ad4-bdce-4c40-a323-7e348578867a/cb7c44c6b2a68063be8e991e8fe8a13d/dotnet-sdk-5.0.201-win-x64.zip",
                "https://download.visualstudio.microsoft.com/download/pr/73a9cb2a-1acd-4d20-b864-d12797ca3d40/075dbe1dc3bba4aa85ca420167b861b6/dotnet-sdk-5.0.201-linux-x64.tar.gz",
                "https://download.visualstudio.microsoft.com/download/pr/b660bd50-30b1-4a69-ad8d-d83209ea6213/4fb0163b7fff707f204a100c24d82ef6/dotnet-sdk-5.0.201-osx-x64.tar.gz",
                new[] { "Microsoft.NETCore.App.Ref", "Microsoft.AspNetCore.App.Ref", "NETStandard.Library.Ref" }
            ),
            new SdkCorePost3("5.0.13", "5.0.404",
                "https://download.visualstudio.microsoft.com/download/pr/fd6872c1-331b-47f7-b44c-061093651652/5e04c7e7b8860f42660b317f3f52eeec/dotnet-sdk-5.0.404-win-x64.zip",
                "https://download.visualstudio.microsoft.com/download/pr/2c1eb8c8-ac05-4dc7-9bef-307b3e450e9d/75e85b3d1662f60afd69572fd5df6884/dotnet-sdk-5.0.404-linux-x64.tar.gz",
                "https://download.visualstudio.microsoft.com/download/pr/90588609-df30-4cb7-b4aa-a2e71ec42c9a/9bc894713f459ebe73493552fd231807/dotnet-sdk-5.0.404-osx-x64.tar.gz",
                new[] { "Microsoft.NETCore.App.Ref", "Microsoft.AspNetCore.App.Ref", "NETStandard.Library.Ref" },
                true
            ),
        };
    }
}
