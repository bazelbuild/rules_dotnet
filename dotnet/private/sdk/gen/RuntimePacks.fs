module RuntimePacks

// Runtime packs and app host packs are also tied to a specific runtime version but they are also tied to a spcific
// RID. We fetch all available versions for each runtime pack since the end user can select which
// SDK version to use and which RID to target when publishing.
// We need fetch the runtime packs for the platforms we support. They can be found in toolchains_repo.bzl
let runtimePacks =
    [ "Microsoft.NETCore.App.Runtime.win-x64"
      "Microsoft.NETCore.App.Runtime.win-arm64"
      "Microsoft.NETCore.App.Runtime.linux-x64"
      "Microsoft.NETCore.App.Runtime.linux-arm64"
      "Microsoft.NETCore.App.Runtime.osx-x64"
      "Microsoft.NETCore.App.Runtime.osx-arm64"
      "Microsoft.AspNetCore.App.Runtime.win-x64"
      "Microsoft.AspNetCore.App.Runtime.win-arm64"
      "Microsoft.AspNetCore.App.Runtime.linux-x64"
      "Microsoft.AspNetCore.App.Runtime.linux-arm64"
      "Microsoft.AspNetCore.App.Runtime.osx-x64"
      "Microsoft.AspNetCore.App.Runtime.osx-arm64" ]
