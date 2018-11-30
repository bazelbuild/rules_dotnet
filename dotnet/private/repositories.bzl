load("@bazel_tools//tools/build_defs/repo:http.bzl", "http_archive", "http_file")


def dotnet_repositories():
  http_file(
      name = "nuget",
      urls = ["https://dist.nuget.org/win-x86-commandline/v4.6.2/nuget.exe"],
      sha256 = "2c562c1a18d720d4885546083ec8eaad6773a6b80befb02564088cc1e55b304e",
  )
    
  http_archive(
    name = "nunit2",
    url = "https://github.com/nunit/nunitv2/archive/2.6.4.zip",
    sha256 = "2db7b4356e7cd9ac022c3f211853e39ae7b3587915124b555c7c39f712902c28",
    strip_prefix = "nunitv2-2.6.4",
    build_file = "@io_bazel_rules_dotnet//dotnet/externals:BUILD.nunit2",
  )

  http_archive(
    name = "nunit3",
    url = "https://www.nuget.org/api/v2/package/NUnit/3.10.1",
    sha256 = "3529193f6028d7f7ccc65c6cb83d62d1b1c39a7d7ba5f74036cd6b69f55b10b6",
    build_file = "@io_bazel_rules_dotnet//dotnet/externals:BUILD.nunit3",
    type = "zip",
  )

  http_archive(
    name = "nunit3_consolerunner",
    url = "https://www.nuget.org/api/v2/package/NUnit.ConsoleRunner/3.8.0",
    sha256 = "785d80095c50f142727e741578297b2ef5e1a0e537e2511697ac25e8bd9fa2ae", 
    build_file = "@io_bazel_rules_dotnet//dotnet/externals:BUILD.nunit3-consolerunner",
    type = "zip",
  )
