def dotnet_repositories():
  native.http_file(
      name = "nuget",
      url = "https://dist.nuget.org/win-x86-commandline/v4.6.2/nuget.exe",
      sha256 = "2c562c1a18d720d4885546083ec8eaad6773a6b80befb02564088cc1e55b304e",
  )
    
  native.new_http_archive(
    name = "nunit2",
    url = "https://github.com/nunit/nunitv2/archive/2.6.4.zip",
    sha256 = "2db7b4356e7cd9ac022c3f211853e39ae7b3587915124b555c7c39f712902c28",
    strip_prefix = "nunitv2-2.6.4",
    build_file = "@io_bazel_rules_dotnet//dotnet/externals:BUILD.nunit2",
  )


