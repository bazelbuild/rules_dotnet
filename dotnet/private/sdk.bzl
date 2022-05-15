"""
Declarations for the .NET SDK Downloads URLs and version

These are the URLs to download the .NET SDKs for each of the supported operating systems. These URLs are accessible from: https://dotnet.microsoft.com/download/dotnet-core.
"""
DOTNET_SDK_VERSION = "6.0.300"
DOTNET_SDK = {
    "windows": {
        "url": "https://download.visualstudio.microsoft.com/download/pr/cc89c1f6-0d56-46fd-88f9-1fbd8ce074ec/753afbad1926cbc8d28aa4a2dd7d9d66/dotnet-sdk-6.0.300-win-x64.zip",
        "hash": "e238e0e1579962e5bfc109a33784fb88101b648b358c96740d9c4cd8de8b2fe9",
    },
    "linux": {
        "url": "https://download.visualstudio.microsoft.com/download/pr/dc930bff-ef3d-4f6f-8799-6eb60390f5b4/1efee2a8ea0180c94aff8f15eb3af981/dotnet-sdk-6.0.300-linux-x64.tar.gz",
        "hash": "1d4c8c90a5c32de9fc4e9872c79a97271abdff3a60fb55e36690e558d5697005",
    },
    "osx": {
        "url": "https://download.visualstudio.microsoft.com/download/pr/5c55a0f8-8f53-4b62-8fc5-9f428b8679a5/af7a2e2804c6cad414e6a686866baad7/dotnet-sdk-6.0.300-osx-x64.tar.gz",
        "hash": "25a818367ea4509eb897884548fc5d9b2388fc9f08ab52ea10d3e6eb1effd1ea",
    },
}

RUNTIME_TFM = "net6.0"
RUNTIME_FRAMEWORK_VERSION = "6.0.5"
