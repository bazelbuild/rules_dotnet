"""Functionality related to resolving .Net targeting/apphost/runtime packs

See: https://github.com/dotnet/designs/blob/main/accepted/2019/targeting-packs-and-runtime-packs.md and https://github.com/dotnet/designs/blob/main/accepted/2020/targeting-packs/targeting-packs.md

TL:DR:
The packs can be selected from either a combination of the tfm, runtime version and RID.

We currently have the following packs (The list is not exhaustive since we don't support all .Net workloads):
Targeting packs:
    Used for compilation targeting specific TFM. The pack contains the reference assemblies for libraries that are part of the the targeted framework.
    Is on the form <shared framework name>.Ref

    Examples:
        NETStandard.Library.Ref: NetStandard 2.1
        NETStandard.Library: NETStandard 1.6 - 2.0
        Microsoft.NETCore.App.Ref: .Net Core 3 and above
        Microsoft.AspNetCore.App.Ref: AspNetCore apps for .Net Core 3 and above
Runtime packs:
    Used for self contained publishing. The pack contains the runtime assemblies and files required for running the application.
    The runtime pack can be selected from the runtime version and targeted runtime identifier (RID): <shared framework name>.Runtime.<rid>

    Examples:
        Microsoft.AspNetCore.App.Runtime.win-x64: AspNetCore for .Net Core 3 and above on Windows x64
        Microsoft.NETCore.App.Runtime.linux-x64: .Net Core 3 and above on Linux x64 
        Microsoft.NETCore.App.Runtime.osx-arm64: .Net Core 3 and above on MacOS arm64 
Apphost pack:
    Contains the app executable template to generate native app executable
    The apphost pack can be selected from the runtime version and targeted runtime identifier (RID): <shared framework name>.Host.<rid>
    NOTE: There are no apphost packs specifically for AspNetCore apps
    
    Examples:
        Microsoft.NETCore.App.Host.win-x64: AspNetCore for .Net Core 3 and above on Windows x64
        Microsoft.NETCore.App.Host.linux-x64: .Net Core 3 and above on Linux x64 
        Microsoft.NETCore.App.Host.osx-arm64: .Net Core 3 and above on MacOS arm64

CrossGen2 pack:
    Contains the files required for crossgen2 compilation. This is used for ReadyToRun compilation.
    The crossgen2 pack can be selected from the runtime version and targeted runtime identifier (RID): <shared framework name>.CrossGen2.<rid>
    NOTE: There are no crossgen2 packs specifically for AspNetCore apps

    Examples:
        Microsoft.NETCore.App.CrossGen2.win-x64: AspNetCore for .Net Core 3 and above on Windows x64
        Microsoft.NETCore.App.CrossGen2.linux-x64: .Net Core 3 and above on Linux x64 
        Microsoft.NETCore.App.CrossGen2.osx-arm64: .Net Core 3 and above on MacOS arm64

How do we resolve correct packs?
    1. We create an external repository that enumerates all the packs using a known naming convention: @nuget.<pack name>.v<runtime version>
"""
